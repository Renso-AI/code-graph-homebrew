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
  version "2.0.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "4e030c10ee6a7b9cbdeb22a4a77c2e9a8ece36e4d494e232805cbde9da50056b"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "be0c47832d6aedb22dc9604fe5bd8432d2f2734e957598287fd5a42345e7484a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f8066960b0daf0f9939c9f1c4b7bdf6ea361af9aae43c5b25a3a6e4a922c3c5a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a2392456b662f418e2875711d79d118c4cf406ba827cf6400664f43a3082c868"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "c0bd7341c9f69b11cac4b5666f36040b1b2e360696f3a97317cf1b39ea3dfb48"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "c78400ac1b4f9c99704094a7df07da82b0a7d38b21710e5d973ce5112e3db0d1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "5605b83840530c0d6fa920df642b230310ea46dc16129076b1505a61509e5b32"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v2.0.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "95e430f2770341dce41c2d266618c9fa13a82d2ca9db7a17f9b7fb038fd2f257"
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
      Cursor, Codex, Claude Code, Grok Build, Gemini CLI, and the other
      clients listed in docs/mcp-server.md) so it picks up code_graph
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
