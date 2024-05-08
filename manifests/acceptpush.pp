# == class: archvsync::acceptpush
#
# archvsync::acceptpush class.
#
# === parameters:
#
#  [*homedir*]
#  homedir for the ssh
#
#  [*ssh_public_key*]
#  Public key allowed to push.
#
#  [*ssh_key_type*]
#  (Optional) ssh key type.
#  Default: 'ssh-rsa'
#
define archvsync::acceptpush (
  $ssh_user       = 'ftp'
  $ssh_home_dir   = "/home/${ssh_user}",
  $ssh_public_key = undef,
  $ssh_key_type   = 'ssh-rsa',
){

  ssh_authorized_key { "archvsync_acceptpush_${name}":
    ensure  => present,
    key     => $ssh_public_key,
    type    => $ssh_key_type,
    user    => $ssh_user,
    options => [
      "command=\"/usr/bin/ftpsync &\"",
      'no-port-forwarding',
      'no-X11-forwarding',
      'no-agent-forwarding',
      'no-pty'
    ],
  }
}
