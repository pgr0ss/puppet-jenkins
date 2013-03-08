class jenkins::user {
  user { "jenkins":
    gid => nogroup,
    home => "/var/lib/jenkins",
    shell => "/bin/bash"
  }

  file { "/var/lib/jenkins":
    ensure => directory,
    owner => jenkins,
    group => adm,
    mode => 0755,
    require => User[jenkins]
  }
}
