# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nagdash::install
#
# This private class is meant to be called from `nagdash`.
# It downloads and installs the nagdash application
#
class nagdash::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case downcase($::osfamily) {
    'debian': {
      ensure_resource('package', ['php5', 'php5-curl', 'php5-common', 'php5-cli', 'php5-fpm', 'nginx', 'git'], {'ensure' => 'installed'})

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
