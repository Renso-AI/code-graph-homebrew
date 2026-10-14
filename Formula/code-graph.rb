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
  version "1.6.4"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "a3cb77944df2cccd583b4e9a0b10f653f9769e345e286198ec18fc7d81e7cee3"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "187c17c8d1e22e083b77e94893b601e08a8aa84de7189c6123876b7a16106884"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "437e0a7ed9ba512650e4f39b308cf302b60d9bbc068819b3db91011b550b05e4"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "261741923a88c5c7d645eb66db6994235144c775c25085d6e92a479425968ed3"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "89c63eb8e40f5f4fbac819998edd365ed61c5ce9c83d6d0200a5d7a03f0ea8e1"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "85bc8d8c0b0f64dd45a160a266f12594b94b3555c7c94babade9e27319214921"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "554b4ceb35869b28a5c455fe0b07f3ec24ee25ce2d62c83216b617dea5c08371"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.4/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9429ea50dd81b7da8703ccf579e31f6e96963319104db534f052a04e34315359"
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
