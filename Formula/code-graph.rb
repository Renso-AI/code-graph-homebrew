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
  version "1.1.10"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "a65673f1df5a2432dfb0c8aeb588777f2b331880d88c245acef9f39d755ed1a7"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "0bc97c0f5b9330c445967e731ac7b3de555df56c0bae3d417c25d02e7fc74bc4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "64ed56ae2ac2a7c2795f4f746ac22185864991668d2e6833fc206174ea13338b"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d987ea43b088faab6e161018962c584f5994e266b8617d15ee4f1416db49571"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "4b569c5870dd15332433fa504898f47a3233a102dd7e9826ea2080fce54b1e93"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "d651cfc1bf240e0cf015439736968ef997a2bfc405ffc66fa67cd10c2f1da4e0"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "ecc23be9a24590376a1abb7c2b7178d2d154db46d40f8c06396581d0465385ea"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.10/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8fd10f655109a22b6333295c4cceee0b07a5bd06ecd92ca1e0b8a6f9f6402ffa"
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
