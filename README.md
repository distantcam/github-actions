# Github Actions

This repo is a collection of [GitHub Actions](https://github.com/features/actions) for working with GitHub itself. 

List of actions:

- distantcam/github-actions/pattern-filter@master
- distantcam/github-actions/delete-pr-branch@master
- distantcam/github-actions/self-assign-pr@master

## Pattern Filter

Allows a workflow to filter based on some pattern in the event.

```hcl
action "Filter Merged PR" {
  uses = "distantcam/github-actions/pattern-filter@master"
  args = ".pull_request.merged true"
}

action "PR is not Assigned" {
  uses = "distantcam/github-actions/pattern-filter@master"
  args = ".pull_request.assignee null"
}
```

## Delete PR Branch

Deletes the branch associated with a PR. Won't delete `master`.

This can be combined with a filter.

```hcl
action "Filter Closed" {
  uses = "actions/bin/filter@95c1a3b"
  args = "action closed"
}

action "Delete PR Branch" {
  uses = "distantcam/github-actions/delete-pr-branch@master"
  needs = ["Filter Closed", "Filter Merged PR"]
  secrets = ["GITHUB_TOKEN"]
}
```

## Self-assign PR

Assigns the user who opened a PR to the PR.

This can be combined with a filter.

```hcl
action "Filter Opened" {
  uses = "actions/bin/filter@95c1a3b"
  args = "action opened"
}

action "Assign PR to opener" {
  uses = "distantcam/github-actions/self-assign-pr@master"
  needs = ["Filter Opened", "PR is not Assigned"]
  secrets = ["GITHUB_TOKEN"]
}
```