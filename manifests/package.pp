class jenkins::package {
  file { "/usr/share/jenkins-key":
    ensure => file,
    owner => "root",
    group => "root",
    mode => "0644",
    source => "puppet:///modules/jenkins/jenkins-ci.org.key",
  }

  exec { "add_jenkins_apt_key":
    command => "apt-key add /usr/share/jenkins-key",
    unless => "apt-key list | grep 10AF40FE",
    require => File["/usr/share/jenkins-key"]
  }

  file { "/etc/apt/sources.list.d/jenkins.list":
    ensure => file,
    source => "puppet:///modules/jenkins/jenkins.list",
    owner => "root",
    group => "root",
    mode => "0644",
    require => Exec["add_jenkins_apt_key"],
    notify => Exec["apt-update"]
  }

  package { "jenkins":
    ensure => installed,
    require => File["/etc/apt/sources.list.d/jenkins.list"]
  }

  exec { "git-plugin" :
    command => "/bin/sh -c 'cd /var/lib/jenkins/plugins && wget http://updates.jenkins-ci.org/download/plugins/git/1.1.26/git.hpi'",
    unless => "test -f /var/lib/jenkins/plugins/git.hpi",
    user => 'jenkins',
    require => Package[jenkins],
    notify => Class['jenkins::service']
  }
}
