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
  version "1.1.13"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "b55e72ea5cdf15627d6999fca5ffef0f88465781396cff68bf1253370ebd78ea"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "cee5414c5a9f2b983a2dde4e27d5325d702c6911be1da746ed43b062c3380e96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3bc7369d74bd923327b2baa3fe72ccbae502495d3a0b737ce51df04efcfee6cb"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "13d2ee7a7e4a87992afb18f6b1e21461d40e94e904b6174bfeac2e51b8ee8fd8"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "71020ae58ff491de599e1146c0298640fa8f6374fd6d79a1e990da143889f6dc"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "f409ce52624f69865703cef555fb1b6058ae421f9bf2cdab20d2b19c36f67076"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "77a8d8144b506e48f117465cdd6a959a2122918812f4d14648ebc198c4ce207b"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.13/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3a7c4876c01e69a71830ec2047fe7fb49270c75abd072534d3c0e07a69c48b4e"
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
