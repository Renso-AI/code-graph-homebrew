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
  version "1.4.2"

  on_macos do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-aarch64-apple-darwin.tar.gz"
      sha256 "03522b72451f4b4ab2a3567ac722261e53775bf0c09dd44fdd833d0f12d10e9d"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-x86_64-apple-darwin.tar.gz"
      sha256 "987960050f1d723baf110c05609aeea6f3412206447bc7d96cb2a07de797b5e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "940080abff48b7a3e953f2c711fa7b1ab1161acfeac05a1b99ddbf56d4daea34"
    end
    on_intel do
      url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f428d1c9d5267fd7d8e9b9a54525312f7ef979c4f3db9d25ae3b12e080b24661"
    end
  end

  # The MCP server ships in a separate archive; download + install
  # both via resources so Homebrew tracks dependencies cleanly.
  resource "code_graph-mcp" do
    on_macos do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-mcp-aarch64-apple-darwin.tar.gz"
        sha256 "53a7076c17a3c4d791798e85af620698f7ddfb22cd3a47039f33a049c550eedf"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-mcp-x86_64-apple-darwin.tar.gz"
        sha256 "48625fdf3df50aa3433bab9eea8ab71d51f4485a563f13b65aa5ff9e26a14867"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-mcp-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "3113df83f1e8512ef3d8d39d9b64a926d432aff7ba3e3f42b4a94149d0e71ac9"
      end
      on_intel do
        url "https://github.com/Renso-AI/code-graph-dist/releases/download/v1.4.2/code_graph-mcp-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3f4c6ff30b8c7d93e2ad8ba4d0a334ffaa35ea902244ebdd35dc15602e170e62"
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
