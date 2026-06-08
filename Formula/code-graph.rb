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
  version "1.1.2"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "dede2aab18ce48298e852267bb9f965500b18f275a861b53c4bb5066f529ac89"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "e99c3a7a45d41db75031e805784737bb092b3530fd4cf8d80afcd9a18cf6b7d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ced829e31864b3bd1a34d31503683b559b8d211bbb7496d8522f6315c8590c98"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec164b47674b0677d0b271b92b25f45b9dbddac9939688da31af5fb003124cdb"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "b41dca4f5e554151472c6385eb8dbc11cfdf75fc37602a9e1eb37eaf5c21bed3"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "43d9c4b1c335e8da26bb9c15f05aed91e5619a042be1d5c7eef9f8856ceadfc2"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c9d5cc01d37a41f068864d327ca632b941c6485fb3797923cf0cc589c9e2cb9f"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.2/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a5f5f1fa31eafd2dc854acdb19b02fdaf5a372a846be738451793513d56b30c9"
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
