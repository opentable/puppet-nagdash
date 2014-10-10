# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nagdash
#
# The purpose of this module is to install the nagdash dashboard
#
# === Requirements/Dependencies
#
# Currently requires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*webroot*]
# The folder to run the Nagdash source code from. Defaults to /var/www/nagdash
#
# [*repository_source*]
# The git repository to check the source code out from. Please note there is no package to install from. Defaults to https://github.com/lozzd/Nagdash
#
# [*repository_revision*]
# The revision of the source code (e.g. tag, git commit etc) that you want to run. Defaults to latest
#
# [*hosts*]
# A list of nagios hosts to monitor.
#
# === Examples
#
# To install a specific commit of the repository:
#
#   class { 'nagdash':
#     repository_revision => '3d30f19ecc6bc8d12a16b0d9e5dba85f0fba9b5a'
#   }
#
# By default, the source of the application gets installed to /var/www/nagdash. To change this:
#
#   class { 'nagdash':
#     webroot => '/usr/local/nagdash'
#   }
#
class nagdash(
  $webroot             = $nagdash::params::webroot,
  $repository_source   = $nagdash::params::repository_source,
  $repository_revision = $nagdash::params::repository_revision,
  $hosts
) inherits nagdash::params {

  validate_string($webroot)
  validate_string($repository_source)
  validate_string($repository_revision)
  validate_hash($hosts)

  class {'nagdash::install':} ->
  class {'nagdash::config':} ->
  class {'nagdash::service':} ->
  Class['nagdash']

}
