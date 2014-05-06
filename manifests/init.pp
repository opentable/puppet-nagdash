# == Class: nagdash
#
# Module to install the nagdash Dashboard
#
# === Parameters
#
# [*webroot*]
#   The folder to run the Nagdash source code from
#   Defaults to /var/www/nagdash
#
# [*repository_source*]
#   The git repository to check the source code out from. Please note there is no package to install from
#   Defaults to https://github.com/lozzd/Nagdash
#
# [*srepository_source*]
#   The revision of the source code (e.g. tag, git commit etc) that you want to run
#   Defaults to latest
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
