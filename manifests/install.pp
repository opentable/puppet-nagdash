# == Class: nagdash::install
#
# The installation of the specific packages and the checkout of the source required to get nagdash running

class nagdash::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case downcase($::osfamily) {
    'debian': {
      ensure_resource('package', ['php5', 'php5-curl', 'php5-common', 'php5-cli', 'php5-fpm', 'nginx'], {'ensure' => 'installed'})

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