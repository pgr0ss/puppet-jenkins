class jenkins::files(
  $url,
  $email_address,
  $slaves,
  $views
) {
  file { "/var/lib/jenkins/config.xml":
    ensure => file,
    owner => jenkins,
    group => nogroup,
    mode => 0644,
    content => strip(template("jenkins/config.xml.erb")),
    notify => Class['jenkins::service']
  }

  file { "/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml":
    ensure => file,
    owner => jenkins,
    group => nogroup,
    mode => "0644",
    content => strip(template("jenkins/jenkins.model.JenkinsLocationConfiguration.xml.erb")),
    notify => Class['jenkins::service']
  }

  file { "/var/lib/jenkins/jobs":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true
  }

  file { "/var/lib/jenkins/plugins":
    ensure => directory,
    owner => jenkins,
    group => nogroup
  }
}
