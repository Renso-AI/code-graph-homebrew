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
  version "1.0.25"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "196c4a1966337d1c45508eba42da8068e2bf25a000379059ff52b91403038d25"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "9b56f6e18e6872cb854b396e05c4d357568d955a6819bbc64bc1fb323727d4a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1c71efc2a7f336a5c47981d502ae71a0f022f3eb7c58db48068e33dd3332a78f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3668a4d704896f2c5b81a5bdfc48581b179806e7b56f8839584e3b6447db551b"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "05e4e37a5dbfbb7e2b9e933b0808bcee84ff5b001d230165a184032dfe320624"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "9c55c3d9867d29228e97ba982ff740691aeaca4fd61339a725b7a1385c95c782"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c031c6587c9a7dcc0e28a1f4972f345c2c6e4811c4dc1910bcf7d551a07b9104"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.25/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1ad7743bb8982dc8d2928e1d25d4e621599de607f4a6b339ef1d7e99544abcf5"
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
