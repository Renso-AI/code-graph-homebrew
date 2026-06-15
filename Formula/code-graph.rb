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
  version "1.3.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "d1a1afaa6013b7c7d5d69ce905137ed2a162847e47b7941198cd7bdb31615170"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "bea51965d5a93eb3d588fd916a77fbbea3e3903caef91ddba2b64519049c77e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e619fee8a6294149195e5016a43c7ba8e6aad126ad433492658406a1474c013"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8e7e3a6b6350fadb82548684e3ebd9bec040863acbf39712b955e5ee1302d1ca"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "efc9e4585595c6f557238942e525fc5ffa338b481663a30f0ea1d1d6ff420696"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "4bec7bdf6773b860ad07cdec28a46e97e708ebdc85b4932a2e8b1fe002efb5ba"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "8916fd790aaf107c61e678e0e79506f529ac4006d6fe997308b91f53071751af"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.3.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2f5db3edd4f7ad7b2ad28dc4ea5dd35cf9b927bfa338b58cbb39d42fe4690789"
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
