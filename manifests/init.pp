class jenkins($slaves, $views) {
  class { "jenkins::files": slaves => $slaves, views => $views }
  include jenkins::files
  include jenkins::package
  include jenkins::service
  include jenkins::user

  Class['jenkins::user'] -> Class['jenkins::package'] -> Class['jenkins::files'] -> Class['jenkins::service']
}
