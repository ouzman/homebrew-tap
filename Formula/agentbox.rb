class Agentbox < Formula
  desc "Run coding agents in throwaway containers with a dind sidecar"
  homepage "https://github.com/ouzman/agentbox"
  url "https://github.com/ouzman/agentbox/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "2fecf0b69826a610f6c166f70380bcd7bff3388503c26a9cc6fb4455e803e277"
  head "https://github.com/ouzman/agentbox.git", branch: "main"

  def install
    bin.install "agentbox"
    %w[bclaude bpi bcursor-agent].each do |name|
      bin.install_symlink "agentbox" => name
    end
  end

  def caveats
    <<~EOS
      Requires a docker CLI (Docker Desktop, colima, ...).
      Remove any old `agentbox` shell function / b* aliases from your shell rc,
      otherwise they shadow these commands.
    EOS
  end

  test do
    assert_match "usage: agentbox", shell_output("#{bin}/agentbox 2>&1", 1)
    assert_equal "agentbox", File.readlink(bin/"bclaude")
  end
end
