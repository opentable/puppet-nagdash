puppet-nagdash
==============

This is the Puppet module to install Nagdash. [Nagdash](https://github.com/lozzd/Nagdash) is a dashboarding tool for Nagios.

[![Build Status](https://travis-ci.org/opentable/puppet-nagdash.png?branch=master)](https://travis-ci.org/opentable/puppet-nagdash)

Usage
--
The module consists of a single class

```puppet
include 'nagdash'
```

Unless specified, this will install the latest version of Nagdash from [Lozzd's Github repo](https://github.com/lozzd/Nagdash). If you want to install a different version, then you can tell the module to do so:

```puppet
class { 'nagdash':
  repository_source => 'http://mysourcecontrol.com/myfork/nagdash'
}
```
If you want to install a specific commit of the repository, then you can also specify that:

```puppet
class { 'nagdash':
  repository_revision => '3d30f19ecc6bc8d12a16b0d9e5dba85f0fba9b5a'
}
```

By default, the source of the application gets installed to /var/www/nagdash. This can also be passed as an argument to the installer:

```puppet
class { 'nagdash':
  webroot => '/usr/local/nagdash'
}
```

Configuring the Specific Nagios instances to monitor
--

Nagdash has the ability to display the information for 1 or more nagios hosts. To specify the hosts to display, we can pass information to the module as follows:

```puppet
$myhost = {
    'firsthost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => 'MY', 'tagcolour' => '#336699'}
}

class {'nagdash':
  hosts => $myhost
}

```
You can specify more than 1 host to pass to the class e.g.


```puppet
$hostlist = {
    'firsthost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => '1st', 'tagcolour' => '#336699'},
    'secondhost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => '2nd', 'tagcolour' => '#191919'}
}

class {'nagdash':
  hosts => $hostlist
}

```

Limitations
--

This module is tested on the following platforms:

* Ubuntu 10.04.4
* Ubuntu 12.04.2

More support will be added. It is tested with the OSS version of Puppet only. The module currently only supports Nginx, but support for apache2 will be added later

Contribute:
--

* Fork it
* Create a branch
* Improve/fix (with spec tests)
* Push new branch
* Submit a PR
