# Tehdit Modeli — N Keto Tracker

Sürüm: 1.0 · Tarih: 2026-09-20 · Dayanak: `docs/MASTER_PROMPT.md` §14, `ORTAK_UYGULAMA_STANDARDI.md` §1; gereksinimler: `docs/REQUIREMENTS_MATRIX.md` REQ-084–REQ-092.

## 1. Varlıklar (assets)

| Varlık | Nerede | Hassasiyet |
|---|---|---|
| A1 Sağlık kayıtları (glukoz/BHB/GKI/öğün/ağırlık/semptom/not) | Uygulama sandbox'ında SQLite (Drift) | Yüksek — kişisel sağlık verisi |
| A2 Profil (yaş/boy/kilo/aktivite/biyolojik katsayı) | SQLite | Orta-yüksek |
| A3 Onam kayıtları (sürüm/dil/tarih/metin hash) | SQLite | Orta — yasal kanıt |
| A4 Risk taraması yanıtları | SQLite | Yüksek — sağlık durumu çıkarımı mümkün |
| A5 Export dosyaları (CSV/JSON/PDF) | Kullanıcının seçtiği harici konum | Yüksek — sandbox dışına çıkar |
| A6 Uygulama anahtarı (varsa: DB şifreleme anahtarı) | Platform güvenli deposu | Yüksek — A1'e erişim |
| A7 Uygulama bütünlüğü (kod, formül, seed içerik) | APK/IPA + repo | Orta — güvenilirlik temeli |

## 2. Tehditler, olasılık/etki ve kontroller

| # | Tehdit | Vektör | Olasılık | Etki | Kontroller | Dayanak |
|---|---|---|---|---|---|---|
| T1 | Cihaz kaybı/çalınması → A1–A4 fiziksel erişim | Cihaz ele geçirme | Orta | Yüksek | Uygulama kilidi (platform biyometrik/PIN, opsiyonel; T31); OS kullanıcı kilidi; DB şifreleme kararı T8 ADR (sqlcipher + secure storage; uygulanırsa düz metin erişimi kapanır) | MASTER §14.2 |
| T2 | Bulut yedeği sızıntısı → A1 sandbox dışına otomatik kopyalanır | Android Auto Backup / iCloud yedeği | Orta | Yüksek | `dataExtractionRules`/`fullBackupContent` ile hassas DB+export hariç tutma; iOS `isExcludedFromBackup`; doğrulama T31'de manifest/aapt2 kanıtıyla | MASTER §14.2 |
| T3 | Kötücül import dosyası → şema enjeksiyonu, dev boyut, path traversal, CSV formül enjeksiyonu | Kullanıcı dışa aktarılmış görünen dosyayı içe aktarır | Orta | Orta-yüksek | Şema doğrulama; boyut limiti; tip/range kontrolü; atomik transaction (hatada sıfır kısmi yazı); önizleme; HTML/markdown çalıştırma yok; CSV hücreleri güvenli dışa aktarma; bilinmeyen alan yok sayma | MASTER §14.3, REQ-091 |
| T4 | Kopya/sahte uygulama → marka güveninin sömürülü | Mağaza dışı dağıtım veya benzer adlı uygulama | Orta | Orta | Açık kaynak + imzalı release; mağaza yayın öncesi ad rezervasyonu (sahip adımı); README'de resmi kaynak tekliği | MASTER §3.4, §22.1 |
| T5 | Omuz sörfü / son uygulamalar önizlemesi → ekranda sağlık verisi | Fiziksel gözlem | Orta | Orta | Opsiyonel ekran perdeleme (platform standardı); kırmızı-alan gösterimini gerektiren durum yok (varsayılan sakin UI) | MASTER §14.2 |
| T6 | Debug log sızıntısı → A1/A2 logcat/syslog'a düşer | Geliştirici hataları, çökme günlükleri | Düşük-orta | Orta | Kod kuralı: loglarda sağlık verisi/profil/öğün/not/ölçüm yok (REQ-035); review checklist; crash SDK'sı hiç yok | MASTER §3.3, §14.1 |
| T7 | Ağ tarafı kanalı → veri sızıntısı | Herhangi bir ağ bağlantısı | Tasarım gereği imkânsız hedef | Yüksek | `INTERNET` izni yok; ağ SDK'sı yok; CI yasaklı bağımlılık/izin taraması; uçak modu smoke testi | MASTER §14.1, REQ-084–086 |
| T8 | Migration bozulması → veri kaybı | Sürüm yükseltme | Düşük | Yüksek | İleri yönlü testli migration; ≥2 eski şema fixture testi; öncesi bütünlük kontrolü; hatada mevcut DB korunur | MASTER §3.3, §13, REQ-083, REQ-098 |
| T9 | Kullanıcının export dosyasını güvenli olmayan kanalla paylaşması | Kullanıcı davranışı | Orta | Orta | Export dosyasında uyarı başlığı; paylaşım yalnız kullanıcının açık eylemiyle; otomatik gönderim yok | MASTER §14.3 |
| T10 | Kök erişimli/jailbreak cihaz → A1/A6 doğrudan erişim | Saldırgan cihaza tam erişimli | Düşük | Yüksek | DB şifrelemesi (T8) anahtarı secure storage'da tutar; kalan risk kabulü aşağıda | ORTAK §1, MASTER §14.2 |
| T11 | Supply chain → kötücül bağımlılık | Pub paketleri | Düşük | Yüksek | Bağımlılık listesi minimum; `pubspec.lock` commit; THIRD_PARTY lisans+kayıt; dependabot bildirimi (T6); GPL-3.0 uyum incelemesi | MASTER §3.4, §3.1 |
| T12 | Telif ihlali iddiası → içerik/görsel/font | Seed veri/tarif/görsel | Orta | Orta-yüksek | Yalnız lisansı doğrulanmış veri (USDA kamu malı vb., T15 doğrulaması); telifli makale metni paketlenmez; THIRD_PARTY_NOTICES kaydı | MASTER §2.3, §3.4 |
| T13 | Yanlış sağlık kararı → kullanıcının uygulamaya dayanarak tedavi değiştirmesi | Yanlış/abartılı içerik veya yorum | Orta | Çok yüksek | Dil ilkeleri (§1.3); bantlar kapalı/opsiyonel; hedef türleri ayrık; risk kilidi (T10); feragat metinleri; içerik lint testleri | MASTER §1.3, §2, §6.4–6.6 |
| T14 | Form verisi kaybı → DB hatasında girilen kayıt yok olur | Yazma hatası | Orta | Orta | Hata durumunda form korunur; yeniden dene/kopyala (REQ-097) | MASTER §15 |

## 3. Güvenlik mimarisi kuralları (bağlayıcı)

1. **Ağ yokluğu bir özellik değil, kanıt zorunluluğudur:** her sürümde `tool/check_offline.sh` + CI taraması + uçak modu smoke (REQ-084–086).
2. **Yanlış güven beyanı yok:** SQLite varsayılanı şifresizdir; şifreleme varsa (T8) yalnız o zaman PRIVACY/metinlerinde belirtilir (REQ-087).
3. **Kullanıcı verisi tek gerçek kaynak:** sandbox SQLite; hesaplanabilir toplamlar çoğaltılmaz (REQ-081).
4. **En az ayrıcalık:** kamera yok, konum yok, bildirim opsiyonel, ağ yok; izin çıkarımı README+mağaza beyanıyla eşleşir.
5. **Silme saygısı:** "tüm verilerimi sil" ikinci onay + geçici dosya temizliği (REQ-092).

## 4. Kalan riskler (residual risks — açıkça kabul edilen)

- **R1 (T1/T10):** Çevrimdışı mimari uzaktan silme/oturum iptali sunamaz; cihaz fiziksel ele geçirilirse yazılım katmanı tek başına yeterli değil. Kabul: uygulama kilidi + (T8 kararıyla) şifreli DB; kullanıcıya cihaz kilidi önerisi.
- **R2 (T9):** Export dosyası bir kez kullanıcı eline geçtiğinde kontrol biter. Kabul: uyarı başlığı + kullanıcının sorumluluğu; belgelendirme (PRIVACY.md).
- **R3 (T4):** Açık kaynak kodun kopyalanıp kötüye kullanılması. Kabul: GPL-3.0 yasal çerçevesi; marka adı/logo lisansa dahil değil (README notu); resmi dağıtım kanallarının tekliği bildirilir.
- **R4 (T13):** Dil/kankanıt katmanlarına rağmen bir kullanıcının uygulamayı tıbbi otorite gibi okuması. Kabul: feragat+onam katmanları, risk kilidi, içerik inceleme süreci (SCIENTIFIC_CONTENT.md); sıfıra indirilemez.
- **R5 (T11):** Transitif bağımlılık zafiyeti. Kabul: minimum bağımlılık seti + lock + güncelleme izleme; tam önleme mümkün değil.
- **R6 (T8):** Migration hatası olasılığı testlerle küçültülür ama sıfırlanamaz; kullanıcıya export alışkanlığı önerilir (uygulama içi hatırlatma metni, bildirim değil).

## 5. Doğrulama planı

| Kontrol | Kanıt | Zaman |
|---|---|---|
| Ağ yokluğu | check_offline.sh exit 0 + manifest grep + bağımlılık taraması | her CI (T4) |
| Yedek hariç tutma | aapt2 dump xmltree çıktısı AUDIT_RESULTS.md'de | T31 |
| Import güvenliği | rollback + enjeksiyon birim testleri | T26 |
| Migration | 2 fixture'lı test | T7/T30 |
| Gizli tarama | gitleaks detect --no-git | T6, her CI |
| Şifreleme (varsa) | düz sqlite3 ile açılama testi | T8 |
