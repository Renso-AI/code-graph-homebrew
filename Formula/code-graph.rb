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
  version "1.5.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "718c1a597a3750000eae4938a101cf7d2561acf69e3f55a23996e5ccff8c1b8d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "5f3b589269a46d7d7e0440ce5015b281cd50ed314f409d743204df68d7b53b1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eaa9f80abd389029a87eb1a1c33509cd1cb4ab66bced52f6f4c276603abc485f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dfab38b3d0e7d536798728f15dc1a50de88e5d81de6a31191e4022850266f0e2"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "eb1cbfdccb872758a781528169e20348d402be486e94375fe612da7925086fd4"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "910d6a9eb640b75a48bd09373c855c574628cf4e97241deed5efcad8666976f0"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "7c77fa96664a6f2234cbcac489e0b89903bff36626bf813c312354f7bd98c682"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.5.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "19004c4fa5ff6bb13323dfd83aaebe3d0c264e70ab1babb035216c8bdc7ff78d"
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
