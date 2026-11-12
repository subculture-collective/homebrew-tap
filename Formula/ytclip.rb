class Ytclip < Formula
  desc "Download a YouTube video or a timestamped clip with yt-dlp and ffmpeg"
  homepage "https://github.com/subculture-collective/ytclip"
  url "https://github.com/subculture-collective/ytclip/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b0ec6d88d19fc373c827d4b15a4804a5f0b2d6df716e9ba82ac0934f2a9de7ea"
  license "MIT"

  depends_on "bash"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    # ytclip needs Bash 4.3 or newer; macOS ships 3.2 as /bin/bash.
    inreplace "bin/ytclip", %r{\A#!/usr/bin/env bash}, "#!#{Formula["bash"].opt_bin}/bash"
    bin.install "bin/ytclip"
    bash_completion.install "completions/bash/ytclip"
  end

  test do
    assert_match "ytclip #{version}", shell_output("#{bin}/ytclip --version")
  end
end
