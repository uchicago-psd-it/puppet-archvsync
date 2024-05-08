# == Class: archvsync::deps
#
# Debian mirror anchors and dependency management
#
class archvsync::deps {

  anchor { 'archvsync::install::begin': }
  -> Package<| tag == 'archvsync-package' |>
  ~> Package<| tag == 'pure-ftpd-package' |>
  -> Service<| title == 'httpd' |>
  ~> anchor { 'archvsync::service::end': }

}
