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
  version "1.6.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "4995c5f50e17b1ae6f2cd207d2a7a3192d10f4fce56238ec9928f21fc7c4b2ce"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "a1e824df9c39d75181ac4c9e8146e11e47500ad7638d2f50f3c247baf9c32520"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56c80584daf1ae5a72fd06d79708bd30ea96c06323c8983ce214a322247a1f2b"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "336374ce2ac158f5e383a6f9d8a710cd2ba7367448586f3ec0d83cae6ba54512"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "3175cd4a05fabb1a00af7cb3136f97361dbf5bb7823897fbe4d56920a31a14c2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "426e32774225d349585857c64dce62a6860333dfa234737ddedfdc4c9740e0cc"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "e40ee04a64bbfa28d195dbf8def54d166def80444c7f708b1133c1ccc18683f3"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d4e89b298a70c5a1d18d717b476edbcc8acd5d925addd9a1e4e1f659a73d7b61"
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
