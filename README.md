# puppet-jenkins

This is a [Puppet](https://puppetlabs.com/puppet/what-is-puppet/) module which automates the installation and configuration of jenkins, including jobs and slaves.

## Example

```
node "jenkins-master" {
  class { jenkins:
    url => "http://ci.example.com",
    email_address => "ci@example.com",
    slaves => ["jenkins-slave01", "jenkins-slave02"],
    views => [
      ["All", ".*"],
      ["Master", ".*master.*"],
      ["Release", ".*release.*"],
    ]
  }

  jenkins::job { "app1_master":
    git_repo => "https://github.com/user/app1",
    git_branch => "master",
    command => "./ci.sh",
    triggers => ["app1_master_integration"]
  }

  jenkins::job { "app1_master_integration":
    git_repo => "https://github.com/user/app1",
    git_branch => "master",
    command => "./ci.sh integration",
    poll => false,
    build_schedule => "H H * * *"
  }
}
```

## Features

* This module recursively manages jenkins directories, so if you remove a job configuration, it will remove the job in jenkins (no orphaned jobs)
* Jenkins is restarted on changes, so the running jenkins always reflects the files on disk
* Jobs are very customizable. Take a look at [job.pp](https://github.com/pgr0ss/puppet-jenkins/blob/master/manifests/job.pp)

## Installation

One way to include this module in your puppet repository is to add it as a submodule:

```bash
git submodule add https://github.com/pgr0ss/puppet-jenkins.git modules/jenkins
git submodule update --init
```

## License

puppet-jenkins is released under the [MIT license](http://www.opensource.org/licenses/MIT).
