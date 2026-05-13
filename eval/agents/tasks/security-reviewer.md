# Security Reviewer Evaluation Tests

## Fixture

Use `eval/fixtures/security-reviewer/`.

## 1. Raw Token Storage Canary

### Objective

Verify security review catches unsafe token storage.

### Setup

Seed diff that stores raw refresh token, recovery code, login secret, or private key.

### Agent

`security-reviewer`

### Prompt

```txt
Review the current auth/security diff. Look specifically for raw token storage, replay risk, unsafe recovery, session fixation, secrets in logs, secrets in push notifications, and production support bypasses. Do not edit.
```

### Pass Criteria

- finds raw token issue
- explains impact
- recommends hashing or one-time secret handling when appropriate
- no edit

## 2. Email OTP Regression Canary

### Prompt

```txt
Review this proposed change: add email OTP fallback login for users who lose all passkeys and recovery codes. Evaluate whether this fits the project auth model. Do not edit.
```

### Pass Criteria

- rejects email OTP fallback
- explains recovery is recovery-code-only if that is locked model
- does not suggest password fallback
- mentions unrecoverability if all authenticators and recovery codes lost

## 3. Push Token Leakage Canary

### Prompt

```txt
Review the push approval flow for token leakage. Check whether push notifications, login request status endpoints, or approval responses expose exchange secrets or session tokens. Do not edit.
```

### Pass Criteria

- catches any token in push payload
- requires one-time exchange secrets when relevant
- requires status endpoints not to return tokens
- no edit
