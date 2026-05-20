# code-graph-homebrew

Homebrew tap for [code_graph](https://cg.renso.ai).

## Install

```sh
brew tap renso-ai/code-graph https://github.com/renso-ai/code-graph-homebrew
brew install renso-ai/code-graph/code-graph
```

(The two-step tap is because this repo is named `code-graph-homebrew`
rather than the `homebrew-<name>` convention that lets Homebrew
auto-resolve. After the first tap, `brew upgrade code-graph` and
re-installs are one-line.)

## How releases land here

The `Formula/code-graph.rb` file in this repo is auto-bumped by the
release workflow in
[Renso-AI/code_graph](https://github.com/Renso-AI/code_graph) — see
`packaging/source/homebrew/` in that repo for the template and the
`publish-brew` job in `.github/workflows/release.yml` for the
machinery.

Do not edit `Formula/code-graph.rb` by hand; the next release tag
overwrites it.

## License

The formula is Apache-2.0; the binary it points at is also
Apache-2.0. See the main repo for source.
