# Holos Action

[Holos] GitHub action to execute the `holos render platform` command in your
workflow.  Useful to fully render configuration manifests when configuration
data changes, then update a pull request automatically.

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
      - run: rm -rf deploy
      - uses: holos-run/holos-action@v1
        with:
          version: v0.102.1 # optional, defaults to latest
          command: holos render platform # optional default
      - name: Commit and push changes
        run: |
          git config --global user.name 'GitHub Actions'
          git config --global user.email 'actions@github.com'
          git add deploy
          git commit -m "holos render platform [skip ci]" || echo "No changes to commit"
          git push
```

## Environment Variables

Pass environment variables using the `flags` input.  The value of this input is
passed without modification to `docker run`.  Useful to to access a [private
helm] registry.  For example:

```yaml
name: holos render platform
on:
  push:
    branches:
      - 'promotion/*'
jobs:
  holos:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: holos-run/holos-action@v1
        env:
          USERNAME: ${{ vars.USERNAME }}
          PASSWORD: ${{ secrets.PASSWORD }}
        with:
          command: holos render platform # optional
          flags: --env USERNAME --env PASSWORD
```

## Support

Community support is provided on a best effort basis.  For commercial support
options please see [support].

[Holos]: https://holos.run/docs/overview/
[support]: https://holos.run/docs/support/
[private helm]: https://holos.run/docs/v1alpha5/topics/private-helm/
