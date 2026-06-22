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
  version "1.4.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "6cb6424bf2f0cde654309ed791ed28e4f9799501d61df71be1ac246fc01c6aa5"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "9613a21f2097e72b87c9c2792f51f60ce4c89d2e12d3962518d71d4facdb3e63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba5ad39d4259352fb8c7940dc2932739f2f43a872ae842700c9bf0b397f82bfb"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af7fda9cb0a016555acdee3d56b23bda5e49a33083d2531a146fbb480d8623e2"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "70d559b3e91efeee93ef334a64162cde483149381902cbd3500cf3d8aeafbfa2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "0fa0efa6f07ea068dc512122dede5bfb6174b21a2c5588f2549c857f99d6f5f1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "d32039023f4035ed8ef69312123db0dc9074bb41e1854e3ae071c15375cfed34"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c8c933c2adca72c41e86eae23381df7507af0919b6e98a73ecae974cc6be07e9"
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
