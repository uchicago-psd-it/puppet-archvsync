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
  $ssh_home_dir = '/home/ftp',
  $ssh_public_key = undef,
  $ssh_key_type = 'ssh-rsa',
){

  $ssh_wrapper = "/home/ftp/.ssh/accept_push_wrapper"
  ssh_authorized_key { "archvsync_acceptpush_${name}":
    ensure  => present,
    key     => $ssh_public_key,
    type    => $ssh_key_type,
    user    => 'ftp',
    options => [
      "command=\"${ssh_wrapper} &\"",
      'no-port-forwarding',
      'no-X11-forwarding',
      'no-agent-forwarding',
      'no-pty'
    ],
  }
}
