# == Class: nagdash::params
#
# Defaut parameter values for the nagdash module

class nagdash::params {
  $webroot             = '/var/www/nagdash'
  $repository_source   = 'https://github.com/lozzd/Nagdash'
  $repository_revision = 'fd6f765e63a16052011a43835743b57938b2dfb5'
}
