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
  version "1.0.23"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "54aba93a0f7eab744f7f146229ca2f86d13c2ffcabbffc750a535621edeb4d03"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "b334d4169c9b4b44c5cd11e0fc1bb06dbd4ccd5eb123d9442da473b9dd26a845"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "11d9d0ce348e009c00dc86e7920a95c4dcf34a14c66166c151d059393d780692"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0cc60351cad071aa7b59d9653acea126ba20c6e12a077be1378f28fe69ef3e35"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "a0ea1dc8297c315b9459de772cd594c02f533ee998926fcb60cf42717536f129"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "2997e742fcd71970ebeca0245532aeee6bc1f3dc5863e6f77bdd537e6f175cff"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "cd05e72fa76885071948d7773c5552feb79911221db6a37fa381bd4c4b3c3b3a"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.23/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6a3c0191c6941352552a7611ee88c1adbf3393e4470958468aaa8672e464db5a"
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
