# Roadmap

Check items off where they are. Do not move them to another section.

## Web shell

- [x] Layouts, stylesheet tokens and placeholder pages
- [ ] Accounts and sign-in
- [ ] Vendor the Tango icons
- [ ] BBCode parser and forum reply form with a toolbar
- [ ] Project thumbnails

## Editors

- [ ] TurboWarp fork as a submodule, built by `bin/editors`
- [ ] Stage on the left layout
- [ ] Restored 1.x/2.x blocks (`forever if`, `loud?`, and others)
- [ ] 1.4/2.0-era sprite and sound library
- [ ] Snap! as a submodule
- [ ] Load and save bridge between the editor frame and Rails

## Git and storage

- [ ] `Git::ProjectRepository`: create, read, commit, branches, log
- [ ] Server-side forks for remixing
- [ ] Git LFS batch API and basic transfer
- [ ] Git smart HTTP for `git clone`
- [ ] Asset dedupe by SHA-256 (`LfsObject.store!`)
- [ ] `.sb3` export with MD5 asset names

## Collaboration

- [ ] Merge proposals: diff, comments, merge
- [ ] Bugs: create, triage, comments
- [ ] Blueprints: create, link bugs and merges

## Federation

- [ ] Phase 1: users as ActivityPub actors, follows, boosts, federated comments
- [ ] Phase 2: ForgeFed repositories, tickets, federated merge proposals, remote bug watches
