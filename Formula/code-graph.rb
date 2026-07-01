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
  version "1.4.5"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "2c3926ad8fd65b4d6420d3c1d46018a7bfb8688864737ad1d1e0f47a32d998c7"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "e1103fe7e8f7a296acc5b6f3a035625a93693e5fc52535820fcb0c25a9dbc624"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2d1daf3a206f3a387c9e98a4af310a4177a7940a7a4e693d97c0c0d488358eb7"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c88a68f4a9915c78ff98e79f9e19fe6ffc74dbfb4e818c6be55ff31813e8f9f4"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "8e52350b981fa8f616d2c3f86ed175f4b0a00a023ae0c9953bd503a15d13059d"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "97ffdabeaf0f9adbf3593d276f1182db5b2b6af1a9310b20a9a1a79a422e3cbf"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "5a3c2b009bcaeb9682bdf4a58a0ebebf7157183d7a3aafaa5651ab376ae1e961"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.5/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0c73a9d1adeb5e34debd8e1b6de1c0414920beba305b7b1a692ec6cf5c722a10"
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
