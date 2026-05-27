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
  version "1.0.12"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "578ca89ba23c730dc40452d155a2420abc0374577c9fb93b316ecb14dba3ece8"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "ba41594b7f92c258663faf7fbe6755783c478a03c3fc7d289ce1d6ba13170c5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2d3f16267f6920205c4b2c0b221580c16db821d61783f79dff7d223c09e18769"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd37c549ad7c3e3cea768dbf5095c2346574f9ac8fcca9d9855977a21789fa80"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "0833b793b8ffb2981ea5a2297854628197be074698f4f4d1e38ae3e0231345ce"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "6fa1b3df1117bc342a474225334b439408b9a003dc2dc80e40fbf18b5ef14f57"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "ccd85622e24085db4c2ef3dbe655c51bc55cd672994729536d5a943ab7d62bb8"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.12/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ea1e8ed3eace83ac0f9a166da0e556d4f5fc480c2b3f3c709966ba529fac077e"
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
