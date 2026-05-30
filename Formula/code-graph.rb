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
  version "1.0.17"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "69e7bb67a166f68467c462b70f0786402aca87953b844a12e7c1828eb576c4e6"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "ad125a5c254c31a967bd5a1e4e0cd70293671e251ddcb8107217e43897b5bf3c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c7231d2a66d174fa197653673bf593b528b07d853b107657c9291c364971aaa0"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f5964e4138bd16aa1bd054f292c649b5419abdad69d14e68631bf4ec54ce3fd0"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "51eb92c156a789e45ca092c648d238c8fe171239f4028beab11cc39b6198e335"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "cb7b496529d8fdfadb33a6e3429a40bf3107effb2ab1798b1ef829d9bc877896"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "e09fa96008d4983e3d5d9d115d7bd3acb47f3223b886cde125c3890d41128af8"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.17/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9ad4f033ee4bcd7fde24cb59cb64564cdfef5abd608967095ea676c5eea5cb8b"
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
