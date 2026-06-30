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
  version "1.4.4"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "5c98bd5b478114e48e581c33f2a5680792639bc602f6b9feb6745f48bd8d5815"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "5c0b79e91f529b4589f25ae744a262e1bb16480e07111d3164c165f9a641796a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f4b8a65419daef6bc188d7f3f52e2f7592a17c61c4ecc6f4db447c2133d826dd"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d4bef43af2c63979242c3153637c343117d1abb20a1afe6c86dd12e6df12d94"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "b09d3f0fb16b242798480ff7f313be31ea0ceb63731d0101fefe03effced38a1"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "49c2248c7c9e472991923dc27b07a72e94ba57cf33339bfaabd09c3060d2e7cd"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "bbf45ff3b8be93aee3da1766d401ef512f9c9b80e2eaaf9e3dfe63fd26e7e4b2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.4/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ab5d3dddea172427d7002a58925ef0527fb3a32ed33554ce9e9880ac2424466e"
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
