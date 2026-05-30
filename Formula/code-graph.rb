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
  version "1.0.19"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "93c4eefb933bbb8f851f3cfe7d8b1ebd3ad6f05c0e1e42f65b4f6173f2c9cd63"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "4520ff4da46501c58048dea4d0feae67785bd2721b33dae5fd7f9c46f529d87e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "da5de8974b8bc01cb7007e3015a11cdf1a3a452e4877cfd572100dc141baf9d6"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54c153c5659fa7dc468b2ed7cf41bf1942c98e9335253978821beca538775fbd"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "02dbcaefe674011147e3ef9f28b3e0485722a3fa39e237da78e6377ffb8df73f"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "3042bde451547269595ceb9bfcd72931cab793c3f09279919bd5946e176c3e28"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "680d30bbfe834a317feb7de1efaf5b1cb4dbf77a22b90ef41296b3ad15842e3c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.19/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a8a6e7854d61e058d0edf60b7f790384107d0db5aabdef14216a3091d64ad485"
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
