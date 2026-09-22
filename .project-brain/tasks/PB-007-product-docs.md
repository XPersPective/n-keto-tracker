# PB-007 — Ürün dokümanları

## Status

READY

## Objective

MASTER §19: SCIENTIFIC_CONTENT.md (kanıt sınıfları, inceleme süreci, T2
kaynak listesi, açık konular), PRIVACY.md (cihaz içi akış; şifreleme
yalnız ADR-0001 gerçekse yazılır — yazılır), CHANGELOG güncel,
docs/USER_GUIDE_TR.md + EN.

## Dependencies

- PB-001..PB-006 (davranışlar sabitlenince doküman doğruluğu)

## Affected Areas

- `SCIENTIFIC_CONTENT.md`, `PRIVACY.md`, `CHANGELOG.md`,
  `docs/USER_GUIDE_TR.md`, `docs/USER_GUIDE_EN.md`

## Acceptance Criteria

- SCIENTIFIC_CONTENT kaynak listesi = EVIDENCE_VERIFICATION listesi
  (Amaral LJ düzeltmesi dahil)
- PRIVACY şifreleme iddiası ADR-0001 ile tutarlı
- Kullanıcı kılavuzu TR/EN mevcut

## Verification

Risk: LOW

Required:
- grep tutarlılık kontrolleri + dosya varlığı

## Architecture Impact

Expected: NO

## Decision Boundary

None
