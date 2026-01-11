# Risk Prompts

Use these prompts to think through "what can go wrong" before relying on tests.
Pick the relevant items and report the top risks and mitigations in the verdict.

## Inputs and boundaries
- Empty/null/zero values
- Invalid types or shapes
- Max size, long strings, large lists
- Encoding, locale, timezones

## State and data
- Partial writes or lost updates
- Migration ordering, rollbacks
- Idempotency and retries
- Data loss or corruption paths

## Dependencies and IO
- API timeouts, retries, rate limits
- Network or service outages
- Version drift or incompatible responses

## Concurrency and ordering
- Races, locks, reentrancy
- Out-of-order events or retries

## Security and access
- Authn/authz gaps
- Injection or unsafe parsing
- Secrets or PII exposure

## Performance and scale
- Hot paths, N+1 queries
- Memory growth, latency spikes
- Background jobs or queues

## Compatibility and rollout
- Backwards compatibility for clients
- Feature flags, config defaults
- Migration and deploy sequencing

## Observability and UX
- Logging and error surfacing
- Metrics/alerts for failures
- API error messages and contracts

## Risk scan template

Risk: {what can go wrong}
Trigger: {when it happens}
Impact: {what breaks or degrades}
Mitigation: {code/test/doc/config change}
Evidence: {file/test/log}
