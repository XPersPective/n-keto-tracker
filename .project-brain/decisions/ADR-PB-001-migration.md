# ADR-PB-001 — Legacy PROJECT_BRAIN.md'den .project-brain/ formatına geçiş

- Tarih: 2026-09-20
- Karar: Tek dosyalık eski beyin formatı yerine skill'in v3 schema
  dizin yapısı (.project-brain/) benimsendi; legacy dosya silindi.

## Bağlam

project-brain skill'i oturum içinde güncellendi; yeni betik
(.project-brain/ dizini + boot/validate subkomutları) eski PROJECT_BRAIN.md
formatını tanımıyor. Eski beyin T1–T26+T35'in tam geçmişini taşıyordu.

## Karar ve gerekçe

- Tüm kapanmış görev geçmişi Git'te korunuyor (commit mesajları T-id'li);
  yeni formatta kapanan görev dosyaları tutulmaz (§20) — geçmiş zaten
  Git'te, çift kayıt gerekmez.
- Eski brain'den taşınanlar: current (doğrulanmış mimari), target
  (kalan T27–T34 + kabul kriterleri), constraints (offline/sağlık/
  lisans/marka), 8 PB task dosyası.
- Normatif dokümanlar (docs/MASTER_PROMPT.md,
  ORTAK_UYGULAMA_STANDARDI.md, docs/REQUIREMENTS_MATRIX.md,
  docs/research/*, docs/adr/*) repository dosyaları olarak kaldı;
  brain bunlara referans verir.

## Etki

Eski PROJECT_BRAIN.md genesis commit'inde silinir. `docs/adr/0001`,
`0002` (repo ADR'leri) geçerliliğini korur.
