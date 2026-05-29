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
  version "1.0.14"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "2f07a6c2f09dddde7edfa1d328d30ffa7f0fe409374def0bc9bc3a503c865790"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "4a8f2f8ae14e4ac60b3d81a2cb6be5aa257369a16f1e244908330b576ec6b481"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "983075b633e41a88a133fabfad045eb5c6ce7a7eb9c0f72da2dbf2fe3549185d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "106c2ec32ef6f40274a239891ad594b669fd0b4ef8269a852aeb7c4ce7b58fcb"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "00053150e613e5ac2d18a1ef9bb2c74b226839180a001b33b57bd6b8eb4ae393"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "500f5d6c6115b6e0e7152de1998be44feb9cd8403d323816eb69dd5ba32e5024"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "52311f96afaac2dc1a0ad5428c8f7018d643f59c067adb553d55d30782ea45c5"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.14/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e0322658a619e61eba3ec79ed5c3ee1651f17a11cd27692f1d92a72c339e4202"
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
