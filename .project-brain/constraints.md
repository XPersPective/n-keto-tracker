# Constraints

Only rules that change decisions. One line each, with source.

- C-001: No network, ads, purchases, analytics, or health data export (user/ADR-PB-016).
- C-002: Keep SQLCipher DB and secure-storage key; never commit secrets (ADR-PB-001/constraints).
- C-003: Keep Flutter stable 3.47.2 and GPL-3.0-compatible dependencies (project config).
- C-004: Changes require tests, fatal analyze, format, and offline audit (project config/CI).
- C-005: No AI name or co-author line in commits/files (user constraint C-050).
