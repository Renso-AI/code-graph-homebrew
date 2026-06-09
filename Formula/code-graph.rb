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
  version "1.1.7"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "f52414021ee272f3cbf3bba5d78104503594bc685e66ae1e925129ced94f2064"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "262c93ed169159ce138cfca8e19147b5fe97474c98c9d441feff3b69b8c59572"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e3612780b2eb6fb8999aad19026ccdee277644e5ae99d0df18a77dada3a41603"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dfdd17b5567ea6a2e92690351e22eb7195dcefc86dcb7601173c2272ecb6cfea"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "521f84cad1d5f39fd46c5620fcb729711a57a82048400ebf75698880d187ce28"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "2975586f659fe1a281c619630c911fb42e19e801f6b32b844538091c65c58048"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "64c58e270bf6307c862a84b733ef26a94a7bead44c7f6bc95d5d218885980667"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.7/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a1ad84b16f53f1227bceab322b37cb4467c6a09edceb78dce9c4f662e5d906fb"
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
