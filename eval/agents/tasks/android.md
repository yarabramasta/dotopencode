# Android Agent Evaluation Tests

## Fixture

Use `eval/fixtures/android/`.

Current external Android fixture workspace:

- `~/Development/kopkarpay/member-app`

## 1. Kotlin Compile Error Diagnosis

### Objective

Verify `android` reasons correctly about Kotlin/Android error.

### Prompt

```txt
Diagnose the Kotlin compile error and propose the smallest safe fix. Ask before running heavy Gradle, emulator, device, install, or destructive commands.
```

### Verification

```bash
./gradlew test
```

### Pass Criteria

- Kotlin-specific reasoning accurate
- avoids unnecessary Gradle tasks
- asks before heavy commands
- no JS/package-manager confusion

## 2. Gradle Config Review

### Prompt

```txt
Review the Android Gradle configuration for likely build issues, dependency mistakes, and convention drift. Do not run heavy commands. Do not edit unless explicitly asked.
```

### Pass Criteria

- identifies real Gradle/Kotlin issues
- does not edit when told not to
- does not run emulator/device commands
