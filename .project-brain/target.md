# Target Architecture
Status: CONFIRMED

## Goal
Üretim kalitesinde N Keto Tracker: tamamen çevrimdışı, açık kaynaklı
(GPL-3.0), TR/EN ketojenik beslenme takip uygulaması (Android+iOS).
Öğün/makro günlüğü, glukoz+BHB+GKI takibi, haftalık plan/tarif/alışveriş,
ağırlık/semptom takibi, kaynaklı sade rehber, CSV/JSON taşınabilirlik.
Hastalık modu YOK; hastalığa özel içerik yalnız bilinçli filtre arkasında.

Normatif: `docs/MASTER_PROMPT.md` (v1.1) + `ORTAK_UYGULAMA_STANDARDI.md`;
ayrıntılı gereksinimler: `docs/REQUIREMENTS_MATRIX.md` (105 REQ).

## Target State

### Marka ve platform varlıkları

Özgün ikon seti (tüm Android/iOS boyutları + monokrom + splash);
Flutter varsayılan logosu kalmaz; ikon THIRD_PARTY kayıtlı.

### Ortak ekranlar

Hakkında (açık kaynak bölümü, gizlilik tek cümle, Lisanslar sayfasına
bağlantı), Lisanslar (showLicensePage + varlıklar), Paylaş (share_plus,
sistem sayfası), Diğer Uygulamalar (gömülü statik liste, ağ YOK).
Tümü ARB TR/EN.

### Taşınabilirlik UI

Ayarlar içinden export (CSV+JSON, başlıklı) ve import (önizleme +
transaction); "tüm verilerimi sil" ikinci onaylı.

### Kalite kapıları

- 18 yaş altı/gebelik/risk: plan+hedef üretimi kilitli (mevcut)
- analyze temiz + tüm testler + check_offline her commit'te
- Integration test: DoD 11 adımlı senaryo uçak modunda
- Release APK: obfuscate, yedek hariç tutma, aapt2 kanıtı
- Marketing paketi (8 dosya) + ürün dokümanları (SCIENTIFIC_CONTENT,
  PRIVACY, CHANGELOG, kullanıcı kılavuzu TR/EN)

### Premium ürün (ADR-PB-012 → ADR-PB-016 ile daraltıldı, 2026-10-08)

Premium görsel kimlik (özel tema, açık/koyu/sistem, kullanıcı seçimi);
çok dilli arayüz (18 dil); **reklam yok, satın alma yok, ağ yok**; Google
Play yayını.

## Explicit Non-Goals

- Bulut senkronu/hesap sistemi, CGM entegrasyonu ; reklam, satın alma ve ağ (ADR-PB-016)
- Kamera/barkod (MVP), AI/LLM, tanı/tedavi/doz önerisi
- Klinisyen paneli, çocuk/gebelik planları

## Open Target Decisions

### TD-001

**Status:** OPEN

Google Play paket adı (`app.nketo` geçici) — yayın adımında sahibi
kesinleştirir.

## Success Conditions

MASTER_PROMPT §18 release checklist + §20 DoD 11 adımlı senaryo uçak
modunda gerçek cihaz/emülatörde geçer; tüm testler ve offline kanıtı
yeşil; release kanıtları `docs/RELEASE_EVIDENCE.md`'de.
