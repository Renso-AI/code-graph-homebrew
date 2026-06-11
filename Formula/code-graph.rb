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
  version "1.2.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "36fcebc83d346dea2368cac27c9ea53c23647cd7bfd3625225cf0a2a0aef2f60"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "e8ca0d2e13221bbf5c51fc4ac1a8fb9f4d0777d5e75504e5caf734808f663db9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9c93369f8762b2fe3a3044643428bca8a8e1330fafd24b27e6025026211ea8d8"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2feec4352500580a2b6f0a11e78ef78493a4f2a0154ae6b61a82f76f81e500fc"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "f4a0235ff1270d4aa5755d28f112a8ec62df90196fa47baf19d8b24513e7d99c"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "130e4634195ac8837d9792f549da9677888be3e7e1424553a87048f8a57bf090"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "9d4d7058d7417997bc3c42cf5807a3c3eca4019365a27c96e3931ad82a699deb"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e1190cf8eed4524c781dd3ee1fb1220e482333bf310892ed5d2ba0fef16834e7"
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
