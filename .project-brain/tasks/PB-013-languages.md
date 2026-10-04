# PB-013 — Çok dilli arayüz

## Status
PLANNED
## Objective
Arayüz ARB'leri çok dilli (en çok konuşulan diller, RTL dahil); sağlık
rehberi/kanıt içeriği çevirisi klinik inceleme gerektirdiğinden TR/EN
kalır, diğer dillerde EN'e düşer ve bu açıkça belirtilir (karar: C-002).
## Dependencies
PB-012 (ekran metinleri sabitlensin)
## Acceptance Criteria
- l10n_completeness testi tüm dillerde anahtar eşitliği
- RTL (ar) emülatörde taşma yok
## Verification
Risk: MEDIUM
## Architecture Impact
YES — l10n
## Decision Boundary
Tıbbi içerik çevirisi: yapılmaz (yalnız UI).
