# Skip Checkout Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to skip Buildkite's default checkout step for jobs that don't need a code checkout until [repository-less builds](https://github.com/buildkite/agent/issues/233) land in the Buildkite agent.

Optionally sets the checkout directory to a specified path.

## Example

```yml
steps:
  - plugins:
      - thedyrt/skip-checkout#v0.1.1: ~
```

```yml
steps:
  - plugins:
      - thedyrt/skip-checkout#v0.1.1:
          cd: /mnt/data
```

## Tests

To run the tests of this plugin, run
```sh
docker-compose run --rm tests
```

## License

MIT (see [LICENSE](LICENSE))
