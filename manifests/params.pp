class customservice::params {

  $log_dir     = "/var/log/${name}"
  $lib_dir     = "/var/lib/${name}"
  $desc        = "Custom service for ${name} managed by Puppet"
  $short_desc  = "Custom service for ${name}"
  $daemon      = undef
  $daemon_args = undef
  $pidfile     = "/var/run/${name}.pid"
  $script      = "/etc/init.d/${name}"
  $user        = "${name}"
  $group       = "${name}"
  
}
