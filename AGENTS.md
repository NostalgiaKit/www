# NostalgiaKit

## What agents may do (IMPORTANT)

A human writes the real code in this project. Agents are limited to the
following kinds of work:

1. **Writing tests.** Unit, integration and system tests, plus fixtures. Tests may describe behavior that is not built yet; mark those with `skip` and a reason instead of implementing the behavior to make them pass.
2. **Reviewing code.** Read a diff, branch or file and report bugs, risks and missed rules from this file. Report findings; do not fix them unless the fix falls under another item on this list.
3. **Trivial changes.** Renaming, moving files, mechanical refactors that keep behavior the same, fixing lint, bumping a dependency to its latest version, and fixing typos.
4. **Updating the agent docs.** `AGENTS.md` (and `CLAUDE.md`, which only includes it), so this file stays true to the code.
5. **Scaffolding.** Generators, migrations, routes, empty controllers and views, model associations and validations, and service classes whose methods `raise NotImplementedError` or carry a `TODO`. The goal is to give the human a shell to fill in.

Anything else, for example implementing `Git::ProjectRepository`, the LFS API, the `.sb3` exporter, the BBCode parser, the editor bridge or federation, is out of scope. When a task needs that, scaffold what you can, leave a `TODO` that says what is missing, and tell the human in your reply. Do not quietly do the work anyway, even if it looks small.

When you are unsure whether something counts as scaffolding or as a trivial change, it does not. Ask.

## Overview

NostalgiaKit is a forge for Scratch and Snap! projects, styled after mid-2000s software forges. It is a Ruby on Rails app (module `NostalgiaKit`). The working directory is still called `www`.

- **Look:** Canonical Launchpad (warm neutrals, crisp 1px borders, dense two-column layouts, orange and gold accents) mixed with Scratch 2.0 (the `#3373CC` to `#4D97FF` sky-blue top bar, beveled block edges). Tango Desktop Project icons at 16x16 and 22x22.
- **Near-zero JS:** every page is server-rendered ERB and ships no JavaScript. The only exception is the editor page, which frames a prebuilt editor. A test (`test/integration/pages_smoke_test.rb`) checks the web shell has no `<script>` tags. Turbo, Stimulus and importmap are still in the Gemfile from `rails new` but the shell layout does not load them; whether to remove them is the human's call.
- **Editors:** a TurboWarp fork (scratch-gui and scratch-vm) with "stage on the left", restored 1.x/2.x blocks such as `forever if` and `loud?`, custom extensions and a rebranded 1.4/2.0 sprite and sound library; and Snap! hosted as is, keeping its Morphic look.
- **Storage:** each project is a bare Git repository opened with Rugged (libgit2), never by shelling out to `git`. Git holds the plain-text source (`project.json` for Scratch, `project.xml` for Snap!). Binary assets are deduplicated by SHA-256 in Active Storage (`LfsObject`) and referenced from Git by LFS pointer files, so `git clone` and `git lfs pull` work. `.sb3` export renames assets to the MD5 names vanilla Scratch expects.
- **Collaboration:** asynchronous only. Remixes are forks; changes come back as merge proposals (`PullRequest`). Launchpad-style bugs (`Issue`) and blueprints (`Blueprint`). No live multiplayer editing.
- **Federation:** phase 1 is ActivityPub through `federails`. Phase 2 is ForgeFed (Repository actors, Ticket and Patch objects, cross-instance forks and merge proposals, remote bug watches).

Details in `docs/architecture.md`, `docs/federation.md` and `docs/roadmap.md`.

### Layout

- `app/models/`: `User`, `Project`, `PullRequest`, `Issue`, `Blueprint`, `ForumTopic`, `ForumPost`, `LfsObject`.
- `app/services/git/`: `ProjectRepository` (the Rugged wrapper; repositories live in `storage/repositories/<username>/<slug>.git`) and `LfsPointer`.
- `app/services/sb3/exporter.rb`: vanilla `.sb3` export.
- `app/services/bbcode/renderer.rb`: forum BBCode to safe HTML. Our own parser, because the Ruby BBCode gems are unmaintained.
- `app/services/forge_fed/`: phase 2, empty for now.
- `app/controllers/`: thin controllers. `ProjectScoped` loads `@owner` and `@project` for every `/~:user_username/:project_slug` route. `Lfs::` controllers serve the Git LFS API under `/~user/project.git/info/lfs/`.
- `app/views/layouts/`: `application` (the shell), `project` (nested inside it for project pages), `editor` (the only page with JavaScript, inside its frame).
- `app/assets/stylesheets/application.css`: design tokens and all styles. Use the CSS variables at the top instead of new hard-coded colors.
- `app/assets/images/tango/`: Tango icons by freedesktop name, through `tango_icon` in `ApplicationHelper`. A trimmed subset is vendored; see its `README.md`.
- `editors/`: the block editors, built by `bin/editors` into `public/editors/` (git ignores the output).
- `docs/`: architecture, federation and roadmap.

### Rules that keep the layers separate

- Git access goes through `Git::ProjectRepository`. Controllers and views never touch `Rugged` directly.
- Asset bytes never go into Git. Git holds LFS pointers; `LfsObject` and Active Storage hold the bytes.
- URLs follow Launchpad: `/~username/project`, with `+bugs`, `+merges` and `+specs` for the project's sub-pages. Keep new project pages under the same scope and the `ProjectScoped` concern.
- Git and LFS endpoints live under `/~user/project.git/` and are separate from the HTML routes.
- No JavaScript in the web shell. If a page seems to need it, ask first.

## Licenses (IMPORTANT)

NostalgiaKit is licensed `AGPL-3.0-only` (see `LICENSE`). Do not change or overwrite `LICENSE`.

- AGPL section 13 means anyone using a running instance must be offered its source. Keep a working "source code" link in the site footer once it exists, and do not add anything that would make that link point at code that differs from what is deployed.
- Dependencies must be compatible with AGPL-3.0-only: permissive licenses (MIT, BSD, Apache-2.0, ISC), MPL-2.0, LGPL-3.0, GPL-3.0 and AGPL-3.0 are fine. GPL-2.0-only and anything with "no network use" or field-of-use limits are not. Check the license before adding a gem or npm package.
- Code from compatible copyleft projects (scratch-vm, scratch-gui, TurboWarp, Snap!) may be used, as long as its copyright and license notices are kept. Still prefer reading them as a reference over pasting.

The editors stay in their own directories under `editors/`, as submodules with our changes on the fork, so they can be rebased on upstream. The Rails app talks to an editor only through the framed page and a `postMessage` bridge, not by importing its code.

Tango icons are public domain. Any other art or sound added for the 1.4/2.0-style library needs a license that allows redistribution; record where it came from.

## Building and testing

- `bundle install`. Rugged compiles libgit2, which needs CMake and pkg-config.
- `bin/rails db:prepare`, then `bin/dev` to run it.
- `bin/rails test` runs the tests. Every page, placeholder or not, should be covered by `test/integration/pages_smoke_test.rb`; add new pages there.
- Fixtures in `test/fixtures/` use named records (`alice`, `platformer`) that the tests refer to. Keep them valid against the migrations.
- Copied engine migrations (`*.federails.rb`, `*.active_storage.rb`) stay as upstream wrote them; `.rubocop.yml` excludes them.

## Searching the codebase

Use fast, modern tools instead of the slow defaults:

- [`rg`](https://github.com/BurntSushi/ripgrep) (ripgrep) for text search, not `grep`. It respects `.gitignore` for you. **NOTE**: Prefer [`ast-grep`](https://ast-grep.github.io) when applicable, as it uses the structure of the code instead.
- [`fd`](https://github.com/sharkdp/fd) for finding files by name, not `find`.
- [`ast-grep`](https://ast-grep.github.io) for structural searches and rewrites, like finding every call to a method or every subclass. Call it as `ast-grep`. The `sg` alias is deprecated, so don't use it.
- `jq` for reading and querying JSON, including `project.json` files.

If your harness has dedicated search or file tools that already wrap these, those are fine too.

## Code quality

Always lint:

- `bin/rubocop` (Rails Omakase style) must pass. `bin/rubocop -a` fixes most of it.
- `bin/brakeman` must report no warnings.
- CI runs both, plus the tests.

### ERB and HTML formatting

Templates are formatted with [Herb](https://herb-tools.dev) (the `herb` gem, development group). Herb picks up every `*.html.erb` under `app/views/` and the static pages in `public/*.html`. Its settings live in `.herb.yml`: `framework: actionview` turns on the Rails rules, the formatter uses 2-space indents and an 80-column limit, and `version` pins the rule set so a Herb upgrade doesn't switch on new rules until someone bumps it. `bundle exec herb config .` lists the files it covers.

- `bundle exec herb format` rewrites templates in place. `bundle exec herb format --check` only reports. The Ruby gem hands both off to the `@herb-tools/formatter` npm package through `npx`, so Node.js has to be installed (no `package.json` is needed).
- `bundle exec herb lint` runs the template linter (`@herb-tools/linter`). It currently reports nothing at all; keep it that way. Only errors fail it, but fix warnings and info notes too.
- Render partials by their full path (`render "projects/grid"`, not `render "grid"`), as the `actionview-prefer-qualified-partial-path` rule asks.
- Its `erb-no-interpolated-class-names` and `erb-prefer-direct-output` rules together rule out both `class="status-<%= x %>"` and `class="<%= "status-#{x}" %>"`. When a class name is built from a value, write the element with the `tag` helper instead, for example `<%= tag.td label, class: "status-#{x}" %>`.
- Format any template you add or touch before committing, and keep the result as Herb writes it: one attribute per line once a tag gets long, wrapped paragraph text, and a blank line between sibling blocks. Don't hand-edit it back into a different shape.
- The `rubocop-erb` gem is in the Gemfile too, but `.rubocop.yml` does not load it yet, so `bin/rubocop` does not check Ruby inside templates. Neither `bin/ci` nor the GitHub workflow runs Herb. Wiring those in is the human's call.

Use modern code practices:

- Latest Ruby and Rails (see `.ruby-version` and the Gemfile). Use current Ruby features such as endless methods and `Data.define` where they read well.
- Rails conventions over custom structure. Business logic goes in models or `app/services/`, not controllers or views.
- No crashes on bad input. A malformed `project.json` or `.sb3` is a reported error, not a 500.

## Docs (IMPORTANT!!!)

Always update the docs if necessary when changing or adding code. If the docs already contain outdated information, expand your scope to cover that info too. This includes `AGENTS.md` itself.

Docs live in `docs/`: `architecture.md`, `federation.md`, `roadmap.md`. Planned: an editors page once the forks exist, and a page on the restored blocks.

When a roadmap item is finished, check it off (`- [x]`) where it is. DO NOT move it into an earlier section like "Done". The roadmap shows how each area is progressing, so finished items stay with the section they belong to.

## Diagrams as Mermaid, not ASCII art

Never draw a flow, pipeline or architecture picture out of characters in a code block. Make a Mermaid diagram instead.

## Outdated packages

PLEASE, PLEASE do not use a package that is old or deprecated. EVEN IF IT IS "INDUSTRY STANDARD" THAT DOES NOT MEAN IT IS GOOD!!! USE THE BEST PACKAGE AND LATEST VERSION LIKE A NORMAL PERSON WOULD!

Check rubygems.org (`gem search -r '^<name>$'` or `https://rubygems.org/api/v1/gems/<name>.json`) for the current release before adding or bumping a gem, and check that it is still maintained. If every gem for a job is unmaintained (as with BBCode), say so and leave a scaffold for the human rather than pulling one in.

## Keep things human

Do not use em dashes or other special symbols not normally found in writing. Do not word things in a weird way. Keep it looking human. If you need to use, for example, an arrow icon, use an SVG or a Tango icon instead.

Replacing an em dash with a hyphen is NOT a fix. A spaced hyphen doing an em dash's job ("the limit - 4 bytes", "fast - but wrong") is the same tic with a different character. Reword the sentence instead: use a comma, a colon, parentheses, or the actual word ("minus", "to", "through"). Plain hyphens in compound words and numeric ranges like 0-1 are fine.

## Use American spelling

It's fine to be British in the chat if the person is actually in a region where it's spelled like that. But if not, just use American spelling. The thing itself MUST use American spelling.
