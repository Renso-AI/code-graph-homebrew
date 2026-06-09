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
  version "1.1.4"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "f50877c794ba799d28cabc57dd815b11332ae73ae420b0d82ace08053587194f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "fe6614cd5759b09c7691fbdd00ab899e691d961542e44ddb5efd1e2fa1c25ba8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b8e31616deed8eeeaa295857b0175bd9ca6671af918d336e12a85b73e8cb4ece"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d49e740f0c142613c8595a18b2cba95d0f4cb75ae2c6478c3c19dc9587178e3b"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "91e91e3c1208118e067c7874f1ad7505a0db8fabdba2b86f6a0616067c922000"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "e9a60a7cace9289935eb00af1488bd276e250f3ad7a4ce9f7fd0b9d38360b1a8"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "40bd913b059cb11ac626fea9bce4101f063d4a2191721f458a815876ef525872"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.4/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1304c6e5501d49c5acc861290caa32e0e5297dbbbc157f08222811698059923e"
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
