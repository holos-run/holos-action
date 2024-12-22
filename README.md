# Holos Render Action

This GitHub Action executes the `holos render platform` command in your workflow
to render your platform configuration.  Useful to fully render configuration
manifests when configuration code, or input data chances.

For an example of Kargo automatically bumping the version of add-ons and
submitting pull requests, see the documentation on the [Holos Kargo
integration](https://holos.run/docs/kargo/).

## Usage

The following example workflow renders manifests and commits the result to the
same branch, useful to see fully rendered configs in pull requests.

```yaml
# .github/workflows/holos-render-platform.yaml
name: holos render platform
on:
  push:
    branches:
      - 'promotion/*'
jobs:
  holos:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - uses: holos-run/holos-action@v1
      - name: Commit and push changes
        run: |
          git config --global user.name 'GitHub Actions'
          git config --global user.email 'actions@github.com'
          git add deploy/
          git commit -m "holos render platform [skip ci]" || echo "No changes to commit"
          git push
```

## Support

Community support is provided for `ubuntu-latest` runners only.  For additional
commercial support options please see https://holos.run/docs/support/
