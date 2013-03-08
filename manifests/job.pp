define jenkins::job(
  $job_name = $title,
  $git_repo,
  $git_branch,
  $git_clean = true,
  $git_wipe_out_workspace = false,
  $command,
  $build_schedule = false,
  $poll = true,
  $url_trigger = {},
  $script_trigger = {},
  $triggers = [],
  $random_ports = [],
  $html_publisher = [],
  $log_rotator = {},
  $artifacts = false,
  $properties = [],
  $image_gallery = {},
  $junit_result = {},
  $description = '',
  $nag_devchat = true
) {
  file { "/var/lib/jenkins/jobs/${job_name}":
    ensure => directory,
    owner => jenkins,
    group => nogroup,
    mode => 0755
  }

  file { "/var/lib/jenkins/jobs/${job_name}/config.xml":
    ensure => file,
    owner => jenkins,
    group => nogroup,
    mode => 0644,
    content => strip(template("jenkins/job_config.xml.erb")),
    notify => Class['jenkins::service']
  }
}
