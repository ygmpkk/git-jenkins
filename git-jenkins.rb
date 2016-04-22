class GitJenkins < Formula
  desc "Jenkins cli for git subcommand"
  homepage "https://github.com/ygmpkk/git-jenkins"
  url "https://github.com/ygmpkk/git-jenkins/archive/1.0.0.tar.gz"
  version "1.0.0"
  sha256 ""

  depends_on "jsawk"

  def install
    bin.install "jenkins-cli"
    bin.install "git-jenkins"
  end

  test do
    system "#{bin}/git-jenkins"
  end
end
