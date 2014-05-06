# == Class: nagdash::service
#
# The management of the service states for the nagdash module

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