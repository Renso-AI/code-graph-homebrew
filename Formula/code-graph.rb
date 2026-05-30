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
  version "1.0.16"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "90db5f78f784d22dea80de73ce7e143c75f6cc6efac33708cd9f133f5f4b0939"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "e1bdfb362e7f62a608469b104f759d8c7c138431a83c0e4cd3431f041ef7caf1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5b47394442141a8620b7ebb327985c7f6ad66b7fa231d49e972fc9fdf0590de"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ed35d6097a5bb8e20f1b861cd148ba7ab41329b6d9c6dbadc8a24507526b60f"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "3b170f4d4490030c4ed31b6ffe937d979510ddee4d8eeedc1a4a3b532a6c2932"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "eefb4b58ce8eb80ac253b8f81eb8ff4ec17723dc61971145a13352ea6b960bf3"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "7ce1cdaf38d45a36bb0c4855e04f47a01e2558793998556e30eeef5cb93c19be"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.16/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "290a0c0502fb615e6b945da73a43e6fad777d2a36d3a5d4a46acf885a7c9c935"
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
