# Builds from source, so no Apple Developer ID or notarization is needed.
class Pult < Formula
  desc "Apply one palette across your terminal apps, and undo every change"
  homepage "https://git.subcult.tv/subculture-collective/pult"
  url "https://git.subcult.tv/subculture-collective/pult/releases/download/v0.3.0/pult-0.3.0-src.tar.gz"
  sha256 "1bd70a9a112f6b94eeb62ad52f7372a94e76eb5dd75d9a05a119b004695b18cc"
  license all_of: ["GPL-3.0-only", "MIT"]

  depends_on "go" => :build

  resource "catalog" do
    url "https://git.subcult.tv/subculture-collective/pult/releases/download/v0.3.0/pult-0.3.0-catalog.db.zst"
    sha256 "5c8aa7a5bf4d96964c6202966e6a33de55bb8776d61842cd94c548f5006ff477"
  end

  def install
    resource("catalog").stage { cp Dir["*"].first, buildpath/"builtin/catalog.db.zst" }
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version} -X git.subcult.tv/subculture-collective/pult.BuiltinVersion=2026.11.10.0", output: bin/"pult"), "./cmd/pult"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pult version")
    assert_match "catalog included", shell_output("#{bin}/pult doctor -state #{testpath}/state")
  end
end
