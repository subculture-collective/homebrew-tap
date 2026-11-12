class SuperProductivityMcp < Formula
  desc "MCP server that lets AI clients read and change Super Productivity tasks"
  homepage "https://github.com/subculture-collective/super-productivity-mcp"
  url "https://github.com/subculture-collective/super-productivity-mcp/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f441f88110e2a4ae3bfa293e23707cbb2977c8b54220edf24afbe312961f51a8"
  license "MIT"

  depends_on "go" => :build

  # The Super Productivity plugin the server talks to, as released.
  resource "plugin" do
    url "https://github.com/subculture-collective/super-productivity-mcp/releases/download/v0.2.0/super-productivity-mcp-plugin-v0.2.0.zip",
        using: :nounzip
    sha256 "1b1142ce69e07d3a791d0c700bfc78a456cc2ba62eb01bfab829808a4069ac6c"
  end

  def install
    module_path = "github.com/PatrickFanella/super-productivity-mcp"
    ldflags = "-s -w -X #{module_path}/internal/version.BinaryVersion=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"sp-mcp"), "./cmd/sp-mcp"
    system "go", "build", *std_go_args(ldflags:, output: bin/"sp-quick-add"), "./cmd/sp-quick-add"
    resource("plugin").stage { pkgshare.install Dir["*.zip"].first => "super-productivity-mcp-plugin.zip" }
  end

  def caveats
    <<~EOS
      Install the plugin in Super Productivity (Settings > Plugins > Upload Plugin):
        #{opt_pkgshare}/super-productivity-mcp-plugin.zip
      Then point your AI client at:
        #{opt_bin}/sp-mcp
    EOS
  end

  test do
    ENV["SP_MCP_DATA_DIR"] = testpath/"data"
    request = '{"jsonrpc":"2.0","id":1,"method":"initialize",' \
              '"params":{"protocolVersion":"2024-11-05","capabilities":{},' \
              '"clientInfo":{"name":"brew","version":"0"}}}'
    output = pipe_output(bin/"sp-mcp", "#{request}\n", 0)
    assert_match "\"version\":\"#{version}\"", output
    assert_path_exists pkgshare/"super-productivity-mcp-plugin.zip"
  end
end
