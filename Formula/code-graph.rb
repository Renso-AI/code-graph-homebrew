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
  version "1.1.3"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "516e87f83f7c3f0a9084412b38130b6a1f59f9d50c3a62058e17a043148038fc"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "19917315c0a97f6c7c037be8b70a2c98b68af5480d10f7d07fb79cc41866ba85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "902233aff6d6cd9f88019fd6a93d066f4fc7265d68b735a9f50d5e16b44c84de"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65e5b8da9f650cfdc74820cf92da2132ee46ab1f52cc6df15884c5e63e09a5c5"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "edc16cfe6a051051407746210ee4c1aa5f29dd28f30d96a0aa40f31be507a8d2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "e3507f1b46862e897d3d0fd6d2bc5ca55e670e77cd01f9e1809d261640b2797c"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "f651130499fb9d47b6a29843fe3143ff5849949adab4fd891d1c7e42630aaf76"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.3/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fe48e7f4c23dbdf68cea188a7956614d22f21d2a9c1b7d4bbd2912efab804966"
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
