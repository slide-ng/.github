# Contributing to slide.ng

Thank you for wanting to help. This page is the general guide for every repository of the organization. A repository can have its own `CONTRIBUTING.md` with more detail, such as the commands and tests of that project. **When the repository has its own guide, follow it first**; this page covers what they share.

By taking part you agree to the [Code of Conduct](CODE_OF_CONDUCT.md). By contributing you agree that your work is licensed under the license of the repository you contribute to (MIT for all of them).

## Where to ask

- **A question or an idea:** open a discussion in the organization's Discussions (see [SUPPORT.md](SUPPORT.md)). Please do not use an issue for a question.
- **A bug or a feature request:** open an issue in the repository it concerns, using the form. If you are not sure which repository, use `slide.ng`; we will move it.
- **A security problem:** report it privately, as [SECURITY.md](SECURITY.md) describes. Never in a public issue.

## Report a bug

1. Search the existing issues first, including closed ones.
2. Use the bug form. Give the version or commit, your Node.js version, your operating system and browser, and what you did, expected and got.
3. Add the smallest `slides.md` that shows the problem, or link a repository. A short reproduction is the fastest way to a fix.

## Suggest a feature

Describe the problem before the solution: what you want to do and cannot. If the feature exists in Slidev, link its documentation. For a large change, open the issue first so we can agree on the approach before you write code.

## Set up a clone

Fork the repository on GitHub, then:

```sh
git clone https://github.com/<you>/<repository>.git
cd <repository>
git remote add upstream https://github.com/slide-ng/<repository>.git
git switch -c <type>/<short-name>
```

The repository's README or its own `CONTRIBUTING.md` says which Node.js version to use (the `.nvmrc` file names it) and how to install, run and test. Most repositories use `npm ci`; the documentation site uses `pnpm`. Many ship hooks in `.githooks` that format staged files and check commit messages; the install step usually turns them on.

Keep your branch up to date with `git fetch upstream` and `git rebase upstream/main`.

## Commit messages

Use `type(scope): summary`:

- `type` is one of `feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `build`, `ci` or `chore`.
- `scope` is the area you touched, in lowercase. The repository's guidelines list the scopes it uses.
- `summary` is imperative and short ("add the zoom layout", not "added" or "adds"), with no full stop.
- Use the body to say why. Add `BREAKING CHANGE:` in the body when users must change something.

Examples: `fix(export): keep the slide order in the pdf`, `docs(readme): explain the offline build`.

Pull requests are squash merged, so the pull request title must follow the same form. It becomes the commit on `main` and the line in the release notes.

## Sign your commits

Please sign your commits with a key you have added to GitHub (SSH or GPG), so that they show as **Verified**. GitHub explains the setup in "About commit signature verification". A repository can require signed commits on `main`; in that case an unsigned commit blocks the merge. If your commits are unsigned, the maintainers will ask you to sign them rather than rewrite them for you.

## Pull requests

- Keep one change to one pull request, with its tests and docs.
- Fill in the template. Link the issue with `Fixes #123`.
- Run the repository's checks before you push (lint, format, build, tests). CI runs them again.
- Add or update the documentation when behavior changes. If none is needed, say why and add the `no-docs` label (a maintainer can add it).
- Be patient with reviews; the projects are kept up in spare time. A pull request that needs changes stays open for a while before it is closed as stale.

## Good first issues

Issues with the `good first issue` label are small and well described. Issues with `help wanted` are open to anyone. Say in the issue that you are taking one, so two people do not do the same work.

## Recognition

Everyone who helps is welcome on the contributors list, for code, docs, design, review and triage alike. Comment `@all-contributors please add @user for <type>` on an issue or pull request where the bot is installed.
