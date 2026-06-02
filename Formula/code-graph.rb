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
  version "1.0.22"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "fc35d2a7115d5eeaa982b9c62a4a8d969ce1b05d3b18a72ce86c56b9606a11cd"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "81d9b468a4faddcda938c3b442c50d45ef68fcf41c738800530f26406cc240c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47ebf088b78bf795f452c90fb62dd34a907caa1a159d1750dc9f8bf4752a9487"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cbc846fc676f4994f8fed96bf55ada77355fdcaf3ef7e75c56bdeef69eb1e35c"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "ad2ff5db3965490a19f31a88f6620c3d42b9ab6ccbe4c63c112468bb2d5b85a8"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "d4e491c0c875dc568d8e60d268c26116e6a40544d807745ebc40289dd699d41c"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "21952e3bc7aed94e04e2e7a0ec849c6d7c8f067288e25ba3a13cd251b80cec98"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.22/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c2e278bba9ced2572f46621bbda61f69f6b1bd16341c9fbe111db0cb347fb411"
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
