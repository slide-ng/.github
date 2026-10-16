# README banner snippet

Paste this at the top of a repository README. It shows the dark banner on GitHub's dark theme and the light one otherwise. Copy `readme-banner-light.png` and `readme-banner-dark.png` into the repository (the satellite repositories keep them in `assets/`) and adjust the path.

```html
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/readme-banner-dark.png">
  <img alt="slide.ng" src="assets/readme-banner-light.png" width="800">
</picture>
```

From the organization profile README (`profile/README.md`), the files are one folder up:

```html
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../brand/github/readme-banner-dark.png">
  <img alt="slide.ng" src="../brand/github/readme-banner-light.png" width="800">
</picture>
```

Files in this folder:

| file                             | use                                                               |
| -------------------------------- | ----------------------------------------------------------------- |
| `org-avatar-500.png`, `-1024.png` | organization profile picture (dark background)                    |
| `org-avatar-light-500.png`        | the same on a light background, for places that need it           |
| `social-preview-1280x640.png`     | repository social preview (Settings > General > Social preview)   |
| `readme-banner-light.png`, `-dark.png` | README banners, 1600 x 400                                   |
