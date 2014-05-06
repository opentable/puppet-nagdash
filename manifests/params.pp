# == Class: nagdash::params
#
# Defaut parameter values for the nagdash module

class nagdash::params {
  $webroot             = '/var/www/nagdash'
  $repository_source   = 'https://github.com/lozzd/Nagdash'
  $repository_revision = 'b9bde411bac206f05dcf138c9b252eec8d2c175a'
}