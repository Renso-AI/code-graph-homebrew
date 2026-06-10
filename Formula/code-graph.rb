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
  version "1.1.11"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "b85bf797a1dce342b0fe999c0ab3e42d9b6250c4fd7cbd850632a3b534af871a"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "b09c6e9341b417ff8cded2c65624fd0ac62e965686f2369d1e95aee2710e0bbc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a7ae87433e3fc3efd8dd0680403960796e248a3ee17f8c7c404cd7014159abce"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "836f6ae4a79d405a261dc4b69ddf3e66b156721b347dfd1b3bea00c5b7f76b3a"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "54906140d4757736b0844e260764c396b2bd7b8913be502ea044d705603900cd"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "13c3d3cc2af14c2d46e22b4c07751989ddb59627d46993736f99840a95d1e384"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c36cce884528955f76c5d9a87cc4bb176700016aa8cc2146b14f77c40c39fea0"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.1.11/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "58a342be73f19d5d8caff49fff10ed94598c054e073b368b34deeba29a2f6590"
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
