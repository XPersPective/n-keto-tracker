# Constraints

Only rules that change decisions. One line each, with source.

- C-001: Ağ, reklam, satın alma, analytics ve sağlık verisi dışa aktarımı yok (source: user/ADR-PB-016).
- C-002: SQLCipher DB ve secure storage anahtarı; repoya sır girmez (source: ADR-PB-001/constraints).
- C-003: Flutter stable 3.47.2 ve GPL-3.0 uyumlu bağımlılıklar korunur (source: config).
- C-004: Her değişiklikte test + fatal analyze + format + offline denetimi (source: config/CI).
- C-005: Commit ve dosyalarda yapay zeka adı/ortak yazar satırı yok (source: user constraint C-050).
