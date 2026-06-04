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
  version "1.0.24"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "3c3ee9ea99705a6ffd8f090223f060677567d2b734eef3159b3ee47363120a2e"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "bf3d0954145671918996eb5e8421d445ebaf693b7fe356a65abdd81bfce69886"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee384d0aef628ff3345c51e1e2bfee41a5995d6a713d47ebe5a5c46818ea9fb8"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5461e5ab17fc708efc7b578e9124c079abeb1fb65a962dc7a5523e555dfadbe7"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "c4ede7fd4f62f73676db087675199e92b287e2b0f429731a81b9ad7ae48b8371"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "8e38bed24207fd296bdb44e2e8ae1552ae178cddbe005673cfbe0cded1b0ed3c"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "b26637dcbf6ce471446bd82b7b56f7556306a4fcaabef6e7767c6648cf2bd8fd"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.24/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "96ce4b651b8ee05ab790cbafa1f0c57da6b7a7235f9625917430b1eacb470504"
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
