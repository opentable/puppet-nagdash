# puppet-nagdash

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nagdash](#setup)
    * [What nagdash affects](#what-nagdash-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nagdash](#beginning-with-nagdash)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


##Overview

The puppet module to install and configure [Nagdash](https://github.com/lozzd/Nagdash). Nagdash is a dashboarding tool for Nagios.

[![Build Status](https://travis-ci.org/opentable/puppet-nagdash.png?branch=master)](https://travis-ci.org/opentable/puppet-nagdash)

##Module Description

The puppet module to install and configure [Nagdash](https://github.com/lozzd/Nagdash). It pulls the nagdash from it's source on
github and configures your webserver to properly serve the application.

##Setup

###What nagdash affects

###Beginning with nagdash

To install nagdash with defaults:

```puppet
include 'nagdash'
```

To install from a different source repo:

```puppet
class { 'nagdash':
  repository_source => 'http://mysourcecontrol.com/myfork/nagdash'
}
```

To install a specific commit of the repository:

```puppet
class { 'nagdash':
  repository_revision => '3d30f19ecc6bc8d12a16b0d9e5dba85f0fba9b5a'
}
```

By default, the source of the application gets installed to /var/www/nagdash. To change this:

```puppet
class { 'nagdash':
  webroot => '/usr/local/nagdash'
}
```

Nagdash has the ability to display the information for 1 or more nagios hosts. To specify the hosts to display, we can pass information to the module as follows:

```puppet
$myhost = {
    'firsthost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => 'MY', 'tagcolour' => '#336699', any_nagdash_setting => 'value', ....}
}

class {'nagdash':
  hosts => $myhost
}

```


You can specify more than 1 host to pass to the class e.g.

```puppet
$hostlist = {
    'firsthost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => '1st', 'tagcolour' => '#336699', any_nagdash_setting => 'value', ....},
    'secondhost.mydomain.com' => {'port' => '8080', 'protocol' => 'http', 'tag' => '2nd', 'tagcolour' => '#191919', any_nagdash_setting => 'value', ....}
}

class {'nagdash':
  hosts => $hostlist
}

```

##Usage

###Classes and Defined Types

####Class: `nagdash`
One of the primary classes of the nagdash module. This class will install the nagdash binaries

**Parameters within `nagdash`:**
#####`webroot`
The folder to run the Nagdash source code from. Defaults to /var/www/nagdash

#####`repository_source`
The git repository to check the source code out from. Please note there is no package to install from. Defaults to https://github.com/lozzd/Nagdash

#####`repository_revision`
The revision of the source code (e.g. tag, git commit etc) that you want to run. Defaults to latest

#####`hosts`
A list of nagios hosts to monitor.


##Reference

###Classes
####Public Classes
* [`nagdash`](#class-nagdash-broker): Guides the basic installation of the nagdash application

####Private Classes
* [`nagdash::config`]  Manages all the default configuration of the nagdash application
* [`nagdash::install`] Manages the installation of the nagdash
* [`nagdash::service`] Manages the nagdash server service

##Limitations

This module is tested on the following platforms:

* CentOS 5
* CentOS 6
* Ubuntu 12.04
* Ubuntu 14.04

It is tested with the OSS version of Puppet only.

##Development

###Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
