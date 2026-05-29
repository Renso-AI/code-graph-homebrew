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
  version "1.0.13"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "f6b951888be35f37c2cd130f3b6fe2470fd5ecefd1b78f5668243b1d5a191099"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "61222b3738d5555381319c657bcb740b7d4f759fa62ebb5d0a681362b83ecb3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ca95f27a232efcb2ab372fd8dbc0348f2d762ec3756f28e0fdb1352a4272c7c"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a0a3e79d41ed46478050567e4cffba6a786cefbc857ed6a65bb79d2bdb695e4d"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "d0bda880a8e856a77176114d756e55f2fc277d2676793660bc36657bd9130c52"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "8ccd00fec3fb799d109c456bdc1fbb647d2b879af488e1bdae5212066e937ad6"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "98d1a14e790fc6d65506fccb2b60d86aca710baef0158eeccba894d836da5ec6"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.13/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ac55551546c343f7887daef5946833205bd538d470668e04b3b4d8ca7de9cff9"
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
