require 'poise_boiler/spec_helper'
require 'chefspec/berkshelf'
require_relative '../../../libraries/rc_file'

describe RcCookbook::Resource::RcFile do
  step_into(:rc_file)
  context 'runtime configuration for bashrc' do
    recipe do
      rc_file '/etc/skel/bashrc' do
        options(
          'http_proxy' => 'http://proxy.corporate.com:80',
          'https_proxy' => 'http://proxy.corporate.com:443',
          'ftp_proxy' => 'http://proxy.corporate.com:80',
          'no_proxy' => 'localhost,127.0.0.1'
        )
      end
    end

    it { is_expected.to render_file('/etc/skel/bashrc').with_content(<<-EOH.chomp) }
# This file is managed by Chef; all manual changes will be lost!
http_proxy="http://proxy.corporate.com:80"
https_proxy="http://proxy.corporate.com:443"
ftp_proxy="http://proxy.corporate.com:80"
no_proxy="localhost,127.0.0.1"
EOH
  end

  context 'runtime configuration for json' do
    recipe do
      rc_file '/etc/skel/berkshelf' do
        type 'json'
        options(
          'vagrant' => {
            'http_proxy' => 'http://proxy.corporate.com:80',
            'https_proxy' => 'http://proxy.corporate.com:443',
            'ftp_proxy' => 'http://proxy.corporate.com:80',
            'no_proxy' => 'localhost,127.0.0.1'
          }
        )
      end
    end

    it { is_expected.to render_file('/etc/skel/berkshelf').with_content(<<-EOH.chomp) }
{
  "vagrant": {
    "http_proxy": "http://proxy.corporate.com:80",
    "https_proxy": "http://proxy.corporate.com:443",
    "ftp_proxy": "http://proxy.corporate.com:80",
    "no_proxy": "localhost,127.0.0.1"
  }
}
EOH
  end

  context 'runtime configuration for yaml' do
    recipe do
      rc_file '/etc/skel/kitchen' do
        type 'yaml'
        options(
          'provisioner' => {
            'http_proxy' => 'http://proxy.corporate.com:80',
            'https_proxy' => 'http://proxy.corporate.com:443',
            'ftp_proxy' => 'http://proxy.corporate.com:80',
            'no_proxy' => 'localhost,127.0.0.1'
          }
        )
      end
    end

    it { is_expected.to render_file('/etc/skel/kitchen').with_content(<<-EOH.chomp) }
--- !ruby/hash:Mash
provisioner: !ruby/hash:Mash
  http_proxy: http://proxy.corporate.com:80
  https_proxy: http://proxy.corporate.com:443
  ftp_proxy: http://proxy.corporate.com:80
  no_proxy: localhost,127.0.0.1
EOH
  end

  context 'runtime configuration for bat' do
    recipe do
      rc_file '/etc/skel/batrc' do
        type 'bat'
        options(
          'http_proxy' => 'http://proxy.corporate.com:80',
          'https_proxy' => 'http://proxy.corporate.com:443',
          'ftp_proxy' => 'http://proxy.corporate.com:80',
          'no_proxy' => 'localhost,127.0.0.1'
        )
      end
    end

    it { is_expected.to render_file('/etc/skel/batrc').with_content(<<-EOH.chomp) }
@REM This file is managed by Chef; all manual changes will be lost!
SET http_proxy=http://proxy.corporate.com:80
SET https_proxy=http://proxy.corporate.com:443
SET ftp_proxy=http://proxy.corporate.com:80
SET no_proxy=localhost,127.0.0.1
EOH
  end
end
