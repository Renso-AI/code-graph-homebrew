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
  version "1.0.8"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "3091e131bdfd80e66d36c7dc67779adcdd9d510c74770f6fabb4bcd50a6ba731"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "a87bec9a28b74432fc9da57bd40d95efb5dfa1d5df48b3374158e76316e5d0d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cdca0ee78ee4b528da4140750914a482a574165e339110635c406e63afc8cdb9"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db3aa415e314ee16cc6160533d786304f97c312ea658a91a1cc4fc7e2d78b930"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "b97474e5a4254cc851280e8646e97b3e168e09655927a34054d42bdce81e4174"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "9dfa60f9f7f331eeadb6bf64a18b24a24958a31de0afaf7786fd705852341ac5"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "999a67663492450286b48de03cabac96acb8435a1acbc32bc6b1076e97f5a89e"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.8/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6259f86777154cad16718e74800ca007bdce6113336dd139829c104b9f991a28"
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
