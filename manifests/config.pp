# == Class: nagdash::config
#
# The configuration of the applications for the nagdash web client

class nagdash::config(
  $webroot = $nagdash::webroot,
  $hosts = $nagdash::hosts
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    mode    => '0755',
    content => template('nagdash/defaultSite.erb'),
    notify  => Service['nginx'],
  } ->

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'link',
    target  => 'etc/nginx/sites-available/default',
    force   => true,
  } ->

  ini_setting { 'update php.ini to enable short_open_tag':
    ensure  => present,
    section => 'PHP',
    setting => 'short_open_tag',
    value   => 'On',
    path    => '/etc/php5/cli/php.ini',
  } ->

  file { "${webroot}/config.php":
    ensure  => file,
    mode    => '0755',
    content => template('nagdash/config.php.erb'),
    notify  => Service['nginx'],
  }

}