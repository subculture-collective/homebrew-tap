class Twitchdl < Formula
  desc "Download Twitch clips and VODs and record live streams"
  homepage "https://github.com/subculture-collective/twitchdl"
  url "https://github.com/subculture-collective/twitchdl/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2d216f17d26c9a9e68c126e6044077f6e1145976682ec57f990ae2e3b4ab11ab"
  license "GPL-3.0-only"

  depends_on "go" => :build
  depends_on "ffmpeg"
  depends_on "streamlink"
  depends_on "yt-dlp"

  def install
    ldflags = "-s -w -X git.subcult.tv/subculture-collective/twitchdl/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/twitchdl"
    generate_completions_from_executable(bin/"twitchdl", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/twitchdl --version")
    # doctor finds the media tools this formula depends on.
    assert_match "streamlink", shell_output("#{bin}/twitchdl doctor")
  end
end
