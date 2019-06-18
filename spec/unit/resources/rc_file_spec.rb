require_relative '../spec_helper'

describe 'test rc_file' do
  step_into(:rc_file)
  platform 'redhat'

  context 'test on toml' do
    recipe do
      rc_file '/etc/confd/confd.toml' do
        type 'toml'
        options(
          'backend' => 'zookeeper',
          'nodes' => %w{10.0.1.1 10.0.1.2 10.0.1.3},
          'prefix' => '/production',
          'interval' => 600,
          'noop' => false
        )
      end
    end

    it { is_expected.to render_file('/etc/confd/confd.toml').with_content(<<~EOH.chomp) }
      backend = "zookeeper"
      interval = 600
      nodes = ["10.0.1.1","10.0.1.2","10.0.1.3"]
      noop = false
      prefix = "/production"
    EOH
  end

  context 'test on java' do
    recipe do
      rc_file '/etc/zookeeper/zookeeper.properties' do
        type 'java'
        options(
          'dataDir' => '/var/opt/zookeeper',
          'leaderPort' => 3181,
          clientPort: 2181,
          electionPort: 2888
        )
      end
    end

    it { is_expected.to render_file('/etc/zookeeper/zookeeper.properties').with_content(<<~EOH.chomp) }
      dataDir=/var/opt/zookeeper
      leaderPort=3181
      clientPort=2181
      electionPort=2888
    EOH
  end

  context 'test on ini' do
    recipe do
      rc_file '/etc/mumble/mumble.ini' do
        type 'ini'
        options(
          'database' => '/var/lib/mumble.sqlite',
          'password' => 'letmein',
          allowping: false,
          logfile: '/var/log/mumble.log',
          welcometext: 'Welcome to the server<br/>Enjoy your stay!'
        )
      end
    end
    it { is_expected.to render_file('/etc/mumble/mumble.ini').with_content(<<~EOH.chomp) }
      database = /var/lib/mumble.sqlite
      password = letmein
      allowping = false
      logfile = /var/log/mumble.log
      welcometext = Welcome to the server<br/>Enjoy your stay!
    EOH
  end

  context 'test on bash' do
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

    it { is_expected.to render_file('/etc/skel/bashrc').with_content(<<~EOH.chomp) }
      # This file is managed by Chef; all manual changes will be lost!
      export http_proxy="http://proxy.corporate.com:80"
      export https_proxy="http://proxy.corporate.com:443"
      export ftp_proxy="http://proxy.corporate.com:80"
      export no_proxy="localhost,127.0.0.1"
    EOH
  end

  context 'test on bash with append_if_missing' do
    recipe do
      rc_file '/etc/skel/bashrc' do
        options(
          'http_proxy' => 'http://proxy.corporate.com:80',
          'https_proxy' => 'http://proxy.corporate.com:443',
          'ftp_proxy' => 'http://proxy.corporate.com:80',
          'no_proxy' => 'localhost,127.0.0.1'
        )
        action :append_if_missing
      end
    end

    it {
      lines = {
        'http_proxy' => 'export http_proxy="http://proxy.corporate.com:80"',
        'https_proxy' => 'export https_proxy="http://proxy.corporate.com:443"',
        'ftp_proxy' => 'export ftp_proxy="http://proxy.corporate.com:80"',
        'no_proxy' => 'export no_proxy="localhost,127.0.0.1"'
      }
      lines.each do |key, ln|
        is_expected.to edit_append_if_no_line("append #{key} if missing").with(path: '/etc/skel/bashrc', line: ln)
      end
    }
  end

  context 'test on json' do
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

    it { is_expected.to render_file('/etc/skel/berkshelf').with_content(<<~EOH.chomp) }
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

  context 'test rc_file on yaml' do
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

    it { is_expected.to render_file('/etc/skel/kitchen').with_content(<<~EOH.chomp) }
      ---
      provisioner:
        http_proxy: http://proxy.corporate.com:80
        https_proxy: http://proxy.corporate.com:443
        ftp_proxy: http://proxy.corporate.com:80
        no_proxy: localhost,127.0.0.1
    EOH
  end

  context 'test rc_file for bat' do
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

    it { is_expected.to render_file('/etc/skel/batrc').with_content(<<~EOH.chomp) }
      @REM This file is managed by Chef; all manual changes will be lost!
      SET http_proxy=http://proxy.corporate.com:80
      SET https_proxy=http://proxy.corporate.com:443
      SET ftp_proxy=http://proxy.corporate.com:80
      SET no_proxy=localhost,127.0.0.1
    EOH
  end
end
