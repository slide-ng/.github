# Security policy

This policy applies to every repository of the slide.ng organization, unless the repository has its own `SECURITY.md`.

## Supported versions

Only the latest release of each project is supported, and until a project has a release, only the latest commit on its `main` branch. There are no older lines to patch. Update to the latest release before you report, and tell us if the problem is already gone there.

## Report a vulnerability

Use GitHub's private vulnerability reporting. Open the **Security** tab of the repository concerned and choose **Report a vulnerability**. If the repository has no such button, open it for `slide.ng` and name the repository in your report.

Please do not open a public issue, discussion or pull request for a vulnerability.

If you cannot use GitHub, email erkamyaman35@gmail.com with "Security" in the subject.

A good report says:

- which repository, version or commit, and how you ran it (dev server, a built deck, the Docker image, the extension);
- what you did, what you expected and what happened;
- a small reproduction, if you can make one.

## What to expect

These are small projects kept up in spare time, so there is no fixed response time. Expect a first answer within a few days. A confirmed problem is fixed in the next release, and the published advisory credits you unless you prefer to stay unnamed. Please keep the details private until the fix is released.

## Scope

Reports about the code in the organization's repositories are in scope. Problems in a dependency should go to that dependency; tell us if we need to update it. A slide deck is code: a deck you did not write can run script in your browser or at build time, so building or serving an untrusted deck is not a vulnerability in itself.
