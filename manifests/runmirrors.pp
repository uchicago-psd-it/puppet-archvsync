define archvsync::runmirrors (
  $homedir                 = '/home/ftp',
  $runmirrors_mailto       = undef,
  $runmirrors_ssh_key_file = '.ssh/id_rsa',
  $runmirrors_logdir       = undef,
  $runmirrors_hostnames   = [],
){

  $runmirrors_ssh_key_path = "${homedir}/${runmirrors_ssh_key_file}"

  if $name == 'debian' {
    $runmirrors_pushargs = 'ftpsync'
    $runmirrors_conf_file = "${homedir}/.config/ftpsync/runmirrors.conf"
    $runmirrors_mirror_file = "${homedir}/.config/ftpsync/runmirrors.mirror"
  }else{
    $runmirrors_pushargs = "ftpsync sync:archive:${name}"
    $runmirrors_conf_file = "${homedir}/.config/ftpsync/runmirrors-${name}.conf"
    $runmirrors_mirror_file = "${homedir}/.config/ftpsync/runmirrors-${name}.mirror"
  }

  file { $runmirrors_conf_file:
    ensure                  => file,
    owner                   => ftp,
    mode                    => '0644',
    selinux_ignore_defaults => true,
    content                 => template("${module_name}/runmirrors.conf.erb"),
  }

# This will produce something like this:
# all hostname-a.ch ssh+ftpsync://ftp@hostname-a.ch
# all hostname-b.ch ssh+ftpsync://ftp@hostname-b.ch

  $runmirrors_template = '<%- if @runmirrors_hostnames and @runmirrors_hostnames != "" -%>
<%-   Array(@runmirrors_hostnames).each do |runmirrors_hostname| -%>
staged <%= runmirrors_hostname %> <%= runmirrors_hostname %> ftp 2
<%-   end -%>
<%- end -%>'

  file { $runmirrors_mirror_file:
    owner                   => 'ftp',
    group                   => 'ftp',
    content                 => inline_template($runmirrors_template),
    selinux_ignore_defaults => true,
    mode                    => '0644',
  }
}
