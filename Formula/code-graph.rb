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
  version "1.0.11"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "77006fd43dd64f1a32f4f57e768ef1aca7100ee0f479eae14d90d216d914b2b4"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "8194d1151a3167ded0f65aa8fc7a1741e470254bc23c8b083c3eaa11d5cf9df4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d94637e068b2173a93789d5fb59597b92760c08264ed9c691c39e9f96c9333cd"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c0be822e232e670eb6936f6bca86e350d6c95f9049a15753c1d2ac1e35e45848"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "9ab7b78aa9c36168081720ee41413b6c4823ba8497aa868f712b155a6ab488df"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "692480c83511c61c4db7fe4d095f6a7cd6212720843129cd233b6706569ceb04"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "03a1f752b84c86acd956fb28f6550aec03e3185b743e989d1136b1f5f8cc7d0e"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.11/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e6c888304c413eaf1aadb0462acc6fbf74132bf7a31f95689b0c6cc5347b894d"
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
