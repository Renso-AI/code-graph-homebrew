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
  version "1.2.1"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "81ded91ccfd9628ef76568d014f3867ccdcffad90e4baf1b12dc487a2fef1190"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "b6c5b6ecf29ffc874c14ea340d16ef133b6bebd6ae0a32f3b4368475fd3fda56"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d24aacd8fa6fd057d2d7511f39ef6cab771c12757e704347501ebd09d4865b78"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55cc5b8a5ddd41f405e1fd3f69ec5c54266324537240c9ea86c5cb431306bef3"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "d26cae749cf2bf9a63e1c47e4c8c1c0fda5cda6614f2d308291b9a43904c7ac8"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "785adfd17639f975fc0652a5c1dc00e4e7190befdf736f4aa56e7d9788693849"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "a01c32da0e7dc3266fd2c0e36bd1822f80479bb3ddc53f1c8a236400b05f9772"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.2.1/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b8155b0a9c43cf106a26ee76beca2d78ced0f06202a5eddbc4a38f8bb5c70d0d"
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
