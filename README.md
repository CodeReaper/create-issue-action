[![Build and Test](https://github.com/codereaper/create-issue-action/actions/workflows/test.yaml/badge.svg)](https://github.com/codereaper/create-issue-action/actions/workflows/test.yaml)

# Create Issue Action

A simple GitHub Action that **creates, updates, comments on, or closes issues** using the GitHub CLI (`gh`).

Ideal for CI/CD workflows that need to:

- Automatically open or update tracking issues
- Comment on existing issues from automation
- Close issues after builds or deployments are complete

## Features

- Create new issues with titles, bodies, templates, labels, and assignees
- Update existing issues automatically
- Add comments to existing issues
- Close issues by title and label search
- Uses `gh` CLI under the hood (no extra dependencies)

## Inputs

| Name        | Description                                                                                                                      | Default                  | Required |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ | -------- |
| `token`     | GitHub token (or PAT) used for authentication                                                                                    | `${{github.token}}`      | Yes      |
| `mode`      | Operation mode: `create` or `close`                                                                                              | `create`                 | Yes      |
| `state`     | Issue state filter when searching for existing issues: `open`, `closed`, or `all`                                                | `open`                   | Yes      |
| `title`     | Title of the issue to create or update                                                                                           | -                        | Yes      |
| `labels`    | Comma-separated list of labels used for creation and search                                                                      | -                        | No       |
| `assignees` | Comma-separated list of users to assign the issue to                                                                             | -                        | No       |
| `body`      | Optional body text for the issue                                                                                                 | -                        | No       |
| `comment`   | Optional comment text to add to an existing issue instead of updating the issue body, or as closing comment if closing the issue | -                        | No       |
| `repo`      | Repository to operate on (`owner/repo`)                                                                                          | `${{github.repository}}` | Yes      |

## Example Usage

```yaml
name: Reporting on failed builds
on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build
        run: make build

  report-failure:
    runs-on: ubuntu-latest
    needs: build
    if: failure()
    permissions:
      contents: read
      issues: write
    steps:
      - name: Report build failure
         uses: CodeReaper/create-issue-action@v1
        with:
          title: "{{ github.workflow }} failed to build"
          labels: automation
          assignees: "@me"
          body: See [the action log](https://github.com/{{ github.repository }}/actions/runs/{{ github.run_id }}) for more details.
```

# License

This project is released under the [MIT License](LICENSE)
