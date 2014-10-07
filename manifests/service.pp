# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nagdash::service
#
# This private class is meant to be called from `nagdash`
# It  managed the service dependencies
#
class nagdash::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'apache2':
    ensure => 'stopped'
  } ->

  service { 'nginx':
    ensure => 'running'
  }

  service {'php5-fpm':
    ensure => 'running'
  }

}
