class archvsync::rsync (
  $configure_rsync = true,
){

  package { 'rsync':
    ensure      => 'latest',
    configfiles => 'keep',
    tag         => ['rsync'],
    notify      => Service['rsync'],
  }

  if $configure_rsync {
    file { '/etc/rsyncd.conf':
      ensure                  => file,
      owner                   => 'root',
      content                 => 'uid = nobody
gid = nogroup
max connections = 50
socket options = SO_KEEPALIVE

[debian]
	comment = The Debian Archive (https://www.debian.org/mirror/size)
	path = /home/ftp/debian
	use chroot = yes
	lock file = /var/lock/rsyncd
	read only = yes
	list = yes
	strict modes = yes
	ignore errors = no
	ignore nonreadable = yes
	transfer logging = no
	dont compress = *
[debian-cd]
	comment = The Debian Archive (https://www.debian.org/mirror/size)
	path = /home/ftp/debian-cd
	use chroot = yes
	lock file = /var/lock/rsyncd
	read only = yes
	list = yes
	strict modes = yes
	ignore errors = no
	ignore nonreadable = yes
	transfer logging = no
	dont compress = *
[debian-archive]
	comment = The Debian Archive (https://www.debian.org/mirror/size)
	path = /home/ftp/debian-archive
	use chroot = yes
	lock file = /var/lock/rsyncd
	read only = yes
	list = yes
	strict modes = yes
	ignore errors = no
	ignore nonreadable = yes
	transfer logging = no
	dont compress = *
[debian-security]
	comment = The Debian Security Archive
	path = /home/ftp/debian-security
	use chroot = yes
	lock file = /var/lock/rsyncd
	read only = yes
	list = yes
	strict modes = yes
	ignore errors = no
	ignore nonreadable = yes
	transfer logging = no
	dont compress = *
[ubuntu]
	comment = The Debian Archive (https://www.debian.org/mirror/size)
	path = /home/ftp/ubuntu
	use chroot = yes
	lock file = /var/lock/rsyncd
	read only = yes
	list = yes
	strict modes = yes
	ignore errors = no
	ignore nonreadable = yes
	transfer logging = no
	dont compress = *
',
      selinux_ignore_defaults => true,
      mode                    => '0644',
      notify                  => Service['rsync'],
    }

    file { '/etc/default/rsync':
      ensure                  => file,
      owner                   => 'root',
      content                 => 'RSYNC_ENABLE=true
',
      selinux_ignore_defaults => true,
      mode                    => '0644',
      notify                  => Service['rsync'],
    }
  }

  service { 'rsync':
    ensure => running,
    enable => true,
  }
}
