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
  version "1.6.2"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "f6d57ecff504914bb75741322444cb48ed0c697f6d012de44d51f23e232eee90"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "955ac75dd121a6d7dfaea675dc2bc2818edaafa2c9516a6e5bbe6fcc5674d714"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "20ca8b26132d65e6e695c5bbf831c513af2c3fcc305d85e5ccd80c759811e7b7"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "073664b538ad97f43235274b7da49ffcada9f715e357c950033beca9e1e08543"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "9186f19b5a7261303f1357b94c3fce080af4beba8de2d514f4a9f3bbf0d2808a"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "404535355388d53147e93d6f826de72ce9a1ab9fd55f40787b6d3abd7b49b1a5"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "e0139f21e087b8b6b0f58ecaf198752f014deafc258c18dcb514d4a7190bfca5"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.2/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3ffc4e3fd8f0f0bbf840cab704e55620907c1468b2c55e4a5933b4ba6cb97e3c"
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
