# ADR-PB-017 — Yemek fotoğrafları ve kullanıcı dostu arayüz (sürüm 2)
Status: ACCEPTED (kullanıcı 2026-10-23: gerçek fotoğraf istedi; kaynak Wikimedia Commons açık lisans)
Date: 2026-10-23
Supersedes: PB-030 kararı (yalnız Material ikon, fotoğraf yok)

## Context
Kullanıcı: "Menü gösteriyorsan fotoğrafları olacak." Uygulama hiç kullanıcı dostu
bulunmadı; Play ekran görüntüleri uygulamayla eşleşmiyor. Bilimsellik önde kalmalı,
ama arayüz sade ve hemen kavranabilir olmalı. Spor (yürüyüş, koşu, kuvvet) ve
beslenme birlikte yer almalı.

## Decision
1. Besin (152) ve tarif (20) listelerinde gerçek fotoğraf gösterilir. Fotoğraflar
   uygulama paketinde (çevrimdışı, C-001) 480x360 WebP olarak tutulur. Özgün çizim
   denendi ve reddedildi (kullanıcı: çizimler kabul edilmez, gerçek fotoğraf istenir).
2. Her fotoğrafın kaynağı, yazarı ve lisansı `assets/food_images/CREDITS.md` ve
   `credits.json` içinde tutulur; Flutter lisans sayfasında gösterilir (main.dart).
   Yalnız CC0, Public domain, CC BY ve CC BY-SA kullanılır; NC ve ND reddedilir.
   Besin fotoğraflarında bileşik yemek başlıkları (pasta, sandviç vb.) reddedilir;
   uygun foto bulunamayan besinde dosya üretilmez.
3. Fotoğraf yoksa kategori ikonu yedek olarak gösterilir (boş kutu yok). Eksik besinler
   `credits.json` içindeki `missing` listesinde raporlanır.
4. İndirme yalnız tool/fetch_food_photos.py ile yapılır; sonuç commit'lenir.

## Consequences
- APK boyutu birkaç MB artar; ölçülüp raporlanır.
- Mağaza ekran görüntüleri yeni arayüzden üretilir (PB-038).
