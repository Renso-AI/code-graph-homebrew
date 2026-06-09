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
  version "1.1.6"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "4fac8832403536451d3db9149433b7c430addfef831cfe0d29ee30691f976090"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "3e2f66398df57b3ff3d97e046581c7a4aa8d8031d881d004d33e6a31eaa573f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aaf2fa377e20669570b7d8528be589a12e97f5a6b26306a8a0f806171159394a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "306fd6bc86bf8c10476aa450b45ce723f0ae75adbc991abf0de996bb005880f5"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "cffebb494619b373ee081a71143aa2e138bb01957fa9449a8c795602d95d9763"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "6fadaf216a06c4233da606ea3b155786095ad515298b071e6bf46ab13419b566"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "3e59d57f3d41f9dafe24162ded7a1cc00cb0d78316d16489b14b61b79e9e0854"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.6/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8402bd12880f3195f05235be07f624ddc06ca9dba188cc0d8d8f402f1236e19a"
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
