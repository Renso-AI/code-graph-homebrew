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
  version "1.1.8"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "cce2f5e2f283c917bb9e66e669ce82b780f4ecc7531d796fb71d4271761cde58"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "87b3e703cdba4242140f088c0b4f43d2dee8a3b6392702dc9c49d3fefb9b32ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fcd8deb26c57adbabfdcd06d765ebcd2c6dc0119004f15f9c6af655a5a66d82b"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c543043615f6c75c0371d4114111ab0021f44e6d326eec8549574397cab687b6"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "31df62d28447280f51dd3312a24434272636316b3eb0f7ea9330b60cfaa4fec4"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "7e692089bee09a6434e50b56f60e0938cfb8a53dbec315ed0a783ef2203ad02d"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "f373d1f6ed74021c99c257b6b680b826f512b9b0208c2a5b7a525a4167f87080"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.8/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8906da47ff4ce2dc77229851fbcf7544d9269203df904f61fe8493f67db5817a"
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
