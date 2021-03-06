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
    hasstatus  => false,
    hasrestart => false,
    enable     => true,
    require    => [
                  File["init script for ${name}"],
                  User["${user}"],
                   ],
  }

  if $initsystem == 'systemd' {  
    file { "/etc/systemd/system/${name}.service" :
      ensure  => present,
      content => template('customservice/systemd.erb'),
      mode    => 'a+x',
      owner   => 'root',
      group   => 'root',
      require => [
                  File["${log_dir}"],
                  File["${lib_dir}"],
                  ],
      alias   => "init script for ${name}"
    }
  } else {
    file { "/etc/init.d/${name}" :
      ensure  => present,
      content => template('customservice/init.erb'),
      mode    => 'a+x',
      owner   => 'root',
      group   => 'root',
      require => [
                  File["${log_dir}"],
                  File["${lib_dir}"],
                  ],
      alias   => "init script for ${name}"
    }

  }
  
  file { ["${log_dir}","${lib_dir}"]:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

}
