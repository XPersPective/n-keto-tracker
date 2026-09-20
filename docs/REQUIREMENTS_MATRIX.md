# Gereksinim Matrisi — N Keto Tracker

Her zorunlu gereksinim REQ satırına indirilmiştir. Kaynak: `docs/MASTER_PROMPT.md` (v1.1) bölüm referansları; AC = beyin §1 kabul kriterleri; Görev = beyin §5 T-id. Norm: her satırın test edilebilir bir karşılığı vardır (test/audit/doküman).

## Kimlik ve marka

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-001 | Ürün/mağaza adı sabit `N Keto Tracker`; `N` açılımsız marka harfi | 0, 0.2 | AC5 | T4, T32 |
| REQ-002 | İsim tek yapılandırma noktasından (appBrandName + l10n metadata) yönetilir | 0.2 | AC5 | T4 |
| REQ-003 | Alt başlık ≤30 karakter (TR `Keto Günlüğü ve GKI Takibi`, EN `Keto Journal & GKI Tracker`) | 0.2 | AC7 | T32 |
| REQ-004 | Mağaza metni/ikon/görsel/anahtar kelimede hastalık-kanser-tümör-GBM-tedavi çağrışımı yok | 0.2 | AC4 | T32 |
| REQ-005 | GitHub depo adı `n-keto-tracker` | 3.4 | AC7 | mevcut (repo) |

## Tüketici deneyimi

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-006 | Ana ekran "bugün ne kaydetmeliyim/görmeliyim" sorusuna birkaç saniyede cevap verir | 0.1 | AC6 | T14 |
| REQ-007 | En sık eylemler (öğün, glukoz, keton, ağırlık, semptom) ≤3 dokunuşta başlar | 0.1 | AC1 | T14 |
| REQ-008 | GKI/BHB/net karb/enerji terimleri ilk görüldüğü yerde tek cümleyle açıklanır | 0.1 | AC5 | T13, T14 |
| REQ-009 | DOI/PMID/kanıt kodu/teknik tablo ana akışta değil "Ayrıntıyı gör" altında | 0.1, 2.1 | AC4, AC6 | T13, T25 |
| REQ-010 | Kısa cümleler, büyük dokunma alanları, hataya dayanıklı formlar | 0.1 | AC6 | T30 |
| REQ-011 | Güvenli varsayılan seçilir; kullanıcı ayazla karşılanmaz; sağlık belirsizliği gizlenmez | 0.1 | AC6 | T9 |

## Bilimsel yaklaşım ve kanıt

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-012 | Her iddia E1–E6 sınıfına sahip; UI'da açık etiket ("İnsan çalışması" vb.) gösterilir | 2.1 | AC4 | T25 |
| REQ-013 | Kullanıcıya önce ≤3 cümle sade sonuç; ayrıntı ve künye katmanlı açılır | 2.1 | AC6 | T25 |
| REQ-014 | Kaynak kütüphanesi paketli yerel JSON/SQLite; WebView/uzak PDF/URL isteği yok; URL yalnız kopyalanabilir metin | 2.3 | AC3 | T25 |
| REQ-015 | İçerik güncellemesi yalnız yeni uygulama sürümüyle; sürüm+inceleme tarihi+değişiklik günlüğü | 2.3 | AC8 | T25 |
| REQ-016 | Telifli makale tam metni paketlenmez; özgün kısa özet + bibliyografik veri | 2.3 | AC11 | T25 |
| REQ-017 | Seyfried kaynakları bağımsız doğrulama gibi sunulmaz; 2024 çerçevesi Debate/research önerisi olarak etiketlenir | 2.4 | AC4 | T25 |
| REQ-018 | Bilimsel içerik ile hesap motoru ayrı; formül sürümü içerikten bağımsız izlenebilir | 2.4 | AC2 | T11 |
| REQ-019 | Kanıt sınıfı atamaları T2 doğrulamasıyla uyumlu (Amaral LJ düzeltmesi dahil) | 21 | AC4 | T25 |

## Hesaplama doğruluğu (release engelleyici)

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-020 | `glucoseMmolL = mgDl/18.0`, `GKI = mmolL/BHB` tek saf sürümlü modülde; UI/grafik/export/test aynı modül | 2.4 | AC2 | T11 |
| REQ-021 | Ara yuvarlama yok; sunum yuvarlaması hesap sonrası | 2.4, 6.2 | AC2 | T11 |
| REQ-022 | Ham değer+birim, normalize değer, ölçüm zamanı, eşleşme farkı, formül sürümü saklanır | 2.4, 6.2 | AC2 | T7, T12 |
| REQ-023 | BHB≤0, glukoz≤0, NaN/Infinity, bozuk ondalık, pencere dışı eşleşme test edilir | 2.4, 16.1 | AC2 | T11, T12 |
| REQ-024 | 90 mg/dL + 2,5 mmol/L → tam 2,0 GKI tüm platformlarda | 2.4 | AC2 | T11 |
| REQ-025 | Referans vektörler `test/fixtures/gki_reference_cases.json`; formül değişimi kaynak+migration+test güncelliği olmadan merge edilemez | 2.4 | AC2 | T11 |
| REQ-026 | Hesaplama/migration/provenance testi başarısızsa release yok | 2.4 | AC6 | T30, T34 |

## Teknoloji ve mimari

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-027 | Flutter stable, null-safe Dart, Material 3, Riverpod, go_router, Drift+SQLite, fl_chart, freezed+json_serializable, gen-l10n ARB | 3.1 | AC6 | T4 |
| REQ-028 | Bağımlılıklar çözülmüş ve kilitlenmiş; lisansları GPL-3.0 uyumlu; yeni bağımlılık ADR gerekçeli | 3.1, 3.4 | AC11 | T4, T8 |
| REQ-029 | app/core/features yapısı; işlevsiz klasör açılmaz; clean-arch boilerplate yok | 3.2 | AC6 | T4 |
| REQ-030 | Formüller/eşleştirme saf deterministik doğrudan test edilir fonksiyonlar | 3.3 | AC2 | T11, T12 |
| REQ-031 | Drift migration ileri yönlü + testli; kullanıcı verisi sessizce silinmez | 3.3, 13 | AC8 | T7 |
| REQ-032 | Tarihler UTC epoch/ISO-8601 + yerel offset; UI yerel zaman | 3.3 | AC8 | T7 |
| REQ-033 | Ondalık girişte TR virgül + EN nokta; DB standart sayısal | 3.3 | AC2 | T11 |
| REQ-034 | Tüm kullanıcı metinleri ARB'de; widget içine kopy dağılmaz | 3.3 | AC5 | T4 |
| REQ-035 | Debug logda sağlık verisi/profil/öğün/not/ölçüm yok | 3.3 | AC3 | T4, T30 |
| REQ-036 | README/CONTRIBUTING/SECURITY/CoC/issue+PR şablonları; THIRD_PARTY kayıtları; sır commit edilmez | 3.4 | AC11 | T5, T6 |
| REQ-037 | CI: analyze + format + test + offline tarama; release sırları CI'da yok | 3.4 | AC3, AC6 | T4 |

## Onboarding ve onam

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-038 | 8 adımlı ilk açılış: dil, gizlilik, tıbbi-olmayan bilgilendirme, kullanım amacı, profil, enerji katsayısı (saygılı, atlanabilir), risk taraması, veri kalıcılığı | 4 | AC10 | T9 |
| REQ-039 | Onam kaydı: sürüm+dil+tarih+metin hash'i; kritik metin değişince yeniden onam | 4 | AC10 | T9 |
| REQ-040 | Risk taramasında risk → plan/hedef üretimi kilitli; kayıt+eğitim açık kalır; uzman değerlendirmesi istenir | 4.7 | AC10 | T10 |

## Ekranlar ve bilgi mimarisi

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-041 | Alt navigasyon ≤5 sekme: Bugün/Günlük/Plan/Trendler/Rehber | 5 | AC6 | T4 |
| REQ-042 | Bugün: son glukoz/BHB/GKI + eşleşme durumu, günlük toplamlar, ağırlık 7/30, semptom, hızlı eylemler, planlı öğünler, tıbbi-olmayan alt bilgi | 5.1 | AC1 | T14 |
| REQ-043 | Günlük: tek kronolojik çizelge (öğün/ölçüm/ağırlık/semptom/not/bağlam etiketleri), yerel filtre/arama, geri alınabilir/onaylı silme | 5.2 | AC1 | T13 |
| REQ-044 | Plan: haftalık plan, tarif+porsiyon, alışverişe çevirme, kopyala/taşı/değiştir; terapötik hedef uydurma yok | 5.3 | AC1 | T20 |
| REQ-045 | Trendler: 7/30/90/özel; ham nokta ≠ hareketli özet; veri yoksa çizgi yok; öğün işareti/bağlam isteğe bağlı; bantlar aç/kapat + kaynak | 5.4 | AC6 | T24 |
| REQ-046 | Rehber: keto temelleri, GKI hesabı, bağlam, gıda rehberi, profesyonel yardım; Bilimsel Kaynaklar: önce genel; hastalığa özel yalnız bilinçli filtreyle ve ana sayfada öneri olarak yok | 5.5 | AC4 | T25 |
| REQ-047 | Profil/ayarlar/veri yönetimi/uzman hedefleri üst menüde; klinisyen paneli yok | 5 | AC1 | T4, T21 |

## Ölçüm ve GKI motoru

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-048 | Glukoz girişi mg/dL veya mmol/L; kaynak türü (parmak ucu/laboratuvar/CGM-elle/diğer); CGM entegrasyonu yok | 6.1 | AC1 | T12 |
| REQ-049 | BHB yalnız kan + mmol/L; idrar/nefes ketonu ayrı tür, GKI'ye girmez | 6.1 | AC1 | T12 |
| REQ-050 | mmol/L girdide dönüşüm ikinci kez uygulanmaz; ham+normalize birlikte saklanır | 6.2 | AC2 | T12 |
| REQ-051 | Hesap kartında formül + iki ölçümün saati gösterilir; dahili tam hassasiyet, UI 1 ondalık, ayrıntıda ham adımlar | 6.2 | AC2 | T13 |
| REQ-052 | Eşleştirme: pencere varsayılan ±5 dk (1–15 ayarlanabilir), en küçük \|Δt\|, eşitlikte erken, ölçüm tek oturumda, onaysız GKI yok, pencere dışı otomatik eşleşme yok | 6.3 | AC2 | T12 |
| REQ-053 | Eşleşme farkı saklanır; "eşzamanlı"/"yaklaşık" ayrımı görünür | 6.3 | AC1 | T13 |
| REQ-054 | Ölçüm düzenlenince GKI deterministik yeniden hesap; silinince geçersizleştir + bildir | 6.3 | AC8 | T12 |
| REQ-055 | Araştırma bantları varsayılan KAPALI; yalnız kaynak okunup bilinçli açılınca; kalıcı açıklama metni; "kötü/başarısız/tehlikeli" yok | 6.4 | AC4 | T13 |
| REQ-056 | Üç hedef türü (researchReference/clinicianTarget/personalTrackingGoal) model+UI+lejantta asla birleşmez | 6.5 | AC9 | T21 |
| REQ-057 | Klinisyen hedefi kim/ne zaman alanlı; uygulama üretmez/doğrulamaz | 6.5 | AC9 | T21 |
| REQ-058 | Güvenlik mesajları: evrensel acil eşik kodlaması yok; belirti/sıra dışı değilde eylem öne çıkar; kırmızı yalnız klinik onaylı acil mesajda | 6.6 | AC4 | T12, T23 |

## Enerji ve hedefler

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-059 | Mifflin–St Jeor (erkek +5/kadın −161) + sürümlenmiş aktivite katsayıları; sonuç "genel tahmin" çerçevesi | 7.1 | AC6 | T21 |
| REQ-060 | Enerji tahmini terapötik/kalori hedefi değil; istemsiz kilo kaybında kısıtlama değil uzman görüşü önerilir | 7.2 | AC4 | T21, T22 |
| REQ-061 | 18 yaş altı/gebelik-emzirme/kapsam dışı → hesap üretme | 7.2 | AC10 | T21 |

## Beslenme

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-062 | Besin modeli §8.1 alanlarının tamamı (provenance dahil); paketli seed; lisanssız veri seti paketlenmez | 8.1 | AC11 | T15 |
| REQ-063 | `netCarb = max(0, totalCarb − fiber)`; şeker alkolü otomatik çıkarılmaz; kullanıcı beyanı ayrı | 8.1 | AC2 | T15 |
| REQ-064 | Porsiyon ölçekleme kayan nokta testli; kullanıcı besini kaynaklı veriden görünür ayrı | 8.1 | AC6 | T16 |
| REQ-065 | Öğün: tür/çoklu besin/gram-porsiyon/tarif/saat/not; günlük toplamlar; toplam+net karb birlikte, hedefte hangisi ayarlarda görünür | 8.2 | AC1 | T16 |
| REQ-066 | Hızlı tekrar/favori/son kullanılan; barkod/kamera MVP'de yok | 8.2 | AC1 | T16 |
| REQ-067 | Öğün–ölçüm: en yakın önceki öğün + seçilebilir analiz penceresi (1–4 saat); nedensellik dili yok; karıştırıcı eğitim kartı; yetersiz veride korelasyon yok | 8.3 | AC4 | T18 |

## Gıda rehberi, tarif, plan, alışveriş

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-068 | Üç gruplu gıda rehberi; kart: Neden?/porsiyon+net karb/kaynak/alternatifler/kanıt etiketi; ahlaki-korkutucu dil yok; Türkiye+uluslararası | 9 | AC5 | T17 |
| REQ-069 | Tarif: TR/EN başlık+adım, gram malzeme, porsiyon, porsiyon başı enerji+makro, net karb yöntemi, alerjen, süre, saklama; malzeme besin kaydına referanslı; deterministik ölçekleme | 10.1 | AC1 | T19 |
| REQ-070 | Plan üretimi deterministik yerel; filtreler (alerji/hariç/dil/öğün sayısı/kayıtlı hedefler); enerji açığı/fasting/terapötik oran üretmez; uygun plan yoksa dürüst başarısızlık | 10.2 | AC1 | T20 |
| REQ-071 | Alışveriş: aralıktaki planlardan birleştir; canonical besin+uyumlu birim topla; çevrilemeyen ayrı; manuel madde korunur; kategori/işaretle/düzenle; paylaşım yalnız sistem paylaşım sayfasıyla | 10.3 | AC1 | T20 |

## Ağırlık ve semptom

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-072 | Ağırlık: kg/lb → normalize kg; tarih-saat/not/koşul; 7/30 değişim; yetersiz veride trend yok; rozet/seri/kilo baskısı yok | 11.1 | AC6 | T22 |
| REQ-073 | Semptom: düzenlenebilir yerel liste (MASTER'daki 11 madde); şiddet 0–10/başlangıç/süre/not; ciddi-yeni belirtide tanı yok, sağlık planı+acil yönlendirme; öğün/GKI ile gösterim yalnız zamansal | 11.2 | AC4 | T23 |

## Grafik ve erişilebilirlik

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-074 | Material 3; açık/koyu/sistem; sakin yüksek kontrast; renk tek başına anlam taşımayabilir | 12 | AC6 | T4, T30 |
| REQ-075 | Font ölçeklemede taşma yok; ≥44–48dp dokunma hedefleri | 12 | AC6 | T30 |
| REQ-076 | Ekran okuyucu etiketleri; grafiklerin metinsel özeti; tooltip: değer+birim+zaman+bağlam+eşleşme farkı+kaynak | 12 | AC1 | T13, T24 |
| REQ-077 | Düşük GKI ödül değil; bantlar yumuşak/kapatılabilir; eksik gün sıfır değil boşluk; aykırı değer gizlenmez | 12 | AC4 | T13, T24 |
| REQ-078 | Her trend ekranında "Bu grafik ne anlatır/ne anlatmaz?" | 12 | AC6 | T24 |

## Veri modeli ve bütünlük

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-079 | §13'teki 27 tablo (AppSettings…ExportHistory); FK aktif; tablo başına bilinçli cascade | 13 | AC8 | T7 |
| REQ-080 | Ölçüm oturumu glukoz+BHB referansı + GKI + formül sürümü | 13 | AC2 | T7 |
| REQ-081 | Hesaplanabilir toplamlar çoğaltılmaz; cache varsa geçersizleştirme testi | 13 | AC8 | T7 |
| REQ-082 | Seed/kullanıcı kimlik çakışmaz | 13 | AC8 | T7 |
| REQ-083 | Migration testi ≥2 eski şema fixture'ı | 13, 16.2 | AC8 | T7, T30 |

## Mahremiyet ve offline

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-084 | Kaynakta HTTP/socket/Firebase/analytics/crash/reklam/remote config/telemetri/AI SDK yok | 14.1 | AC3 | T4 |
| REQ-085 | Android manifest'te `INTERNET` yok; iOS ağ capability/entitlement yok | 14.1 | AC3 | T4 |
| REQ-086 | CI yasaklı paket/izin taraması; uçak modu smoke | 14.1 | AC3 | T4, T30 |
| REQ-087 | SQLite varsayılan şifresiz; yanlış şifreleme iddiası yok (T8 ADR'iyle uyumlu metin) | 14.2 | AC3 | T8, T33 |
| REQ-088 | Hassas DB ve export bulut yedeği kapsamı dışında (backup rules doğrulamalı) | 14.2 | AC3 | T31 |
| REQ-089 | Panoya otomatik sağlık verisi kopyalanmaz; son uygulamalar perdeleme platform standardıyla; biyometrik kilit opsiyonel | 14.2 | AC3 | T31 |
| REQ-090 | Export yalnız kullanıcı eylemiyle CSV+JSON; başlıkta sürüm/şema/birim/tz/uyarı | 14.3 | AC8 | T26 |
| REQ-091 | Import: şema doğrulama, boyut limiti, tip/range, transaction (hatada sıfır kısmi yazı), önizleme, eski format okuma, bilinmeyen alan yok sayma; CSV formül enjeksiyonu koruması | 14.3, 15 | AC8 | T26 |
| REQ-092 | "Tüm verilerimi sil" kapsam gösteren ikinci onay + geçici dosya temizliği | 14.3 | AC8 | T26 |

## Doğrulama ve hata durumları

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-093 | Anlamsız değerler reddedilir; mümkün-sıra dışı değerler onayla-koru akışıyla | 15 | AC2 | T12 |
| REQ-094 | Birim her sayısal alanın yanında; gelecek tarih doğrulanır; saat değişimi toleransı | 15 | AC6 | T12 |
| REQ-095 | BHB yoksa GKI yok ("0" gösterme); glukoz yoksa GKI yok | 15 | AC2 | T12 |
| REQ-096 | Çift kayıt uyarısı (zaman/değer); kullanıcı yine de kaydedebilir | 15 | AC6 | T12 |
| REQ-097 | DB yazma hatasında form verisi korunur; yeniden dene/kopyala | 15 | AC8 | T12 |
| REQ-098 | Migration/import öncesi bütünlük kontrolü; başarısızlıkta mevcut DB korunur | 15 | AC8 | T7, T26 |

## Test ve teslimat

| ID | Gereksinim | Master § | AC | Görev |
|---|---|---|---|---|
| REQ-099 | §16.1 birim testlerinin tamamı (dönüşüm/GKI/virgül/eşleştirme/net karb/Mifflin/hedef türleri/tz) | 16.1 | AC2 | T11, T12, T15, T21 |
| REQ-100 | §16.2 DB testleri: CRUD/FK/rollback/migration/idempotency/import rollback/GKI yeniden hesap | 16.2 | AC8 | T7, T26 |
| REQ-101 | §16.3 widget/erişilebilirlik testleri; sıradan kullanıcı akademik ekran olmadan tamamlayabilmeli | 16.3 | AC1, AC6 | T30 |
| REQ-102 | §16.4 golden/integration: tema, uçtan uca akış, plan→alışveriş, export/import round-trip, ağ kapalı | 16.4 | AC1, AC8 | T30 |
| REQ-103 | §16.5 bilimsel içerik testleri: provenance zorunlu, kırık DOI/PMID build engeli, yasaklı dil lint'i, çeviri sayısal eşliği | 16.5 | AC4 | T25 |
| REQ-104 | §19 teslimat listesi (16 madde) eksiksiz | 19 | AC7 | T5, T33, T34 |
| REQ-105 | §20 DoD 11 adımlı senaryo uçak modunda geçer | 20 | AC1 | T34 |

**Toplam: 105 REQ satırı** (≥40 gereksinimi aşar; her satırda master bölüm referansı vardır).

## İzlenebilirlik özeti

- Her AC (AC1–AC11) en az bir REQ'e bağlıdır; her REQ en az bir T-id'ye bağlıdır.
- REQ-019 (Amaral düzeltmesi) `docs/research/EVIDENCE_VERIFICATION.md` ile bağlantılıdır.
- REQ-087'nin metni T8 ADR kararıyla senkron tutulmalıdır (şifreleme varsa/yoksa).
