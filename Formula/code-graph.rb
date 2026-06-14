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
  version "1.2.2"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "8ef7592285299491ebccea75e6f6ce8c9cc24be224a18bdf4c211828211e89db"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "05b2843620edb14da685c6c750fc5335991da281c1d1c90e0b15a52cbe748f97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f744cc2932c418a67d17cba20f70ce17db64cf8d93ac20bd187423cd04d3bc26"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8fc3df3fadea4643f60ad0294013ff2710570450f40c00ba787721c0c58ac040"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "a78bf019589962701374da84f5c56e2b2b85ad95ad381831ab299e7be032dd28"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "208034fa7bafc57078f997eaab7dd6dd7d535b828d60030f9cef69eba742cf5c"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "47a4f9f79bb3ff0d4292d9a3e99e47992c57f0919b0e64ca63b5ea3817cbf4ec"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.2/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7d0e93a54ff2894032785232337244f85ef366e1f71703880ec286326bbabdac"
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
