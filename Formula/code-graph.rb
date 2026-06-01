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
  version "1.0.21"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "7e3407351d8e4b61103a1dd216344aed8ad92ebdc18dba31a9cecee4a76eb0e3"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "98e74fa6186e6101aa623018b9efbe3683407c2cb24e868933887d629c5c6335"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "46e7169760eecf908fdd252e1523108bc817076ea643db6499ac297e6d50191a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "606e5919f75a2d81714f56a607997e07720d7857353d25edc2e11ff2d60e5e1e"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "1bd62be11f78b328f63df586f425bc2ec8042645c47cb78aab86e5c55b905e82"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "5180ddb8beaa449b226832db2df174a61ab25a26c85397cf883618b50fadd5ff"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "03b28f5b6f93fbdb1664f394b8d6147a9ce08ab39c38158d27c3d59e2fcac942"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.21/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "429c67840cefb11501d06c60ade47bb2c23409a987473d852f6a84bb9eac79ba"
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
