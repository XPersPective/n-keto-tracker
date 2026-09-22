# ADR-0003 — share_plus bağımlılığı; in_app_review ertelendi

- Tarih: 2026-09-20 · Görev: PB-002

## Karar

1. `share_plus` (BSD-3, flutter.dev resmi plus ailesi) eklendi —
   ORTAK §3.5 Paylaş özelliği için sistem paylaşım sayfası. Uygulamanın
   kendisi ağ çağrısı yapmaz; hedef uygulamayı OS seçer. `check_offline`
   yasağı kapsamına girmez (http/dio/webview/firebase desenleri yok).
2. `in_app_review` (ORTAK §3.5 Puan ver) **eklenmedi ve ertelendi**:
   gerçek in-app review akışı mağaza kaydının varlığını gerektirir;
   uygulama henüz mağazada yayınlanmadı. Yayın sonrası ayrı görevle
   eklenir (ADR ile). Bu süre içinde Puan istemi gösterilmez.

## Sonuç

- Paylaş: share_plus.shareText (uygulama tanıtım metni, kullanıcı
  eylemiyle).
- Puan ver: PB-002 kapsamı dışına alındı; Hakkında ekranında görünmez.
- Diğer Uygulamalar: gömülü statik liste; bağlantılar ağ çağrısı
  yapmadan yalnız kopyalanabilir metin olarak sunulur (url_launcher
  eklenmedi — konservatif çevrimdışı seçim).
