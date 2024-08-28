# fzf-raindrop

Fast search through all your [Raindrop](https://raindrop.io/) bookmarks.

## Features

- 🔥 Instant as-you-type fuzzy search (tested on 100,000 bookmarks): thanks to [fzf](https://github.com/junegunn/fzf).
- 🚀 Instant launch: convenient for mapping to global system shortcut.
- 🔭 Multi-field search: Search through url, tags, title, highlights, and excerpt.
- ♻️ Offline: A network request is fired only when pulling latest bookmarks.
- 🐙 Multi-select: Use `TAB` to select multiple items and open them in your browser.

### Demo

Searching through 120,000 bookmarks and opening 7 of them in new tabs.

https://github.com/thenbe/fzf-raindrop/assets/33713262/599d82bc-9515-4174-88b5-63e6b8697a20

## Usage

### Run

```sh
fzf-raindrop

# or through nix if you prefer
nix run github:thenbe/fzf-raindrop
```

### Pull latest bookmarks

> [!NOTE]
> Bookmarks will be pulled _automatically_ only when you launch `fzf-raindrop` for the first time. After that, you can pull the latest bookmarks by running the following command.

```sh
FZF_RAINDROP_TOKEN="..." fzf-raindrop update

# or using nix
FZF_RAINDROP_TOKEN="..." nix run github:thenbe/fzf-raindrop -- update
```

### Key maps

| Key      | Description             |
| -------- | ----------------------- |
| `ENTER`  | open item(s) in browser |
| `TAB`    | (un)select item         |
| `ctrl+p` | previous query          |
| `ctrl+n` | next query              |

### Advanced

- **Search syntax.** If you search for `#github` you will see both (1) items that are tagged with `#github` and (2) items that have `github.com` in their URL. If you'd like to be more strict and only match the tags, search for `'#github` instead. See [fzf](https://github.com/junegunn/fzf#search-syntax)'s advanced search syntax for more.

## Installation

### Nix

If you have nix [installed](https://zero-to-nix.com/start/install), use `nix run ...` to take advantage of the flake hosted in this repo. See examples above.

### Manual

Clone this repo and make sure you have the required [dependencies](#dependencies).

## Configuration

| Env Var                 | Required | Default                           | Example              | Notes                       |
| ----------------------- | -------- | --------------------------------- | -------------------- | --------------------------- |
| `OPENER`                | no       | `xdg-open`, `open`                | "mimeo" or "firefox" | Program used to launch URLs |
| `FZF_RAINDROP_TOKEN`    | yes      |                                   | "a1b2c3..."          | Get from Raindrop app\*     |
| `FZF_RAINDROP_DATA_DIR` |          | `$HOME/.local/share/fzf-raindrop` |                      |                             |

### Generate a Raindrop token

A test token is [sufficient](https://developer.raindrop.io/v1/authentication/token) for our needs. To create one:

1. Go to the [Raindrop app settings](https://app.raindrop.io/settings/integrations).
1. Click `Create new app`. Name it `fzf-raindrop`.
1. Click on the item you just created.
1. Click on `Create test token`.

## Dependencies

- [`duckdb`](https://github.com/duckdb/duckdb)
- [`fzf`](https://github.com/junegunn/fzf)
- `jq`

## Contributing

- To generate a picker with fake data, clone the repo, run `nix develop .#demo`, then follow the on-screen prompt.
- Embedded SQL snippets can be formatted using `sleek` (If using vim: highlight SQL string in visual mode, then `:!sleek`)
