# == class: archvsync
#
# base archvsync class.
#
# === parameters:
#
# === GLOBAL PARAMS ===
#
#  [*manage_apache*]
#    (Optional) Install and configure Apache.
#    Defaults to true
#
#  [*manage_pureftpd*]
#    (Optional) Install and configure pureftpd.
#    Defaults to true
#
#  [*manage_rsync*]
#    (Optional) Install and configure rsync, so that other mirror
#    can mirror us.
#    Defaults to true
#
#  [*configure_rsync*]
#    (Optional) Should this module tweak /etc/rsyncd.conf and /etc/default/rsync.
#    Defaults to true
#
#  [*package_ensure*]
#    (Optional) Ensure state for the ftpsync package.
#    Defaults to 'present'
#
#  [*mirrorname*]
#    (Optional) Name of the mirror.
#    Defaults to the hostname's FQDN.
#
#  [*mailto*]
#    (Optional) Email of the ftpmaster.
#    Defaults to 'toto@example.com'
#
#  [*homedir*]
#    (Optional) Mirror FTP home.
#    Defaults to '/home/ftp'
#
#  [*info_maintainer*]
#    (Optional) Maintainer name and email.
#    Defaults to 'Toor Op <root@localhost>'
#
#  [*info_sponsor*]
#    (Optional) Company sponsoring the mirror.
#    Defaults to 'World Company SA <https://www.example.com>'
#
#  [*info_country*]
#    (Optional) Country where the mirror will be hosted in.
#    Defaults to 'US'
#
#  [*info_location*]
#    (Optional) Location where the mirror will be hosted in.
#    Defaults to 'Nowhere city'
#
#  [*info_throughput*]
#    (Optional) Bandwidth speed of the mirror.
#    Defaults to '10Gb'
#
#  [*arch_include*]
#    (Optional) Architectures to mirror.
#    Defaults to 'amd64 source'
#
#  [*arch_exclude*]
#    (Optional) Architectures to mirror.
#    Defaults to ''
#
#  [*logdir*]
#    (Optional) Directory where logs will be written.
#    Repo names will be concatenated (for example: $logdir-security).
#    Defaults to '/home/ftp/log'
#
#  [*setup_daily_cron*]
#    (Optional) Install a cron job to do ftpsync every day.
#    Default to true
#
#  [*ftp_user_shell*]
#    (Optional) Define explicit shell for ftp user.
#    Use especially if push sync running as a different user to disable ftp shell
#    Default to '/bin/bash'
#
# === debian/ MIRROR PARAMS ===
#
#  [*sync_debian*]
#    (Optional) Should we also rsync /debian using ftpsync?
#    Defaults to true
#
#  [*debian_to*]
#    (Optional) Mirror destination.
#    Defaults to '/home/ftp/debian/'
#
#  [*debian_rsync_host*]
#    (Optional) Source to rsync from.
#    Defaults to ftp.fr.debian.org.
#
#  [*debian_rsync_path*]
#    (Optional) Rsync path in the rsync_host.
#    Defaults to 'debian'
#
#  [*debian_exclude*]
#    (Optional) Suites to exclude, in format --exclude=foo*.
#    Defaults to '' (empty exclude).
#
#  [*debian_accept_push*]
#    (Optional) Switch to install a /home/ftp/.ssh/authorized_keys to allow
#    another mirror to send a push signal.
#    Default to false
#
#  [*debian_push_user*]
#    (Optional) Username for triggering push sync for debian mirror
#    Default to ftp
#
#  [*debian_push_ssh_key*]
#    (Optional) Publish ssh key to accept the push
#    Default to undef
#
#  [*debian_enable_runmirrors*]
#    (Optional) Should this server launch runmirrors to push to other
#    downstream servers
#    Default to false
#
#  [*debian_runmirrors_hostnames*]
#    (Optional) List of downstream hostnames to push to.
#    Default to []
#
# === debian-security/ MIRROR PARAMS ===
#
#  [*sync_debian_security*]
#    (Optional) Should we also rsync /debian-security using ftpsync?
#    Note that debian-security is sync imperatively every hours
#    without using the push facilities.
#    Defaults to true
#
#  [*debian_security_to*]
#    (Optional) Mirror destination.
#    Defaults to '/home/ftp/debian-security/'
#
#  [*debian_security_rsync_host*]
#    (Optional) Source to rsync from for security.
#    Defaults to rsync.security.debian.org.
#
#  [*debian_security_rsync_path*]
#    (Optional) Remote rsync path for the debian-cd repo
#    Defaults to debian-security
#
# === debian-archive/ MIRROR PARAMS ===
#
#  [*sync_debian_archive*]
#    (Optional) Should we also rsync /debian-archive using ftpsync?
#    Defaults to true
#
#  [*debian_archive_to*]
#    (Optional) Mirror destination.
#    Defaults to '/home/ftp/debian-archive/'
#
#  [*debian_archive_rsync_path*]
#    (Optional) Remote rsync path for the debian-archive repo
#    Defaults to debian-archive
#
#  [*debian_archive_rsync_host*]
#    (Optional) Remote rsync path for the debian-archive repo
#    Defaults to archive.debian.org
#
#  [*debian_archive_exclude*]
#    (Optional) Suites to exclude. Default to start only at Jessie,
#    which means cluding: buzz, rex, bo, hamm, slink, potato, woody, sarge, etch, lenny, squeeze, wheezy
#    Default to what's above.
#
# === ubuntu/ MIRROR PARAMS ===
#
#  [*sync_ubuntu*]
#    (Optional) Should we also rsync /debian-ubuntu using ftpsync?
#    Defaults to true
#
#  [*ubuntu_to*]
#    (Optional) Mirror destination.
#    Defaults to '/home/ftp/ubuntu/'
#
#  [*ubuntu_rsync_path*]
#    (Optional) Remote rsync path for the ubuntu repo
#    Defaults to ubuntu
#
#  [*ubuntu_rsync_host*]
#    (Optional) Remote rsync host for the ubuntu repo
#    Defaults to rsync.releases.ubuntu.com
#
#  [*ubuntu_exclude*]
#    (Optional) Suites to exclude, in format --exclude=foo*.
#    Default to '--exclude=precise*'.
#
# === debian-cd/ MIRROR PARAMS ===
#
#  [*sync_debian_cd*]
#    (Optional) Should we also rsync /debian-cd using regular Rsync?
#    Defaults to true
#
#  [*debian_cd_to*]
#    (Optional) Mirror destination.
#    Defaults to '/home/ftp/debian-cd/'
#
#  [*debian_cd_rsync_host*]
#    (Optional) Remote rsync host for the debian-cd repo.
#    Note that the default only contains the latest CD image,
#    not the full archive which is really too big. Use a different
#    mirror to get the full debian-cd archive.
#    Defaults to mirrors.ocf.berkeley.edu
#
#  [*debian_cd_rsync_path*]
#    (Optional) Remote rsync path for the debian-cd repo
#    Defaults to debian-cd
#
class archvsync(
  # Global params
  $manage_apache                        = true,
  $manage_pureftpd                      = true,
  $manage_rsync                         = true,
  $configure_rsync                      = true,
  $package_ensure                       = 'present',
  $mirrorname                           = $facts['networking']['fqdn'],
  $mailto                               = 'toto@example.com',
  $homedir                              = '/home/ftp',
  $info_maintainer                      = 'Toor Op <root@localhost>',
  $info_sponsor                         = 'World Company SA <https://www.example.com>',
  $info_country                         = 'US',
  $info_location                        = 'Nowhere city',
  $info_throughput                      = '10Gb',
  $arch_include                         = 'amd64 source',
  $arch_exclude                         = '',
  $logdir                               = '/var/log/ftpsync',
  $setup_daily_cron                     = true,
  $ftp_user_shell                       = '/bin/bash',

  # debian/ mirror options
  $sync_debian                          = true,
  $debian_to                            = '/home/ftp/debian/',
  $debian_rsync_host                    = 'ftp.fr.debian.org',
  $debian_rsync_path                    = 'debian',
  $debian_exclude                       = '',

  $debian_accept_push                   = false,
  $debian_push_user                     = 'ftp',
  $debian_push_homedir                  = "/home/${debian_push_user}",
  $debian_push_ssh_key                  = undef,
  $debian_enable_runmirrors             = false,
  $debian_runmirrors_hostnames          = [],

  # debian-security mirror options
  $sync_debian_security                 = true,
  $debian_security_to                   = '/home/ftp/debian-security/',
  $debian_security_rsync_host           = 'rsync.security.debian.org',
  $debian_security_rsync_path           = 'debian-security',
  $debian_security_exclude              = '',

  $debian_security_accept_push          = false,
  $debian_security_push_ssh_key         = $debian_push_ssh_key,
  $debian_security_enable_runmirrors    = false,
  $debian_security_runmirrors_hostnames = [],

  # debian-archive mirror options
  $sync_debian_archive                  = true,
  $debian_archive_to                    = '/home/ftp/debian-archive/',
  $debian_archive_rsync_path            = 'debian-archive',
  $debian_archive_rsync_host            = 'archive.debian.org',
  # 
  $debian_archive_exclude               = '--exclude=buzz* --exclude=rex* --exclude=bo* --exclude=hamm* --exclude=slink* --exclude=potato* --exclude=woody* --exclude=sarge* --exclude=etch* --exclude=lenny* --exclude=squeeze* --exclude=wheezy*', # lint:ignore:140chars

  $debian_archive_accept_push           = false,
  $debian_archive_push_ssh_key          = $debian_push_ssh_key,
  $debian_archive_enable_runmirrors     = false,
  $debian_archive_runmirrors_hostnames  = [],

  # ubuntu mirror options
  $sync_ubuntu                          = true,
  $ubuntu_to                            = '/home/ftp/ubuntu/',
  $ubuntu_rsync_host                    = 'rsync.releases.ubuntu.com',
  $ubuntu_rsync_path                    = 'ubuntu',
  $ubuntu_exclude                       = '--exclude=precise*',

  $ubuntu_accept_push                   = false,
  # This is the official Ubuntu push key, as per https://wiki.ubuntu.com/Mirrors/PushMirroring
  $ubuntu_push_user                     = 'ftp',
  $ubuntu_push_homedir                  = "/home/${ubuntu_push_user}",
  $ubuntu_push_ssh_key                  = 'AAAAB3NzaC1yc2EAAAABIwAAAQEAt8xHRbCVFT3Uw/B+TavIlDYRoLMxOKlN3HnBeniFUJTto5Im52FbT3ODfMszz5/BIAnXBf1baWDljHErx4huohh9MxyovZ0h8GYCmMy7dZzsrV5eYhLXd2idCOKIl6gr0BTgTlJOKOgVEoZ2YtiU9MnNzRk3gkBeCMDJrnQOCC8Sko0F0RUJnrzLXOdtvDfNu7Ff+tRNb4PwrU3inbm2YJRnOoZI9vIsv/9DwsMm9d+YIIOz/7y5jLGhZ34nXzhmI6cJO92+Ve5ubhbbpKUFQAh2L1PP6A+I7jHvoWHToSaZlt+DCN4Kg+JlZuf2FXk8MeHkEc6qWWHQTFF8/ArKew==', # lint:ignore:140chars
  $ubuntu_enable_runmirrors             = false,
  $ubuntu_runmirrors_hostnames          = [],

  # debian-cd/ mirror options
  $sync_debian_cd                       = true,
  $debian_cd_to                         = '/home/ftp/debian-cd/',
  $debian_cd_rsync_host                 = 'mirrors.ocf.berkeley.edu',
  $debian_cd_rsync_path                 = 'debian-cd',
) {
  include ::archvsync::deps

  $debian_hub = $debian_enable_runmirrors
  $debian_security_hub = $debian_security_enable_runmirrors
  $debian_archive_hub = $debian_archive_enable_runmirrors
  $ubuntu_hub = $ubuntu_enable_runmirrors

  if $arch_include == ' ' {
    $arch_include_real = ''
  }else{
    $arch_include_real = $arch_include
  }

  group { 'ftp':
    ensure => 'present',
  }
  -> user { 'ftp':
    ensure           => 'present',
    purge_ssh_keys   => true,
    home             => $homedir,
    password         => '!!',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => $ftp_user_shell,
    groups           => ['ftp'],
  }
  -> file { $homedir:
    ensure                  => directory,
    owner                   => ftp,
    mode                    => '0755',
    selinux_ignore_defaults => true,
  }
  -> file { "${homedir}/.config":
    ensure                  => directory,
    owner                   => 'ftp',
    group                   => 'ftp',
    mode                    => '0750',
    selinux_ignore_defaults => true,
  }
  -> file { "${homedir}/.config/ftpsync":
    ensure                  => directory,
    owner                   => 'ftp',
    group                   => 'ftp',
    mode                    => '0750',
    selinux_ignore_defaults => true,
  }
  -> file { "${homedir}/.config/ftpsync/ftpsync.conf":
    ensure                  => file,
    owner                   => 'ftp',
    group                   => 'ftp',
    mode                    => '0640',
    selinux_ignore_defaults => true,
    content                 => template("${module_name}/ftpsync.conf.erb"),
  }

  # Set up users for sync targets if different
  $push_configs = ['debian','ubuntu']
  $push_users = Array($push_configs.each |$x| { getvar("${x}_user") }).unique
  $push_homedirs = Array($push_configs.each |$x| { getvar("${x}_homedir") }).unique

  if $push_users.length() != $push_homedirs.length() {
    fail('number of push users does not match number of their home directories. Check $*_push_user and $*_push_homedir')
  }

  $push_configs.each |$push| {
    $user = getvar("${push}_push_user")
    unless defined(User[$user]) {
      $push_homedir = getvar("${push}_push_homedir")
      group { $user:
        ensure => present,
      }
      -> user { $user:
        ensure           => 'present',
        purge_ssh_keys   => true,
        home             => $push_homedir,
        password         => '!!',
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
        groups           => [$user,'ftp'].unique(),
        require          => Group['ftp'],
      }
      -> file { $push_homedir:
        ensure                  => directory,
        owner                   => $user,
        group                   => $user,
        mode                    => '0750',
        selinux_ignore_defaults => true,
      }
      -> file { "${push_homedir}/.config":
        ensure                  => directory,
        owner                   => $user,
        group                   => $user,
        mode                    => '0750',
        selinux_ignore_defaults => true,
      }
      -> file { "${push_homedir}/.config/ftpsync":
        ensure                  => directory,
        owner                   => $user,
        group                   => $user,
        mode                    => '0750',
        selinux_ignore_defaults => true,
      }
      -> file { "${push_homedir}/.config/ftpsync/ftpsync.conf":
        ensure                  => file,
        owner                   => $user,
        group                   => $user,
        mode                    => '0640',
        selinux_ignore_defaults => true,
        content                 => template("${module_name}/ftpsync.conf.erb"),
      }
    }
  }
  package { 'ftpsync':
    ensure => $package_ensure,
    tag    => ['archvsync-package'],
  }
  file { $logdir:
    ensure                  => directory,
    owner                   => 'ftp',
    group                   => 'ftp',
    mode                    => '0775',
    selinux_ignore_defaults => true,
  }

  # Resources to manage only if using those syncs
  if ($sync_debian or $sync_debian_security or $sync_debian_archive or $sync_debian_cd) {
    $ensure_debian_to = directory
    $ensure_debian_ftpsync = file
  } else {
    $ensure_debian_to = absent
    $ensure_debian_ftpsync = absent
  }
  if $sync_debian_security {
    $ensure_debian_security_to = directory
    $ensure_debian_security_ftpsync = file
  } else {
    $ensure_debian_security_to = absent
    $ensure_debian_security_ftpsync = absent
  }

  if $sync_debian_archive {
    $ensure_debian_archive_to = directory
    $ensure_debian_archive_ftpsync = file
  } else {
    $ensure_debian_archive_to = absent
    $ensure_debian_archive_ftpsync = absent
  }

  if $sync_ubuntu {
    $ensure_ubuntu_to = directory
    $ensure_ubuntu_ftpsync = file
  } else {
    $ensure_ubuntu_to = absent
    $ensure_ubuntu_ftpsync = absent
  }

  file { $debian_to:
    ensure                  => $ensure_debian_to,
    owner                   => $debian_push_user,
    group                   => $debian_push_user,
    mode                    => '0755',
    selinux_ignore_defaults => true,
    require                 => File[$debian_push_homedir]
  }
  file { $debian_security_to:
    ensure                  => $ensure_debian_security_to,
    owner                   => $debian_push_user,
    group                   => $debian_push_user,
    mode                    => '0755',
    selinux_ignore_defaults => true,
    require                 => File[$debian_push_homedir],
  }
  file { $debian_archive_to:
    ensure                  => $ensure_debian_archive_to,
    owner                   => $debian_push_user,
    group                   => $debian_push_user,
    mode                    => '0755',
    selinux_ignore_defaults => true,
    require                 => File[$debian_push_homedir],
  }
  file { $ubuntu_to:
    ensure                  => $ensure_ubuntu_to,
    owner                   => $ubuntu_push_user,
    group                   => $ubuntu_push_user,
    mode                    => '0755',
    selinux_ignore_defaults => true,
    require                 => File[$ubuntu_push_homedir],
  }
  file { "${ubuntu_push_homedir}/.config/ftpsync/ftpsync-ubuntu.conf":
    ensure                  => $ensure_ubuntu_ftpsync,
    owner                   => $ubuntu_push_user,
    group                   => $ubuntu_push_user,
    mode                    => '0644',
    selinux_ignore_defaults => true,
    content                 => template("${module_name}/ftpsync-ubuntu.conf.erb"),
    require                 => File["${ubuntu_push_homedir}/.config/ftpsync"],
  }
  file { "${debian_push_homedir}/.config/ftpsync/ftpsync-security.conf":
    ensure                  => $ensure_debian_security_ftpsync,
    owner                   => $debian_push_user,
    group                   => $debian_push_user,
    mode                    => '0644',
    selinux_ignore_defaults => true,
    content                 => template("${module_name}/ftpsync-security.conf.erb"),
    require                 => File["${debian_push_homedir}/.config/ftpsync"],
  }
  file { "${debian_push_homedir}/.config/ftpsync/ftpsync-archive.conf":
    ensure                  => $ensure_debian_archive_ftpsync,
    owner                   => $debian_push_user,
    group                   => $debian_push_user,
    mode                    => '0644',
    selinux_ignore_defaults => true,
    content                 => template("${module_name}/ftpsync-archive.conf.erb"),
    require                 => File["${debian_push_homedir}/.config/ftpsync"],
  }

  if $setup_daily_cron {
    file { '/etc/cron.daily/ftpsync':
      ensure                  => file,
      owner                   => 'root',
      mode                    => '0755',
      selinux_ignore_defaults => true,
      content                 => template("${module_name}/ftpsync.erb"),
      require                 => Package['ftpsync']
    }
  }else{
    file { '/etc/cron.daily/ftpsync':
      ensure => absent,
    }
  }


  # Configure push recieve
  if $debian_accept_push {
    archvsync::acceptpush { 'debian':
      ssh_user       => $debian_push_user,
      ssh_public_key => $debian_push_ssh_key,
    }
    $ftpsync_debian = ''
  }else{
    $ftpsync_debian = "su ftp -c 'cd ${homedir} ; ftpsync'"
  }

#  notify {"sync_ubuntu: ${sync_ubuntu}": }
  if $sync_debian_cd or $sync_debian_security or $sync_debian_archive or $sync_ubuntu {
    if $sync_debian_security {
      if $debian_security_accept_push {
        archvsync::acceptpush { 'debian-security':
          ssh_user       => $debian_push_user,
          ssh_public_key => $debian_security_push_ssh_key,
        }
        $ftpsync_debian_security = ''
      }else{
        $ftpsync_debian_security = "su ftp -c 'cd ${homedir} ; ftpsync sync:archive:security'"
      }
    }else{
      $ftpsync_debian_security = ''
    }

    if $sync_debian_archive {
      if $debian_archive_accept_push {
        archvsync::acceptpush { 'debian-archive':
          ssh_user       => $debian_push_user,
          ssh_public_key => $debian_push_ssh_key,
        }
        $ftpsync_debian_archive = ''
      }else{
        $ftpsync_debian_archive = "su ftp -c 'cd ${homedir} ; ftpsync sync:archive:archive'"
      }
    }else{
      $ftpsync_debian_archive = ''
    }

    if $sync_ubuntu {
#      notify {"ubuntu_accept_push: ${ubuntu_accept_push}": }
      if $ubuntu_accept_push {
#        notify {"Adding archvsync::acceptpush with name=ubuntu": }
        archvsync::acceptpush { 'ubuntu':
          ssh_user       => $ubuntu_push_user,
          ssh_public_key => $ubuntu_push_ssh_key,
        }
        $ftpsync_ubuntu = ''
      }else{
        $ftpsync_ubuntu = "su ftp -c 'cd ${homedir} ; ftpsync sync:archive:ubuntu'"
      }
    }else{
      $ftpsync_ubuntu = ''
    }

    if $sync_debian_cd {
      $rsync_debian_cd = "su ftp -c 'rsync -av --delete ${debian_cd_rsync_host}::${$debian_cd_rsync_path} ${debian_cd_to}'"
    }else{
      $rsync_debian_cd = ''
    }


    $rsync_script = "#!/bin/sh
#set -e

${ftpsync_debian}
${ftpsync_debian_archive}
${ftpsync_ubuntu}
${rsync_debian_cd}
exit 0
"

    $rsync_script_security = "#!/bin/sh
set -e

${ftpsync_debian_security}
exit 0
"
    if $sync_debian_cd or
      ($sync_debian         and $debian_accept_push != true) or
      ($sync_debian_archive and $debian_archive_accept_push != true) or
      ($sync_ubuntu         and $ubuntu_accept_push != true) {
      file { '/etc/cron.daily/archvsync-rsync':
        ensure                  => file,
        owner                   => 'root',
        mode                    => '0755',
        selinux_ignore_defaults => true,
        content                 => $rsync_script,
        require                 => Package['rsync']
      }
    }
    if $sync_debian_security and $debian_security_accept_push != true {
      file { '/etc/cron.hourly/archvsync-rsync':
        ensure                  => file,
        owner                   => 'root',
        mode                    => '0755',
        selinux_ignore_defaults => true,
        content                 => $rsync_script_security,
        require                 => Package['rsync']
      }
    }else{
      file { '/etc/cron.hourly/archvsync-rsync':
        ensure                  => absent,
      }
    }
  }

  # Configure Apache
  if $manage_apache {
    class { '::archvsync::apache': }
  }

  # Configure pure-ftpd
  if $manage_pureftpd {
    class { '::archvsync::pureftpd':
      package_ensure => $package_ensure,
    }
  }

  # Configure rsync, so we accept other servers to rsync us
  if $manage_rsync {
    class { '::archvsync::rsync':
      configure_rsync => $configure_rsync,
    }
  }

#  notify {"debian_enable_runmirrors : ${debian_enable_runmirrors}": }
  # Configure so we can push to other servers
  if $debian_enable_runmirrors {
#    notify {"Activating runmirror for debian": }
    archvsync::runmirrors { 'debian':
      homedir              => $homedir,
      runmirrors_mailto    => $mailto,
      runmirrors_logdir    => $logdir,
      runmirrors_hostnames => $debian_runmirrors_hostnames,
    }
  }

#  notify {"debian_security_enable_runmirrors : ${debian_security_enable_runmirrors}": }
  if $debian_security_enable_runmirrors{
#    notify {"Activating runmirror for debian-security": }
    archvsync::runmirrors { 'security':
      homedir              => $homedir,
      runmirrors_mailto    => $mailto,
      runmirrors_logdir    => $logdir,
      runmirrors_hostnames => $debian_security_runmirrors_hostnames,
    }
  }

#  notify {"debian_archive_enable_runmirrors : ${debian_archive_enable_runmirrors}": }
  if $debian_archive_enable_runmirrors{
#    notify {"Activating runmirror for debian-archive": }
    archvsync::runmirrors { 'archive':
      homedir              => $homedir,
      runmirrors_mailto    => $mailto,
      runmirrors_logdir    => $logdir,
      runmirrors_hostnames => $debian_archive_runmirrors_hostnames,
    }
  }

#  notify {"ubuntu_enable_runmirrors : ${ubuntu_enable_runmirrors}": }
  if $ubuntu_enable_runmirrors{
#    notify {"Activating runmirror for ubuntu": }
    archvsync::runmirrors { 'ubuntu':
      homedir              => $homedir,
      runmirrors_mailto    => $mailto,
      runmirrors_logdir    => $logdir,
      runmirrors_hostnames => $ubuntu_runmirrors_hostnames,
    }
  }
}
