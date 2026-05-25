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
  version "1.0.9"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "b8f07055af0a17abde8fe7d9f60be5cc1a91ab55667a96af6ddb35f877cd0174"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "34a9b1d4b0680cef1d9c17a75491b53c78b67a8ed6f88de379f37ea234c82b6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf6eeef1146a1cc65e56722e8172f961497e03316668095fbac4f7aaf2f692d3"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b9441b1d990e1c993f413f55067e70a7a43971002ec16c75b7d33e92e8624180"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "64ed1ae400bf1343447def58d9d6eeea411d0c516bd047856b442d6cde96a58c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "3232450294ddca4f9d436225e1a20cb8fced9ce54a7169915c08e7a6478cccf1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c8835e7e486f9ed112ba87a250994fb7c4cdb14a48015c810debd63b4e1a222e"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.9/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c3ca422c55c16bec13937390ba07886c5ea318caea932d2b6094a6e161f7465c"
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
