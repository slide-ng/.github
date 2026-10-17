# GitHub setup checklist

The things only a person can do, in the order to do them. Tick them off as you go. The organization name `slide-ng` is a placeholder everywhere; if the name is taken or you choose another, use it in step 1 and follow [step 19](#19-replace-the-placeholders).

Menu names below are the ones GitHub shows today. If one moved, search the settings page for the word in **bold**.

## 0. Before you start

- [ ] Two-factor authentication is on for the `erkamyaman` account.
- [ ] You have a signing key (SSH or GPG) added at **Settings > SSH and GPG keys** as a *signing key*, and git is set to use it (`git config --global commit.gpgsign true` plus `user.signingkey`). This matters for [step 8](#8-branch-protection-and-rulesets).
- [ ] `gh auth login` works on your computer (for the label script and for checks).
- [ ] The seven repositories exist locally as folders next to this one: `slide.ng`, `themes`, `starter`, `docs`, `docker`, `vscode-extension`. `skills` does not exist yet (see [step 4](#4-create-and-push-the-repositories)).

## 1. Create the organization

- [ ] <https://github.com/organizations/plan> > **Create a free organization**.
- [ ] Name: `slide-ng` (placeholder; if taken, try `slideng`, `slide-ng-dev`). Contact email: use one you read, it is private. Belongs to: **My personal account**.
- [ ] Skip the invitation step. Add people later.

## 2. Organization profile

At **github.com/organizations/slide-ng/settings/profile**:

- [ ] **Organization display name:** `slide.ng`
- [ ] **Description:** `Slidev-style slides in markdown, compiled with Angular.`
- [ ] **URL:** the documentation address, `https://slide-ng.dev/` (change it when there is a custom domain).
- [ ] **Profile picture:** upload `brand/github/org-avatar-1024.png` (square PNG, dark background; GitHub shows it round, and the shield sits inside the circle). Use `org-avatar-500.png` if you want a smaller file, or `org-avatar-light-500.png` where a light background is needed.
- [ ] **Location:** optional. **Social accounts:** add the ones that exist.
- [ ] Leave the public email empty. Nothing in these files asks for it.

## 3. Organization settings

- [ ] **Settings > Member privileges > Base permissions:** `Read`. Leave repository creation to owners only.
- [ ] **Settings > Authentication security:** *Require two-factor authentication for everyone in the organization.*
- [ ] **Settings > Repository > Repository defaults > Default branch:** `main` (it is usually already `main`; this fixes the name for every new repository).
- [ ] **Settings > Code security:** turn on, for new repositories, *Dependency graph*, *Dependabot alerts*, *Dependabot security updates*, *Secret scanning* and *Push protection*, and *Private vulnerability reporting*. Use **Enable all** for the existing ones once the repositories exist.
- [ ] **Settings > Actions > General:** allow actions from GitHub and from verified creators; workflow permissions *Read repository contents* (the workflows ask for what they need); leave *Allow GitHub Actions to create and approve pull requests* off.

## 4. Create and push the repositories

Create each one empty (no README, no license, no `.gitignore`), **Public**, owner `slide-ng`. Then, from each local folder:

```sh
git remote add origin git@github.com:slide-ng/<name>.git
git push -u origin main
```

| order | repository        | notes                                                                                                                 |
| ----- | ----------------- | --------------------------------------------------------------------------------------------------------------------- |
| 1     | `.github`         | this repository. It must be named exactly `.github` and be public, or GitHub does not read it. Push it first.         |
| 2     | `slide.ng`        | the core                                                                                                              |
| 3     | `themes` |                                                                                                                       |
| 4     | `starter`| also mark as a template in [step 9](#9-github-pages-and-the-template-repository)                                      |
| 5     | `docs`   |                                                                                                                       |
| 6     | `docker` |                                                                                                                       |
| 7     | `vscode-extension` |                                                                                                                       |
| 8     | `skills` | create it from the folder `slide.ng/skills/slide-ng` (the agent skill) plus a README, LICENSE and a note that the core is the source of truth. It is mirrored from the core, so it is never edited by hand. Decide how the mirror is copied (a script in the core, or a workflow with a token, see [step 10](#10-secrets-and-variables)). |

- [ ] All eight pushed. Open <https://github.com/slide-ng> and check that the profile page (`profile/README.md`) shows, with the logo banner (light or dark by theme).
- [ ] Open a new issue in `themes`: it should show the bug and feature forms of that repository (their own templates win over the defaults here). A repository without its own `.github/ISSUE_TEMPLATE` (for example `skills`) shows the forms of this repository.

## 5. Discussions

Discussions are what `SUPPORT.md`, `CONTRIBUTING.md` and the issue chooser point to.

- [ ] In the `.github` repository: **Settings > General > Features > Discussions** on.
- [ ] Open **Discussions > Categories** and create: `Q&A` (question and answer format), `Ideas`, `Show and tell` (the issue chooser links to its URL, so keep the name; GitHub makes the slug `show-and-tell`), `Announcements` (announcement format, maintainers only).
- [ ] In the organization: **Settings > Discussions** > select the `.github` repository as the source of organization discussions. The link <https://github.com/orgs/slide-ng/discussions> in `SUPPORT.md` and `.github/ISSUE_TEMPLATE/config.yml` then works.
- [ ] Optional: also turn Discussions on in `slide.ng` and use it for repository-specific talk. Then change nothing here; the links above stay organization-wide.

## 6. GitHub Sponsors

`.github/FUNDING.yml` lists `erkamyaman`. The Sponsor button only shows when that account has an enabled Sponsors profile.

- [ ] <https://github.com/sponsors/accounts> > pick your personal account > **Join the waitlist / Get started**, then complete the profile: tiers, payout country, bank or Stripe account, tax details. GitHub reviews it, which can take days.
- [ ] After approval, check <https://github.com/sponsors/erkamyaman>, which is the link in the profile README.
- [ ] To list another sponsorable account (an organization, or another maintainer), edit `github:` in `.github/FUNDING.yml`. Other platforms use the same file (`open_collective`, `ko_fi`, `custom`...). The file explains it in a comment.
- [ ] A repository with its own `.github/FUNDING.yml` overrides this one. Check that none of the repositories has an outdated one.

## 7. Private vulnerability reporting, per repository

`SECURITY.md` and every `config.yml` link to `.../security/advisories/new`, which only works when this is on.

- [ ] For each of the seven repositories and `.github`: **Settings > Code security > Private vulnerability reporting > Enable**. (Step 3 may already have done it; check each.)
- [ ] Also on the same page: *Dependabot alerts*, *Dependabot security updates*, *Secret scanning*, *Push protection*, and *Code scanning* (default setup) for `slide.ng`, `themes`, `docs`, `vscode-extension`.
- [ ] Open `https://github.com/slide-ng/slide.ng/security/advisories/new` while signed out of the owner account in a private window (or ask a friend): it should show the report form.
- [ ] `CODE_OF_CONDUCT.md` here sends conduct reports through a private report on the `.github` repository. Check that this repository has private reporting on too.

## 8. Branch protection and rulesets

Do this for `main` of every repository, after the first push (so you can push the initial commits).

Use **Settings > Rules > Rulesets > New ruleset > New branch ruleset**. The organization-wide ruleset (**Organization Settings > Rules**) may need a paid plan; if it is offered on the free plan, use one for all seven repositories, otherwise create the same ruleset in each repository (public repositories can use rulesets on the free plan).

- Name: `main`. Enforcement: **Active**. Target branches: **Include default branch**.
- [ ] **Restrict deletions** and **Block force pushes**.
- [ ] **Require linear history** (the pull requests are squash merged).
- [ ] **Require a pull request before merging**: 1 approval for repositories with more than one maintainer; for a solo owner, leave approvals at 0 and use the rule only to force the pull request and the checks. Dismiss stale approvals on new commits.
- [ ] **Require status checks to pass**, with *Require branches to be up to date*. Add these checks after each workflow has run once (the name is `<workflow> / <job>` as GitHub lists it):

  | repository         | checks to require                                              |
  | ------------------ | -------------------------------------------------------------- |
  | `slide.ng`         | `CI / check`, `CI / browser`, `Commit message / check`, `Docs check / check` |
  | `themes`  | `Commit message / check` (there is no build workflow yet; add one before the first release) |
  | `starter` | none yet (its workflows deploy; add a build check if you add one) |
  | `docs`    | `CI / build`                                                   |
  | `docker`  | `build / lint-and-test`, `build / image`                       |
  | `vscode-extension`  | `CI / build`, `Commit message / check`                         |
  | `skills`  | none yet                                                       |

- [ ] **Require signed commits.** Only turn this on after your signing key works (step 0): every commit that lands on `main` must be Verified. With squash merges, GitHub signs the squash commit itself, so the rule holds for contributors who cannot sign; but commits you push directly, and merges you make with *rebase*, need your key. The commits in these local repositories were made without a signing key; if you want the rule on, only the *new* commits need to be signed, old history is not checked. Do not turn the rule on the day you push if you still need to push unsigned work.
- [ ] Add yourself as a **bypass actor** (Repository admin) only while setting up, then remove it, so that the rules apply to you too.
- [ ] **Settings > General > Pull Requests:** allow *Squash merging* only, default message *Pull request title*; turn on *Automatically delete head branches*.
- [ ] Each repository has `.github/CODEOWNERS` (`* @erkamyaman`). With **Require review from Code Owners** on, a solo owner cannot merge their own pull request unless approvals stay at 0; leave it off until there is a second maintainer.

## 9. GitHub Pages and the template repository

**docs** (`.github/workflows/deploy.yml` publishes `dist/analog/public`):

- [ ] **Settings > Pages > Build and deployment > Source: GitHub Actions.**
- [ ] The site is built for the root of a host (`site.base: '/'` in `src/ngmd.config.ts`, `url: 'https://slide-ng.dev'`). A project site lives at `https://slide-ng.dev/`, so either set `NGMD_BASE=/docs/` in the deploy workflow's build step (or change `base` in the config), or add a custom domain and keep `/`. Without one of these the links and assets break.
- [ ] Push to `main` or run the **Deploy** workflow by hand. Open the URL it prints. If the first run fails on the `github-pages` environment, check **Settings > Environments > github-pages > Deployment branches** allows `main`.
- [ ] Custom domain (later): **Settings > Pages > Custom domain**, add the DNS record GitHub asks for, tick **Enforce HTTPS**, and update `url` in the config and the organization URL from step 2.

**starter** (`.github/workflows/deploy.yml` builds with `--base /<repository-name>/` automatically):

- [ ] **Settings > Pages > Source: GitHub Actions.** The deck is then at `https://slide-ng.github.io/starter/`.
- [ ] **Settings > General > Template repository:** tick it, so that **Use this template** shows.
- [ ] The *Export PDF* workflow needs no secret. Run it once to check it.
- [ ] The workflows install `@slide-ng/core` from npm (`"@slide-ng/core": "latest"`), so Pages only builds after the core is published ([step 16](#16-npm-the-scope-and-the-publish-order)).

## 10. Secrets and variables

Read from the workflows in `.github/workflows` of each repository. Only the Docker workflow reads a secret or variable today. Every other workflow uses the automatic `GITHUB_TOKEN`.

| name                    | kind               | repository         | used by                                | needed?                                                                                   |
| ----------------------- | ------------------ | ------------------ | -------------------------------------- | ----------------------------------------------------------------------------------------- |
| `GITHUB_TOKEN`          | automatic          | all                | all workflows, Pages, ghcr             | nothing to create. Check **Settings > Actions > General > Workflow permissions**.          |
| `SLIDE_NG_READ_TOKEN`   | secret             | `docker`  | `build.yml`, the checkout of `slide.ng` | only while `slide.ng` is private; with a public core, delete the mention. A fine-grained token with *Contents: Read* on `slide.ng`. |
| `SLIDE_NG_SOURCE`       | variable (`vars.`) | `docker`  | `build.yml`                            | optional. An npm spec such as `slide-ng@0.1.0`. Empty means "pack the checked-out core".  |
| `NPM_TOKEN`             | secret             | `slide.ng`, `themes` | a publish workflow (not written yet) | only if you do not use npm trusted publishing (recommended, no token). Granular token, publish only, scoped to the packages. |
| `VSCE_PAT`              | secret             | `vscode-extension`  | a publish workflow (not written yet)   | Azure DevOps personal access token with the *Marketplace > Manage* scope.                 |
| `OVSX_PAT`              | secret             | `vscode-extension`  | a publish workflow (not written yet)   | token from open-vsx.org, for VSCodium and similar editors. Optional.                       |
| skills mirror token     | secret             | `slide.ng`         | a mirror workflow (not written yet)    | only if the mirror to `skills` is a workflow: a fine-grained token with *Contents: Write* on `skills`. |

- [ ] Add the ones you need under **Settings > Secrets and variables > Actions**. Prefer environment secrets (a `release` environment with *Required reviewers* = you) for anything that publishes.

## 11. All Contributors bot

The contributing guide mentions `@all-contributors please add`. Every repository except the starter ships `.all-contributorsrc` and the contributors markers in its README, with `erkamyaman` as the first entry.

- [ ] Install the app: <https://github.com/apps/allcontributors> > **Install** > the organization > select the repositories (or all).
- [ ] Check that each repository has `.all-contributorsrc` with `projectOwner` set to the real organization name (`scripts/set-org.sh` does not touch it in other repositories, so edit it by hand).
- [ ] Test the bot: comment `@all-contributors please add @erkamyaman for code` on an issue. It should answer with a pull request.

## 12. Dependabot or Renovate

- [ ] Dependabot version updates: copy [`templates/dependabot.yml`](../templates/dependabot.yml) to `.github/dependabot.yml` in each repository and keep the blocks that apply:

  | repository         | ecosystems                                        |
  | ------------------ | ------------------------------------------------- |
  | `slide.ng`         | `npm`, `github-actions`                           |
  | `themes`  | `npm`, `github-actions`                           |
  | `starter` | `npm`, `github-actions`                           |
  | `docs`    | `npm` (it uses pnpm; Dependabot reads `pnpm-lock.yaml`), `github-actions` |
  | `docker`  | `docker` (the `Dockerfile`), `github-actions`, `npm` if the repository has a `package.json` |
  | `vscode-extension`  | `npm`, `github-actions`                           |
  | `skills`  | none                                              |

  Dependabot labels the pull requests `dependencies` (included in `labels.yml`) and uses the `type(scope): summary` form, so the commit-message check passes.
- [ ] Prefer Renovate instead? Install the Mend Renovate app for the organization and use its `config:recommended` preset with the same grouping. Use one of the two, not both.
- [ ] The core and the themes pin Node by `.nvmrc`. Dependabot does not bump it; change it by hand when a new Node LTS is adopted.

## 13. Labels

- [ ] Dry run first: `scripts/sync-labels.sh` prints the `gh label create ... --force` command for each label and repository. Read it.
- [ ] Apply: `scripts/sync-labels.sh --apply` (needs `gh auth login` as an owner). It creates or updates and never deletes.
- [ ] Delete the labels GitHub creates by default that you do not use (`invalid`, `question`, `wontfix`, `duplicate`, `enhancement`, `documentation`), because `bug`, `feature` and `area: docs` replace them. Keep `duplicate` if you like it. The issue forms add `bug` or `feature` plus `needs triage`, so those names must exist.
- [ ] The labeler workflow of `slide.ng` adds `area: generator`, `area: app`, `area: dev server`, `area: build`, `area: tests` and others from changed paths. They are not in `labels.yml`; either add them there or keep them to that repository.

## 14. Repository descriptions, topics and homepage

For each repository: the gear icon next to **About** on the repository page. Paste the description (GitHub allows 350 characters), the website, and the topics (up to 20; lowercase, hyphens). Tick none of *Releases*, *Packages* or *Deployments* until they exist.

| repository         | description                                                                                      | website                                      | topics                                                                                                     |
| ------------------ | ------------------------------------------------------------------------------------------------ | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `slide.ng`         | Slidev-style presentations written in markdown, compiled with Angular. The core app and the `slide-ng` command line. | `https://slide-ng.dev/`  | `slide-ng`, `slidev`, `angular`, `presentation`, `markdown`, `slides`, `slide-deck`, `typescript`, `cli`, `presentation-tools` |
| `themes`  | The official themes for slide.ng, one npm package each (`@slide-ng/theme-*`).                    | `https://slide-ng.dev/`  | `slide-ng`, `slidev`, `angular`, `theme`, `themes`, `presentation`, `slides`, `markdown`                   |
| `starter` | A template deck for slide.ng: use the template, write `slides.md`, publish to GitHub Pages.      | `https://slide-ng.github.io/starter/` | `slide-ng`, `slidev`, `angular`, `template`, `starter`, `presentation`, `slides`, `markdown`, `github-pages` |
| `docs`    | The documentation site for slide.ng.                                                             | `https://slide-ng.dev/`  | `slide-ng`, `documentation`, `docs`, `angular`, `analog`, `slidev`, `presentation`, `markdown`            |
| `docker`  | A Docker image that runs slide.ng decks: live dev server, static build, export and a small static server. | `https://slide-ng.dev/`  | `slide-ng`, `docker`, `dockerfile`, `container`, `slidev`, `angular`, `presentation`, `slides`            |
| `vscode-extension`  | Editor support for slide.ng decks in Visual Studio Code: syntax highlighting and slide commands. | `https://slide-ng.dev/`  | `slide-ng`, `vscode`, `vscode-extension`, `slidev`, `angular`, `markdown`, `presentation`, `syntax-highlighting` |
| `skills`  | The agent skill for writing slide.ng decks, mirrored from the core. Do not edit here.            | `https://slide-ng.dev/`  | `slide-ng`, `agent-skills`, `skills`, `slidev`, `angular`, `presentation`, `markdown`, `slides`           |
| `.github`          | Organization profile, default community health files and shared labels for slide.ng.             | (empty)                                      | `github`, `community-health`, `slide-ng`                                                                   |

- [ ] Every repository carries `slide-ng`; the core also has `slidev`, `angular`, `presentation`, `markdown` and `slides`. The other topics are suggestions; trim them if you prefer fewer.
- [ ] Pin up to **six** repositories on the organization page (GitHub's limit): `slide.ng`, `themes`, `starter`, `docs`, `vscode-extension`, `docker`. The skill repository is the one left out. The profile README lists all seven.
- [ ] Update the `homepage`, `bugs` and `repository` fields in each `package.json` if the organization name changed (step 19).

## 15. Social preview images

- [ ] One image per repository: **Settings > General > Social preview > Upload an image**. Size **1280 x 640 px** (2:1), PNG or JPG under 1 MB. GitHub accepts 640 x 320 as a minimum, but 1280 x 640 stays sharp.
- [ ] Keep text and the logo inside the centre, about 40 px away from every edge, because the preview is cropped on some networks. Use the same layout across repositories with the repository name as the only change.
- [ ] Upload `brand/github/social-preview-1280x640.png` for every repository (it is already 1280 x 640 with the logo inside the safe area). For the organization, the profile picture is the preview; there is no separate organization banner.
- [ ] The documentation site has its own `og:image` (see `seoMeta` in its config); it is not the GitHub one.

## 16. npm: the scope and the publish order

- [ ] Create an npm account for the project (or use yours) and turn on 2FA.
- [ ] Create the organization **slide-ng** at <https://www.npmjs.com/org/create> (the scope is `@slide-ng`; the free plan allows unlimited public packages). If the npm name is taken, the scoped packages `@slide-ng/theme-*` need a different scope, which means a change in `themes` and every doc listed in the placeholder table under `npm-scope`.
- [ ] Check that the unscoped name **`slide-ng`** is free: `npm view slide-ng`. The core publishes under that name and the starter, docker and the vscode default command use it. If it is taken, the core has to move into the scope (`@slide-ng/cli` or similar), which is a larger change than a search and replace; decide before the first publish.
- [ ] Enable **trusted publishing** (OIDC from GitHub Actions) per package once it exists, or create the `NPM_TOKEN` secret of step 10. Add a publish workflow to each repository; none exists yet.

**Order.** Themes and the starter need the core, so:

| #   | publish                              | what first                                                                                                           | flips in the repository                                                                                               |
| --- | ------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| 1   | `slide.ng` -> npm `@slide-ng/core`         | check the `files` list with `npm pack --dry-run`; set a real version (now `0.0.0`); update `CHANGELOG.md`            | `package.json`: remove `"private": true` (line 22); the `homepage`, `bugs` and `repository` URLs if the organization name changed |
| 2   | `themes` -> `@slide-ng/theme-apple-basic`, `-bricks`, `-seriph`, `-shibainu` | the themes have `peerDependencies: { "@slide-ng/core": "*" }` and are tested against a core checkout (`SLIDE_NG_DIR`); run the tests against the published core | the monorepo root `package.json` stays `"private": true` (it is not published; the four packages have no `private` and `publishConfig.access: public`). Set each package version; each package's `repository`, `homepage` and `bugs` URLs |
| 3   | `starter`                   | it depends on `"@slide-ng/core": "latest"`, so it works as soon as step 1 is done. It is a template, not an npm package    | keep `"private": true` (never published). Check the `README` and `slides.md` mention of `@slide-ng/...`              |
| 4   | `docs`                      | the site is not an npm package                                                                                       | keep `"private": true`. Turn Pages on (step 9). Deploy after the core and themes are on npm if the docs install them  |
| 5   | `docker` -> ghcr.io image   | build with `SLIDE_NG_SOURCE=@slide-ng/core@<version>`; follow "Publishing the image" in its README (login to ghcr, `packages: write`) | no `private` flag. In `.github/workflows/build.yml` change `SLIDE_NG_REPO` if the name changed, and decide whether to keep the pack-from-source path |
| 6   | `vscode-extension` -> Marketplace     | create the publisher `slide-ng` at <https://marketplace.visualstudio.com/manage> (Azure DevOps account needed) and the `VSCE_PAT`; optionally Open VSX; the extension runs `npx --no-install slide-ng` by default, so the core must exist for users | `package.json`: remove `"private": true` (line 8), keep `publisher: slide-ng` or change it to the real publisher id, update the repository URL. First test the `.vsix` by hand in VS Code (the README says that was not checked) |
| 7   | `skills`                    | mirror `slide.ng/skills/slide-ng` after the core is released, so the skill matches the version                        | n/a                                                                                                                   |

- [ ] After step 1: `npm install @slide-ng/core` in an empty folder, then `npx slide-ng create my-deck && cd my-deck && npx slide-ng build`.
- [ ] After step 2: `npm i -D @slide-ng/theme-seriph` in that deck, set `theme: seriph` and build.
- [ ] Never publish with `--tag latest` by hand from a dirty tree. Use `npm publish --provenance` from the workflow.

## 17. Releases

- [ ] For each repository, when you tag `vX.Y.Z`: **Releases > Draft a new release > Generate release notes**. The notes are grouped by [`.github/release.yml`](../.github/release.yml), which GitHub does **not** inherit. `slide.ng` has its own copy; copy this one into the other repositories that publish releases.
- [ ] Release notes read the pull request labels (`breaking changes`, `feature`, `bug`, `area: docs`, `release: skip`), so label the pull requests (the labeler workflow of `slide.ng` does the `area:` ones).

## 18. Final check

- [ ] <https://github.com/slide-ng> shows the logo, the description, six pinned repositories and the profile README.
- [ ] A new issue in a repository without its own templates shows the forms and the three contact links.
- [ ] A new pull request in such a repository is filled with the template.
- [ ] The Sponsor button shows on a repository without its own `FUNDING.yml`.
- [ ] The Community Standards page (`Insights > Community Standards`) of each repository is green: description, README, code of conduct, contributing, license, security policy, issue templates, pull request template.
- [ ] `https://slide-ng.dev/` and `.../starter/` load.

## 19. Replace the placeholders

Every place that names the placeholder organization, the npm scope, a `private` flag or a "these are placeholders" sentence is listed in [PLACEHOLDERS.md](PLACEHOLDERS.md), with the file and line, produced by:

```sh
scripts/list-placeholders.sh             # the table
scripts/list-placeholders.sh --summary   # the counts
```

The output of the run on 2026-10-16:

```text
total: 166
by category:
  npm-scope    80
  org-url      77
  placeholder  4
  private      5
by repository:
  slide.ng           63
  docker    16
  docs      16
  starter   6
  themes    47
  vscode-extension    18
```

166 rows in 62 files; `skills` does not exist yet. There are no `TODO` or `FIXME` comments in the repositories. Strings such as `example.org` in the documentation are examples, not placeholders, and the script skips them.

**What each category needs**

| category      | rows | what to do                                                                                                                                        |
| ------------- | ---- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `org-url`     | 77   | If the real organization is `slide-ng`: nothing. Otherwise replace `github.com/slide-ng/` and `slide-ng.github.io` (and `SLIDE_NG_REPO: slide-ng/slide.ng` in the Docker workflow). |
| `npm-scope`   | 80   | If the npm scope `@slide-ng` is yours: nothing. Otherwise replace `@slide-ng/` in the 4 theme `package.json` files, their READMEs, the tests (`themes/tests/*`), the docs (`slide.ng/docs/THEMES.md`, `DECISIONS.md`, `STATUS.md`, `PARITY.md`, `WRITING-A-THEME.md`), the agent skill references, `slide.ng/scripts/lib/roots.mjs` and its tests, and `slide.ng/tests/export/theme.mjs`. The code in `roots.mjs` resolves the official themes by this scope, so run the tests after a change. |
| `private`     | 5    | See the rows below.                                                                                                                               |
| `placeholder` | 4    | The sentence "These addresses are placeholders until the repositories are published." in the READMEs of `docker` (line 226), `themes` (line 65), `vscode-extension` (line 105), and the comment `Placeholder origin` in `docs/src/ngmd.config.ts` (line 167). Delete them once the repositories exist. `vscode-extension/README.md` line 111 says the same about the repository URL and the publisher name. |

The `"private": true` rows:

| file                              | line | flip before publishing?                                          |
| --------------------------------- | ---- | ---------------------------------------------------------------- |
| `slide.ng/package.json`           | 22   | yes, to publish `slide-ng` to npm                                 |
| `themes/package.json`    | 3    | no, the monorepo root; the four theme packages are not private    |
| `starter/package.json`   | 4    | no, a template                                                    |
| `docs/package.json`      | 81   | no, a site                                                        |
| `vscode-extension/package.json`    | 8    | yes, before `vsce publish`                                        |

**The files with the most rows** (the full list is in [PLACEHOLDERS.md](PLACEHOLDERS.md)):

| file                                                    | rows |
| ------------------------------------------------------- | ---- |
| `themes/README.md`                             | 14   |
| `docker/README.md`                             | 9    |
| `vscode-extension/README.md`                             | 9    |
| `slide.ng/docs/THEMES.md`                               | 9    |
| `slide.ng/docs/DECISIONS.md`                            | 8    |
| `slide.ng/scripts/lib/roots.spec.ts`                    | 5    |
| `slide.ng/docs/STATUS.md`                               | 5    |
| each `themes/packages/theme-*/package.json`   | 4    |

**A single pass.** Only when the organization or the scope changed. Run it from the folder that holds the repositories, on clean working trees, then read `git diff` in each repository and run each one's tests:

```sh
OLD_ORG=slide-ng; NEW_ORG=your-org     # the organization (GitHub)
OLD_SCOPE=@slide-ng; NEW_SCOPE=@your-scope   # the npm scope

for r in slide.ng themes starter docs docker vscode-extension; do
  git -C "$r" grep -lIE "github\.com/$OLD_ORG/|$OLD_ORG\.github\.io|SLIDE_NG_REPO: $OLD_ORG/|$OLD_SCOPE/" \
    -- . ':!package-lock.json' ':!pnpm-lock.yaml' ':!*.vsix' ':!public/demos' |
    xargs -r sed -i \
      -e "s#github\.com/$OLD_ORG/#github.com/$NEW_ORG/#g" \
      -e "s#$OLD_ORG\.github\.io#$NEW_ORG.github.io#g" \
      -e "s#SLIDE_NG_REPO: $OLD_ORG/#SLIDE_NG_REPO: $NEW_ORG/#g" \
      -e "s#$OLD_SCOPE/#$NEW_SCOPE/#g"
done
```

Then, in this repository: `scripts/set-org.sh your-org`. Regenerate the two lock files (`npm install`, `pnpm install`) because the scoped package names are in them, and run `scripts/list-placeholders.sh --summary` again; the `org-url` and `npm-scope` counts then show what is left (they count the new name too, because the script looks for `slide-ng`, so a count of zero means the pass worked).

- [ ] Placeholders replaced, tests run in every repository.
- [ ] Delete the "placeholder" sentences listed above.
- [ ] Commit in each repository with `docs: use the real organization name`.
