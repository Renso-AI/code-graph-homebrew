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
  version "1.0.26"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "51273d534afe268692bc85bebb81288afbca501b1cf08eda74e7af9de255965f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "1a065ae724807b50d137d69bd50c5fb672caf1a8efc328ec77460d3e230ba16a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "027fddb5781818e45b307e7656f81676b367e24b3a7e98ce4f5b0d01738432c3"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c98eeed0215dce17de5c982a51fbd601615cc372c3a3c5394211aa9ca9d7a5c1"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "b1ea99271ac1f44ed461691dc647af3ad1db26f9b6674fae61758b17f582ad33"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "ea93e55941bc551c6a3f49b19a30775502c1c8205c291211b5d9072aa51c0aa1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "2dbcfcf219112450805bd71bfae46a4b94ced08d9fe056c8ea6639e1edb65f38"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.26/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "32e197218a3d1c3c09a6e180128d3bad0b6734e8665b13d56dc3d43a4237d767"
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
