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
  version "1.1.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "c40ed6a1c7f125f55c71b3f6688bd2056ff7a44b089b777cf02af7e67e5c148f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "c56306b52999af1534f3813640e346b3b904a53081556e226b1eeebee3945d1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c2ba5f26309248d4255743d2fc9f21f9b6c2a6ee9d0380e88f71ea848e4ac7be"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee12c92a4504ebfe4d57b52f885014e11d10f0f8bc6914f25b66dce66e211f95"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "7d90463a4026892156e0cc22516cb4a90d34f416e6613e94be7baaab9d356df4"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "4816f22b931f6de59c16f2055773024fa756fcc7aa65cd5a173da599b405ccde"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "9ff22849082ecac8c663ea63d2679650fae0391e441a1c47c7b0c21cbeba71a7"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "87a7e67d40b63824e3fa972bf905ebc01ba743f4c88513c23d44945543bbd834"
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
