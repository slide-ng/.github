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
| [`brand/`](brand)                               | the official logo kit: SVGs, icons, GitHub avatar, social preview, README banners |
| [`docs/`](docs)                                 | the owner's setup checklist and the placeholder list                         |

## Brand

[`brand/`](brand) is the full slide.ng logo kit; the other repositories copy only the files they use. The wordmark is Space Grotesk Bold (SIL OFL 1.1), outlined in the SVGs, so no font file is needed. The shield is original artwork. slide.ng is a community project, not affiliated with the Angular team.

## Scripts

```sh
scripts/sync-labels.sh              # prints the gh commands (dry run, the default)
scripts/sync-labels.sh --apply      # creates or updates the labels in every repository
scripts/list-placeholders.sh        # lists the placeholders found in the sibling repositories
scripts/set-org.sh <new-name>       # replaces the placeholder organization name
```

The first steps for the owner are in [docs/GITHUB-SETUP.md](docs/GITHUB-SETUP.md).

## Maintainers

<!-- prettier-ignore-start -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/erkamyaman"><img src="https://avatars.githubusercontent.com/u/88717125?v=4&s=100" width="100px;" alt="Erkam Yaman"/><br /><sub><b>Erkam Yaman</b></sub></a><br /><sub>Maintainer</sub></td>
    </tr>
  </tbody>
</table>
<!-- prettier-ignore-end -->

## Contributors

Thanks to everyone who has helped. This project follows the [all-contributors](https://allcontributors.org) specification. Contributions of any kind welcome!

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/erkamyaman"><img src="https://avatars.githubusercontent.com/u/88717125?v=4?s=100" width="100px;" alt="Erkam Yaman"/><br /><sub><b>Erkam Yaman</b></sub></a><br /><a href="https://github.com/slide-ng/.github/commits?author=erkamyaman" title="Documentation">📖</a> <a href="#infra-erkamyaman" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#maintenance-erkamyaman" title="Maintenance">🚧</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## Sponsors

slide.ng is free and open source. If it helps your work, please consider sponsoring it. Your support keeps development going.

<p>
  <a href="https://github.com/sponsors/erkamyaman"><img src="https://img.shields.io/badge/Sponsor-%E2%9D%A4-db61a2?logo=githubsponsors&logoColor=white" alt="Sponsor on GitHub" /></a>
</p>

## License

MIT, see [LICENSE](LICENSE). Note that GitHub never inherits a license file.
