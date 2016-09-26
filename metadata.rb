name 'rc'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Library cookbook which provides a resource for writing runtime configuration files.'
long_description 'Library cookbook which provides a resource for writing runtime configuration files.'
version '1.6.5'
source_url 'https://github.com/bloomberg/rc-cookbook' if defined?(:source_url)
issues_url 'https://github.com/bloomberg/rc-cookbook/issues' if defined?(:source_url)

supports 'ubuntu'
supports 'centos'
supports 'redhat'
supports 'windows'
supports 'freebsd'
supports 'aix'
supports 'solaris2'

depends 'poise', '~> 2.2'
depends 'line', '~> 0.6'
