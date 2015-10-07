#
# Cookbook: rc
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  chef_gem 'toml' do
    version '~> 0.1.2'
    compile_time true
  end
  require 'toml'
else
  chef_gem 'toml' do
    action :nothing
  end.action(:install)
end
