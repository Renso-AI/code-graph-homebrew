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
  version "1.0.5"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "b5c29e6159a6fc3c0a2b1c571a0ea926cff770e61122d61721f64d7b5d3b734d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "cb0ad97dd71183fc0ca3458c27a3f78222ce0a245b244496f995dc407e514b1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5706d827deba87948e042cf0dfa06684f696a5d949a142417042918ff663b1d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7aa8304dc7834fe44bd406c1e4d5b4e68f5ee59b428c91e8efbcda0bd398f10"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "425dd9b0a00e0908ebc3a556879abd3c47da09f8d7071756c64ff8f502531d24"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "3b6841672527942911735f872bd7dd01dd56742e84b5cda90ddd14f998add63d"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "0499afc551b1d5cf9aaaee9434dc0d67cbe1008ee3e46b132548222181a94a5f"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.5/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2db795bf20eac709bd88ec0aa6f1f834189405cfe7f360294b0625878c3164e7"
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
