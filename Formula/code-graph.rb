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
  version "1.1.5"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "bc38377ab6190742c28a9cecc794a0701a43da99813a8ac595905c79ce1d24a9"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "0ce9d143abbe4894e70a40b5edb9c397415b2dc20ece4c0d5cef50870e5a9a42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f645336dddbbdb778674bb4dcd2a47c7f98391c3ce1a8bd198404b170671ac8f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "115c7630a3dd4aec6e0643e87b787b8f59d705448edbdfc3b97d6529a5b84323"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "4515abbcae37846ad1a43cbe3dd5a9c59d3ee52d3f515f46993671332472290c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "921ee24932551b416ba917bf64daac471a7dd91a4e466a6480c924a77f03fc4e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "057a0243695bc9858e611a4ed831c31131dd0cfb5cf47652d6fe024cd558676b"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.5/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6bf8d0387b1e1a7c5f1df6daa00553606b0f97430b183e953479c32111d1a415"
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
