# == Class: archvsync::apache
#
# Configures Apache for a Debian mirror.
#
# === Parameters
#
# [*bind_address*]
#   (optional) Bind address in Apache. (Defaults to '0.0.0.0')
#
# [*servername*]
#   (Optional) Server Name
#   Defaults to ::fqdn.
#
# [*server_aliases*]
#   (optional) List of names which should be defined as ServerAlias directives
#   in vhost.conf.
#   Defaults to ::fqdn.
#
# [*http_port*]
#   (optional) Port to use for the HTTP virtual host. (Defaults to 80)
#
# [*priority*]
#   (optional) The apache vhost priority.
#   Defaults to '15'. To set the Debian mirror as the primary vhost, change to '10'.
#
# [*vhost_conf_name*]
#   (Optional) Description
#   Defaults to 'debmirror_vhost'.
#
# [*redirect_type*]
#   (optional) What type of redirect to use when redirecting an http request
#   for a user. This should be either 'temp' or 'permanent'. Setting this value
#   to 'permanent' will result in the use of a 301 redirect which may be cached
#   by a user's browser.  Setting this value to 'temp' will result in the use
#   of a 302 redirect which is not cached by browsers and may solve issues if
#   users report errors accessing the Debian mirror.
#   Defaults to 'permanent'
#
#  [*access_log_format*]
#    (optional) The log format to use to the access log.
#    Defaults to false
#
class archvsync::apache (
  $bind_address                = undef,
  $servername                  = $::fqdn,
  $server_aliases              = $::fqdn,
  $http_port                   = 80,
  $access_log_format           = false,
  $redirect_type               = 'permanent',
  $priority                    = '10',
  $vhost_conf_name               = 'debmirror_vhost',
){

  include ::archvsync::deps
  include ::apache

  $default_vhost_conf_no_ip = {
    default_vhost               => false,
    servername                  => $servername,
    serveraliases               => any2array($server_aliases),
    docroot                     => '/var/www/html',
    access_log_file             => 'debian_mirror_access.log',
    access_log_format           => $access_log_format,
    error_log_file              => 'debian_mirror_error.log',
    priority                    => $priority,
    aliases                     => [{
      alias => "${root_url_real}/debian",
      path  => "${root_path}/home/ftp/debian",
    },
    {
      alias => "${root_url_real}/debian-cd",
      path  => "${root_path}/home/ftp/debian-cd",
    },
    {
      alias => "${root_url_real}/debian-security",
      path  => "${root_path}/home/ftp/debian-security",
    },
    {
      alias => "${root_url_real}/debian-archive",
      path  => "${root_path}/home/ftp/debian-archive",
    },
    {
      alias => "${root_url_real}/ubuntu",
      path  => "${root_path}/home/ftp/ubuntu",
    }],
    directories         => [
    {  'path'                => '/home/ftp/debian',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },
    {  'path'                => '/home/ftp/ubuntu',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },
    {  'path'                => '/home/ftp/debian-cd',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },
    {  'path'                => '/home/ftp/debian-security',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },
    {  'path'                => '/home/ftp/debian-archive',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },
    {  'path'                => '/var/www/html',
       'options'             => 'Indexes FollowSymLinks MultiViews',
       'allow_override'      => 'None',
       'Require'             => 'all granted',
      },      ],
    port                        => $http_port,
    redirectmatch_status        => $redirect_type,
  }

  if $bind_address {
    $default_vhost_conf = merge($default_vhost_conf_no_ip, { ip => $bind_address })
  } else {
    $default_vhost_conf = $default_vhost_conf_no_ip
  }

  ensure_resource('apache::vhost', $vhost_conf_name, $default_vhost_conf)

}
