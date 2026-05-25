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
  version "1.0.7"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "3f9a3bfae359a803bf69ebe5e411c1280ed6fa70c020eb2b18a8dbff703063a8"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "eeb74f3a728a94e083ece1fd2f7f5b1a9870fc5b94ba3adad9f05d77f2aae45f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9521d27410b3f93a1c2cccdea8669c6c42e8e57ab37df6ccc72190b39addba32"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9b75e3ffbabfbac4c3e80d114e586424e2bd42935c05ad789fb482b4de0f4b89"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "263f83382a861ddfd70f8ad45b783a84ed31e431cac429dde7d0a76226974590"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "366f0bf29f084d91c1d15fd8ebef94977fdf0f5140c8132fedc3069adb52a368"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "8bca56f076f243d034b7e712a6b530c00f4f4fbc445ce4c62119499311f77a5c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.7/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "607ea67f093908690f66a78ced345f05df1e41d3aaff2748d9cf237b0ebd3dcf"
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
