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
  version "1.0.4"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "9abc1b2de5fe268f9cfccbd8462b6b58ad293bbb0240a972bb85a74204d2a20c"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "a4c6db327eeac0fefb767c88b001d76c33fc285084e3e3c0790120e42280437c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6acf9f9960eca916cc75097963dc8319dfcc4735aa2c068d88b6d0aaefeebe2b"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "116e40bafbacce0f78f36bb060a5b8871a2db16232e1ec7969549162e9e5ee89"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "ceb41460368c9f6400cc65741dec926badd753a188c918f9b4e5a574a18787b4"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "4fe1753a132cc2d017acace3158b49a1552b29a1448539535255c4f4c9232b6e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "abc20ef6156faa78b39bedc56317b8179bc5d53c6dc2a1e5998aaed7823fd011"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.4/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a44e565b1748cb961d09f1a10d49cc8021fd81c342aa29e9d8c06396c0197f83"
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
