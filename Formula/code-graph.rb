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
  version "1.0.15"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "d7af2676f9f8384f6509e610f889f3fd6adc36f488e2b80d6c013c687b5fb8b6"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "40c63b8cc0e124893a11908c6bee676250481e0dafdc6771c229780a8b01702c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1aaf9afb2c1a09f011329380fb504e7982677cbc9fc39eaeef82d2c830a8c17"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "93f66714cf3012ce51666d22a62dd1bc9b6d0bfddfcd4af7942414b87590434e"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "dbbf3b71fdcebd558576f71c00f5614517e0d6002bd5d57e534ea8e96b543bbb"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "7af715feca5a79ea4ae5d1879d9a9af9e098c5ffd6703fc949c9b4a10fb74ecf"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "338de37a313a2731e03eafa3d8782fe84ef96fb8ab97ceec8af53a2e588ffb66"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.15/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5102bb6ffc2a60d68716a4ef37af993841027cdd3eed5f804a16797904799964"
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
