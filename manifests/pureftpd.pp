# == Class: archvsync::apache
#
# Configures Apache for a Debian mirror.
#
# === Parameters
#
#  [*package_ensure*]
#    (Optional) Ensure state for package.
#    Defaults to 'present'
#
class archvsync::pureftpd (
  $package_ensure = 'present',
){
  include ::archvsync::deps

  package { 'pure-ftpd':
    ensure => $package_ensure,
    tag    => ['pure-ftpd-package'],
  }
  service { 'pure-ftpd':
    ensure  => 'running',
    enable  => true,
    require => Package['pure-ftpd'],
  }
  file {'/etc/pure-ftpd/conf/NoAnonymous':
    ensure  => absent,
    notify  => Service['pure-ftpd'],
    require => Package['pure-ftpd'],
  }
  file {'/etc/pure-ftpd/conf/AnonymousCantUpload':
    ensure  => present,
    notify  => Service['pure-ftpd'],
    require => Package['pure-ftpd'],
    content => 'Yes',
  }
  file {'/etc/pure-ftpd/conf/AnonymousOnly':
    ensure  => present,
    notify  => Service['pure-ftpd'],
    require => Package['pure-ftpd'],
    content => 'Yes',
  }
}
