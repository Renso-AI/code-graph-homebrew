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
  version "1.0.3"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "7f20623febffcba7f13e4d460b2284ae82b1fdc1d4903b68ac04421e2667aebb"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "6c8ff29ef1a1c083fbf85db3e3dd38c3a7266031f0722de9bed403b8b5361b23"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "458fc8f7cb74d4e6fe95aa2c8879b0be6e8ed775c624664ebcb983405ee0f86e"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "33b9bef0c7e297446e480199223b1a4d584a08af1a026a2ac784642c97d54980"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "127889941a7de3f7fbf70df2743e1f1846f627d072aa8a46a7663e33c5aeade2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "ae938adb2cb014de8e94bf4909f6e093471c957df8da1089179706d19bb3ef89"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "82d15ef04cb46f66e37100459c6fb455d03159d62952cd65bc84ce8a11cc22cc"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.0.3/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "66d3a321b1a27251f22f46e87060c3e3febcadfa468da1b9bc715b633c4999a1"
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
