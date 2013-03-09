Facter.add("jenkins_version") do
  setcode do
    Facter::Util::Resolution.exec("dpkg -p jenkins | grep Version | sed 's/Version://'").strip
  end
end
