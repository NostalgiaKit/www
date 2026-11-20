# Editors

The block editors live here, outside the Rails app. Each one is built on its own
and its static output is copied into `public/editors/<name>/` (git ignores that
directory), where `EditorsController` frames it.

| Directory | Upstream | License | Status |
| --- | --- | --- | --- |
| `scratch/` | Fork of TurboWarp `scratch-gui` and `scratch-vm` | GPL-3.0 (gui), MPL-2.0 (TurboWarp vm) | Not set up |
| `snap/` | Snap! | AGPL-3.0 | Not set up |

Both licenses are compatible with NostalgiaKit's AGPL-3.0-only. Each editor
still lives in its own directory as a git submodule, with our changes as commits
on the fork, so it can be rebased on upstream. The Rails app talks to an editor
only through the page it frames and a `postMessage` bridge, never by importing
its code.

## Scratch (TurboWarp fork)

Planned changes on the fork:

- "Stage on the left" layout.
- Restored 1.x/2.x blocks that Scratch 3 retired (for example `forever if` and `loud?`).
- Rebranded 1.4/2.0-era sprite and sound library, served from our LFS store.
- Custom extensions.
- Load and save through the NostalgiaKit bridge instead of the Scratch website API.

## Snap!

Hosted as is, with its Morphic look intact. Only the load and save hooks change.

## Building

`bin/editors` will build both and copy them into `public/editors/`. It is a stub for now.
