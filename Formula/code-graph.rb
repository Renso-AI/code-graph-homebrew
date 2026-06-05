# Code Graph — Homebrew formula
#
# Templated by packaging/source/homebrew/render.py from
# packaging/_shared/bin-manifest.json. The published copy lives in
# github.com/renso-ai/homebrew-tap/Formula/code-graph.rb.

class CodeGraph < Formula
  desc "Dependency graph analyzer for code, tests, docs, and policy surfaces"
  homepage "https://cg.renso.ai"
  # Proprietary, closed-source software (c) Renso AI; not an SPDX/OSS license.
  license :cannot_represent
  version "1.0.27"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "9962a4cf772f7c327157bc1aaaa80eef1b8c7c6bf5f8a6a5ec5f460511b05b60"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "fb1da31e0faddcc6ae1c59be4303b6b8f7071efec92f24b4b4d20150da37051d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9aeb251168539637f788730a4a9159546cabd37d03831fe0ab51cd4c95166c92"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb328c9380fdc3453f883cf475a3def0d1ceaec5b8c8e98e83e2b52fe1cbef7b"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "49bd256871b39961282dc657601ae5905d22a8a873d0648bcb555c346f62bd68"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "9a1ea7cd7e97e7027dab2b2c16cc99308948ceb9aca748c1d232816d687c9ba0"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "dffa493f04ee7c26023ede7ba225dfc4e0e03cfe4c45121511b25c315942aaa4"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.27/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "870ff1f74bbb0aa682c98dd9f4870f52acc543d9879d8c4b27fc43635dfc62c3"
      end
    end
  end

  def install
    bin.install "code_graph"
    resource("code_graph-mcp").stage do
      bin.install "code_graph-mcp"
    end
  end

  def caveats
    <<~EOS
      Register the MCP server with your LLM client (Claude Desktop,
      Cursor, Codex, Renso Code) so it picks up code_graph
      automatically:

        code_graph-mcp --register

      Full docs:  https://cg.renso.ai/docs
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/code_graph --version")
    assert_match version.to_s, shell_output("#{bin}/code_graph-mcp --version")
  end
end
