name 'rc'
maintainer 'Bloomberg Finance L.P.'
maintainer_email 'chef@bloomberg.net'
license 'Apache-2.0'
description 'Library cookbook which provides a resource for writing runtime configuration files.'
long_description 'Library cookbook which provides a resource for writing runtime configuration files.'
version '2.0.0'
source_url 'https://github.com/bloomberg-cookbooks/rc' if defined?(:source_url)
issues_url 'https://github.com/bloomberg-cookbooks/rc/issues' if defined?(:source_url)
chef_version '>= 12.5.0'

supports 'ubuntu'
supports 'centos'
supports 'redhat'
supports 'windows'
supports 'freebsd'
supports 'aix'
supports 'solaris2'

depends 'line', '~> 0.6'
