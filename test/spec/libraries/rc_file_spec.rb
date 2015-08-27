require 'poise_boiler/spec_helper'
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
end
