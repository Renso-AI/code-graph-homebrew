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
  version "1.1.12"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "346865df46025f93139fe622eb968e27b7d0f561320ddece67cffc5a54d65b90"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "b0174d47e998165d48b75dd7e7339dc53703839984a212e29e693e9ae28e58fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8e30b3652fe461f76625465549457628f32fed97b64eaf1223d0a93b14767796"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cefc78fc6574eaf5680c276d240c2cc020d37fed50486055a8540dee8a65b895"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "dbf2afdcfe594f7a6ee17ea457fe5093d09283b7944aa612bca9a773bdf06f8c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "f46599d74ea4c43d9b0616a154f375a7b5e6f3bc8748fc9a09ef690c15a48c57"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c24ca28afeaa28aa3cd27438846a87cde56eeae423e399e69a380cdc87cb93b0"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.12/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e1778874e4a604bd50c4a70b8997dce57f90b40d17848060e1fa7a7b605ef3e2"
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
