define jenkins::plugin(
  $version    = 0,
  $plugin     = "${title}.hpi",
  $plugin_dir = "/var/lib/jenkins/plugins"
) {
  if ($version != 0) {
    $base_url = "http://updates.jenkins-ci.org/download/plugins/${title}/${version}/"
  } else {
    $base_url = "http://updates.jenkins-ci.org/latest/"
  }

  exec {
    "download-${title}" :
      command  => "wget --no-check-certificate ${base_url}${plugin}",
      cwd      => $plugin_dir,
      require  => File[$plugin_dir],
      path     => ["/usr/bin", "/usr/sbin"],
      user     => "jenkins",
      unless   => "test -f ${plugin_dir}/${plugin}",
      notify   => Service['jenkins'];
  }
}
