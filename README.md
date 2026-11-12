# SUBCULT Homebrew tap

Homebrew formulae for tools from the [SUBCULT collective](https://github.com/subculture-collective).

```bash
brew install subculture-collective/tap/pult
brew install subculture-collective/tap/super-productivity-mcp
brew install subculture-collective/tap/twitchdl
brew install subculture-collective/tap/ytclip
```

| Formula | What it is |
|---|---|
| [pult](Formula/pult.rb) | Applies one palette across your terminal apps and can undo every change. Website: <https://pult.subcult.tv> |
| [super-productivity-mcp](Formula/super-productivity-mcp.rb) | MCP server that lets AI clients read and change your tasks in Super Productivity; installs `sp-mcp`, `sp-quick-add` and the plugin zip. |
| [twitchdl](Formula/twitchdl.rb) | Downloads Twitch clips and VODs and records live streams, with yt-dlp, Streamlink and ffmpeg. |
| [ytclip](Formula/ytclip.rb) | Downloads a whole YouTube video or a timestamped clip, with yt-dlp and ffmpeg. |

Formulae build from source, so macOS needs no signed binary, and they work with Homebrew on Linux too.

## How it is kept current

`Formula/pult.rb` is a copy of the `pult.rb` attached to each [Pult release](https://git.subcult.tv/subculture-collective/pult/releases). The `update` workflow checks for a new release every six hours, or when run by hand. It builds, tests and audits the new formula on macOS and commits it only if all three pass. The `test` workflow does the same on macOS and Linux for every push and pull request.

To update pult by hand, run `scripts/sync-pult.sh` and commit `Formula/pult.rb`.

super-productivity-mcp, twitchdl and ytclip build from their GitHub release tags (super-productivity-mcp also takes the plugin zip from its release). To update one, change its `url` (and any `resource` URL) to the new tag and each `sha256` to the checksum of that file (`curl -fsSL <url> | sha256sum`).

## Licence

The formulae are MIT-licensed. Each tool keeps its own licence.
