define customservice::config (

  $log_dir     = "/var/log/${name}",
  $lib_dir     = "/var/lib/${name}",
  $desc        = "Custom service for ${name} managed by Puppet",
  $short_desc  = "Custom service for ${name}",
  $daemon      = undef,
  $daemon_args = undef,
  $pidfile     = "/var/run/${name}.pid",
  $script      = "/etc/init.d/${name}",
  $user        = "${name}",
  $group       = "${name}",
  
)  {

  group { "${group}":
    ensure => 'present',
  }

  user { "${user}":
    ensure  => 'present',
    gid     => "${group}",
    require => Group["${group}"],
  }

  service { "${name}" :
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [
                  File["/etc/init.d/${name}"],
                  User["${user}"],
                 ]
  }

  file { "/etc/init.d/${name}" :
    ensure  => present,
    content => template('customservice/service.erb'),
    mode    => 'a+x',
    owner   => 'root',
    group   => 'root',
    require => [
                File["${log_dir}"],
                File["${lib_dir}"],
                ],
  }

  file { ["${log_dir}","${lib_dir}"]:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

}
