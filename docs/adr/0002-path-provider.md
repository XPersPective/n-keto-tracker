# ADR-0002 — path_provider bağımlılığı

- Durum: Kabul edildi · Tarih: 2026-09-20 · Görev: T7
- Karar: `path_provider` (Flutter ekibi paketi) eklendi.

## Bağlam

MASTER_PROMPT §3.1 izinli paket listesi (Riverpod, go_router, Drift, fl_chart,
freezed, json_serializable, gen-l10n) bir yerel veritabanı dosyası için
yazılabilir dizin yolu sağlamaz. Drift'in `NativeDatabase` bir `File` ister;
Android/iOS'te güvenilir tek yol uygulama sandbox'ı içi dizindir
(`getApplicationSupportDirectory`). Çalışma dizini/yol tahmini cihazda
yazılabilir değildir ve veri kaybına yol açar.

## Seçenekler

1. path_provider ekle (Flutter ekibi resmi paketi; platform kanallarıyla
   doğru dizini döner).
2. Elle platform kanalı yaz — aynı işi yapan bakım yükü; standart yeniden
   icat (MASTER §23 "mevcut platform özelliklerini yeniden icat etme").
3. Drift Web/ffi geçici dizin — mobil hedef için geçersiz.

## Sonuç

1 numaralı seçenek. Lisans: BSD-3-Clause (Flutter Authors) — GPL-3.0
uyumlu (ORTAK §2 izinli liste). Ağ izni/telemetri içermez; `check_offline`
desenine takılmaz. `THIRD_PARTY_NOTICES.md` güncellendi.
