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
  version "1.0.20"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "22595e2090a75437ec30d24ce4ab097b6656186292491abce25ebf82bf98b899"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "24f26050e9d88280b923a9ba840af682c24a9400ebcca793965f73f8469d1ad8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cc96ddfe7a2a178e2bdcad8ce59c1a0c3464df7ca12221d45fb03f03ab6a913a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8cdfe06415e1d313b867a50a9b164700cdb35df495d6c70c044d6dca9abe92ea"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "3ac2c6a26dc6f41c8e2d2e6aa9292f9266d66eb0b0b948b09202d9a8ffd64b48"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "5ef53d4ef9ed636abdb33dd2b67ce66636394ee6a3b916f553271f951886d7d5"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "fcd453d96a0906977376e620ecdc159d3abad23d08aa72a795491ffd0322049b"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.20/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "644a3fc48404d735be34ca7d8ca40e2e0940745a4f39debaaab9d340bd9122e7"
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
