  class {'::archvsync':
    manage_apache    => true,
    manage_pureftpd  => true,
    package_ensure   => 'present',
    mirrorname       => $facts['networking']['fqdn'],
    to               => '/home/ftp/debian/',
    mailto           => 'toto@example.com',
    homedir          => '/home/ftp',
    hub              => 'false',
    rsync_host       => 'ftp.fr.debian.org',
    rsync_path       => 'debian',
    info_maintainer  => 'Toor Op <root@localhost>',
    info_sponsor     => 'World Company SA <https://www.example.com>',
    info_country     => 'US',
    info_location    => 'Nowhere city',
    info_throughput  => '10Gb',
    arch_include     => 'amd64 source',
    arch_exclude     => '',
    logdir           => '/home/ftp/log',
    setup_daily_cron => true,
  }

class {'::archvsync':
  # Global params
  manage_apache                        => true,
  manage_pureftpd                      => true,
  manage_rsync                         => true,
  configure_rsync                      => true,
  package_ensure                       => 'present',
  mirrorname                           => $facts['networking']['fqdn'],
  mailto                               => 'toto@example.com',
  homedir                              => '/home/ftp',
  info_maintainer                      => 'Toor Op <root@localhost>',
  info_sponsor                         => 'World Company SA <https://www.example.com>',
  info_country                         => 'US',
  info_location                        => 'Nowhere city',
  info_throughput                      => '10Gb',
  arch_include                         => 'amd64 source',
  arch_exclude                         => '',
  logdir                               => '/home/ftp/log',
  setup_daily_cron                     => true,

  # debian/ mirror options
  sync_debian                          => true,
  debian_to                            => '/home/ftp/debian/',
  debian_rsync_host                    => 'ftp.fr.debian.org',
  debian_rsync_path                    => 'debian',
  debian_exclude                       => '',

  debian_accept_push                   => false,
  debian_push_ssh_key                  => undef,
  debian_enable_runmirrors             => false,
  debian_runmirrors_hostnames          => [],

  # debian-security mirror options
  sync_debian_security                 => true,
  debian_security_to                   => '/home/ftp/debian-security/',
  debian_security_rsync_host           => 'rsync.security.debian.org',
  debian_security_rsync_path           => 'debian-security',
  debian_security_exclude              => '',

  debian_security_accept_push          => false,
  debian_security_push_ssh_key         => undef,
  debian_security_enable_runmirrors    => false,
  debian_security_runmirrors_hostnames => [],

  # debian-archive mirror options
  sync_debian_archive                  => true,
  debian_archive_to                    => '/home/ftp/debian-archive/',
  debian_archive_rsync_path            => 'debian-archive',
  debian_archive_rsync_host            => 'archive.debian.org',
  debian_archive_exclude               => '--exclude=buzz* --exclude=rex* --exclude=bo* --exclude=hamm* --exclude=slink* --exclude=potato* --exclude=woody* --exclude=sarge* --exclude=etch* --exclude=lenny* --exclude=squeeze* --exclude=wheezy', # lint:ignore:140chars

  debian_archive_accept_push           => false,
  debian_archive_push_ssh_key          => undef,
  debian_archive_enable_runmirrors     => false,
  debian_archive_runmirrors_hostnames  => [],

  # ubuntu mirror options
  sync_ubuntu                          => true,
  ubuntu_to                            => '/home/ftp/ubuntu/',
  ubuntu_rsync_host                    => 'archive.ubuntu.com',
  ubuntu_rsync_path                    => 'ubuntu',
  ubuntu_exclude                       => '--exclude=precise*',

  # debian-cd/ mirror options
  sync_deb_cd                          => true,
  debian_cd_to                         => '/home/ftp/debian-cd/',
  debian_cd_rsync_host                 => 'mirrors.ocf.berkeley.edu',
  debian_cd_rsync_path                 => 'debian-cd',
}
