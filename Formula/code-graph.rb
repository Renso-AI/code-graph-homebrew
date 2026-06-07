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
  version "1.1.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "69c33cc5ee104ccdb271a741674e033de8dafe1d6ca42aaea35195859b980d9a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "4058a1138a2a5f57a5b0a09add6f0b0238eb2a24ec0068c9ab39c23ff52edd9c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4e9543f590825b1a8b1fa940d9aba8098d1f46af0785edd0f073b067f409bda"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9809c5fbe031c31dd70c2505bf0d299f388f180d4ac5a7cc29156c7d95711dfd"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "c2e304598e74f41e1255a3741e823a5f4083b342c1ac9165220504c5eb729412"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "45dcad3234dc04329948fbedb524267970f55b0f6cc7c329ee0aaee43fcf7e60"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "3ec2a6b1868ef51c241588ff7724e48b2748848cca7837aeac78e8c4a8fcc485"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "93bb59b641a6a6aa01be408ae231058c83a381fb7749272e4ab07c4c2eb3e860"
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
