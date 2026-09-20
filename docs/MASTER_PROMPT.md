# N Keto Tracker — Profesyonel Flutter Master Prompt

> Bu belgenin tamamını kodlama yapay zekâsına tek görev tanımı olarak ver.
> Belge sürümü: 1.1 — 20 Eylül 2026

---

## 0. Rolün ve görevin

Sen; kıdemli Flutter mimarı, Dart geliştiricisi, mobil UX/UI tasarımcısı, klinik beslenme yazılımı tasarımcısı, biyomedikal kanıt analisti, veri görselleştirme uzmanı, test mühendisi ve mahremiyet mühendisi olarak çalışacaksın.

Görevin, ürün ve mağaza adı tam olarak **N Keto Tracker** olan, Türkçe ve İngilizce kullanılabilen, tamamen çevrimdışı çalışan, üretim kalitesinde bir Flutter mobil uygulaması tasarlamak ve uygulamaktır. `N`, tek başına duran marka harfidir; hiçbir kelimenin kısaltması veya baş harfi olarak açıklanmayacaktır. `Keto Tracker`, uygulamanın ketojenik beslenme kayıt ve takip işlevini doğrudan anlatır. İngilizcede doğru yazım `keto` ve `ketogenic` biçimindedir; ikisi de K harfiyle yazılır. Ürün adındaki `N` harfini `Next`, `Neuro`, `Nourish`, `Nutrition`, `Nova` veya başka bir kelimeye genişletme; `NKeto`, `N-Keto`, `Ceto`, `Enketo` ya da başka bir yazıma dönüştürme. İsme hastalık veya dolaylı tıbbi anlam yükleme. Nihai ad yayın öncesi App Store Connect, Google Play ve resmi marka araştırmasıyla doğrulanmalıdır; ad tüm kod ve çeviri dosyalarında tek yapılandırma noktasından değiştirilebilir olmalıdır.

Bu ürünün birincil kullanıcısı **bilim insanı, araştırmacı veya klinisyen değil; günlük yaşamında ketojenik beslenmesini takip etmek isteyen sıradan kişidir**. Tüm ürün kararlarını sağlık bilimi eğitimi olmayan, teknik terimlere aşina olmayan, hızlı ve anlaşılır bir deneyim isteyen kişi için ver.

Uygulama **tek ve genel bir ketojenik beslenme deneyimi** sunmalıdır: ketojenik beslenme eğitimi, genel enerji tahmini, yemek planlama, yemek günlüğü, glukoz/BHB/GKI, ağırlık ve iyi oluş takibi. Hastalığa özel mod, profil, menü, karşılama ekranı veya ana sayfa kartı oluşturma.

Thomas N. Seyfried ve diğer araştırmacıların glukoz–keton indeksi (GKI) ve ketojenik metabolik terapi yayınları yalnızca kullanıcının isteyerek girdiği **Rehber > Bilimsel Kaynaklar ve Makaleler** bölümünde doğru atıfla yer alabilir. Bu çalışmalar ana sayfada, onboarding'de, bildirimlerde, tariflerde, planlarda, ölçüm girişinde veya varsayılan grafiklerde hastalık adıyla gösterilmemelidir. Mekanistik hipotezleri, hayvan/preklinik kanıtını, insanlarda uygulanabilirlik-güvenlik bulgularını ve klinik etkinlik kanıtını birbirinden görünür biçimde ayır. Kullanıcının bir görüşü “bilimsel” diye sorgusuz kabul etmesini sağlayan bir ürün değil, belirsizliği dürüstçe anlatan bir uygulama üret.

Bu prompttaki sağlık güvenliği, offline çalışma, kanıt sunumu ve veri bütünlüğü gereksinimleri **taviz verilemez kabul kriterleridir**.

### 0.1 Tüketici uygulaması deneyimi

- Ana ekranın amacı kullanıcıya “Bugün neyi kaydetmem veya görmem gerekiyor?” sorusunun cevabını birkaç saniyede vermektir.
- En sık eylemler — öğün, glukoz, keton, ağırlık ve semptom ekleme — en fazla üç dokunuşta başlamalıdır.
- GKI, BHB, net karbonhidrat ve enerji tahmini gibi terimler ilk görüldüğü yerde tek cümleyle açıklanmalıdır.
- Bilimsel ayrıntılar, çalışma tasarımı, DOI/PMID ve kanıt sınıfları ana akışı kaplamamalı; “Bu bilgi nereden geliyor?” veya “Ayrıntıyı gör” altında bulunmalıdır.
- Kullanıcıdan araştırma metodolojisi, biyokimya veya beslenme bilimi bilmesi beklenmemelidir.
- Arayüz “veri yönetim sistemi” gibi değil, sade bir günlük ve yol arkadaşı gibi hissettirmelidir.
- Bir görev için güvenli bir varsayılan varsa onu seç; kullanıcıyı gereksiz ayarlarla karşılaştırma. Sağlıkla ilgili belirsizliği ise gizleme.
- Teknik tablo, kod, kanıt kodu veya ham bibliyografik veri günlük ekranlarda gösterilmemelidir.
- Yorgunluk, bilişsel güçlük, görme sorunu veya bakım veren desteği ihtimali düşünülerek kısa cümleler, büyük dokunma alanları, net geri bildirim ve hataya dayanıklı formlar kullanılmalıdır.

### 0.2 Marka ve mağaza görünümü

- Ürün ve marka adı: **N Keto Tracker**.
- Mağaza adı: **N Keto Tracker**.
- Anlamı: ketojenik beslenme takibi uygulaması. Baştaki `N` yalnızca marka harfidir; açılımı, gizli anlamı ve hastalığa özel çağrışımı yoktur.
- Marka adı her dilde değişmeden `N Keto Tracker` kalır; açıklayıcı alt başlık yerelleştirilebilir.
- Türkçe ve İngilizce mağaza adı: `N Keto Tracker`.
- Önerilen Türkçe alt başlık: `Keto Günlüğü ve GKI Takibi`.
- Önerilen İngilizce alt başlık: `Keto Journal & GKI Tracker`.
- Mağaza adı ve alt başlık her dilde 30 karakter sınırını aşmamalıdır.
- Uygulama adı, ikon, alt başlık, kısa/uzun açıklama, ekran görüntüsü, tanıtım videosu ve anahtar kelimelerde hastalık, kanser, tümör, glioblastoma/GBM veya tedavi çağrışımı kullanılmamalıdır.
- Mağaza metni yalnızca gerçek genel işlevleri anlatmalıdır: offline keto günlüğü, makro takibi, glukoz/keton/GKI kaydı, tarifler, planlar ve kaynaklı eğitim.
- Nihai ad yayın öncesinde App Store Connect içinde oluşturularak fiilen rezerve edilmeli; Google Play paket adı kalıcı olduğu için dikkatle seçilmeli; TÜRKPATENT ve hedef pazarlardaki resmi marka veri tabanlarında profesyonel ön araştırma yapılmalıdır.
- Marka adı tek bir `appBrandName` yapılandırmasından ve yerelleştirme metadata dosyalarından yönetilsin; isim değişikliği iş mantığına dokunmayı gerektirmesin.

### 0.3 Zorunlu pazar, rakip ve saha araştırması

Kod veya yüksek sadakatli tasarım üretmeden önce güncel internet araştırması yap. Bu araştırma uygulamanın runtime'ına internet bağlantısı eklemek anlamına gelmez; yalnızca ürün geliştirme aşamasındaki masa başı/saha keşfidir. Araştırma tarihini ve erişilen URL'leri kaydet.

En az 8–12 güncel iOS/Android ürününü incele. Listede mümkün olduğunca şu farklı sınıflar bulunsun:

- Keto odaklı büyük ürünler: Carb Manager, Senza, Keto.app/Keto Diet App ve yayın tarihinde aktif benzerleri.
- Veri doğruluğu ve ayrıntılı besin takibiyle öne çıkan genel ürünler: Cronometer ve yayın tarihinde aktif benzerleri.
- Basit/tek amaçlı keto günlükleri ve GKI/glukoz-keton takip araçları.
- Türkçe mağaza sonuçları ve Türkiye'deki kullanıcıların erişebildiği ürünler.
- Açık kaynaklı beslenme veya sağlık günlüğü örnekleri.

Her ürün için karşılaştırma matrisi hazırla:

```text
ürün adı ve platform
mağaza/official URL
araştırma tarihi
puan, yorum sayısı ve Android indirme aralığı (varsa; tarih damgalı)
hedef kullanıcı ve konumlandırma
ücretsiz/premium/paywall modeli
onboarding uzunluğu
bir öğün kaydına başlama ve tamamlama adım sayısı
net/toplam karbonhidrat ve makro sunumu
glukoz, keton ve GKI desteği
tarif, plan ve alışveriş özellikleri
grafik ve ana ekran bilgi hiyerarşisi
arama, porsiyon ve tekrar kayıt kolaylığı
offline çalışma ve mahremiyet beyanı
erişilebilirlik gözlemleri
mağaza ekran görüntülerindeki görsel dil
kullanıcıların tekrar eden olumlu/olumsuz yorum temaları
N Keto Tracker için alınacak dersler
kesinlikle kopyalanmayacak öğeler
```

Araştırma kuralları:

- Öncelikle resmi App Store/Google Play sayfaları, resmi ürün siteleri, açık kaynak depoları ve doğrudan ürün dokümantasyonunu kullan.
- “En başarılı” sonucunu tek bir puana dayandırma; puan, yorum hacmi, indirme aralığı, güncelleme sıklığı ve kullanıcı yorumlarını birlikte değerlendir.
- Rakip ekran görüntülerini, ikonlarını, metinlerini, tariflerini veya özel etkileşimlerini kopyalama. Yalnızca genel desenlerden özgün tasarım ilkeleri çıkar.
- En az 100 yakın tarihli kullanıcı yorumunu ürünler arasında örnekleyerek tekrar eden sürtünmeleri sınıflandır: yavaş yemek kaydı, hatalı veri, zor paywall, karmaşık ana ekran, senkronizasyon, gizlilik, reklam, abonelik ve erişilebilirlik.
- Gerçek kullanıcı görüşmesi yapılmadıysa yapılmış gibi yazma. Görüşme/anket ancak açık onamlı gerçek katılımcılarla yürütülür ve kişisel sağlık verisi toplanmaz.
- Araştırma sonuçlarını `docs/research/COMPETITIVE_LANDSCAPE.md`, `USER_REVIEW_THEMES.md`, `UX_BENCHMARK.md` ve `PRODUCT_POSITIONING.md` olarak teslim et.
- Bulgulardan önceliklendirilmiş bir “kopyalama değil öğrenme” listesi çıkar ve her önemli ürün kararını bir bulgu veya açık gereksinimle ilişkilendir.

Başlangıç hipotezi olarak başarılı ürünlerde sık görülen şu konuları doğrula veya reddet: hızlı yemek kaydı, net karbonhidratın görünürlüğü, güvenilir besin verisi, basit makro halkaları/kartları, tarif ve plan desteği, anlaşılır grafikler, kişiselleştirilebilir hedefler ve düşük giriş sürtünmesi. N Keto Tracker'ın farklılaştırıcı hipotezleri: tamamen offline çalışma, reklamsız ve hesapsız kullanım, açık kaynak kod, glukoz+BHB+GKI bütünlüğü, bilimsel kaynak provenance'ı ve hastalık çağrışımı yapmayan sakin kullanıcı deneyimi.

### 0.4 Promotion, mağaza optimizasyonu ve lansman paketi

Uygulama geliştirmesiyle birlikte dürüst ve doğrulanabilir bir tanıtım paketi hazırla. Promotion sağlık iddialarına, korkuya, “mucize”, “tedavi”, “garantili ketozis” veya kanıtlanmamış kilo verme vaatlerine dayanamaz.

Zorunlu çıktılar:

- `docs/marketing/STORE_LISTING_TR.md` ve `STORE_LISTING_EN.md`: uygulama adı, alt başlık, kısa açıklama, uzun açıklama, anahtar kelime adayları ve sürüm notu şablonu.
- `docs/marketing/SCREENSHOT_PLAN.md`: her mağaza görselinin amacı, başlığı, gösterdiği gerçek ekran ve erişilebilir alt metni. Hastalık adı veya hassas örnek veri kullanma.
- `docs/marketing/APP_PREVIEW_SCRIPT.md`: 20–30 saniyelik sessiz de anlaşılabilen mağaza videosu akışı.
- `docs/marketing/LAUNCH_PLAN.md`: GitHub release, proje README'si, dokümantasyon sitesi/GitHub Pages, uygun açık kaynak ve keto toplulukları için spam içermeyen paylaşım planı.
- `docs/marketing/BRAND_GUIDE.md`: kelime markası, ikon yaklaşımı, renkler, tipografi, ton ve yasaklı iddialar.
- `docs/marketing/ASO_RESEARCH.md`: yayın tarihindeki mağaza arama terimleri, rakip metadata örneklerinden türetilen özgün konumlandırma ve yerelleştirme planı.
- `docs/marketing/PRESS_KIT.md`: kısa ürün özeti, özellik listesi, açık kaynak/offline farkı, logo ve ekran görüntüsü listesi; gerçek olmayan basın alıntısı veya kullanıcı yorumu ekleme.

Tanıtımda öne çıkarılacak sıra:

1. Hızlı ve anlaşılır keto günlüğü.
2. Net karbonhidrat, makro, glukoz, kan ketonu ve GKI'yi tek yerde takip.
3. Verilerin cihazda kalması; hesap, reklam ve bulut zorunluluğu olmaması.
4. Açık kaynak ve incelenebilir hesaplama mantığı.
5. Kaynaklı fakat sade bilimsel açıklamalar.
6. Türkçe ve İngilizce kullanım.

Mağaza metadata limitlerini yayın gününde resmi Apple ve Google dokümanlarından yeniden doğrula. Uygulama tamamen offline kalırken, mağazanın zorunlu tuttuğu gizlilik politikası URL'si ve tanıtım sayfası statik GitHub Pages üzerinden yayınlanabilir; uygulamanın kendisi bu siteye otomatik veri veya telemetri göndermez. Topluluklarda otomatik paylaşım, sahte yorum, teşvikli puan, rakip marka anahtar kelime doldurma veya izinsiz mesaj gönderme yapma.

---

## 1. Ürün ilkeleri ve kesin sınırlar

### 1.1 Ürünün yaptığı şey

- Kullanıcının glukoz ve kan β-hidroksibütirat (BHB) ölçümlerini kaydeder.
- Aynı zaman bağlamındaki ölçümlerden GKI hesaplar ve hesabı açıklanabilir şekilde gösterir.
- Öğünleri, besinleri, net/toplam karbonhidratı, protein ve yağı kaydeder.
- Öğünlerle sonraki ölçümler arasındaki zamansal ilişkiyi keşfetmeye yardımcı olur; nedensellik iddia etmez.
- Yaş, boy, kilo ve aktiviteye göre **genel, tahmini** enerji gereksinimi verir.
- Kullanıcı veya klinisyenin ayrıca belirlediği hedefleri saklar; bunları araştırma referanslarıyla karıştırmaz.
- Ağırlık, semptom, not, ölçüm bağlamı ve eğilimleri izler.
- Yerel tarif, öğün planı, alışveriş listesi, anlaşılır gıda rehberi ve isteyen kullanıcı için sadeleştirilmiş “Bilginin kaynağı” bölümü sunar.
- Kullanıcının kayıtlarını yalnızca açıkça başlattığı bir işlemle yerel dosyaya dışa aktarır.

### 1.2 Ürünün yapmadığı şey

- Tanı, prognoz, sağkalım tahmini veya tedavi kararı üretmez.
- GKI'yi tek başına sağlık, hastalık, tedavi başarısı veya güvenlik göstergesi saymaz.
- Ketojenik beslenmenin herhangi bir hastalığı önlediğini veya tedavi ettiğini iddia etmez.
- Hekimin uygun gördüğü tedavilerin yerine geçmesini önermez, bunları geciktirmeyi ya da bırakmayı teşvik etmez.
- İlaç, takviye, elektrolit, insülin veya antidiyabetik doz önermez/değiştirmez.
- Otomatik olarak fasting/oruç, su orucu, kalori kısıtlaması, hızlı kilo verme veya terapötik makro hedefi reçete etmez.
- Laboratuvar sonucunu yorumlayıp hastalık teşhisi koymaz.
- Çocuklar, gebelik/emzirme veya özel klinik gruplar için kişiselleştirilmiş plan oluşturmaz.
- İnternete bağlanmaz; Firebase, analitik SDK, reklam SDK'sı, uzaktan yapılandırma, çökme raporlama servisi, bulut senkronizasyonu, harici API veya harici/yerleşik üretken yapay zekâ kullanmaz.

### 1.3 Her ekranda izlenecek dil ilkesi

- “İyi/kötü”, “başarılı/başarısız”, “güvenli/tehlikesiz” gibi kesin yargılar yerine ölçüm bağlamı kullan.
- Örnek: “Bu değer, Duraj ve arkadaşlarının 2024 araştırma önerisindeki ≤2 bölgesinin içindedir. Bu, tedavinin işe yaradığını veya güvenli olduğunu göstermez.”
- “Normal GKI” deme; GKI için genel nüfusa ait evrensel klinik normal aralık yoktur.
- Gıda etiketleri ahlaki dil kullanmasın. “Zararlı” yerine “ketojenik hedefle genellikle uyumsuz”, “sıklık/porsiyon sınırı gerekebilir” ve “neden” açıklaması kullan.
- Her klinik içerik ekranında kısa uyarı ve ayrıntılı “Neden?” bağlantısı olsun.

---

## 2. Bilimsel yaklaşım ve kanıt mimarisi

### 2.1 Kanıt sınıfları

Her bilimsel iddia arka plandaki içerik modelinde şu sınıflardan tam birine sahip olmalıdır. `E1–E6` kodları içerik yönetimi ve kalite kontrol içindir; sıradan kullanıcıya kod olarak gösterilmez. Kullanıcı arayüzünde bunları “Güçlü insan kanıtı”, “İnsan çalışması”, “Erken güvenlik bulgusu”, “Laboratuvar/hayvan araştırması”, “Araştırmacı görüşü” ve “Genel bilgi” gibi açık etiketlere çevir.

| Kod | Görünen etiket | Anlamı |
|---|---|---|
| E1 | Klinik kılavuz / yüksek düzey kanıt | İlgili, güncel kılavuz veya güçlü insan verisi |
| E2 | İnsan klinik çalışması | Randomize veya gözlemsel insan verisi; tasarım ve örneklem açıkça yazılır |
| E3 | Uygulanabilirlik / güvenlik sinyali | Genellikle küçük ve etkinlik göstermek için yetersiz insan çalışması |
| E4 | Preklinik / mekanistik | Hücre, hayvan veya biyolojik mekanizma; insan faydası anlamına gelmez |
| E5 | Uzman görüşü / araştırma önerisi | Hipotez, tartışma, konsensüs önerisi veya henüz doğrulanmamış çerçeve |
| E6 | Genel eğitim | Klinik sonuç iddiası içermeyen temel beslenme/ölçüm bilgisi |

“Seyfried yaklaşımı” ayrı bir kanıt seviyesi değildir. Her iddia, çalışmanın gerçek tasarımına göre etiketlenmelidir. Bir yayının kendi güçlü dili, uygulamanın daha yüksek kanıt etiketi vermesine neden olamaz.

Kullanıcıya önce en fazla iki–üç cümlelik sade sonuç göster. “Ayrıntıyı gör” açıldığında kanıt türü ve sınırlılık; “Bu bilgi nereden geliyor?” açıldığında yayın künyesi gösterilsin. Kullanıcı kaynakları hiç açmadan da temel işlevleri anlayabilmelidir.

### 2.2 Güncel bilimsel konumlandırma

Uygulamanın genel kullanıcıya gösterdiği yerleşik özet metni şu anlamı korumalıdır:

- Ketojenik beslenme karbonhidratın sınırlandığı, yağın görece yüksek, proteinin ise amaca göre yeterli tutulduğu bir beslenme yaklaşımıdır.
- GKI, aynı zaman bağlamındaki glukoz ile kan BHB değerlerinin oranıdır; bir tanı veya tek başına sağlık puanı değildir.
- Kişisel tolerans, gereksinim ve güvenlik; sağlık durumu, kullanılan ilaçlar ve beslenme durumuna göre değişebilir.
- Uygulama günlük takip ve eğitim aracıdır; tıbbi cihaz veya klinik karar sistemi değildir.

Hastalığa özel araştırmalar yalnızca Bilimsel Kaynaklar ve Makaleler bölümünde bulunur. Kullanıcı ilgili makaleyi kendisi açmadan hastalık adı, hastalık prognozu, tedavi veya tümör dili hiçbir yüzeyde görünmez. Arama sonuçlarında hastalığa özel makaleler ancak kullanıcı “Hastalıklara özel araştırmalar” filtresini bilinçli olarak açarsa listelenir.

### 2.3 Kaynak provenance zorunluluğu

Her bilimsel içerik kaydı şu alanları taşımalıdır:

```text
id
titleTr, titleEn
plainSummaryTr, plainSummaryEn
claimTr, claimEn
evidenceLevel
studyType
population
sampleSize (nullable)
year
authors
journal
doi (nullable)
pmid (nullable)
pmcid (nullable)
canonicalUrl
accessedAt
contentVersion
lastReviewedAt
reviewedByRole
limitationsTr, limitationsEn
conflictsOrFundingNoteTr, conflictsOrFundingNoteEn
linkedFeatureIds[]
```

- Her hesap, referans bölgesi veya eğitim iddiasından ilgili kaynağa uygulama içinden ulaşılabilsin.
- Kaynak kütüphanesi build sırasında paketlenen yerel JSON/SQLite verisinden çalışsın.
- Uygulama içinde WebView, uzaktan PDF veya URL isteği olmasın. URL yalnızca kopyalanabilir metin olarak gösterilebilir; uygulama bağlantıyı kendisi açmasın.
- İçerik güncellemesi yalnızca yeni uygulama sürümüyle gelsin. Her içerik paketinin sürümü, inceleme tarihi ve değişiklik günlüğü olsun.
- Telifli makale tam metnini paketleme. Bibliyografik bilgi ve özgün, kısa özet kullan.

### 2.4 Seyfried araştırma çerçevesi ve bilimsel doğruluk kapısı

Thomas N. Seyfried, Boston College'da çalışmalar yürütmüş bir araştırmacıdır; kişi, kurum ve yayın bilgilerini doğrulamadan içerik yazma. N Keto Tracker'ın GKI hesaplama ve bilimsel kaynak altyapısı özellikle şu iki birincil kaynağı doğru temsil etmelidir:

1. Meidenbauer, Mukherjee ve Seyfried (2015): GKI hesaplama yöntemi; glukoz mmol/L değerinin kan BHB mmol/L değerine oranı.
2. Duraj ve arkadaşları, Seyfried dahil (2024): ketojenik metabolik terapi için araştırma çerçevesi ve temsili GKI bölgeleri.

Bu kaynakları kullanırken:

- Yazarların hipotez/önerilerini bağımsız klinik doğrulama gibi sunma.
- 2024 yayınının bir araştırma çerçevesi/debate niteliğinde olduğunu ve GKI bölgelerinin reçete olmadığını belirt.
- Bağımsız sistematik derlemeler ve randomize insan çalışmalarıyla dengele; insanlarda klinik fayda kanıtlanmış gibi yazma.
- Thomas N. Seyfried'i uygulama markasının, mağaza açıklamasının veya tanıtımının yüzü haline getirme; isim yalnızca ilgili bilimsel kaynak künyelerinde görünür.
- Bilimsel içerik ile uygulama hesap motorunu ayır: makale özeti değişse bile formül sürümü ve testleri izlenebilir kalsın.

Hesaplama doğruluğu release engelleyicisidir:

- `glucoseMmolL = glucoseMgDl / 18.0` ve `GKI = glucoseMmolL / bhbMmolL` tek, saf ve sürümlenmiş hesaplama modülünde uygulanmalıdır.
- UI, grafik, export, rapor ve testler aynı modülü kullanmalıdır; aynı formülü farklı ekranlarda yeniden yazma.
- Ham değer, ham birim, normalize değer, ölçüm zamanı, eşleşme farkı ve formül sürümü saklanmalıdır.
- Birim dönüşümünde ara yuvarlama yapılmamalı; sunum yuvarlaması hesap sonucundan sonra uygulanmalıdır.
- BHB sıfır/negatif, glukoz negatif, NaN/Infinity, hatalı yerel ondalık ve zaman penceresi dışı eşleşmeler test edilmelidir.
- 90 mg/dL glukoz + 2,5 mmol/L BHB örneği her platformda tam olarak 2,0 GKI üretmelidir.
- Golden/reference test vektörleri `test/fixtures/gki_reference_cases.json` içinde tutulmalı; formül veya dönüşüm değişikliği bilimsel kaynak, migration etkisi ve test güncellemesi olmadan merge edilmemelidir.
- Hesaplama testleri, migration testleri veya bilimsel içerik provenance kontrolü başarısızsa release oluşturma.

---

## 3. Zorunlu teknoloji ve mimari

### 3.1 Teknoloji seti

- Flutter stable ve null-safe Dart.
- Material 3.
- Durum yönetimi: Riverpod.
- Navigasyon: `go_router`.
- Yerel ilişkisel veri: Drift + SQLite.
- Grafikler: `fl_chart`.
- Değişmez modeller/union tipleri ve serileştirme: `freezed` + `json_serializable`.
- Yerelleştirme: Flutter gen-l10n ve ARB dosyaları.
- Platform hedefleri: Android ve iOS; responsive düzen tabletlerde de bozulmamalı.
- Bağımlılık sürümlerini uydurma. Proje oluşturulduğu gün birbiriyle ve seçilen Flutter stable ile uyumlu güncel kararlı sürümleri çöz, kilit dosyasını commit et.
- Yeni bağımlılık yalnızca standart Flutter/Dart veya yukarıdaki paketler ihtiyacı karşılamıyorsa eklenebilir; gerekçeyi ADR'de yaz.

### 3.2 Basit, özellik odaklı yapı

Gereksiz katman ve soyutlama oluşturma. Aşağıdaki yapı yönlendiricidir; işlev yoksa klasör açma:

```text
lib/
  app/
    app.dart
    router.dart
    theme/
    l10n/
  core/
    database/
    privacy/
    units/
    validation/
  features/
    onboarding/
    dashboard/
    measurements/
    nutrition/
    meal_plans/
    recipes/
    shopping/
    weight/
    symptoms/
    evidence/
    export_import/
    settings/
assets/
  seed/
    foods.json
    recipes.json
    evidence.json
test/
integration_test/
```

### 3.3 Mimari kurallar

- UI, veri erişimi ve saf hesaplama mantığını ayır; bunun ötesinde “clean architecture” boilerplate'i üretme.
- Formüller ve eşleştirme algoritmaları saf, deterministik ve doğrudan birim test edilebilir fonksiyonlar olsun.
- Drift migration'ları ileri yönlü ve testli olsun. Kullanıcı verisini sessizce silme.
- Tarihleri UTC epoch veya ISO-8601 olarak sakla; ayrıca ölçüm anındaki yerel UTC offsetini sakla. UI'da kullanıcının yerel zamanına göre göster.
- Ondalık girişte Türkçe virgül ve İngilizce nokta kabul et; veri tabanında standart sayısal değer sakla.
- UI kopyası widget içine dağılmasın; tüm kullanıcı metinleri ARB'de olsun.
- Debug loglarında sağlık verisi, profil, öğün, not veya ölçüm değeri yazma.

### 3.4 Açık kaynak ve GitHub deposu

Proje baştan sona herkese açık bir GitHub deposunda geliştirilmeye ve bağımsız kişiler tarafından derlenmeye uygun olmalıdır.

- Zorunlu GitHub depo adı: `n-keto-tracker`. GitHub URL'lerinde boşluk kullanılamadığı için ürün adındaki boşluklar tireye dönüşür; farklı bir repo adı seçme.
- Lisans türünü proje sahibi daha sonra seçecektir. Lisans adı veya metni uydurma, otomatik ekleme ve proje sahibi onaylamadan belirli bir lisans tanımlama. Depoda geçici olarak “License to be selected by the project owner before first public release” notu kullanılabilir.
- Seçilecek açık kaynak lisansla uyumsuz olabilecek bağımlılık, font, ikon, görsel, tarif, makale özeti veya besin veri seti ekleme.
- Her üçüncü taraf bileşen için ad, sürüm, lisans, kaynak URL'si ve kullanım alanını `THIRD_PARTY_NOTICES.md` içinde kaydet.
- Kaynak kod, build talimatları, veritabanı migration'ları, seed veri üretim yöntemi ve testler depoda bulunmalı; uygulamanın çalışması için özel sunucu, gizli API, ücretli kapalı servis veya geliştiricinin bilgisayarındaki yayımlanmamış dosya gerekmemelidir.
- Gizli anahtar, imzalama sertifikası, provisioning profile, kişisel geliştirici bilgisi, gerçek sağlık verisi veya mağaza kimlik bilgisi commit etme.
- `.gitignore`, örnek yapılandırma ve sahte/test verileri sağla. Gerçek sır gerekmese bile hassas dosya desenlerini hariç tut.
- `README.md` en az şu bölümleri içersin: ürün amacı, ekran görüntüleri için yer tutucu, temel özellikler, offline mimari, sağlık uyarısı, hızlı kurulum, desteklenen Flutter sürümü, kod üretimi, test komutları, katkı bağlantısı ve lisans durumuna bağlantı.
- `CONTRIBUTING.md`: geliştirme ortamı, branch/commit beklentisi, test ve çeviri katkısı, bilimsel içerik değişikliklerinde kaynak/provenance gereksinimi.
- `CODE_OF_CONDUCT.md`: yaygın ve tanınan bir metin ancak lisans uyumu ve atfı doğrulanarak eklenir.
- `SECURITY.md`: sağlık verisi mahremiyeti, güvenlik açığı bildirim yolu ve hangi sürümlerin desteklendiği. Gerçek iletişim adresini proje sahibi sağlamadan uydurma adres kullanma.
- `.github/ISSUE_TEMPLATE/` altında hata ve özellik şablonları; sağlık iddiası veya bilimsel içerik değişiklikleri için kaynak alanı.
- `.github/pull_request_template.md`: kapsam, test kanıtı, ekran görüntüsü, erişilebilirlik, mahremiyet/offline etkisi ve üçüncü taraf lisans kontrolü.
- GitHub Actions ile `flutter analyze`, format kontrolü ve testleri çalıştır. Release imzalama sırları veya mağaza yükleme işlemi varsayılan açık kaynak CI'a eklenmesin.
- Dependabot/Renovate gibi otomasyon zorunlu değildir; eklenirse ağsız uygulama ilkesini değiştirmediği ve lisans değişikliklerini görünür kıldığı doğrulansın.
- Katkıların bilimsel doğruluğu otomatik varsayılmasın. Kaynak ve kullanıcı metni değişiklikleri review gerektirsin.

---

## 4. Onboarding, modlar ve onam

İlk açılış akışı:

1. Dil seçimi: Türkçe / English.
2. Büyük ve sade offline gizlilik özeti.
3. “Bu uygulama genel bilgilendirme ve takip içindir; tıbbi tavsiye veya tedavi değildir” bilgilendirmesi.
4. Kullanım amacı: öğrenme, öğün planlama, makro takibi, glukoz/keton/GKI takibi veya bunların birkaçı. Bu seçim yalnızca ana ekranı sadeleştirir; hastalık modu oluşturmaz.
5. Yaş, boy, ağırlık, tercih edilen birimler, aktivite düzeyi. Ad/soyad zorunlu olmasın.
6. Enerji tahmini için formülün gerektirdiği biyolojik katsayı seçimi; bunun cinsiyet kimliği olmadığı, yalnızca denklemin iki doğrulanmış katsayısından biri olduğu saygılı biçimde açıklansın. Kullanıcı seçmek istemezse enerji hesabını atlayabilsin.
7. Genel güvenlik taraması: diyabet, glukoz düşürücü ilaç/insülin, gebelik/emzirme, böbrek/karaciğer/pankreas hastalığı, yeme bozukluğu öyküsü, belirgin istemsiz kilo kaybı ve 18 yaş altı olma. Yanıtlar tanı üretmez. Herhangi bir riskte otomatik kişisel plan ve hedef üretimi kilitlenir; uygulama yalnızca kayıt/eğitim işlevlerini sunar ve uygun sağlık uzmanı değerlendirmesi ister.
8. Verilerin yalnızca cihazda tutulduğu, uygulama silinirse yedeği olmayan verilerin kaybolabileceği açıklansın.

Onam sürümü, dil, tarih ve kabul edilen metin hash'i yerel olarak saklansın. Kritik metin değişirse yeniden onam istenmelidir.

---

## 5. Ana bilgi mimarisi ve ekranlar

Alt navigasyon en fazla beş ana hedef içersin:

1. **Bugün / Today**
2. **Günlük / Log**
3. **Plan**
4. **Trendler / Trends**
5. **Rehber / Guide**

Profil, ayarlar, veri yönetimi ve “Uzmanımın verdiği hedefler” üst menüden erişilsin. Uygulama içinde klinisyen hesabı, klinisyen paneli veya profesyonel iş akışı oluşturma.

### 5.1 Bugün ekranı

- Son glukoz, BHB ve GKI; ölçüm saati ve “eşzamanlı/ yaklaşık eşleşme” durumu.
- Günlük besin toplamları: enerji, toplam karbonhidrat, lif, net karbonhidrat, protein, yağ.
- Son ağırlık ve son 7/30 günlük değişim; dramatik renk/yargı kullanma.
- Bugünün semptom kaydı.
- Hızlı eylemler: Ölçüm ekle, öğün ekle, ağırlık ekle, semptom ekle.
- Planlanan öğünler ve tamamlanma durumu.
- Sağlık verileri yorumlanırken kısa “Genel bilgi içindir; tıbbi tavsiye değildir” alt bilgisi.

### 5.2 Günlük ekranı

Tek kronolojik zaman çizelgesinde:

- Öğünler ve porsiyonları.
- Glukoz/BHB/GKI oturumları.
- Ağırlık.
- Semptomlar.
- Kullanıcı notları.
- Tedavi/ilaç ayrıntısı girmeden “ölçümü etkileyebilecek bağlam” etiketleri: açlık, öğün sonrası, egzersiz sonrası, stres, kötü uyku, hastalık, steroid kullanımı, diğer.

Filtreler ve arama yerel çalışmalıdır. Kayıt düzenleme/silme geri alınabilir olmalı veya açık onay istemelidir.

### 5.3 Plan ekranı

- Haftalık öğün planı.
- Tarif seçme ve porsiyon ayarlama.
- Planı alışveriş listesine dönüştürme.
- Kopyala, taşı, değiştir.
- Hedefler gösterilir ama uygulama terapötik hedef uydurmaz.

### 5.4 Trendler ekranı

- GKI, glukoz, BHB, ağırlık, net karbonhidrat, enerji ve semptom trendleri.
- 7 gün, 30 gün, 90 gün ve özel aralık.
- Ham noktalar ile hareketli özet birbirinden ayrı gösterilsin; veri yokken çizgi uydurma.
- Kullanıcı seçerse öğün işaretleri ve ölçüm bağlamı grafik üstünde gösterilsin.
- GKI grafiğinde araştırma referans bantları aç/kapat kontrolü ve kaynak bağlantısı olsun.

### 5.5 Rehber ekranı

- Keto temelleri.
- GKI nasıl hesaplanır?
- Ölçüm bağlamı neden önemlidir?
- Gıda rehberi.
- Sık görülen sorunlar ve ne zaman profesyonel yardım aranacağı.
- Bilimsel Kaynaklar ve Makaleler: önce genel ketojenik beslenme ve ölçüm kaynakları; ayrı ve isteğe bağlı “Hastalıklara özel araştırmalar” alt bölümü.
- “Bilginin kaynağı” bölümü: önce sade özet, isteğe bağlı olarak kanıt türü, sınırlılıklar ve yayın künyesi. Akademik filtreler varsayılan görünümde olmasın.
- Hastalığa özel makale başlıkları, özetleri veya küçük görselleri Rehber ana sayfasında öneri olarak gösterilmesin; yalnızca kullanıcı ilgili alt bölümü bilinçli olarak açtıktan sonra görünsün.

---

## 6. Glukoz, BHB ve GKI motoru

### 6.1 Girdi

Glukoz için:

- Birim seçimi: mg/dL veya mmol/L.
- Değer, tarih-saat, kaynak türü (parmak ucu, laboratuvar, CGM'den elle girilmiş, diğer), bağlam ve not.
- CGM entegrasyonu yok; yalnızca elle giriş.

BHB için:

- Yalnızca kan BHB ve mmol/L.
- Değer, tarih-saat, ölçüm cihazı/kaynak türü, bağlam ve not.
- İdrar ketonu veya nefes asetonu GKI hesabında kullanılamaz; eğitim amaçlı ayrı kayıt eklenirse türü açıkça ayrılır ve GKI'ye girmez.

### 6.2 Dönüşüm ve formül

```text
glucoseMmolL = glucoseMgDl / 18.0
GKI = glucoseMmolL / bhbMmolL
```

- Glukoz zaten mmol/L ise dönüştürme yapma.
- Veri tabanında kullanıcının girdiği ham değer/birim ile normalize edilmiş mmol/L değerini birlikte sakla.
- BHB sıfır veya negatifse bölme yapma; doğrulama hatası göster.
- Sonucu dahili olarak yeterli hassasiyetle sakla; UI'da varsayılan 1 ondalık göster, ayrıntıda ham hesap adımlarını göster.
- Yuvarlanmış ara değerden GKI hesaplama.
- Her hesap kartında formülü ve kullanılan iki ölçümün saatini göster.

Örnek doğrulama:

```text
Glukoz: 90 mg/dL -> 5.0 mmol/L
BHB: 2.5 mmol/L
GKI: 5.0 / 2.5 = 2.0
```

### 6.3 Eşzamanlı ölçüm eşleştirme

Tercih edilen akış tek “Ölçüm oturumu” formunda glukoz ve BHB'yi birlikte girmektir. Kullanıcı ayrı kayıt girdiyse:

- Varsayılan eşleştirme penceresi ±5 dakikadır; ayarlardan 1–15 dakika arasında değiştirilebilir.
- En küçük mutlak zaman farkına sahip, daha önce başka bir oturumda kullanılmamış karşı ölçümü öner.
- Eşitlikte daha erken zaman damgasını seç.
- Kullanıcı eşleşmeyi açıkça onaylamadan GKI üretme.
- Pencere dışındaki ölçümleri otomatik eşleştirme; kullanıcı yeni eş ölçüm girmeli veya kaydı GKI'siz bırakmalıdır.
- Eşleşme zaman farkını sakla ve grafikte “eşzamanlı” (aynı oturum) veya “yaklaşık eşleşme” (ayrı giriş) olarak göster.
- Bir ölçümü iki GKI oturumunda kullanma.
- Sonradan ölçüm düzenlenirse ilgili GKI'yi deterministik olarak yeniden hesapla; silinirse GKI kaydını geçersizleştir ve kullanıcıya bildir.

### 6.4 İsteğe bağlı araştırma referans bölgeleri

Varsayılan GKI grafiği yalnızca kullanıcının ölçümlerini, trendini ve varsa kişisel/uzman hedefini gösterir. Hastalığa özel araştırmalardan gelen bölgeler varsayılan olarak kapalıdır. Kullanıcı Bilimsel Kaynaklar ve Makaleler bölümünde ilgili araştırmayı okuyup “Bu araştırma katmanını grafikte göster” seçeneğini bilinçli olarak açarsa, kaynağı açık iki bölge gösterilebilir:

- **GKI ≤ 1,0:** 2024 araştırma çerçevesinde “önerilen optimal araştırma bölgesi”.
- **1,0 < GKI ≤ 2,0:** “önerilen terapötik araştırma bölgesi”.
- **GKI > 2,0:** “önerilen ≤2 araştırma bölgesinin dışında”; “kötü”, “başarısız” veya “tehlikeli” deme.

Her grafikte şu anlamda kalıcı açıklama bulunsun:

> Bu bantlar klinik normal aralık veya kanıtlanmış tedavi hedefi değildir. Belirli bir araştırma çerçevesindeki temsili, reçete niteliğinde olmayan önerilerdir. GKI sağlığı, hastalık yanıtını veya güvenliği tek başına göstermez. Kaynağın ayrıntısını görmek için dokunun.

Grafik üzerinde hastalık adı yazmak zorunlu değildir; katman “Seçtiğiniz makaledeki araştırma aralığı” diye adlandırılabilir. Kullanıcı kaynak ayrıntısını açarsa makalenin özgün başlığı ve çalışma alanı saklanmadan gösterilir. Uygulama genel kullanıcılar için evrensel bir “ideal GKI” üretmesin.

### 6.5 Üç ayrı hedef türü

Veri modelinde ve UI'da asla birleştirme:

1. `researchReference`: uygulamayla gelen, kaynaklı, kullanıcı tarafından değiştirilemeyen araştırma bandı.
2. `clinicianTarget`: sağlık uzmanının kullanıcıya verdiği hedef; kullanıcı bunu “Uzmanımın verdiği hedef” adıyla kaydeder ve kim tarafından/ne zaman verildiğini girebilir. Uygulama hedefi üretmez veya doğrulamaz.
3. `personalTrackingGoal`: kullanıcının yalnızca öz-izlem amacıyla koyduğu hedef; tıbbi hedef olmadığı yazılır.

Grafik lejandı bu üç türü farklı desen/renk/etiketle ve günlük dilde gösterir: “Araştırmada kullanılan bölge”, “Uzmanımın hedefi”, “Kişisel takip hedefim”. Varsayılan görünümde hedefe erişememe nedeniyle alarm, suçluluk dili veya gamification kullanılmaz.

### 6.6 Güvenlik mesajları

- Glukoz/BHB için evrensel acil eşik kodlama; eşikler hastaya, duruma ve cihaza göre değişebilir.
- Yine de kullanıcı belirti bildirdiğinde veya sıra dışı değer girdiğinde sayısal tanı koymadan şu eylemi öne çıkar: ölçümü cihaz talimatına göre doğrula; kendini kötü hissediyorsan veya acil belirtiler varsa yerel acil sağlık hizmetine başvur; diyabet/ilaç kullanıyorsan kendi klinik planını izle.
- Kırmızı renk yalnızca acil eylem gerektiren, klinik olarak gözden geçirilmiş mesajlarda kullanılsın; düşük GKI “yeşil başarı” olmasın.

---

## 7. Enerji tahmini ve hedef ayrımı

### 7.1 Genel tahmin

Yetişkinler için Mifflin–St Jeor dinlenme enerji harcaması denklemini kullan:

```text
Erkek katsayısı: REE = 10 × kg + 6.25 × cm - 5 × yaş + 5
Kadın katsayısı: REE = 10 × kg + 6.25 × cm - 5 × yaş - 161
TDEE tahmini = REE × aktivite katsayısı
```

Aktivite katsayıları, açıklamalarıyla ve kaynak kaydıyla sürümlenmiş yerel içerikte dursun. UI sonucu tek kesin sayı gibi değil, “genel tahmin” olarak göstersin ve denklemin sağlıklı yetişkinlerden türetildiğini açıklasın.

### 7.2 Klinik hedef ayrı olmalı

- Genel enerji tahmini hiçbir zaman hastalığa özel veya terapötik kalori hedefi olarak kullanılmasın.
- Sağlık durumu, kullanılan ilaçlar, kas kaybı ve başka etkenler enerji ihtiyacını değiştirebilir.
- Uygulama otomatik fasting, agresif kalori açığı veya hızlı kilo kaybı hedefi üretmesin.
- Klinisyen enerji/makro hedefi girdiyse tahminden ayrı kart ve veri alanında göster.
- İstemsiz kilo kaybı eğilimi varsa otomatik kısıtlamayı değil, klinisyen/diyetisyen görüşmesini öne çıkar.
- 18 yaş altı, gebelik/emzirme veya denklemin kapsamı dışı durumda hesap üretme.

---

## 8. Yerel besin veritabanı ve yemek günlüğü

### 8.1 Besin modeli

Her besin için minimum:

```text
id, canonicalName
nameTr, nameEn
category
servingOptions[]
gramsPerServing
kcalPer100g
proteinGPer100g
fatGPer100g
carbohydrateTotalGPer100g
fiberGPer100g
netCarbGPer100g
dataSource
sourceVersion
sourceRecordId
license
lastReviewedAt
isUserCreated
notes
```

- `netCarb = max(0, totalCarbohydrate - fiber)` varsayılanını açıkça belirt. Şeker alkolleri ülke/etiket mevzuatına göre değişebildiği için otomatik çıkarma yapma; kullanıcı etiketten özel net karbonhidrat girerse “kullanıcı beyanı” olarak sakla.
- Besin değerleri porsiyona göre ölçeklenirken kayan nokta hatalarını test et.
- Kullanıcı özel gıda ve tarif ekleyebilsin. Kaynaklı veri ile kullanıcı verisi görünür biçimde ayrışsın.
- Gıda veri seti uygulama paketi içinde gelsin; çalışma anında indirme olmasın.
- Kaynak lisansı, sürümü ve kullanma hakkı doğrulanmadan üçüncü taraf veri setini paketleme.

### 8.2 Yemek kaydı

- Kahvaltı, öğle, akşam, ara öğün veya özel ad.
- Birden çok besin, gram/porsiyon, tarif, saat, not.
- Günlük enerji ve makro toplamları.
- Toplam karbonhidrat ile net karbonhidrat birlikte; hangisinin hedefte kullanıldığı ayarlarda görünür olsun.
- Hızlı tekrar, favori, son kullanılanlar.
- Barkod/online arama yok. Kamera izin gerektiren özellik MVP'de yok.

### 8.3 Öğün–ölçüm ilişkisi

- Ölçüm ekranında en yakın önceki öğünü göster; varsayılan analiz penceresi kullanıcı tarafından seçilebilir (ör. 1/2/3/4 saat), ancak nedensellik iddiası yapma.
- Öğün öncesi ve sonrası ölçümler ancak kullanıcı bağlam etiketi verirse karşılaştırılsın.
- “Bu öğün GKI'yi bozdu” yerine “Bu öğünden X saat sonra kaydedilen değer” de.
- Steroid, egzersiz, uyku, stres, hastalık ve ölçüm hatası gibi karıştırıcı etkenleri eğitim kartında açıkla.
- Yeterli tekrarlı veri yoksa korelasyon veya kişisel öneri üretme.

---

## 9. Gıda rehberi

Üç ana grup:

1. **Genellikle tercih edilebilir**
2. **Porsiyon/sıklık sınırlı olabilir**
3. **Ketojenik hedefle genellikle uyumsuz**

Her kart şunları içersin:

- Basit açıklama: “Neden?”
- Tipik porsiyon ve yaklaşık net karbonhidrat; veri kaynağı.
- Alternatifler.
- Kanıt etiketi.
- Alerji, gıda güvenliği veya ilaç-etkileşim uyarısı gerekiyorsa yalnızca doğrulanmış içerik.

Örnek sade dil yaklaşımı:

- Şekerli içecek: “Sıvı şeker hızlı ve yoğun karbonhidrat sağlar; küçük miktarda bile günlük karbonhidrat hedefini aşmayı kolaylaştırır.”
- Nişastalı gıda: “Ekmek, pirinç ve patates sindirimde büyük ölçüde glukoza dönüşen nişasta içerir. Porsiyon küçültmek bile bazı ketojenik hedefler için yeterli olmayabilir.”
- Kuruyemiş: “Türüne ve porsiyona göre karbonhidrat değişir. Paket yerine tartılmış porsiyon kaydetmek daha doğru sonuç verir.”

“Zehirdir”, “mucizedir”, “kesinlikle yasak” veya bir gıdayı hastalıkla ilişkilendiren korkutucu ve aşırı genellemeci dil kullanma. Gıda rehberi kültürel olarak Türkiye'de kullanılan besinleri ve uluslararası seçenekleri kapsasın; içerik yalnızca lisanslı/izlenebilir besin değerlerinden türesin.

---

## 10. Tarifler, öğün planı ve alışveriş listesi

### 10.1 Tarifler

- Türkçe/İngilizce başlık ve adımlar.
- Malzemeler gramla, porsiyon sayısı, porsiyon başına enerji ve makrolar.
- Net karbonhidrat hesabının yöntemi.
- Alerjenler, hazırlama süresi, saklama notu.
- Tüm değerlerin kaynak besin kayıtlarına izi.
- Porsiyon değişince değerler deterministik ölçeklensin.

### 10.2 Plan üretimi

- Kullanıcı elle plan oluşturabilsin veya yerel kurallarla mevcut tariflerden taslak plan üretebilsin.
- “Akıllı” plan tamamen deterministik ve cihaz içinde olmalı; AI/LLM yok.
- Taslak üretici; alerji, hariç tutulan gıda, dil/kültür tercihi, öğün sayısı ve kullanıcı tarafından kaydedilmiş kişisel/uzman hedeflerini filtre olarak kullanır.
- Sistem kendiliğinden enerji açığı, fasting penceresi veya terapötik oran oluşturmaz.
- Hedef çelişkisi veya yeterli uygun tarif yoksa dürüstçe “uygun plan oluşturulamadı” de; kuralı gevşetme.

### 10.3 Alışveriş listesi

- Seçilen tarih aralığındaki planlardan malzemeleri birleştir.
- Aynı canonical besini ve uyumlu birimleri topla; çevrilemeyen birimleri ayrı bırak.
- Kullanıcının manuel maddeleri koru.
- Kategoriye göre grupla, işaretle, miktar düzenle.
- Tamamı yerel; paylaşım yalnızca kullanıcının açtığı sistem paylaşım sayfası üzerinden, açık eylemle.

---

## 11. Ağırlık ve semptom takibi

### 11.1 Ağırlık

- kg/lb giriş ve normalize kg saklama.
- Tarih-saat, not, isteğe bağlı ölçüm koşulu.
- 7/30 günlük değişim; veri noktası yetersizse trend gösterme.
- Hızlı/istemsiz kayıp değerlendirmesi tıbbi içerik kurulu tarafından gözden geçirilmiş kurallara bağlı olsun. Uygulama tanı koymadan profesyonel değerlendirme önerir.
- Kilo verme baskısı yaratan rozet, seri veya agresif kalori kısıtlama teşviki bulunmasın.

### 11.2 Semptomlar

Yerel, düzenlenebilir liste: bulantı, kusma, iştahsızlık, kabızlık, ishal, yorgunluk, baş ağrısı, baş dönmesi, nöbet olayı, uyku sorunu, diğer.

- Şiddet 0–10, başlangıç zamanı, süre, not.
- Ciddi veya yeni bir belirti kaydında uygulama ayrıntılı teşhis yapmaz; kullanıcıyı kendi sağlık planına ve gerektiğinde yerel acil sağlık hizmetine yönlendirir.
- Semptomları öğün/GKI ile birlikte göstermek yalnızca zamansal görselleştirmedir; neden-sonuç iddiası yoktur.

---

## 12. Grafik ve erişilebilirlik tasarımı

- Material 3; sakin, yüksek kontrastlı, profesyonel görsel dil.
- Açık/koyu tema ve sistem temasını takip.
- Renge tek başına anlam yükleme; desen, ikon ve metin etiketi kullan.
- Dynamic Type/font ölçeklemesinde taşma olmasın; minimum 44–48 dp dokunma hedefleri.
- Ekran okuyucu etiketleri; grafiklerin metinsel özeti.
- Grafik tooltip'lerinde değer, birim, zaman, bağlam, eşleşme farkı ve veri kaynağı.
- GKI ekseni düşük değerleri “ödül” gibi sunmasın. Bantlar yumuşak tonlu ve kapatılabilir olsun.
- Eksik günleri sıfır kabul etme; çizgide boşluk göster.
- Aykırı değeri gizleme; ham veri korunur, kullanıcı isterse görünüm filtresi uygular.
- Her trend ekranında “Bu grafik ne anlatır / ne anlatmaz?” açıklaması.

---

## 13. Veri modeli ve bütünlük

En az şu tabloları tasarla:

```text
AppSettings
ConsentRecords
UserProfile
RiskScreening
EnergyEstimate
Goal (research/clinician/personal ayrımıyla)
Food
ServingOption
Recipe
RecipeIngredient
Meal
MealItem
GlucoseMeasurement
KetoneMeasurement
MeasurementSession
WeightEntry
SymptomDefinition
SymptomEntry
ContextTag
MealPlan
MealPlanEntry
ShoppingList
ShoppingListItem
EvidenceSource
EvidenceClaim
ContentVersion
ExportHistory (yalnız metadata; dosyanın içeriği değil)
```

Kurallar:

- Foreign key'leri etkinleştir.
- Ölçüm oturumu, glukoz ve BHB kayıtlarına referans verir; hesaplanmış GKI yanında formül sürümünü de saklar.
- Hesaplanabilen toplamları tek gerçek kaynak gibi çoğaltma; performans için cache kullanırsan geçersizleştirme testi yaz.
- Kullanıcı silme işlemlerinde ilişkili kayıtların etkisini açıkla. Cascade davranışını her tablo için bilinçli tanımla.
- Seed içerik ile kullanıcı içeriğinin kimlik alanları çakışmasın.
- Migration testinde en az iki eski şema fixture'ı üzerinden veri korunmasını doğrula.

---

## 14. Mahremiyet, güvenlik ve tamamen offline çalışma

### 14.1 Ağsızlık kanıtı

- Uygulama kaynak kodunda HTTP istemcisi, socket, Firebase, analytics, crash reporting, reklam, remote config, telemetri veya üçüncü taraf AI SDK'sı bulunmamalı.
- Android manifestinden `INTERNET` izni çıkarılsın.
- iOS'ta ağ kullanımı gerektiren capability/entitlement eklenmesin.
- CI testi, manifest ve dependency graph içinde yasaklı paket/izinleri tarasın.
- Uçak modu ve ağ engelli cihazda tüm işlevler çalışsın.

### 14.2 Yerel veri güvenliği

- Veriler uygulama sandbox'ındaki SQLite'ta saklansın.
- Varsayılan SQLite şifreli değildir; kullanıcıya şifreleme varmış gibi davranma.
- Hassas DB ve dışa aktarımlar, Android otomatik bulut yedeği ve iOS bulut yedeği kapsamına alınmasın; platform yapılandırması ve test ile doğrula.
- Ekran görüntüsü engelleme gibi platform davranışları kullanıcı deneyimi ve erişilebilirlik açısından değerlendirilmeden zorunlu yapılmasın.
- Panoya sağlık verisi otomatik kopyalama.
- Uygulama son uygulamalar önizlemesinde hassas veriyi perdeleme seçeneği sunsun; platform standardını kullan.
- Uygulama kilidi istenirse platformun yerel biyometrik/PIN özelliğini kullan; biyometrik veri saklama. Yeni bağımlılığı gerekçelendir ve kilit açılmadığında veri silme.

### 14.3 İçe/dışa aktarma

- Dışa aktarma yalnızca kullanıcı eylemiyle; CSV ve okunabilir JSON. Kullanıcının sağlık uzmanıyla paylaşabileceği sade PDF özeti isteğe bağlıdır ve ancak ek bağımlılık gerekçelendirilirse yapılır.
- Dosya başında uygulama sürümü, şema sürümü, birimler, zaman dilimi ve uyarı metni.
- İçe aktarmada şema doğrulama, boyut limiti, tip/range kontrolü, transaction ve önizleme. Hata olursa hiçbir kısmi veri yazma.
- İçe aktarılan veri güvenilmez girdidir; HTML/markdown çalıştırma, dosya yolu takip etme, formül enjeksiyonuna karşı CSV hücrelerini güvenli dışa aktar.
- “Tüm verilerimi sil” işlemi kapsamı açıkça gösteren ikinci onay ister; silme sonrası yerel DB ve oluşturulmuş geçici dosyalar temizlenir.

---

## 15. Hata durumları ve doğrulama

- Fiziksel olarak anlamsız negatif/sıfır değerleri reddet.
- Aşırı/sıra dışı ama mümkün değerleri sessizce reddetme; yazım hatası olabileceğini söyleyip onay iste, kaynağı koru.
- Birim seçimini her sayısal alanın yanında göster.
- Tarih gelecekteyse doğrula; cihaz saati değişikliklerini tolere et.
- BHB yoksa GKI yoktur; “0” gösterme.
- Glukoz yoksa GKI yoktur.
- Aynı ölçümün yanlışlıkla çift kaydı için zaman/değer tabanlı uyarı ver; kullanıcı isterse yine kaydedebilir.
- Veritabanı yazma hatasında girilen form verisini kaybetme; tekrar deneme ve kopyalama seçeneği sun.
- Migration veya import öncesi bütünlük kontrolü yap; başarısızlıkta mevcut DB'yi koru.

---

## 16. Test stratejisi

Yeni işlev, onu bozacak hatayı yakalayan en küçük testle birlikte gelmelidir.

### 16.1 Birim testleri

- mg/dL → mmol/L dönüşümü: 90 → 5.0; 180 → 10.0.
- GKI: 90 mg/dL ve 2.5 mmol/L → 2.0.
- mmol/L girdi yolunda dönüşümün iki kez uygulanmaması.
- BHB 0/negatif, glukoz negatif, NaN/Infinity ve boş giriş.
- Türkçe virgüllü ondalık ayrıştırma.
- Ara yuvarlama yapılmaması.
- Eşleştirme: pencere içi/dışı, en yakın, eşitlik, ölçümün yeniden kullanılmaması, düzenleme/silme.
- Net karbonhidrat ve porsiyon ölçekleme.
- Tarif ve alışveriş birleştirme.
- Mifflin–St Jeor iki katsayı yolu ve aktivite çarpanı.
- Hedef türlerinin birbirine dönüşmemesi.
- Tarih/timezone ve yaz saati değişimi.

### 16.2 Veritabanı testleri

- CRUD, foreign key, transaction rollback.
- Migration ile kullanıcı verisinin korunması.
- Seed içerik idempotency.
- Import transaction'ının hatada tamamen geri alınması.
- Ölçüm değiştiğinde GKI yeniden hesaplama/geçersizleştirme.

### 16.3 Widget ve erişilebilirlik testleri

- Onboarding ve mod seçimi.
- Ölçüm formu ve formül açıklaması.
- “Araştırmada kullanılan bölge / Uzmanımın hedefi / Kişisel takip hedefim” lejant ayrımı.
- Sağlık eğitimi olmayan bir kullanıcının ana görevleri akademik kaynak ekranına girmeden tamamlayabilmesi.
- Öğün ve ölçüm ekleme akışının en fazla üç dokunuşta başlayabilmesi.
- GKI, BHB ve net karbonhidratın ilk kullanımda sade dille açıklanması.
- Büyük yazı ölçeği ve dar ekran taşmaları.
- Türkçe/İngilizce tüm ana akışlar.
- Semantics etiketleri ve klavye/focus sırası.
- Boş, yükleniyor, hata ve dolu durumlar.

### 16.4 Golden/integration testleri

- Açık/koyu tema için temel ekranlar.
- İlk açılış → profil → öğün → eşzamanlı glukoz/BHB → GKI → grafik tam akışı.
- Plan → alışveriş listesi.
- Export → temiz kurulum → import → kayıt sayısı ve değer eşitliği.
- Ağ kapalıyken uygulamanın işlevsel olması.

### 16.5 Bilimsel içerik testleri

- Her iddianın kaynak kimliği ve kanıt seviyesi var.
- Kırık DOI/PMID biçimi, eksik inceleme tarihi veya kaynaksız referans bandı build'i başarısız kılar.
- Yasaklı kesin sağlık dili için TR/EN içerik lint listesi.
- Çevirilerde sayısal eşik ve formüllerin aynı olması.

---

## 17. Aşamalı uygulama planı

Her aşamada çalışan, test edilen küçük bir dilim teslim et. Sonraki aşamaya mevcut testler geçmeden geçme.

### Aşama 0 — Kararlar ve iskelet

- Önce güncel pazar/rakip/mağaza araştırmasını tamamla; `COMPETITIVE_LANDSCAPE.md`, `USER_REVIEW_THEMES.md`, `UX_BENCHMARK.md` ve `PRODUCT_POSITIONING.md` onaylanmadan yüksek sadakatli UI veya üretim koduna başlama.
- Seyfried/GKI birincil kaynaklarını, bağımsız insan kanıtını ve formül test vektörlerini doğrula.
- Araştırma bulgularından gereksinim matrisi, özgün UX ilkeleri, veri akışı, tehdit modeli ve kanıt içerik şeması çıkar.
- Flutter proje iskeleti, l10n, tema, router, CI.
- Offline/network yasağı otomatik kontrolü.

### Aşama 1 — Yerel veri ve onboarding

- Drift şeması/migration altyapısı.
- Dil, gizlilik, kullanım amacı, profil, risk taraması, onam.
- Yerel ayarlar.

### Aşama 2 — Ölçüm ve GKI dikey dilimi

- Glukoz/BHB formları, birimler, oturum, eşleştirme, GKI saf hesap motoru.
- Günlük ve temel grafik.
- Kaynaklı araştırma bantları ve açıklamalar.

### Aşama 3 — Beslenme günlüğü

- Lisanslı seed besinler, arama, porsiyon, öğün, günlük toplamlar.
- Gıda rehberi ve basit dil içerikleri.
- Öğün–ölçüm zaman ilişkisi.

### Aşama 4 — Planlama

- Tarifler, haftalık öğün planı, deterministik plan taslağı, alışveriş listesi.
- Genel enerji tahmini ve üç hedef türü.

### Aşama 5 — Ağırlık, semptom ve gelişmiş trend

- Kayıtlar, grafik katmanları, metinsel grafik özetleri ve güvenlik yönlendirmeleri.

### Aşama 6 — Kaynak kütüphanesi ve veri taşınabilirliği

- EvidenceSource/EvidenceClaim ekranları.
- CSV/JSON export, doğrulamalı transaction import.
- İçerik sürümü/değişiklik günlüğü.

### Aşama 7 — Sertleştirme ve release

- Erişilebilirlik, performans, migration, güvenlik, offline ve localization auditleri.
- Release build, mağaza metinleri, ekran görüntüsü planı, app preview, promotion/lansman paketi, mahremiyet beyanı ve kullanıcı kılavuzu.

---

## 18. Release checklist

Release adayı ancak aşağıdakilerin tamamı doğrulandıysa hazırdır:

### Bilimsel ve klinik güvenlik

- [ ] Ketojenik yaklaşım herhangi bir tıbbi tedavinin alternatifi gibi sunulmuyor.
- [ ] Hastalık önleme/tedavi iddiası yok; kanıt belirsizliği görünür.
- [ ] Hastalık adı onboarding, ana sayfa, varsayılan grafik, plan, bildirim ve mağaza materyallerinde yer almıyor.
- [ ] Hastalığa özel yayınlar yalnızca kullanıcının isteyerek açtığı Bilimsel Kaynaklar ve Makaleler alt bölümünde görünüyor.
- [ ] GKI araştırma bantları varsayılan olarak kapalı, isteğe bağlı ve kaynaklı.
- [ ] Klinisyen, kişisel ve araştırma hedefleri ayrık.
- [ ] Fasting/kalori kısıtlaması otomatik reçete edilmiyor.
- [ ] Risk taramasında plan üretimi doğru kilitleniyor.
- [ ] İlaç/takviye doz önerisi yok.
- [ ] Bilimsel içerik klinik ve beslenme uzmanı tarafından incelenmiş; rol/tarih kaydı var.
- [ ] Seyfried'in GKI/KMT çerçevesi özgün kaynaklara sadık, araştırma önerisi olarak ve bağımsız insan kanıtıyla dengeli sunuluyor.

### Matematik ve veri

- [ ] GKI formülü ve mg/dL dönüşümü testli.
- [ ] 90 mg/dL + 2,5 mmol/L reference testi tüm hedef platformlarda 2,0 sonucu veriyor.
- [ ] UI, grafik, export ve rapor aynı sürümlenmiş GKI hesaplama modülünü kullanıyor.
- [ ] Eşzamanlı eşleştirme deterministik ve onaylı.
- [ ] Ham ve normalize değerler korunuyor.
- [ ] Birim, timezone, virgül/nokta girişleri testli.
- [ ] Migration ve import rollback testleri geçiyor.
- [ ] Seed gıda verisinin lisansı ve provenance'ı doğrulanmış.

### Offline ve mahremiyet

- [ ] Android `INTERNET` izni yok.
- [ ] Ağ/telemetri/analytics/Firebase/harici AI bağımlılığı yok.
- [ ] Ağ kapalı cihazda tam smoke test geçti.
- [ ] Hassas veriler debug logunda yok.
- [ ] Otomatik bulut yedeği dışlamaları doğrulandı.
- [ ] Export/import ve tüm verileri silme akışları testli.
- [ ] Uygulama gerçek olmayan “şifreli veritabanı” iddiası yapmıyor.

### UX ve kalite

- [ ] TR/EN çeviri kapsamı tam; hard-coded kullanıcı metni yok.
- [ ] Ana deneyim sıradan kullanıcıya göre tasarlanmış; akademik ayrıntılar isteğe bağlı ikinci katmanda.
- [ ] Klinik araştırma kodları, DOI/PMID ve teknik veri alanları günlük ekranları kalabalıklaştırmıyor.
- [ ] En sık kayıt işlemleri en fazla üç dokunuşta başlatılabiliyor.
- [ ] Koyu/açık tema ve büyük yazı testi geçti.
- [ ] Ekran okuyucu temel akışları kullanılabilir.
- [ ] Grafiklerin metinsel alternatifi var.
- [ ] Boş/hata/yükleme durumları tasarlanmış.
- [ ] Unit/widget/integration testleri ve static analysis geçiyor.
- [ ] Android ve iOS release build'leri temiz kuruluma açılıyor.

### Açık kaynak yayına hazırlık

- [ ] README ve mağaza markası tam olarak `N Keto Tracker`; GitHub depo slug'ı tam olarak `n-keto-tracker`.
- [ ] Temiz bir bilgisayarda yalnızca depodaki talimatlarla build ve test yapılabiliyor.
- [ ] Gizli anahtar, sertifika, kişisel veri veya gerçek sağlık kaydı commit edilmemiş.
- [ ] Üçüncü taraf kod, veri, font ve görseller `THIRD_PARTY_NOTICES.md` içinde kayıtlı ve seçilecek açık kaynak lisansla uyumluluk incelemesine hazır.
- [ ] Katkı, davranış kuralları, güvenlik bildirimi, issue ve pull request şablonları mevcut.
- [ ] Lisans türü proje sahibinin kararına bırakılmış; otomatik veya varsayılan lisans metni eklenmemiş.

### Pazar araştırması ve promotion

- [ ] En az 8–12 güncel rakip ürün resmi mağaza/ürün kaynaklarıyla incelenmiş ve araştırma tarihi kaydedilmiş.
- [ ] Yakın tarihli kullanıcı yorumlarından sürtünme temaları çıkarılmış; gerçek kullanıcı araştırması yapılmadıysa yapılmış gibi gösterilmemiş.
- [ ] Tasarım kararları araştırma bulgularına bağlanmış, rakip varlıkları veya metinleri kopyalanmamış.
- [ ] TR/EN mağaza metinleri, ekran görüntüsü planı, app preview senaryosu, ASO araştırması, launch plan ve press kit hazır.
- [ ] Promotion materyallerinde tedavi, mucize, garantili ketozis veya kanıtlanmamış kilo verme iddiası yok.
- [ ] Mağaza metadata sınırları yayın gününde resmi Apple/Google kaynaklarından yeniden doğrulanmış.

---

## 19. Zorunlu teslimatlar

Yalnızca ekran maketi veya örnek kod verme. Çalışan proje teslim et:

1. Flutter kaynak kodu.
2. Drift şeması ve migration'lar.
3. Sürümlenmiş, lisansı doğrulanmış seed içerik dosyaları.
4. TR/EN ARB çevirileri.
5. Birim, widget, DB ve integration testleri.
6. `README.md`: kurulum, build, test, mimari özeti, offline garantisi ve bilinen sınırlamalar.
7. `SCIENTIFIC_CONTENT.md`: kanıt sınıfları, içerik inceleme süreci, kaynak listesi.
8. `PRIVACY.md`: cihaz içi veri akışı, izinler, yedekleme, export/import ve silme.
9. `THREAT_MODEL.md`: varlıklar, tehditler, kontroller ve kalan riskler.
10. `CHANGELOG.md` ve içerik veri sürümü.
11. Release checklist'in doldurulmuş kanıtı.
12. `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` ve GitHub katkı şablonları.
13. `THIRD_PARTY_NOTICES.md`: tüm kod/veri/görsel/font bağımlılıklarının kaynağı ve lisansı.
14. Proje sahibinin seçip ekleyeceği açık kaynak lisans için kök dizinde ayrılmış `LICENSE` süreci; lisans türünü yapay zekâ kendi başına seçmemelidir.
15. `docs/research/`: rekabet ortamı, kullanıcı yorumu temaları, UX benchmark ve ürün konumlandırması.
16. `docs/marketing/`: TR/EN mağaza metinleri, ekran görüntüsü planı, app preview senaryosu, ASO araştırması, marka rehberi, lansman planı ve press kit.

Her aşama sonunda şunları raporla:

- Tamamlanan kabul kriterleri.
- Değişen dosyalar.
- Çalıştırılan testler ve sonuçları.
- Bilinen sınırlamalar.
- Bir sonraki en küçük uygulanabilir adım.

---

## 20. Definition of Done

Ürün ancak şu uçtan uca senaryo gerçek cihaz/emülatörde çalışıyorsa tamamlanmıştır:

1. Kullanıcı Türkçe dili ve takip etmek istediği genel keto özelliklerini seçer, sade bilgilendirmeyi okuyup onam verir.
2. Yaş, boy, kilo ve aktiviteyi girer; genel enerji tahmininin klinik hedef olmadığını görür.
3. Yerel veritabanından besin seçerek öğün kaydeder.
4. 90 mg/dL glukoz ve 2,5 mmol/L BHB'yi aynı oturumda girer.
5. Uygulama 90/18 = 5,0 mmol/L ve GKI = 5,0/2,5 = 2,0 hesabını gösterir.
6. Grafikte GKI 2,0 noktası, kaynaklı araştırma bölgesi içinde görünür; UI bunu “tedavi başarısı” olarak yorumlamaz.
7. Kullanıcı bu ölçümü öğün sonrası bağlamıyla görür; uygulama korelasyonu nedensellik olarak sunmaz.
8. Ağırlık ve semptom kaydeder, trendin metinsel özetini ekran okuyucuyla dinleyebilir.
9. Haftalık plandan yerel alışveriş listesi üretir.
10. Verileri JSON/CSV dışa aktarır; temiz kurulumda doğrulanmış import ile geri yükler.
11. Bütün akış internet izni ve ağ bağlantısı olmadan çalışır.

---

## 21. Başlangıç bilimsel kaynak seti

Bu liste içerik ekibinin başlangıç setidir; kaynakların uygulamadaki iddiaları gerçekten desteklediğini tek tek doğrula. Yeni sürümde daha güncel ve daha güçlü kanıt varsa ekle, fakat önceki kaynağı provenance geçmişinden silme.

1. **Meidenbauer JJ, Mukherjee P, Seyfried TN (2015).** *The glucose ketone index calculator: a simple tool to monitor therapeutic efficacy for metabolic management of brain cancer.* Nutrition & Metabolism 12:12. DOI: `10.1186/s12986-015-0009-2`; PMID: `25798181`; PMCID: `PMC4367849`.  
   Kullanım: GKI formülü, glukozun mmol/L'ye çevrilmesi, ölçümlerin aynı zaman bağlamında ele alınması ve 1–2 aralığının yazarların öngördüğü araştırma bölgesi olması. İnsanlarda klinik etkinliği doğrulayan kanıt olarak kullanma.

2. **Duraj T, et al. (2024).** *Clinical research framework proposal for ketogenic metabolic therapy in glioblastoma.* BMC Medicine 22:578. DOI: `10.1186/s12916-024-03775-4`.  
   Kullanım: Yalnızca Rehber > Bilimsel Kaynaklar ve Makaleler > Hastalıklara özel araştırmalar altında. KMT araştırma çerçevesi, GKI ≤2 ve ideal olarak ≤1 önerisi. Makalenin bu değerleri kişiler arası/kişi içi değişkenliği temsil eden ve reçete niteliğinde olmayan değerler olarak açıkladığını aynı görünümde belirt. Bu yayın bir “Debate”/araştırma çerçevesidir; klinik kılavuz değildir.

3. **Persiani M, et al. (2026).** *Ketogenic Diet in the Treatment of Malignant Gliomas: A Systematic Review.* Nutrients 18(13):2166. DOI: `10.3390/nu18132166`; PMID: `42451166`; PMCID: `PMC13363701`.  
   Kullanım: 23 çalışma/306 hasta, yalnız iki RCT, heterojen müdahaleler, çoğunlukla hafif yan etkiler ve sağkalım/yaşam kalitesi yararının kanıtlanmamış olduğu güncel bağlam.

4. **Voss M, et al. (2020).** *ERGO2: A Prospective, Randomized Trial of Calorie-Restricted Ketogenic Diet and Fasting in Addition to Reirradiation for Malignant Glioma.* International Journal of Radiation Oncology Biology Physics. DOI: `10.1016/j.ijrobp.2020.06.021`; PMID: `32619561`.  
   Kullanım: Randomize insan çalışması bağlamı; kısa KD-IF programı reirradyasyon etkinliğini artırmamıştır. Otomatik fasting reçetesi üretmeme kararını destekleyen kanıt setinin parçası.

5. **Klein P, et al. (2025).** *A phase 1 safety and feasibility trial of a ketogenic diet plus standard of care for patients with recently diagnosed glioblastoma.* Scientific Reports. DOI: `10.1038/s41598-025-06675-6`; PMID: `40595067`; PMCID: `PMC12215994`.  
   Kullanım: Küçük, tek kollu faz 1 güvenlik/uygulanabilirlik sinyali. Kontrol grubu olmadığı için sağkalım etkinliği kanıtı olarak sunma.

6. **Martin-McGill KJ, et al. (2020).** *Ketogenic diets as an adjuvant therapy for glioblastoma (KEATING): a randomized, mixed methods, feasibility study.* Journal of Neuro-Oncology. DOI: `10.1007/s11060-020-03417-8`; PMID: `32036576`; PMCID: `PMC7076054`.  
   Kullanım: Uygulanabilirlik, düşük katılım/retansiyon ve hasta/bakım veren yükünü tasarımda dikkate alma.

7. **Mifflin MD, et al. (1990).** *A new predictive equation for resting energy expenditure in healthy individuals.* American Journal of Clinical Nutrition 51(2):241–247. DOI: `10.1093/ajcn/51.2.241`; PMID: `2305711`.  
   Kullanım: Genel yetişkin REE tahmin denklemi. Kanserli bireylerde klinik enerji reçetesi olarak sunma.

Kaynak kütüphanesinde her yayının tasarımı, örneklem büyüklüğü, sınırlılıkları ve çıkar çatışması/finansman notu görünür olmalıdır. Hastalığa özel bu yayınlar uygulamanın marka adına, açıklamasına, ana navigasyonuna, onboarding'ine, bildirimlerine veya varsayılan önerilerine taşınmamalıdır. Uygulama mağazaya çıkmadan önce bilimsel içerik, ilgili alanı bilen hekim ve diyetisyen tarafından incelenmelidir.

---

## 22. Mevcut saha araştırması özeti — 20 Eylül 2026

Bu bölüm yalnızca “ileride araştır” talimatı değildir; ürün brief'i hazırlanırken yapılan ilk masa başı saha taramasının tarihli özetidir. Puanlar, yorum sayıları, indirme aralıkları ve mağaza özellikleri zamanla değişir. Uygulamayı kodlamadan ve yayımlamadan önce 0.3'teki daha geniş araştırmayı güncelle; aşağıdaki bulguları körü körüne kalıcı gerçek kabul etme.

### 22.1 Ad ve depo için ön çakışma taraması

- 20 Eylül 2026'da Apple'ın herkese açık ABD yazılım arama uç noktasında `N Keto Tracker` için yapılan taramada tam ad eşleşmesi görülmedi.
- Aynı tarihte GitHub'ın herkese açık repository search uç noktasında `n-keto-tracker` için tam depo adı eşleşmesi görülmedi.
- Genel web, App Store ve Google Play aramalarında da bu tam ad için açık bir ürün eşleşmesi bulunmadı.
- Bu sonuç **adın hukuken müsait olduğu, tüm ülkelerde boş olduğu veya mağazada rezerve edildiği anlamına gelmez**. Yayından önce App Store Connect'te ad rezervasyonu, Google Play'de uygulama kaydı ve hedef ülkelerde resmi marka/alan adı incelemesi yapılmalıdır.
- Sabit ürün adı: `N Keto Tracker`. `N` tek başına marka harfidir ve hiçbir zaman `Next`, `Neuro`, `Nourish`, `Nutrition` veya başka bir kelime şeklinde açılmaz.
- Sabit GitHub depo adı: `n-keto-tracker`.

### 22.2 İncelenen mevcut ürünler

| Ürün | 20 Eylül 2026 tarihli görünür sinyal | Öne çıkan yaklaşım | N Keto Tracker için ders |
|---|---|---|---|
| [Carb Manager — iOS](https://apps.apple.com/us/app/carb-manager-keto-macro-log/id410089731) / [Android](https://play.google.com/store/apps/details?id=com.wombatapps.carbmanager) | iOS 4,8/5 ve yaklaşık 735 bin değerlendirme; Android 4,8/5, yaklaşık 166 bin yorum ve 5 milyon+ indirme | Net karbonhidrat, barkod, 1 milyon+ besin, 5.000+ tarif, plan, fasting, glukoz/keton ve raporlar | Günlük makroları ilk bakışta anlaşılır göster; kapsam büyürken ana ekranı kalabalıklaştırma. Premium, hesap, topluluk ve bulut bağımlılığını kopyalama. |
| [Cronometer — iOS](https://apps.apple.com/us/app/cronometer-calorie-counter/id1145935738) | 4,8/5 ve yaklaşık 98 bin değerlendirme | Doğruluk, doğrulanmış besin verisi, ayrıntılı besin öğeleri ve güçlü raporlar | Veri kaynağı/provenance disiplinini örnek al; sıradan kullanıcıyı 95+ besin öğesiyle ilk ekranda boğma. |
| [Senza — iOS](https://apps.apple.com/us/app/senza-keto-fasting/id1038260828) | 4,8/5 ve yaklaşık 11 bin değerlendirme | 1,6 milyon besin, 5.000 tarif; yemek, fasting, uyku, ruh hali, ağırlık, glukoz ve ketonun birlikte kaydı | Öğün ve biyobelirteç bağlamlarını aynı zaman çizgisinde ilişkilendir; sosyal/bulut özelliklerini temel deneyime sokma. |
| [Keto.app — iOS](https://apps.apple.com/us/app/keto-diet-app-low-carb-manager/id1169054597) / [Android](https://play.google.com/store/apps/details?id=keto.droid.lappir.com.ketodiettracker) | iOS 4,6/5 ve yaklaşık 62 bin değerlendirme; Android 4,4/5, yaklaşık 9,5 bin yorum ve 1 milyon+ indirme | Basit makro ve net karbonhidrat takibi, barkod, plan, tarif ve grafik | Hızlı günlük akışını koru. Yorumlarda görülen porsiyon dönüşümü, kaybolan/tekrarlanan kayıt, çöken tarif ve çalışmayan barkod sorunlarını test kapısı yap. |
| [Keto Manager — iOS](https://apps.apple.com/us/app/keto-diet-app-keto-manager/id1475764462) | 4,7/5 ve yaklaşık 9,4 bin değerlendirme | Makro takibi, sesli giriş, alışkanlık serileri ve topluluk | Tekrar kaydı kolaylaştır; topluluk, yarışma ve dikkat dağıtan motivasyon mekaniklerini ekleme. |
| [MyMojoHealth — iOS](https://apps.apple.com/us/app/mymojohealth/id1591026859) | 4,7/5 ve yaklaşık 18 bin değerlendirme | Cihaz senkronizasyonu, manuel giriş, mg/dL veya mmol/L, GKI, etiket/not, filtre ve grafik | Glukoz+BHB+GKI akışını güçlü tut; donanım, hesap ve bulut zorunluluğu olmadan bütün işlevleri cihazda sun. Küçük yazı ve geciken senkronizasyon gibi erişilebilirlik/sahiplik sorunlarından kaçın. |
| [GKI Tracker — iOS](https://apps.apple.com/us/app/gki-tracker/id1452955250) | 3,8/5 ve 16 değerlendirme | Glukoz ve ketondan GKI, geçmiş, not, tarih değiştirme ve alışveriş listesi | Ölçüm tarih/saatini geriye dönük düzenlemeyi ilk sürümde destekle. Grafik ölçekleri BHB çizgisini görünmez hâle getirmemeli; GKI'yi “iyi/kötü” sağlık hükmüne dönüştürme. |
| [GKI Insights — iOS](https://apps.apple.com/us/app/gki-insights/id6748614520) | Yeni ve henüz yeterli değerlendirmesi yok | Öğün, uyku, fasting ve not bağlamı; haftalık trend; AI yorumları | Bağlam etiketlerini ve sade trendleri kullan; harici AI, otomatik tıbbi yorum ve “optimal durum” hükmünü kullanma. |
| [Go-Keto — Android](https://play.google.com/store/apps/details?id=com.goketo.goketo) | 10 bin+ indirme; 12 Haziran 2026 güncellemesi | mmol/L ve mg/dL, otomatik GKI, grafik, ağırlık ve ölçüm cihazı ekosistemi | Birimleri açık ve hatasız dönüştür; mağaza/donanım satışını kullanıcı deneyimine karıştırma. |

Rakamlar başarıyı tek başına kanıtlamaz. Büyük yorum hacmi dağıtım ve marka yaşını; yüksek puan ise seçilim, platform ve sürüm etkilerini de yansıtır. Tasarım kararları yalnızca puana değil; özellik kapsamına, güncelliğe, yorumlarda tekrarlanan problemlere, erişilebilirliğe ve veri pratiğine dayanmalıdır.

### 22.3 Kullanıcı ihtiyacı ve tekrarlanan sürtünmeler

Resmi mağaza sayfaları ve görünen kullanıcı yorumlarından çıkan başlangıç temaları:

1. **Kayıt hızı belirleyicidir.** Kullanıcılar aynı öğünü, favoriyi veya son kullanılanı birkaç dokunuşla yeniden eklemek ister. Araya giren premium pencereleri ve uzun formlar günlük alışkanlığı bozar.
2. **Besin ve porsiyon doğruluğu güvenin temelidir.** Yanlış marka, hatalı net karbonhidrat, `1/4 cup` gibi ölçülerin yanlış çevrilmesi ve belirsiz porsiyonlar doğrudan yanlış günlük toplam üretir.
3. **Veri kaybı kabul edilemez.** Kaybolan tarifler, silinen içerikler, yinelenen öğünler ve migration sonrası değişen toplamlar sağlık günlüğüne güveni bitirir.
4. **Grafik ölçeği anlamı değiştirebilir.** Glukoz, BHB ve GKI tek eksene zorlandığında küçük BHB değişimleri düz çizgi gibi görünebilir. Ayrı küçük grafikler veya açıkça etiketlenmiş bağımsız ölçekler tercih edilmelidir.
5. **Ölçümün bağlamı sayının kendisi kadar önemlidir.** Tarih/saat, açlık/tokluk, son öğün, uyku, egzersiz ve kullanıcı notu sonradan eklenebilmeli ve düzenlenebilmelidir.
6. **Paywall, reklam ve hesap zorunluluğu temel takibi engellediğinde kullanıcı kızar.** Bu projede reklam, abonelik ve hesap yoktur; çekirdek özelliklerin tamamı offline çalışır.
7. **“Her şeyi yapan” ekranlar yeni kullanıcıyı yorabilir.** Bilimsel ayrıntı ve ileri metrikler aşamalı gösterilmeli; ana ekran yalnızca bugünün özeti ve hızlı eylemleri taşımalıdır.
8. **AI fotoğraf/etiket okuma pazarda görünür hâle gelmiştir fakat offline doğruluk vaadiyle çelişebilir.** Bu üründe harici AI yoktur. İlk sürümde manuel arama, favori, son kullanılan, özel besin ve isteğe bağlı tamamen yerel barkod eşleştirmesi güvenilir çekirdektir.
9. **Kilo verme dili pazarda baskındır fakat bu ürünün tonu daha geniş ve sakindir.** “Dönüşüm”, “mucize”, “yağ yak”, “garantili ketozis” ve beden utandıran dil kullanılmamalıdır.

Bu özet nitel bir başlangıç taramasıdır; kullanıcılarla yapılmış bir kullanılabilirlik çalışması değildir. Kodlama ekibi 0.3'te istenen güncel ve daha geniş yorum örneklemesini tamamlamadan “kullanıcılar kesin olarak şunu istiyor” şeklinde nicel iddia kurmamalıdır.

### 22.4 Saha araştırmasından çıkan zorunlu ürün ve görsel yön

- Alt navigasyon: **Bugün / Günlük / Plan / Trendler / Rehber**. Ana eylem her ekranda tek ve belirgin olmalıdır.
- Bugün ekranında net karbonhidratı öne alan sade makro özeti, son glukoz, BHB ve hesaplanmış GKI için ayrı kartlar, sıradaki planlı öğün ve hızlı ekleme bulunmalıdır.
- Glukoz, BHB ve GKI trendlerini varsayılan olarak ayrı küçük grafiklerde göster. Birleşik grafik sunulursa eksenleri, birimleri ve normalizasyonu görünür kıl.
- Renk sistemi sakin Material 3 yüzeyleri, erişilebilir kontrast ve en fazla bir ana vurgu rengi kullanmalıdır. Kırmızı/yeşili tek anlam taşıyıcısı yapma; neon “keto”, alev, şimşek, beyin, hastane ve hastalık görsellerinden kaçın.
- Mağaza ekran görüntülerinin önerilen sırası: `Günün keto özeti` → `Öğünü hızla kaydet` → `Glukoz, keton ve GKI` → `Trendleri bağlamıyla gör` → `Plan, tarif ve alışveriş` → `Kaynaklı, sade rehber` → `Verilerin yalnızca cihazında`.
- Store görsellerinde büyük tek mesaj, gerçek uygulama ekranı, kısa yerelleştirilmiş başlık ve bol boşluk kullan. Rakiplerin ekran görüntüsü düzenini, metnini, renklerini veya ikonlarını kopyalama.
- İlk kullanımda zorunlu hesap, ödeme duvarı, sağlık iddiası veya uzun test yoktur. Kullanıcı isterse profili sonra tamamlayabilmelidir.
- “İyi/kötü GKI”, “ketozistesin/değilsin” veya “tedavi bölgesi” gibi kesin rozetler yerine ölçüm, eğilim, veri kalitesi ve kaynaklı araştırma bağlamı sunulmalıdır.

### 22.5 Konumlandırma ve promotion kararı

Önerilen tek cümlelik konumlandırma:

> **N Keto Tracker — private, open-source and fully offline keto, glucose, ketone and GKI tracking.**

Türkçe karşılığı yalnız açıklayıcı mağaza metninde kullanılabilir:

> **Tamamen offline çalışan, açık kaynaklı keto günlüğü; glukoz, keton ve GKI takibi.**

Tanıtım önceliği: (1) offline ve hesapsız mahremiyet, (2) hızlı keto/öğün günlüğü ve net karbonhidrat, (3) doğru birim dönüşümüyle glukoz+BHB+GKI, (4) bağlamlı grafikler, (5) plan/tarif/alışveriş, (6) kaynaklı sade eğitim. Hastalık, tedavi ve sağkalım iddiası tanıtımda kullanılmaz. Seyfried ve ilgili yayınlar pazarlama sloganı değil; yalnızca isteğe bağlı bilimsel kaynak kütüphanesinde, kanıt sınırlarıyla birlikte yer alır.

### 22.6 Bu taramanın geliştirme kabul kriterlerine dönüşümü

- Porsiyon ve birim dönüşümleri için tablo tabanlı birim testleri; yuvarlama ve locale testleri zorunlu.
- Drift migration, tarif/öğün bütünlüğü, yinelenen kayıt ve export/import round-trip testleri release engelleyicisidir.
- GKI grafikleri farklı büyüklükte glukoz ve BHB örnekleriyle golden/widget testinden geçmelidir.
- Öğün, ölçüm ve ağırlık girişlerinin her biri ana ekrandan en fazla üç dokunuşta başlayabilmelidir; kullanılabilirlik testi bunu ölçmelidir.
- Büyük yazı, ekran okuyucu etiketi, kontrast, dokunma alanı ve renk dışı durum anlatımı erişilebilirlik checklist'inde kanıtlanmalıdır.
- Release adayı uçak modunda ilk kurulumdan export'a kadar test edilmeli; ağ çağrısı olmadığını gösteren statik ve çalışma zamanı kanıtı saklanmalıdır.

---

## 23. Son yürütme talimatı

Önce gereksinim–kabul kriteri matrisi ve küçük bir uygulama planı oluştur. Sonra çalışan dikey dilimleri sırayla uygula. Mevcut Flutter/platform özelliklerini ve yukarıdaki kurulu paketleri yeniden icat etme; gereksiz servis, repository katmanı, kod üretimi veya bağımlılık ekleme. Sağlık güvenliğiyle ilgili bir gereksinimi “MVP” gerekçesiyle atlama.

Bir iddia için güvenilir kaynak yoksa içerik uydurma; özelliği güvenli biçimde sınırla ve `SCIENTIFIC_CONTENT.md` içinde açık konu olarak işaretle. Uygulama tamamlandığında test komutlarının gerçek çıktılarını, offline doğrulamasını ve release checklist sonucunu raporla.
