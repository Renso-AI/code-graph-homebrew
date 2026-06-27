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
  version "1.4.3"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "e9e7f50198f2a1523708728e779560a9067b691da17b7d19083005a6ced3d15e"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "1ccd5d585c4b21b352553591ce91b050390f7b3c00ab44f6b61a0219c0eac42a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b733964aa41ff81c416b4f0e9e5ea7ba67ea3ec4acea5d14ca7b3d4f8fdb6d72"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d052f88f4fddbba9efdaab55a45076f711970036314ce1fa0b6fff09ddd65bf9"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "4f78ff2f9c766537065247dee278b02a8cf02f110a71bbed6c853cf29ae1d01d"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "68152092f3c374ea52df4857fa7058b5e02e2142263b5a61fc5d71c859e11cd5"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "64897cd8b23a7f9aad3efd4967e4c8872c306bd2462f2f6c1fc226c560b8f186"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.3/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "48ddfe0e3567f9c9fd48e1f20a9a03a5be35b4642f27b9aa1cbc54ec7575a478"
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
