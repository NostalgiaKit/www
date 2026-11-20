# NostalgiaKit

A forge for Scratch and Snap! projects, with the feel of a mid-2000s software
forge. Projects are Git repositories, remixes come back as merge proposals,
and every project gets a bug tracker and blueprints. It federates over
ActivityPub, with ForgeFed planned.

Early scaffolding: most pages are placeholders. See `docs/roadmap.md`.

## Running it

```sh
bundle install
bin/rails db:prepare
bin/dev
```

Rugged builds libgit2 from source on install, which needs CMake and pkg-config.
The editors are built separately with `bin/editors` (not implemented yet; see
`editors/README.md`).

## Docs

- `docs/architecture.md`: how the pieces fit
- `docs/federation.md`: ActivityPub and ForgeFed plans
- `docs/roadmap.md`: what is done and what is next
- `AGENTS.md`: rules for coding agents

## License

AGPL-3.0-only. See `LICENSE`.

## Configuration

This app reads all secrets from environment variables. It does not use Rails
encrypted credentials, so there is no `config/master.key` or `config/credentials.yml.enc`.

- **Development / test:** `cp .env.example .env` and fill in what you need. The
  `dotenv` gem loads it automatically. `SECRET_KEY_BASE` can stay blank; Rails
  generates `tmp/local_secret.txt` for you.
- **Production:** set `SECRET_KEY_BASE` (generate with `bin/rails secret`) plus any
  optional variables listed in `.env.example`.
- **Kamal:** export the variables in the shell you deploy from.
  `.kamal/secrets` forwards them to the containers.
