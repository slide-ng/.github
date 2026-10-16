# .github of the slide-ng organization

This is the organization-level `.github` repository. It holds the files that GitHub shows on the organization page and applies to every repository in the organization that does not have its own copy.

The organization name `slide-ng` is a placeholder. It is kept in [`org.env`](org.env) for the scripts, and `scripts/set-org.sh <name>` rewrites the links in the other files once the real name is chosen.

## What is inherited

GitHub reads these files from this repository for any public repository of the organization that has no file of its own:

| file                                                     | what it gives every repository                       |
| -------------------------------------------------------- | ---------------------------------------------------- |
| [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md)              | the code of conduct                                  |
| [`CONTRIBUTING.md`](CONTRIBUTING.md)                    | the contributing guide                               |
| [`SECURITY.md`](SECURITY.md)                            | the security policy                                  |
| [`SUPPORT.md`](SUPPORT.md)                              | where to get help                                    |
| [`.github/FUNDING.yml`](.github/FUNDING.yml)            | the Sponsor button                                   |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE)     | the bug and feature forms and the issue chooser      |
| [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md) | the pull request template              |
| [`profile/README.md`](profile/README.md)                | the organization profile page (not a per-repo file)  |

A repository that has its own version of a file, or its own `ISSUE_TEMPLATE` folder, keeps it. The repository-specific guides take priority.

## What is not inherited

GitHub does not apply these to other repositories. They live here as the shared source to copy from:

| file                                            | how it is used                                                               |
| ----------------------------------------------- | ---------------------------------------------------------------------------- |
| [`labels.yml`](labels.yml)                      | the shared label set; `scripts/sync-labels.sh` pushes it to each repository  |
| [`.github/release.yml`](.github/release.yml)    | release-note categories; copy it into each repository's `.github/`          |
| [`templates/dependabot.yml`](templates/dependabot.yml) | a Dependabot configuration to copy per repository                    |
| [`docs/`](docs)                                 | the owner's setup checklist and the placeholder list                         |

## Scripts

```sh
scripts/sync-labels.sh              # prints the gh commands (dry run, the default)
scripts/sync-labels.sh --apply      # creates or updates the labels in every repository
scripts/list-placeholders.sh        # lists the placeholders found in the sibling repositories
scripts/set-org.sh <new-name>       # replaces the placeholder organization name
```

The first steps for the owner are in [docs/GITHUB-SETUP.md](docs/GITHUB-SETUP.md).

## License

MIT, see [LICENSE](LICENSE). Note that GitHub never inherits a license file.
