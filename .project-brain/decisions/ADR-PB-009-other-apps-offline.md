# ADR-0004 — ORTAK §3.6 "Diğer Uygulamalarımız" gömülü katalog uyarlaması

## Durum

Kabul edildi (2026-10-02, PB-009).

## Bağlam

`napp_app_template` / `ORTAK_UYGULAMA_STANDARDI.md` §3.6, "Diğer
Uygulamalarımız" sayfası zorunlu kılar: veri kaynağı proje sahibinin
herkese açık reposundaki `apps.json` ve HTTPS ile
`raw.githubusercontent.com/.../apps.json` adresinden çekilir; internet
yoksa önbellek, o da yoksa uygulamaya gömülü kopya gösterilir.

Bu uygulama MASTER §14 ve depo kısıtı gereği **INTERNET izni olmadan
tamamen çevrimdışı** çalışır; HTTPS istek atamaz (PB-009 öncesi
`about_page.dart`'ta bu girişin `onTap: () {}` ölü düğmesi vardı).

## Karar

1. Sayfa uygulanır; veri kaynağı **kalıcı olarak gömülü kopya**
   (`assets/apps.json`, standarttaki kademelendirmenin son basamağı).
   Önbellek ve ağ katmanı uygulanmaz.
2. Katalog formatı standarttaki şemayla aynıdır (`schema: 1`, `apps`
   dizisi; `id`, `androidPackage`, `name`/`description` {en,tr}).
   Yeni uygulama yayınlamak = standart deposundaki kayıt + bir sonraki
   sürüme gömme.
3. Mağaza bağlantısı açılmaz; yerleşik "URL yalnız kopyala" kalıbıyla
   panoya kopyalanır (url_launcher bağımlılığı eklenmez).
4. Girdi doğrulama (ORTAK §1.4): bozuk JSON çökertmez; şema 1 değilse
   boş liste; geçersiz kayıt atlanır; yerelleştirilmiş metinde EN yedek.

## Sonuç

- §3.6'nın amacı (çapraz tanıtım, ödül yok) korunur; tek maliyeti yeni
  uygulamaların görünmesi için sürüm çıkarmak gerekmesidir (bu uygulama
  için ağ yine de mümkün olmadığından fark pratikte yoktur).
- `REKLAM=HAYIR`, `PRO=HAYIR` ayarlarıyla uyumlu: sayfa yalnız tanıtır,
  indirme ödülü/Pro bağlantısı yoktur.
