# totally-fine-action

> ⚠️ **TRAINING FIXTURE.** This action exists only for a Plumber CI/CD security
> demo. The second release is built to behave like a supply-chain-compromised
> GitHub Action. **Never** add it to a real repository. The exfiltration is
> **defanged**: credentials only leave the runner if you set `DEMO_SINK_URL` to
> an endpoint you control.

## What it pretends to be

A friendly "Coverage Summary" action: you add it to your pipeline and it posts a
one-line test-coverage summary to the job log.

```yaml
- uses: getplumber-examples/totally-fine-action@v1
  with:
    report-path: coverage/coverage-summary.json
```

## The two versions (this is the whole point)

| Tag | What it does | Safe? |
| --- | --- | --- |
| `v1.1` | Prints a coverage summary. Nothing else. | ✅ safe |
| `v1.2` | Keeps the v1.1 cover story **and adds a payload** that rakes the runner for credentials and ships them off the box. | ❌ compromised |
| `v1` | A **mutable** tag. It pointed at `v1.1` when you reviewed it. It now points at `v1.2`. | ❌ moved under you |

This is the **tj-actions** pattern (March 2026). You vet `v1.1`, you pin to the
`v1` tag because that is what every example shows, and later the maintainer (or
whoever stole their token) publishes `v1.2` and repoints `v1`. Your next pipeline
run executes code you never reviewed. Pinning to a commit SHA is what stops it:
the attacker can move the tag, but not the digest.

Pin to a full commit SHA instead of a tag:

```yaml
- uses: getplumber-examples/totally-fine-action@<full-40-char-sha>
  with:
    report-path: coverage/coverage-summary.json
```

The payload lives in [`scripts/summarise.sh`](scripts/summarise.sh) at `v1.2`. It
hides its work inside a collapsed `::group::coverage upload` log section.

## Running the exfiltration safely in a demo

1. Open a disposable sink (e.g. https://webhook.site) and copy its URL.
2. Pass it as `DEMO_SINK_URL` in the calling job's environment.
3. Run the pipeline. Watch the "loot" land in your sink.

With no `DEMO_SINK_URL`, the action prints what it *would* send and sends nothing,
so it is safe to leave this repository public.

The companion victim repo
[`insecure-pipeline-demo`](https://github.com/getplumber-examples/insecure-pipeline-demo)
references this action as `@v1`.

## License

MIT. Provided purely as an educational security fixture, with no warranty.
