# README

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
