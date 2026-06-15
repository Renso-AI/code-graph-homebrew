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
  version "1.3.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "a1477358c62576b2fef131136743c0fa8f76b6b27b7eb792c2ce42e13b20959d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "821e86257310707887a7dcc2d473fde3a925f9f5b223498eda760d127ca45cec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb17f62634d84e8bb7bc58a30c0711aa61b75970b634ef370dbbe73c1b128c95"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5843da175d4f31dc289543acb4d4fb42d507a4d6ba8f89057b6f5c253a5ad49c"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "14c6bb8ca39e5a586cdea5a266fb7c0d033520516743bac5d0e21eb9b36882aa"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "84b49d8f677abd7df5bd6901a188c647bb4995c06c132d50310d38b756b1e782"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "85c695446a860f3a33514c3ee3dfcd6ed1ddd70697f530b46fd5e0b12c46a011"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "33f98fb5241e071264dd9d25ebe3d1469848263cd17e3151d059fb3eccb42a6c"
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
