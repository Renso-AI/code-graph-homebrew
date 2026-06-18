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
  version "1.4.0"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "2d195e7af6f1174e6c3df28a1f274b364a8b6a0f60a478ee6470c40058e00f2f"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "7b53290cbf41690478f5ec4b8f493bb415cac97b21dd7eb6acc9537084d98433"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d8aa893a40470ef76ace78d8ea282d13d3e20f5d8ef9df4baf93f6c7a3d477c2"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc8cd5363722e1b32727363e1697357ca074730954cdf39a1af54c2dda7339d3"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "0b9b309b7aeeb18298c267a23abdaf4c54c023ef06c973d2cee9583dfedda785"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "17d3799b1bb1c3512fbd94533e5f47403e5cdbc7efd91b69b400ac1fe46b3af6"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "6829825f89f9dc3d505aa4e20a5bb7176927ebadade00d14964f2626329736e2"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.0/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0716897806706a4ed5aa52a84670a89ce4827600c50da49c366612974e08c194"
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
