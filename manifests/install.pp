# == Class: nagdash::install
#
# The installation of the specific packages and the checkout of the source required to get nagdash running

class nagdash::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case downcase($::osfamily) {
    'debian': {

      ensure_resource('package', ['php5', 'php5-curl', 'php5-common', 'php5-cli', 'php5-fpm', 'nginx', 'git'], {
        ensure => 'installed',
        require => Apt::Source['ondrej']
      })

      apt::source { 'ondrej':
        location    => 'http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu',
        key         => 'E5267A6C',
        key_content => template('nagdash/php5.ondrej.aptkey.gpg.erb'),
        repos       => 'main'
      }

      vcsrepo { $nagdash::webroot:
        ensure   => present,
        provider => git,
        source   => $nagdash::repository_source,
        revision => $nagdash::repository_revision
      }

      Package['php5-curl'] -> Package['php5-fpm']

    }
    default: {
      fail('This module only works on Ubuntu based systems.')
    }
  }

}
