# Federation

## Phase 1: ActivityPub through federails

[federails](https://gitlab.com/experimentslabs/federails) is mounted at `/` and
configured in `config/federails.yml`. Users become ActivityPub `Person` actors,
so people on Mastodon, Lemmy and similar platforms can follow creators, boost
releases and reply to comments.

Not done yet: `acts_as_federails_actor` on `User`, and publishing activities
for new projects, releases and comments.

## Phase 2: ForgeFed

[ForgeFed](https://forgefed.org/spec/) adds forge vocabulary on top of the same
actors. Code lives in `app/services/forge_fed/` once it starts.

```mermaid
flowchart TB
  person["Person (User)"]
  repo["Repository (Project)"]
  ticket["Ticket (Issue)"]
  patch["Patch / MergeRequest (PullRequest)"]
  person -- owns --> repo
  repo -- has --> ticket
  repo -- receives --> patch
```

Goals: forks across instances, merge proposals from a remix on another
instance, and Launchpad-style remote bug watches.
