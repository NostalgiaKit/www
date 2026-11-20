# ForgeFed (phase 2)

Nothing here yet. Phase 2 extends the phase 1 ActivityPub actors from federails with
the [ForgeFed](https://forgefed.org/spec/) vocabulary:

- `Repository` actor for each `Project`, next to the `Person` actor each `User` has.
- `Ticket` objects for issues, `Patch`/`MergeRequest` objects for pull requests.
- Cross-instance forks, federated pull requests, and Launchpad-style remote bug watches.

See `docs/federation.md` for the plan.
