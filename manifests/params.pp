# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nagdash::params
#
# This private class is meant to be called from `nagdash`
# It sets variables according to platform
#
class nagdash::params {
  $webroot             = '/var/www/nagdash'
  $repository_source   = 'https://github.com/lozzd/Nagdash'
  $repository_revision = 'b9bde411bac206f05dcf138c9b252eec8d2c175a'
}
