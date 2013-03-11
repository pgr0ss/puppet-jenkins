Facter.add("jenkins_version") do
  setcode do
    begin
      Facter::Util::Resolution.exec("dpkg -p jenkins 2>/dev/null | grep Version | sed 's/Version://'").strip
    rescue
      nil
    end
  end
end
