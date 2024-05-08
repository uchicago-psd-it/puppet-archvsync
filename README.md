# What's this?

A tiny puppet module for setting-up a Debian mirror.
It will setup for you:
- apache
- pure-ftpd
- rsync
- ssh push reciever, aka ftpsync
- ssh push sender, aka runmirrors

This module can setup mirrors for:
- rebular Debian
- debian-archive
- debian-security
- ubuntu
- debian-cd

For each archive (except debian-cd), this module makes it possible to
exclude suites from the mirror.

It's also possible to only mirror some architectures.

Currently, mirror push and runmirror is only possible for the regular
Debian repository (ie: not for debian-security, debian-archive or ubuntu,
where the ftpsync is only done daily via the cron.daily facility).

# How to use it?

Simply write this in a manifest:

```
class {'::archvsync': }

```
# What if I want more control?

None of the parameters are mandatory, though you can customize a bit your
installation. Here's an exhaustive list:

```
  class {'::archvsync':
    manage_apache         => true,
    manage_pureftpd       => true,
    manage_rsync          => true,
    configure_rsync       => true,
    package_ensure        => 'present',
    mirrorname            => $::fqdn,
    to                    => '/home/ftp/debian/',
    mailto                => 'toto@example.com',
    homedir               => '/home/ftp',
    hub                   => 'false',
    rsync_host            => 'ftp.fr.debian.org',
    rsync_path            => 'debian',

    also_sync_deb_cd       => true,
    deb_cd_path            => 'debian-cd',
    also_sync_deb_security => true,
    deb_security_path      => 'debian-security',
    also_sync_deb_archive  => true,
    deb_archive_path       => 'debian-archive',
    also_sync_ubuntu       => true,
    ubuntu_path            => 'ubuntu',

    info_maintainer       => 'Toor Op <root@localhost>',
    info_sponsor          => 'World Company SA <https://www.example.com>',
    info_country          => 'US',
    info_location         => 'Nowhere city',
    info_throughput       => '10Gb',
    arch_include          => 'amd64 source',
    arch_exclude          => '',
    logdir                => '/home/ftp/log',
    setup_daily_cron      => false,
    accept_push           => true,
    push_ssh_key          => 'ssh-rsa AAAAB3NzaC1yc2......ExZgE= zigo-at-debian.org',
    enable_runmirrors     => true,
    runmirrors_hostnames  => ['debian.example.com', 'debian.example.net'],

  }
```

Except the last 5 parameters, what you see above are the default values.
Of course, you should change push_ssh_key with the public key given by
the upstream server.

# What's missing in this module?

It should currently be feature-complete. Please test and report.
