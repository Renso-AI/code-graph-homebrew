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
  version "1.0.18"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "eb0f1b4da429476d7d454855dd5b72b6cdf0728d942f7a8332dcdc1f520a9151"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "7de474aa299af0bcf06a307d3e04bca5b11d7005028ed4ed2cf6da31f5b43a89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "77d56cbf64167186607150e63a7878547dc7074ce9cd4b941819758610a4dce7"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "401069c1f84d1acbd63221cc6817c9cd466536abe518d2f4a829ad0a22901242"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "f4337b08d2d9c5cdbcf6dd2e5e332d8782a84baf671812f1993595d0fc889135"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "f874699189688c8eea091e732d60f0ba011c056ae553f0ee85a275504238f0ce"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "598b9a2be07a57ccfd04dd52ca2f47ac59cb1707d143202a470f8eefefe8f894"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.18/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "36388d562ca88385fb5e0b0af09a08c66028e15ed9f555d7991c10d561a4be71"
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
