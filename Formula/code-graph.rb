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
  version "1.0.6"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "0be2aa8da8b9bb9b0979ff9e07d04f222e844ff05e51cbd21951cbac4ef5ec92"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "b8e8d816870089c0c8c35a4fefe4218c91cb20e4f0917f4ffdbc0f2f1463a6b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5af0487e271922a1ff1184059c0c30493f2b520bf1aa6647d318a5ed7080e4d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2640163070bc5fa5f248f0d597c03413cb70a1d8827bf3299c8c1f1f51a407ac"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "f0aa72b0935df71d24237c60b1fc9122e2088c00ad3d3fe4b54b49694d9ddf27"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "285671482d0541e69076df27e9f7bdba4093473e970386ff2c9ac348d5939552"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "a34424826b8a367403513e06d3cd6259f632b633697724591239eff89b5ae751"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.6/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "30eaa1237e696549614639409a0926a4d0e2aefb6dc92cda8ae336e72d6adf4a"
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
