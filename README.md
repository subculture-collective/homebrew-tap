# SUBCULT Homebrew tap

Homebrew formulae for tools from the [SUBCULT collective](https://github.com/subculture-collective).

```bash
brew install subculture-collective/tap/pult
```

| Formula | What it is |
|---|---|
| [pult](Formula/pult.rb) | Applies one palette across your terminal apps and can undo every change. Website: <https://pult.subcult.tv> |

Formulae build from source, so macOS needs no signed binary, and they work with Homebrew on Linux too.

## How it is kept current

`Formula/pult.rb` is a copy of the `pult.rb` attached to each [Pult release](https://git.subcult.tv/subculture-collective/pult/releases). The `update` workflow checks for a new release every six hours, or when run by hand. It builds, tests and audits the new formula on macOS and commits it only if all three pass. The `test` workflow does the same on macOS and Linux for every push and pull request.

To update by hand, run `scripts/sync-pult.sh` and commit `Formula/pult.rb`.

## Licence

The formulae are MIT-licensed. Each tool keeps its own licence.
