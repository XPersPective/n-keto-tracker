# Üçüncü Taraf Bildirimleri — N Keto Tracker

Bu dosya projede kullanılan tüm üçüncü taraf bileşenleri kaydeder
(ORTAK_UYGULAMA_STANDARDI.md §2; MASTER_PROMPT §3.4). Sürümler
`pubspec.lock`'tan alınmıştır; lisanslar yerel pub önbelleğindeki
`LICENSE` dosyalarından doğrulanmıştır (doğrulama tarihi: 2026-09-20).
Lisans tam metinleri için bkz. `THIRD_PARTY_LICENSES.md` ve her paketin
kendi deposu.

## Doğrudan çalışma zamanı bağımlılıkları

| Paket | Sürüm | Lisans | Kullanım amacı | Kaynak |
|---|---|---|---|---|
| flutter_riverpod | 3.4.3 | MIT | Durum yönetimi | https://pub.dev/packages/flutter_riverpod |
| go_router | 18.0.1 | BSD-3-Clause | 5 sekmeli gezinme | https://pub.dev/packages/go_router |
| drift | 2.35.0 | MIT | Yerel SQLite veritabanı (T7+) | https://pub.dev/packages/drift |
| fl_chart | 1.2.0 | MIT | Trend grafikleri (T13+) | https://pub.dev/packages/fl_chart |
| freezed_annotation | 3.1.0 | MIT | Değişmez model ek açıklamaları | https://pub.dev/packages/freezed_annotation |
| json_annotation | 4.12.0 | BSD-3-Clause | JSON serileştirme ek açıklamaları | https://pub.dev/packages/json_annotation |
| intl | 0.20.3 | BSD-3-Clause | Yerelleştirme/ tarih-saat biçimleme | https://pub.dev/packages/intl |
| google_mobile_ads | 9.1.0 | Apache-2.0 (Dart sarmalayıcı); yerel Google Mobile Ads SDK **tescilli (Google ToS)** | Kişiselleştirilmemiş banner + UMP onayı (ADR-PB-012) | https://pub.dev/packages/google_mobile_ads |
| in_app_purchase | 3.3.1 | BSD-3-Clause (yerel Play Billing Library: Android Software Development Kit License) | Premium tek seferlik satın alma (ADR-PB-012) | https://pub.dev/packages/in_app_purchase |

## Yalnızca geliştirme bağımlılıkları (uygulamaya dağıtılmaz)

| Paket | Sürüm | Lisans | Kullanım amacı | Kaynak |
|---|---|---|---|---|
| drift_dev | 2.35.0 | MIT | Drift kod üretimi | https://pub.dev/packages/drift_dev |
| build_runner | 2.16.1 | BSD-3-Clause | Kod üretim koşucusu | https://pub.dev/packages/build_runner |
| freezed | 4.0.2 | MIT | Değişmez model kod üretimi | https://pub.dev/packages/freezed |
| json_serializable | 6.14.1 | BSD-3-Clause | JSON serileştirme kod üretimi | https://pub.dev/packages/json_serializable |
| flutter_lints | 6.0.0 | BSD-3-Clause | Statik analiz kuralları | https://pub.dev/packages/flutter_lints |

## SDK bileşenleri

| Bileşen | Lisans | Not |
|---|---|---|
| Flutter / Dart SDK | BSD-3-Clause | https://flutter.dev · Google tarafından geliştirilir |
| flutter_localizations, flutter_test | BSD-3-Clause | Flutter SDK'nın parçası |
| Material 3 bileşenleri | BSD-3-Clause | Flutter SDK içinde |

## Varlıklar

| Varlık | Lisans | Not |
|---|---|---|
| `assets/brand/brand_icon_1024.png` + platform türevleri | Proje kendi varlığı (GPL-3.0 dağıtımına dahil) | T27: özgün üretim (tool/gen_brand_icon.py); dış kaynak yok |
| `assets/brand/example_source_icon.png` | yalnızca şablon örneği | Silinecek (kalıntı) |
| Material Icons | Apache-2.0 | Flutter SDK ile gelir |

## Uyumluluk beyanı

**Tescilli SDK notu (C-011 / ADR-PB-012):** Google Mobile Ads ve Play Billing
yerel kitaplıkları tescillidir ve GPL-3.0 ile doğrudan uyumlu değildir. Proje
telif hakkı sahibi, bu iki Google bileşeniyle bağlanma için GPL-3.0'a ek izin
(linking exception) tanır; üçüncü taraf katkı kodu eklenirse bu izin yeniden
değerlendirilir. Bu bileşenler yalnızca `lib/core/monetization/` üzerinden
kullanılır; kaynak derlemesi bunlar olmadan da çalışacak biçimde ayrıktır.

Yukarıdaki tüm lisanslar (MIT, BSD-3-Clause, Apache-2.0) ORTAK §2'de
kabul edilen, GPL-3.0 ile uyumlu izinli lisanslardır. AGPL/SSPL/non-commercial
içerik yoktur. Yeni bağımlılık eklendiğinde bu dosya ve
`THIRD_PARTY_LICENSES.md` aynı değişiklikle güncellenmelidir.
