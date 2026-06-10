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
  version "1.1.9"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "56efcca2b081b4ed7be267e4f8d8962e5ec3fc3dd92bba9ce040486723741bb4"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "1d23db45aebc3749ad9f2c1424eea52d295ebfd278f393c499f7c0660b13c1c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03e38ee66d4a462ec8354d0d2c9678b999aa9edc1b40ab753f01fb6044553edb"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d0a2b76b0e0abfa59dd3ed900bfdac5b3541d2bfb875c873e5be3c03402556f"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "8a31f92333e5c53ad3b8b9d713ee1ac020bc66b8a4ec8cd659224836783f5139"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "30e22cec89229ae87875a29f7143737c85331e95be647033c99bcec8154b4007"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "7c5af8983478618c2dc2be07371ac378e80d8456482a570c348a8ec1c4d2b33c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.9/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1a3dae7fc32422354f44061aaeb83b6375b5908bc2a45e82556b73d7ace42221"
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
