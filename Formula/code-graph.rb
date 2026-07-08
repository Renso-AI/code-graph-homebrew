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
  version "1.6.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "15787bd1476d1a4a53238fb8c66dda32f36582adb4c2dec349eeb38a7a371691"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "c7e46d5d6a23847d2d205dc52915cb52bc9de2505c5c7c1fe61b348207321e05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59230339fc826de9c0cce995ad768dd66cd9f51e814aaea4d670c9bfc0d172d9"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "695c96be57476e53aceaae82b3e0e4c1d45fd535f424780f68b1d33d2c1eb447"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "ad50f8aba9b70ac8968dc4c3845825371bebd0d5998ef9683eb2811db56e7849"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "5b80178a24441d0712d00ef8feb4bad068a715eaedaf784931263211862ad336"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "9e5e875a847aeab6694d07839375ec243c01274690939ba4c050b6b44a673325"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.6.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "de6f075b7a898afa9f7abcb61d34a424001408c81c372f0336cd73258c7d0ac6"
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
