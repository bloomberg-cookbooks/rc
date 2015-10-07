#
# Cookbook: rc
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#

if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  chef_gem 'toml' do
    compile_time true
  end
else
  chef_gem 'toml' do
    action :nothing
  end.action(:install)
end

require 'toml'
