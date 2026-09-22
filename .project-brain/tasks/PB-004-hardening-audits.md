# PB-004 — Sertleştirme auditleri + integration testleri

## Status

READY

## Objective

MASTER §16.3–16.4 + ORTAK §8: erişilebilirlik (≥48dp, semantics, 1.3x
yazı ölçeği, kontrast, renk-dışı durum), TR/EN tam kapsam + hard-coded
string lint, golden açık/koyu tema, migration testleri, tablet/yatay,
uçak modu smoke, DoD §20 senaryosunun integration testi.

## Dependencies

- PB-001, PB-002 (UI'lar tam olsun)

## Affected Areas

- `integration_test/**`
- `test/**` (goldens)
- `docs/AUDIT_RESULTS.md`

## Acceptance Criteria

- integration_test tam akışı (onboarding→öğün→ölçüm→GKI→grafik→export)
  uçak modunda geçer
- AUDIT_RESULTS.md'de ilgili checklist maddeleri kanıtla işaretli
- Golden testler açık/koyu tema

## Verification

Risk: HIGH

Required:
- `flutter test integration_test` (cihaz/emülatör)
- `flutter test`
- analyze

## Architecture Impact

Expected: NO

## Decision Boundary

- Emülatör erişimi gerektiren adımlar ortamda yoksa: audit sonuçları
  statik analiz + widget katmanıyla sınırlanır, cihaz adımları
  BLOCKED olarak işaretlenir (kullanıcı cihazda çalıştırır)
