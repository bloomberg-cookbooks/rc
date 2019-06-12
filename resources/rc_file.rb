#
# Cookbook: rc
# License: Apache 2.0
#
# Copyright 2015-2019, Bloomberg Finance L.P.
#

resource_name 'rc_file'

property :path, String, name_property: true
property :owner, String
property :group, String
property :mode, String, default: '0640'
property :type, String, default: 'bash', equal_to: %w{bash bat edn yaml json toml java ini}
property :cookbook, String, default: 'rc'
property :source, String # only for bash/bat types
property :options, Hash, default: {}

def to_content(type, options)
  case type
  when :edn
    require 'edn'
    options.to_edn
  when :yaml
    options.to_hash.to_yaml
  when :java, :properties, :java_properties
    require 'java-properties'
    JavaProperties.generate(options)
  when :toml
    require 'toml'
    TOML::Generator.new(options).body
  when :json
    JSON.pretty_generate(options)
  when :ini
    require 'iniparse'
    IniParse.gen do |doc|
      options.each_pair do |key, value|
        if value.kind_of?(Hash) # rubocop:disable Style/ClassCheck
          doc.section(key) do |s|
            value.each { |k, v| s.option(k, v) }
          end
        else
          doc.option(key, value)
        end
      end
    end.to_ini
  else
    options.to_hash
  end
end

action(:create) do
  case new_resource.type.to_sym
  when :bash
    template new_resource.path do
      source new_resource.source || 'bash.erb'
      cookbook new_resource.cookbook
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      variables('options' => new_resource.options)
    end
  when :bat
    template new_resource.path do
      source new_resource.source || 'bat.erb'
      cookbook new_resource.cookbook
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      variables('options' => new_resource.options)
    end
  else
    file new_resource.path do
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      content to_content(new_resource.type.to_sym, new_resource.options)
    end
  end
end

action(:append_if_missing) do
  raise 'You cannot use append_if_missing on non-bash file types!' unless new_resource.type == 'bash'

  new_resource.options.each_pair do |k, v|
    append_if_no_line "append #{k} if missing" do
      path new_resource.path
      line %{export #{k}="#{v}"}
      action :edit
    end
  end
end

action(:delete) do
  file new_resource.path do
    action :delete
  end
end
