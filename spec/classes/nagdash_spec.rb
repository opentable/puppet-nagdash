require 'spec_helper'

describe 'nagdash', :type => :class do

  let(:facts) { {
      :osfamily        => 'Debian',
      :lsbdistid       => 'ubuntu',
      :lsbdistcodename => 'precise'
  } }
  let(:params) {{
      :webroot             => '/var/www/nagdash',
      :repository_source   => 'https://github.com/lozzd/Nagdash',
      :repository_revision => 'b9bde411bac206f05dcf138c9b252eec8d2c175a',
      :hosts               => {'test.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => 'MY', 'tagcolour' => '#336699'}}
  }}

  it { should compile.with_all_deps }

  it { should contain_class('nagdash::install').that_comes_before('nagdash::config') }
  it { should contain_class('nagdash::config').that_comes_before('nagdash::service') }

  context 'using params defaults the install class' do
    it { should contain_class('nagdash::install') }

    it { should contain_package('php5', 'php5-curl', 'php5-common', 'php5-cli', 'php5-fpm', 'nginx').with(
      'ensure' => 'installed'
    )}

    it { should contain_vcsrepo('/var/www/nagdash').with(
      'ensure'   => 'present',
      'source'   => 'https://github.com/lozzd/Nagdash',
      'provider' => 'git',
      'revision' => 'b9bde411bac206f05dcf138c9b252eec8d2c175a'
    )}

  end

  context 'using params defaults the config class' do
    it { should contain_class('nagdash::config') }

    it { should contain_file('/etc/nginx/sites-available/default').with(
      'ensure'  => 'file',
      'mode'    => '0755',
      'notify'  => 'Service[nginx]'
    )}

    it { should contain_file('/etc/nginx/sites-available/default').with_content(/fastcgi_index index.php/) }

    it { should contain_file('/etc/nginx/sites-enabled/default').with(
      'ensure' => 'link',
      'target' => '/etc/nginx/sites-available/default',
      'force'  => 'true'
    )}

    it { should contain_ini_setting('update php.ini to enable short_open_tag').with(
      'ensure'  => 'present',
      'section' => 'PHP',
      'setting' => 'short_open_tag',
      'value'   => 'On',
      'path'    => '/etc/php5/cli/php.ini'
    )}

    it { should contain_file('/var/www/nagdash/config.php').with(
      'ensure'  => 'file',
      'mode'    => '0755',
      'notify'  => 'Service[nginx]'
    )}

    it { should contain_file('/var/www/nagdash/config.php').with_content(/nagios_hosts = array/) }

  end

  context 'using params defaults the service class' do
    it { should contain_class('nagdash::service') }

    it { should contain_service('apache2').with('ensure' => 'stopped') }

    it { should contain_service('nginx').with('ensure' => 'running') }

    it { should contain_service('php5-fpm').with('ensure' => 'running') }

  end

  context 'using params defaults the install class' do
    it { should contain_class('nagdash::install') }

    it { should contain_package('php5', 'php5-curl', 'php5-common', 'php5-cli', 'php5-fpm', 'nginx').with(
      'ensure' => 'installed',
      'require' => 'Apt::Source[ondrej]'
    )}

    it { should contain_vcsrepo('/var/www/nagdash').with(
      'ensure'   => 'present',
      'source'   => 'https://github.com/lozzd/Nagdash',
      'provider' => 'git',
      'revision' => 'b9bde411bac206f05dcf138c9b252eec8d2c175a'
    )}

  end

  context 'when trying to install nagdash on windows' do
    let(:facts) { {
        :osfamily  => 'Windows'
    } }

    it do
      expect {
        should contain_class('nagdash')
      }.to raise_error(Puppet::Error, /^This module only works on Ubuntu based systems./)
    end
  end

  context 'when trying to install nagdash on Redhat' do
    let(:facts) { {
        :osfamily  => 'Redhat'
    } }

    it do
      expect {
        should contain_class('nagdash')
      }.to raise_error(Puppet::Error, /^This module only works on Ubuntu based systems./)
    end
  end


end
