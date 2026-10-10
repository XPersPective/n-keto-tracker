#!/usr/bin/env python3
"""68 dil için mağaza listesi (STORE_LISTING_<code>.md) üretir.

SEO uyumlu: başlık (≤30), kısa açıklama (≤80), uzun açıklama
(anahtar kelimeler, GKI, keto, journal, offline, no ads), anahtar
kelimeler listesi. Hepsinde "no medical advice" feragatnamesi.
"""
import os

OUT_DIR = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '..', 'docs', 'marketing'
)
os.makedirs(OUT_DIR, exist_ok=True)

# 68 dil: code, native_name, subtitle, short, long, keywords
T = [
    ('en', 'English',
     'Keto Journal & GKI Tracker',
     'Private keto journal with offline glucose + BHB GKI calculator.',
     "N Keto Tracker is a private, open-source keto journal. Log meals, "
     "macros and net carbs; record glucose + blood ketones (BHB) in the "
     "same session and the app computes GKI with a transparent formula "
     "disclosure. Weight, symptoms, weekly meal plan and shopping list "
     "stay on your device. Your health data is never sent anywhere, no "
     "account needed. No ads, no purchases. Light and dark themes. 68 languages. "
     "This app is for general information only; not medical advice, "
     "diagnosis, or treatment.",
     ['keto', 'ketogenic', 'journal', 'macro', 'carb', 'GKI', 'glucose',
      'ketone', 'BHB', 'tracker', 'offline', 'private']),
    ('tr', 'Türkçe',
     'Keto Günlüğü ve GKI Takibi',
     'Çevrimdışı glukoz + BHB GKI hesaplayıcılı özel keto günlüğü.',
     "N Keto Tracker; gizliliğe önem veren, açık kaynaklı bir keto günlüğüdür. "
     "Öğün, makro ve net karbonhidrat kaydı; glukoz + kan ketonu (BHB) "
     "aynı oturumda girildiğinde GKI hesaplanır (formül açıkça gösterilir). "
     "Ağırlık, semptom, haftalık öğün planı ve alışveriş listesi cihazınızda kalır. "
     "Sağlık verileriniz hiçbir yere gönderilmez, hesap gerekmez. Reklam yok, "
     "satın alma yok. Açık ve koyu tema. 68 dil. Bu uygulama genel bilgilendirme "
     "içindir; tıbbi tavsiye, teşhis veya tedavi değildir.",
     ['keto', 'ketojenik', 'günlük', 'makro', 'karbonhidrat', 'GKI',
      'glukoz', 'keton', 'BHB', 'izleme', 'çevrimdışı', 'gizli']),

    ('de', 'Deutsch',
     'Keto-Tagebuch & GKI-Tracker',
     'Privates Keto-Tagebuch mit Offline-Glukose-+BHB-GKI-Rechner.',
     "N Keto Tracker ist ein privates, quelloffenes Keto-Tagebuch. Erfasse "
     "Mahlzeiten, Makros und Nettokohlenhydrate; Glukose + Blutketone (BHB) "
     "in derselben Sitzung ergeben GKI mit transparenter Formel-Offenlegung. "
     "Gewicht, Symptome, Wochenplan und Einkaufsliste bleiben auf dem Gerät. "
     "Deine Gesundheitsdaten verlassen das Gerät nie, kein Konto nötig. Keine "
     "Werbung, keine Käufe. Hell- und Dunkelthema. 68 Sprachen. Diese App ist "
     "nur zur allgemeinen Information; keine medizinische Beratung, Diagnose "
     "oder Behandlung.",
     ['keto', 'ketogen', 'tagebuch', 'makro', 'kohlenhydrate', 'GKI',
      'glukose', 'keton', 'BHB', 'tracker', 'offline', 'privat']),
    ('fr', 'Français',
     'Journal céto & suivi GKI',
     'Journal céto privé avec calculateur GKI glucose + BHB hors ligne.',
     "N Keto Tracker est un journal céto privé et open source. Enregistrez "
     "repas, macros et glucides nets ; glucose + cétones sanguines (BHB) dans "
     "la même séance donnent le GKI avec divulgation transparente de la formule. "
     "Poids, symptômes, plan hebdomadaire et liste de courses restent sur "
     "l'appareil. Vos données de santé ne vont nulle part, aucun compte requis. "
     "Pas de publicité, pas d'achat. Thèmes clair et sombre. 68 langues. Cette "
     "application est purement informative ; pas un avis médical, diagnostic "
     "ou traitement.",
     ['ceto', 'céto', 'journal', 'macro', 'glucide', 'GKI', 'glucose',
      'cétone', 'BHB', 'suivi', 'hors ligne', 'privé']),
    ('es', 'Español',
     'Diario keto y registro GKI',
     'Diario keto privado con calculadora GKI glucosa + BHB sin conexión.',
     "N Keto Tracker es un diario keto privado y de código abierto. Registra "
     "comidas, macros y carbohidratos netos; glucosa + cetonas en sangre (BHB) "
     "en la misma sesión calculan el GKI con divulgación transparente de la "
     "fórmula. Peso, síntomas, plan semanal y lista de compras quedan en el "
     "dispositivo. Tus datos de salud nunca salen, sin cuenta. Sin anuncios, "
     "sin compras. Temas claro y oscuro. 68 idiomas. Esta aplicación es solo "
     "informativa; no es consejo médico, diagnóstico ni tratamiento.",
     ['keto', 'cetogénica', 'diario', 'macro', 'carbohidrato', 'GKI',
      'glucosa', 'cetona', 'BHB', 'registro', 'sin conexión', 'privado']),
    ('it', 'Italiano',
     'Diario cheto e tracker GKI',
     'Diario cheto privato con calcolatrice GKI glucosio + BHB offline.',
     "N Keto Tracker è un diario cheto privato e open source. Registra pasti, "
     "macro e carboidrati netti; glucosio + chetoni nel sangue (BHB) nella "
     "stessa sessione calcolano il GKI con formula trasparente. Peso, sintomi, "
     "piano settimanale e lista della spesa restano sul dispositivo. I tuoi "
     "dati sanitari non escono mai, nessun account. Niente pubblicità, niente "
     "acquisti. Tema chiaro e scuro. 68 lingue. Questa app è solo informativa; "
     "non è consulenza medica, diagnosi o trattamento.",
     ['cheto', 'chetogenica', 'diario', 'macro', 'carboidrato', 'GKI',
      'glucosio', 'chetone', 'BHB', 'tracker', 'offline', 'privato']),
    ('pt', 'Português',
     'Diário keto e rastreador GKI',
     'Diário keto privado com calculadora GKI glicose + BHB offline.',
     "N Keto Tracker é um diário keto privado e de código aberto. Registe "
     "refeições, macros e carboidratos líquidos; glicose + cetonas (BHB) na "
     "mesma sessão calculam o GKI com divulgação transparente da fórmula. "
     "Peso, sintomas, plano semanal e lista de compras ficam no dispositivo. "
     "Os seus dados de saúde nunca saem, sem conta. Sem anúncios, sem compras. "
     "Tema claro e escuro. 68 idiomas. Esta aplicação é apenas informativa; "
     "não é conselho médico, diagnóstico ou tratamento.",
     ['keto', 'cetogénica', 'diário', 'macro', 'carboidrato', 'GKI',
      'glicose', 'cetona', 'BHB', 'rastreador', 'offline', 'privado']),
    ('ru', 'Русский',
     'Кето-дневник и трекер ГКИ',
     'Приватный кето-дневник с офлайн ГКИ глюкоза + BHB калькулятором.',
     "N Keto Tracker — приватный, открытый кето-дневник. Записывайте блюда, "
     "макросы и чистые углеводы; глюкоза + кетоны крови (BHB) в одной сессии "
     "дают ГКИ с прозрачной формулой. Вес, симптомы, недельный план и список "
     "покупок остаются на устройстве. Данные никуда не уходят, аккаунт не "
     "нужен. Нет рекламы, нет покупок. Светлая и тёмная темы. 68 языков. Это "
     "приложение — общая информация; не медицинский совет, диагноз или "
     "лечение.",
     ['кето', 'кетогенная', 'дневник', 'макрос', 'углеводы', 'ГКИ',
      'глюкоза', 'кетон', 'BHB', 'трекер', 'офлайн', 'приватно']),
    ('ar', 'العربية',
     'يوميات كيتو ومتتبع GKI',
     'يوميات كيتو خاصة مع حاسبة GKI للجلوكوز + BHB دون اتصال.',
     "N Keto Tracker يوميات كيتو خاصة ومفتوحة المصدر. سجّل الوجبات "
     "والماكروز والكربوهيدرات الصافية؛ الجلوكوز + كيتونات الدم (BHB) في "
     "الجلسة نفسها تحسب GKI مع كشف الصيغة بشفافية. الوزن والأعراض والخطة "
     "الأسبوعية وقائمة التسوق تبقى على الجهاز. بياناتك الصحية لا تغادر "
     "الجهاز، لا حاجة لحساب. لا إعلانات، لا مشتريات. فاتح وداكن. 68 لغة. "
     "هذا التطبيق للمعلومات العامة فقط؛ ليس نصيحة طبية أو تشخيصًا أو علاجًا.",
     ['كيتو', 'كيتوجينية', 'يوميات', 'ماكرو', 'كربوهيدرات', 'GKI',
      'جلوكوز', 'كيتون', 'BHB', 'متتبع', 'دون اتصال', 'خاص']),
    ('ja', '日本語',
     'ケト日記とGKIトラッカー',
     'オフラインの血糖値+BHB GKI計算機付きプライベートケト日記。',
     "N Keto Trackerはプライベートでオープンソースのケト日記です。食事、"
     "マクロ、純炭水化物を記録。同じセッションで血糖値と血中ケトン体(BHB)"
     "を入力するとGKIを計算し、式を透明に開示します。体重、症状、週間計画、"
     "買い物リストはデバイス上に留まります。健康データが外部に出ることは"
     "なく、アカウント不要。広告なし、課金なし。ライト・ダークテーマ。68言語。"
     "本アプリは一般的な情報提供のみ。医学的助言・診断・治療ではありません。",
     ['ケト', 'ケトジェニック', '日記', 'マクロ', '炭水化物', 'GKI',
      '血糖', 'ケトン', 'BHB', 'トラッカー', 'オフライン', 'プライベート']),
    ('ko', '한국어',
     '키토 일지 & GKI 추적기',
     '오프라인 혈당 + BHB GKI 계산기 포함 사설 키토 일지.',
     "N Keto Tracker는 사설 오픈소스 키토 일지입니다. 식사, 매크로, 순수 "
     "탄수화물을 기록하고, 같은 세션에서 혈당 + 혈중 케톤(BHB)을 입력하면 "
     "GKI를 계산하며 공식을 투명하게 공개합니다. 체중, 증상, 주간 계획, "
     "장보기 목록은 기기에만 남습니다. 건강 데이터는 외부로 나가지 않으며 "
     "계정이 필요 없습니다. 광고 없음, 구매 없음. 라이트/다크 테마. 68개 "
     "언어. 본 앱은 일반 정보 제공용이며 의학적 조언·진단·치료가 아닙니다.",
     ['키토', '키토제닉', '일지', '매크로', '탄수화물', 'GKI', '혈당',
      '케톤', 'BHB', '추적기', '오프라인', '사설']),
    ('zh', '中文',
     '生酮日记与GKI追踪器',
     '离线血糖+BHB GKI计算器的私密生酮日记。',
     "N Keto Tracker是一款私密、开源的生酮日记。记录餐食、宏量营养素"
     "和净碳水；同一次会话中输入血糖与血酮(BHB)即可计算GKI并透明展示"
     "公式。体重、症状、每周饮食计划和购物清单都保留在您的设备上。健康"
     "数据绝不上传，无需账号。无广告、无内购。浅色与深色主题。68种语言。"
     "本应用仅提供一般信息；不构成医疗建议、诊断或治疗。",
     ['生酮', '生酮饮食', '日记', '宏量', '碳水', 'GKI', '血糖',
      '酮体', 'BHB', '追踪', '离线', '私密']),
    ('zh_Hant', '繁體中文',
     '生酮日記與GKI追蹤器',
     '離線血糖+BHB GKI計算器的私密生酮日記。',
     "N Keto Tracker 是一款私密、開源的生酮日記。記錄餐食、巨量營養素"
     "與淨碳水；同一次會話中輸入血糖與血酮(BHB)即可計算 GKI 並透明展示"
     "公式。體重、症狀、每週飲食計畫與購物清單都保留在您的裝置上。健康"
     "資料絕不上傳，無需帳號。無廣告、無內購。淺色與深色主題。68 種語言。"
     "本應用僅提供一般資訊；不構成醫療建議、診斷或治療。",
     ['生酮', '生酮飲食', '日記', '巨量', '碳水', 'GKI', '血糖',
      '酮體', 'BHB', '追蹤', '離線', '私密']),
    ('hi', 'हिन्दी',
     'कीटो डायरी और GKI ट्रैकर',
     'ऑफलाइन ग्लूकोज + BHB GKI कैल्क्युलेटर के साथ निजी कीटो डायरी।',
     "N Keto Tracker एक निजी, ओपन-सोर्स कीटो डायरी है। भोजन, मैक्रो और "
     "नेट कार्ब्स रिकॉर्ड करें; एक ही सत्र में ग्लूकोज + रक्त कीटोन (BHB) "
     "दर्ज करने पर पारदर्शी सूत्र के साथ GKI की गणना होती है। वज़न, लक्षण, "
     "साप्ताहिक योजना और खरीदारी सूची आपके डिवाइस पर रहती है। आपका स्वास्थ्य "
     "डेटा कहीं नहीं जाता, किसी खाते की ज़रूरत नहीं। कोई विज्ञापन नहीं, कोई "
     "खरीद नहीं। हल्की और गहरी थीम। 68 भाषाएँ। यह ऐप केवल सामान्य जानकारी "
     "के लिए है; यह चिकित्सा सलाह, निदान या उपचार नहीं है।",
     ['कीटो', 'कीटोजेनिक', 'डायरी', 'मैक्रो', 'कार्ब', 'GKI', 'ग्लूकोज',
      'कीटोन', 'BHB', 'ट्रैकर', 'ऑफलाइन', 'निजी']),

    # Kalan 53 dil — kısa şablonla
    ('af', 'Afrikaans',
     'Keto Dagboek & GKI',
     'Privaat keto-dagboek met aflyn glukose + BHB GKI sakrekenaar.',
     "N Keto Tracker is 'n private, oopbron keto-dagboek. Teken maaltye, "
     "makros en netto koolhidrate; glukose + bloedketone (BHB) in dieselfde "
     "sessie bereken GKI met 'n deursigtige formule. Gewig, simptome, "
     "weeklikse plan en inkopielys bly op jou toestel. Jou gesondheidsdata "
     "gaan nêrens heen, geen rekening nodig nie. Geen advertensies, geen "
     "aankope nie. Lig en donker temas. 68 tale. Hierdie app is slegs vir "
     "algemene inligting; nie mediese advies, diagnose of behandeling nie.",
     ['keto', 'dagboek', 'makro', 'GKI', 'glukose', 'BHB']),
    ('az', 'Azərbaycanca',
     'Keto Gündəlik və GKI',
     'Offline qlükoza + BHB GKI kalkulyatoru ilə özəl keto gündəlik.',
     "N Keto Tracker özəl, açıq mənbəli keto gündəliyidir. Yemək, makro və "
     "xalis karbohidratları qeyd edin; eyni sessiyada qlükoza + qan ketonu "
     "(BHB) şəffaf formulu ilə GKI hesablayır. Çəki, simptomlar, həftəlik "
     "plan və alış-veriş siyahısı cihazınızda qalır. Sağlamlıq məlumatlarınız "
     "heç yerə göndərilmir, hesab tələb olunmur. Reklam yoxdur, alış yoxdur. "
     "Açıq və tünd mövzu. 68 dil. Bu tətbiq yalnız ümumi məlumat üçündür; "
     "tibbi məsləhət, diaqnoz və ya müalicə deyil.",
     ['keto', 'gündəlik', 'makro', 'GKI', 'qlükoza', 'BHB']),
    ('be', 'Беларуская',
     'Кето-даннік і трэкер ГКІ',
     'Прыватны кето-даннік з аўлайн-калькулятарам ГКІ (глюкоза + BHB).',
     "N Keto Tracker — прыватны, адкрыты кето-даннік. Запісвайце стравы, "
     "макры і чыстыя вугляводы; глюкоза + кетоны крыві (BHB) у адной сесіі "
     "лічаць ГКІ з празрыстай формулай. Вага, сімптомы, тыднёвы план і "
     "спіс пакупак застаюцца на прыладзе. Здароўе нікуды не сыходзіць, рахунак "
     "не патрэбны. Без рэкламы, без пакупак. Светлая і цёмная тэмы. 68 моў. "
     "Гэта дадатак толькі для агульнай інфармацыі; не медыцынская парада, "
     "дыягназ або лячэнне.",
     ['кето', 'даннік', 'макры', 'ГКІ', 'глюкоза', 'BHB']),
    ('bg', 'Български',
     'Кето дневник и GKI тракер',
     'Частен кето дневник с офлайн GKI калкулатор за глюкоза + BHB.',
     "N Keto Tracker е частен, отворен кето дневник. Записвайте хранения, "
     "макроси и нетни въглехидрати; глюкоза + кръвни кетони (BHB) в една "
     "сесия изчисляват GKI с прозрачна формула. Тегло, симптоми, седмичен "
     "план и списък за пазаруване остават на устройството. Здравните ви "
     "данни не напускат устройството, без акаунт. Без реклами, без покупки. "
     "Светла и тъмна тема. 68 езика. Това приложение е само за обща "
     "информация; не е медицински съвет, диагноза или лечение.",
     ['кето', 'дневник', 'макрос', 'GKI', 'глюкоза', 'BHB']),
    ('bn', 'বাংলা',
     'কিটো ডায়েরি ও GKI ট্র্যাকার',
     'অফলাইন গ্লুকোজ + BHB GKI ক্যালকুলেটর সহ ব্যক্তিগত কিটো ডায়েরি।',
     "N Keto Tracker একটি ব্যক্তিগত, ওপেন-সোর্স কিটো ডায়েরি। খাবার, "
     "ম্যাক্রো এবং নিট কার্ব রেকর্ড করুন; একই সেশনে গ্লুকোজ + রক্তের "
     "কিটোন (BHB) লিখলে স্বচ্ছ সূত্র সহ GKI গণনা হয়। ওজন, উপসর্গ, সাপ্তাহিক "
     "পরিকল্পনা ও কেনাকাটার তালিকা আপনার ডিভাইসে থাকে। স্বাস্থ্য ডেটা "
     "কোথাও যায় না, অ্যাকাউন্ট লাগে না। বিজ্ঞাপন নেই, কেনাকাটা নেই। হালকা "
     "ও অন্ধকার থিম। ৬৮টি ভাষা। এই অ্যাপ শুধু সাধারণ তথ্যের জন্য; চিকিৎসা "
     "পরামর্শ, রোগ নির্ণয় বা চিকিৎসা নয়।",
     ['কিটো', 'ডায়েরি', 'ম্যাক্রো', 'GKI', 'গ্লুকোজ', 'BHB']),
    ('ca', 'Català',
     'Diari keto i GKI',
     'Diari keto privat amb calculadora GKI glucosa + BHB sense connexió.',
     "N Keto Tracker és un diari keto privat i de codi obert. Registra "
     "àpats, macros i carbohidrats nets; glucosa + cetones en sang (BHB) "
     "en la mateixa sessió calculen el GKI amb una fórmula transparent. "
     "Pes, símptomes, pla setmanal i llista de compres es queden al "
     "dispositiu. Les teves dades de salut no surten mai, sense compte. "
     "Sense anuncis, sense compres. Tema clar i fosc. 68 idiomes. Aquesta "
     "aplicació és només informativa; no és consell mèdic, diagnòstic ni "
     "tractament.",
     ['keto', 'diari', 'màcro', 'GKI', 'glucosa', 'BHB']),
    ('cs', 'Čeština',
     'Keto deník a GKI',
     'Soukromý keto deník s offline GKI kalkulátorem glukóza + BHB.',
     "N Keto Tracker je soukromý open-source keto deník. Zaznamenávejte "
     "jídla, makra a čisté sacharidy; glukóza + ketony v krvi (BHB) ve "
     "stejné relaci počítají GKI s transparentní formulí. Váha, příznaky, "
     "týdenní plán a nákupní seznam zůstávají v zařízení. Vaše zdravotní "
     "data nikam neodcházejí, žádný účet. Žádné reklamy, žádné nákupy. "
     "Světlý a tmavý motiv. 68 jazyků. Tato aplikace slouží pouze k obecným "
     "informacím; není lékařskou radou, diagnózou ani léčbou.",
     ['keto', 'deník', 'makro', 'GKI', 'glukóza', 'BHB']),
    ('da', 'Dansk',
     'Keto-dagbog og GKI',
     'Privat keto-dagbog med offline glukose + BHB GKI-beregner.',
     "N Keto Tracker er en privat open source keto-dagbog. Log måltider, "
     "makroer og netto kulhydrater; glukose + blodketoner (BHB) i samme "
     "session beregner GKI med en gennemsigtig formel. Vægt, symptomer, "
     "ugeplan og indkøbsliste bliver på enheden. Dine sundhedsdata forlader "
     "aldrig enheden, ingen konto nødvendig. Ingen reklamer, ingen køb. "
     "Lys og mørk tema. 68 sprog. Denne app er kun til generel information; "
     "ikke lægefaglig rådgivning, diagnose eller behandling.",
     ['keto', 'dagbog', 'makro', 'GKI', 'glukose', 'BHB']),
    ('el', 'Ελληνικά',
     'Κετο-ημερολόγιο & GKI',
     'Ιδιωτικό κετο-ημερολόγιο με offline GKI γλυκόζη + BHB.',
     "Το N Keto Tracker είναι ένα ιδιωτικό κετο-ημερολόγιο ανοιχτού "
     "κώδικα. Καταγράψτε γεύματα, μακροθρεπτικά και καθαρούς υδατάνθρακες· "
     "γλυκόζη + κετόνες αίματος (BHB) στην ίδια συνεδρία υπολογίζουν GKI "
     "με διαφανή τύπο. Βάρος, συμπτώματα, εβδομαδιαίο πλάνο και λίστα "
     "αγορών μένουν στη συσκευή. Τα δεδομένα υγείας σας δεν φεύγουν ποτέ, "
     "χωρίς λογαριασμό. Χωρίς διαφημίσεις, χωρίς αγορές. Φωτεινό και "
     "σκοτεινό θέμα. 68 γλώσσες. Η εφαρμογή είναι μόνο για γενικές "
     "πληροφορίες· δεν αποτελεί ιατρική συμβουλή, διάγνωση ή θεραπεία.",
     ['κετο', 'ημερολόγιο', 'μακρο', 'GKI', 'γλυκόζη', 'BHB']),
    ('et', 'Eesti',
     'Keto-päevik ja GKI',
     'Privaatne keto-päevik võrguühenduseta glükoos + BHB GKI-ga.',
     "N Keto Tracker on privaatne avatud lähtekoodiga keto-päevik. Logi "
     "söögikorrad, makrod ja netosüsivesikud; glükoos + vere ketoonid "
     "(BHB) samas seansis arvutavad GKI läbipaistva valemiga. Kaal, "
     "sümptomid, nädala plaan ja ostunimekiri jäävad seadmesse. Teie "
     "terviseandmed ei lähe kuhugi, kontot pole vaja. Reklaamid puuduvad, "
     "ostud puuduvad. Hele ja tume teema. 68 keelt. See rakendus on ainult "
     "üldiseks teabeks; ei ole meditsiiniline nõuanne, diagnoos ega ravi.",
     ['keto', 'päevik', 'makro', 'GKI', 'glükoos', 'BHB']),
    ('eu', 'Euskara',
     'Keto egunkaria eta GKI',
     'Keto egunkari pribatua lineaz kanpoko glukosa + BHB GKI kalkulagailuarekin.',
     "N Keto Tracker keto egunkari pribatu eta kode irekikoa da. Erregistratu "
     "janariak, makroak eta karbono hidrato garbiak; glukosa + odoleko "
     "ketonak (BHB) saio berean GKI kalkulatzen dute formula gardenarekin. "
     "Pisua, sintomak, asteroko plana eta erosketa-zerrenda gailuan "
     "geratzen dira. Zure osasun-datuak ez dira inora joaten, konturik "
     "beharrik ez. Ez iragarkirik, ez erosketarik. Gai argia eta iluna. "
     "68 hizkuntza. Aplikazio hau informazio ororrerako soilik da; ez da "
     "aholku medikoa, diagnosia edo tratamendua.",
     ['keto', 'egunkari', 'makro', 'GKI', 'glukosa', 'BHB']),
    ('fa', 'فارسی',
     'دفتر کتو و ردیاب GKI',
     'دفتر کتو خصوصی با ماشین‌حساب آفلاین GKI گلوکز + BHB.',
     "N Keto Tracker یک دفتر کتو خصوصی و متن‌باز است. وعده‌ها، ماکروها و "
     "کربوهیدرات خالص را ثبت کنید؛ گلوکز + کتون خون (BHB) در همان جلسه "
     "GKI را با فرمول شفاف محاسبه می‌کند. وزن، علائم، برنامه هفتگی و "
     "فهرست خرید در دستگاه می‌ماند. داده‌های سلامت شما جایی نمی‌رود، حسابی "
     "لازم نیست. بدون تبلیغ، بدون خرید. پوسته روشن و تیره. ۶۸ زبان. این "
     "برنامه فقط برای اطلاعات عمومی است؛ توصیه پزشکی، تشخیص یا درمان نیست.",
     ['کتو', 'دفتر', 'ماکرو', 'GKI', 'گلوکز', 'BHB']),
    ('fi', 'Suomi',
     'Keto-päiväkirja ja GKI',
     'Yksityinen keto-päiväkirja offline-glukoosi + BHB GKI -laskurilla.',
     "N Keto Tracker on yksityinen avoimen lähdekoodin keto-päiväkirja. "
     "Kirjaa ateriat, makrot ja nettokarbohydraatit; glukoosi + "
     "veriketonit (BHB) samassa istunnossa laskevat GKI:n avoimella "
     "kaavalla. Paino, oireet, viikkosuunnitelma ja ostoslista pysyvät "
     "laitteella. Terveystietosi eivät lähde minnekään, tiliä ei tarvita. "
     "Ei mainoksia, ei ostoja. Vaalea ja tumma teema. 68 kieltä. Tämä sovellus "
     "on vain yleistä tietoa varten; ei lääketieteellistä neuvoa, diagnoosia "
     "tai hoitoa.",
     ['keto', 'päiväkirja', 'makro', 'GKI', 'glukoosi', 'BHB']),
    ('fil', 'Filipino',
     'Keto diary at GKI',
     'Pribadong keto diary na may offline na GKI glukosa + BHB.',
     "Ang N Keto Tracker ay pribadong open-source na keto diary. Itala "
     "ang mga pagkain, macro at net carbs; glukosa + blood ketones (BHB) "
     "sa iisang sesyon ay nagko-kompyut ng GKI na may transparent na "
     "formula. Timbang, sintomas, lingguhang plano at shopping list ay "
     "nananatili sa device. Hindi lumalabas ang iyong data sa kalusugan, "
     "walang account. Walang ad, walang binibili. Light at dark na tema. "
     "68 wika. Ang app na ito ay para sa pangkalahatang impormasyon lamang; "
     "hindi medikal na payo, diagnosis o gamot.",
     ['keto', 'diary', 'macro', 'GKI', 'glukosa', 'BHB']),
    ('gl', 'Galego',
     'Diario keto e GKI',
     'Diario keto privado con calculadora GKI glucosa + BHB sen conexión.',
     "N Keto Tracker é un diario keto privado e de código aberto. Rexistra "
     "comidas, macros e carbohidratos netos; glucosa + cetonas en sangue "
     "(BHB) na mesma sesión calculan o GKI con fórmula transparente. Peso, "
     "síntomas, plan semanal e lista da compra quedan no dispositivo. Os "
     "teus datos de saúde non saen, sen conta. Sen anuncios, sen compras. "
     "Tema claro e escuro. 68 idiomas. Esta aplicación é só informativa; "
     "non é consello médico, diagnóstico nin tratamento.",
     ['keto', 'diario', 'macro', 'GKI', 'glucosa', 'BHB']),
    ('gu', 'ગુજરાતી',
     'કીટો ડાયરી અને GKI',
     'ઓફલાઇન ગ્લુકોઝ + BHB GKI કેલ્ક્યુલેટર સાથે ખાનગી કીટો ડાયરી.',
     "N Keto Tracker એ ખાનગી, ઓપન-સોર્સ કીટો ડાયરી છે. ભોજન, મેક્રો અને "
     "નેટ કાર્બ્સ રેકોર્ડ કરો; એ જ સેશનમાં ગ્લુકોઝ + બ્લડ કીટોન (BHB) "
     "પારદર્શક સૂત્ર સાથે GKI ગણે છે. વજન, લક્ષણો, સાપ્તાહિક યોજના અને "
     "ખરીદી યાદી ઉપકરણ પર રહે છે. તમારો આરોગ્ય ડેટા ક્યાંય જતો નથી, એકાઉન્ટ "
     "જરૂરી નથી. કોઈ જાહેરાત નહીં, કોઈ ખરીદી નહીં. લાઇટ અને ડાર્ક થીમ. 68 "
     "ભાષાઓ. આ એપ ફક્ત સામાન્ય માહિતી માટે છે; તે તબીબી સલાહ, નિદાન અથવા "
     "સારવાર નથી.",
     ['કીટો', 'ડાયરી', 'મેક્રો', 'GKI', 'ગ્લુકોઝ', 'BHB']),
    ('he', 'עברית',
     'יומן קיטו ו-GKI',
     'יומן קיטו פרטי עם מחשבון GKI ללא חיבור לגלוקוז + BHB.',
     "N Keto Tracker הוא יומן קיטו פרטי וקוד פתוח. תיעוד ארוחות, מאקרו "
     "ופחמימות נטו; גלוקוז + קטונים בדם (BHB) באותו סשן מחשבים GKI עם נוסחה "
     "שקופה. משקל, תסמינים, תוכנית שבועית ורשימת קניות נשארים במכשיר. "
     "נתוני הבריאות שלך לא יוצאים מהמכשיר, ללא חשבון. אין פרסומות, אין "
     "רכישות. ערכות בהירות וכהות. 68 שפות. האפליקציה למידע כללי בלבד; "
     "אינה ייעוץ רפואי, אבחון או טיפול.",
     ['קיטו', 'יומן', 'מאקרו', 'GKI', 'גלוקוז', 'BHB']),
    ('hr', 'Hrvatski',
     'Keto dnevnik i GKI',
     'Privatni keto dnevnik s offline GKI kalkulatorom glukoze + BHB.',
     "N Keto Tracker je privatni keto dnevnik otvorenog koda. Bilježite "
     "obroke, makro i neto ugljikohidrate; glukoza + ketoni u krvi (BHB) "
     "u istoj sesiji računaju GKI s transparentnom formulom. Težina, "
     "simptomi, tjedni plan i lista za kupnju ostaju na uređaju. Vaši "
     "zdravstveni podaci ne izlaze, bez računa. Bez oglasa, bez kupnji. "
     "Svijetla i tamna tema. 68 jezika. Ova aplikacija je samo za opće "
     "informacije; nije medicinski savjet, dijagnoza ili liječenje.",
     ['keto', 'dnevnik', 'makro', 'GKI', 'glukoza', 'BHB']),
    ('hu', 'Magyar',
     'Keto napló és GKI',
     'Privát keto napló offline glükóz + BHB GKI számológéppel.',
     "Az N Keto Tracker egy privát, nyílt forráskódú keto napló. Rögzíts "
     "étkezéseket, makrót és nettó szénhidrátot; a glükóz + vérketonok "
     "(BHB) ugyanabban a munkamenetben átlátható képlettel számítja a "
     "GKI-t. Súly, tünetek, heti terv és bevásárlólista a készüléken "
     "marad. Az egészségügyi adataid sehova sem mennek, nincs fiók. Nincs "
     "reklám, nincs vásárlás. Világos és sötét téma. 68 nyelv. Ez az "
     "alkalmazás csak általános tájékoztatásra szolgál; nem orvosi "
     "tanács, diagnózis vagy kezelés.",
     ['keto', 'napló', 'makro', 'GKI', 'glükóz', 'BHB']),
    ('hy', 'Հայերեն',
     'Կետո օրագիր և GKI',
     'Անձնական կետո օրագիր օֆլայն գլյուկոզ + BHB GKI հաշվիչով.',
     "N Keto Tracker-ը անձնական, բաց կոդով կետո օրագիր է: Գրանցեք ուտեստեսքը, "
     "մակրոն և զուտ ածխաջրերը; գլյուկոզ + արյան կետոնները (BHB) նույն սեսիայում "
     "հաշվարկում են GKI թափանցիկ բանաձևով: Քաշը, ախտանիշները, շաբաթական "
     "պլանը և գնումների ցուցակը մնում են սարքում: Ձեր առողջության տվյալները "
     "ոչ մի տեղ չեն գնում, հաշիվ պետք չէ: Գովազdelays չկա, գնումներ չկան: "
     "Բաց և մուգ ոճ: 68 լեզուներ: Այս հավելվածը միայն ընդհանուր տեղեկատվության "
     "համար է; բժշկական խորհրդատվություն, ախտորոշում կամ բուժում չէ:",
     ['կետո', 'օրագիր', 'մակրո', 'GKI', 'գլյուկոզ', 'BHB']),
    ('id', 'Bahasa Indonesia',
     'Buku keto & pelacak GKI',
     'Buku keto pribadi dengan kalkulator GKI glukosa + BHB offline.',
     "N Keto Tracker adalah buku keto pribadi dan sumber terbuka. Catat "
     "makanan, makro, dan karbohidrat bersih; glukosa + keton darah (BHB) "
     "dalam sesi yang sama menghitung GKI dengan formula transparan. "
     "Berat, gejala, rencana mingguan, dan daftar belanja tetap di "
     "perangkat. Data kesehatan Anda tidak pernah keluar, tanpa akun. "
     "Tanpa iklan, tanpa pembelian. Tema terang dan gelap. 68 bahasa. "
     "Aplikasi ini hanya untuk informasi umum; bukan saran medis, "
     "diagnosis, atau perawatan.",
     ['keto', 'buku', 'makro', 'GKI', 'glukosa', 'BHB']),
    ('is', 'Íslenska',
     'Keto dagbók og GKI',
     'Einkarekin keto dagbók með offline GKI reikni glukósa + BHB.',
     "N Keto Tracker er einkarekin opinn keto dagbók. Skráðu máltíðir, "
     "makro og nettó kolvetni; glúkósi + blóðketon (BHB) í sömu lotu "
     "reiknar GKI með gagnsæju formúlu. Þyngd, einkenni, vikuleg áætlun "
     "og innkaupalisti haldast á tækinu. Heilsufarsgögn þín fara ekki "
     "neitt, enginn reikningur nauðsynlegur. Engar auglýsingar, engin "
     "kaup. Ljós og dökkt þema. 68 tungumál. Þetta forrit er aðeins fyrir "
     "almennar upplýsingar; er ekki læknisráðgjöf, greining eða meðferð.",
     ['keto', 'dagbók', 'makro', 'GKI', 'glúkósi', 'BHB']),
    ('ka', 'ქართული',
     'კეტო დღიური და GKI',
     'პირადი კეტო დღიური ოფლაინ GKI გლუკოზა + BHB კალკულატორით.',
     "N Keto Tracker არის პირადი, ღია კოდის კეტო დღიური. ჩაწერეთ კვება, "
     "მაკრო და წმინდა ნახშირწყლები; გლუკოზა + სისხლის კეტონები (BHB) "
     "ერთსა და იმავე სესიაზე გამოთვლის GKI-ს გამჭვიროვანე ფორმულით. "
     "წონა, სიმპტომები, კვირეული გეგმა და საყიდველო სია რჩება მოწყობილობაზე. "
     "თქვენი ჯანმრთელობის მონაცემები არსად გადის, ანგარიში არ არის საჭირო. "
     "რეკლამა არ არის, ყიდვა არ არის. ნათელი და მუქი თემა. 68 ენა. ეს "
     "აპი მხოლოდ ზოგადი ინფორმაციისთვისაა; არ არის სამედიცინო რჩევა, "
     "დიაგნოზი ან მკურნალობა.",
     ['კეტო', 'დღიური', 'მაკრო', 'GKI', 'გლუკოზა', 'BHB']),
    ('kk', 'Қазақша',
     'Кето күнделік және GKI',
     'Жеке кето күнделік офлайн глюкоза + BHB GKI калькуляторымен.',
     "N Keto Tracker — жеке, ашық кодты кето күнделік. Тамақ, макро және "
     "таза көмірсуларды жазыңыз; глюкоза + қан кетондары (BHB) бір сессияда "
     "ашық формуламен GKI есептейді. Салмақ, белгілер, апталық жоспар және "
     "сатып алу тізімі құрылғыда қалады. Денсаулық деректеріңіз ешқайда "
     "кетпейді, тіркелгі қажет емес. Жарнама жоқ, сатып алу жоқ. Ашық және "
     "қараңғы тақырып. 68 тіл. Бұл қолданба тек жалпы ақпарат үшін; медициналық "
     "кеңес, диагноз немесе емдеу емес.",
     ['кето', 'күнделік', 'макро', 'GKI', 'глюкоза', 'BHB']),
    ('kn', 'ಕನ್ನಡ',
     'ಕೀಟೋ ಡೈರಿ ಮತ್ತು GKI',
     'ಆಫ್‌ಲೈನ್ ಗ್ಲೂಕೋಸ್ + BHB GKI ಕ್ಯಾಲ್ಕ್ಯುಲೇಟರ್‌ನೊಂದಿಗೆ ಖಾಸಗಿ ಕೀಟೋ ಡೈರಿ.',
     "N Keto Tracker ಒಂದು ಖಾಸಗಿ, ಮುಕ್ತ-ಮೂಲದ ಕೀಟೋ ಡೈರಿ. ಊಟ, ಮ್ಯಾಕ್ರೋ ಮತ್ತು "
     "ನಿವ್ವಳ ಕಾರ್ಬ್‌ಗಳನ್ನು ದಾಖಲಿಸಿ; ಒಂದೇ ಸೆಷನ್‌ನಲ್ಲಿ ಗ್ಲೂಕೋಸ್ + ರಕ್ತ ಕೀಟೋನ್ (BHB) "
     "ಪಾರದರ್ಶಕ ಸೂತ್ರದೊಂದಿಗೆ GKI ಲೆಕ್ಕ ಹಾಕುತ್ತದೆ. ತೂಕ, ಲಕ್ಷಣಗಳು, ವಾರದ ಯೋಜನೆ ಮತ್ತು "
     "ಶಾಪಿಂಗ್ ಪಟ್ಟಿ ಸಾಧನದಲ್ಲೇ ಉಳಿಯುತ್ತದೆ. ನಿಮ್ಮ ಆರೋಗ್ಯ ಡೇಟಾ ಎಲ್ಲಿಗೂ ಹೋಗುವುದಿಲ್ಲ, "
     "ಖಾತೆ ಬೇಡ. ಜಾಹೀರಾತು ಇಲ್ಲ, ಖರೀದಿ ಇಲ್ಲ. ಬೆಳಕು ಮತ್ತು ಕತ್ತಲು ಥೀಮ್. 68 ಭಾಷೆಗಳು. "
     "ಈ ಆಪ್ ಸಾಮಾನ್ಯ ಮಾಹಿತಿಗಾಗಿ ಮಾತ್ರ; ವೈದ್ಯಕೀಯ ಸಲಹೆ, ರೋಗನಿರ್ಣಯ ಅಥವಾ ಚಿಕಿತ್ಸೆ ಅಲ್ಲ.",
     ['ಕೀಟೋ', 'ಡೈರಿ', 'ಮ್ಯಾಕ್ರೋ', 'GKI', 'ಗ್ಲೂಕೋಸ್', 'BHB']),
    ('ky', 'Кыргызча',
     'Кето күндөлүк жана GKI',
     'Жеке кето күндөлүк оффлайн глюкоза + BHB GKI эсептегич.',
     "N Keto Tracker — жеке, ачык коду бар кето күндөлүк. Тамак, макро жана "
     "таза углеводдорду жазыңыз; глюкоза + кан кетондору (BHB) бир сессияда "
     "ачык формула менен GKI эсептейт. Салмак, белгилер, жумалык план жана "
     "сатып алуу тизмеси түзүлүштө калат. Сиздин ден соолук маалыматыңыз "
     "эч жакка кетпейт, аккаунт керек эмес. Жарнама жок, сатып алуу жок. "
     "Ачык жана караңгы тема. 68 тил. Бул колдонмо жалпы маалымат үчүн гана; "
     "медициналык кеңеш, диагноз же дарылоо эмес.",
     ['кето', 'күндөлүк', 'макро', 'GKI', 'глюкоза', 'BHB']),
    ('lo', 'ລາວ',
     'ບັນທຶກ keto ແລະ GKI',
     'ບັນທຶກ keto ສ່ວນຕົວ ມີເຄື່ອງຄິດໄລ່ GKI ອອບລາຍ.',
     "N Keto Tracker ເປັນບັນທຶກ keto ສ່ວນຕົວ ທີ່ເປັນ open-source. ບັນທຶກອາຫານ, "
     "macro ແລະ carb ສຸດທິ; ກູໂຄສ + ketone ໃນເລືອດ (BHB) ໃນ session ດຽວກັນ "
     "ຄິດໄລ່ GKI ດ້ວຍສູດໂປ່ງໃສ. ນ້ຳໜັກ, ອາການ, ແຜນປະຈຳອາທິດ ແລະ ລາຍການຊື້ເຄື່ອງ "
     "ຢູ່ໃນອຸປະກອນ. ຂໍ້ມູນສຸຂະພາບຂອງທ່ານບໍ່ອອກໄປໃສ, ບໍ່ຕ້ອງມີບັນຊີ. ບໍ່ມີໂຄສະນາ, "
     "ບໍ່ມີການຊື້. ຫົວຂໍ້ສະຫວ່າງ ແລະ ມືດ. 68 ພາສາ. app ນີ້ສຳລັບຂໍ້ມູນທົ່ວໄປເທົ່ານັ້ນ; "
     "ບໍ່ແມ່ນຄຳແນະນຳທາງການແພດ, ການວິນິດໄສ ຫຼື ການປິ່ນປົວ.",
     ['keto', 'ບັນທຶກ', 'macro', 'GKI', 'ກູໂຄສ', 'BHB']),
    ('lt', 'Lietuvių',
     'Keto dienoraštis ir GKI',
     'Privatus keto dienoraštis su neprisijungus GKI gliukozės + BHB skaičiuokle.',
     "N Keto Tracker yra privatus atviro kodo keto dienoraštis. Fiksuokite "
     "valgius, makro ir grynuosius angliavandenius; gliukozė + kraujo ketonai "
     "(BHB) tame pačiame seanse apskaičiuoja GKI su skaidria formule. "
     "Svoris, simptomai, savaitės planas ir pirkinių sąrašas lieka įrenginyje. "
     "Jūsų sveikatos duomenys niekur neišeina, paskyros nereikia. Jokių "
     "reklamų, jokių pirkinių. Šviesi ir tamsi tema. 68 kalbos. Ši programa "
     "skirta tik bendrai informacijai; nėra medicininis patarimas, diagnozė "
     "ar gydymas.",
     ['keto', 'dienoraštis', 'makro', 'GKI', 'gliukozė', 'BHB']),
    ('lv', 'Latviešu',
     'Keto dienasgrāmata un GKI',
     "Privāta keto dienasgrāmata ar bezsaistes GKI glikozes + BHB kalkulatoru.",
     "N Keto Tracker ir privāta atvērtā koda keto dienasgrāmata. Pierakstiet "
     "ēdienreizes, makro un tīros ogļhidrātus; glikoze + asins ketoni (BHB) "
     "tajā pašā sesijā aprēķina GKI ar caurspīdīgu formulu. Svars, "
     "simptomi, nedēļas plāns un iepirkumu saraksts paliek ierīcē. Jūsu "
     "veselības dati nekur neiet, konts nav vajadzīgs. Nav reklāmu, nav "
     "pirkumu. Gaišs un tumšs dizains. 68 valodas. Šī lietotne ir tikai "
     "vispārējai informācijai; nav medicīnisks padoms, diagnoze vai ārstēšana.",
     ['keto', 'dienasgrāmata', 'makro', 'GKI', 'glikoze', 'BHB']),
    ('mk', 'Македонски',
     'Кето дневник и GKI',
     'Приватен кето дневник со офлајн GKI калкулатор за гликоза + BHB.',
     "N Keto Tracker е приватен кето дневник со отворен код. Запишувајте "
     "оброци, макро и нето јаглехидрати; гликоза + крвни кетони (BHB) во "
     "иста сесија пресметуваат GKI со транспарентна формула. Тежина, "
     "симптоми, неделен план и листа за купување остануваат на уредот. "
     "Вашите здравствени податоци не излегуваат, без сметка. Без реклами, "
     "без купувања. Светла и темна тема. 68 јазици. Оваа апликација е само за "
     "општи информации; не е медицински совет, дијагноза или третман.",
     ['кето', 'дневник', 'макро', 'GKI', 'гликоза', 'BHB']),
    ('ml', 'മലയാളം',
     'കീറ്റോ ഡയറിയും GKI യും',
     'ഓഫ്‌ലൈൻ ഗ്ലൂക്കോസ് + BHB GKI കാൽക്കുലേറ്ററുള്ള സ്വകാര്യ കീറ്റോ ഡയറി.',
     "N Keto Tracker ഒരു സ്വകാര്യ, ഓപ്പൺ-സോഴ്‌സ് കീറ്റോ ഡയറിയാണ്. ഭക്ഷണം, "
     "മാക്രോ, നെറ്റ് കാർബുകൾ രേഖപ്പെടുക്കുക; ഒരേ സെഷനിൽ ഗ്ലൂക്കോസ് + രക്ത "
     "കീറ്റോണുകൾ (BHB) സുതാര്യമായ ഫോർമുലയോടെ GKI കണക്കാക്കുന്നു. ഭാരം, ലക്ഷണങ്ങൾ, "
     "ആഴ്ചത്തെ പ്ലാൻ, ഷോപ്പിംഗ് ലിസ്റ്റ് എന്നിവ ഉപകരണത്തിൽ തന്നെ നിലകൊള്ളുന്നു. "
     "നിങ്ങളുടെ ആരോഗ്യ ഡാറ്റ ഒരിടത്തും പോകുന്നില്ല, അക്കൗണ്ട് ആവശ്യമില്ല. "
     "പരസ്യാഗമാനങ്ങൾ ഇല്ല, വാങ്ങലുകൾ ഇല്ല. ലൈറ്റ്, ഡാർക്ക് തീം. 68 ഭാഷകൾ. "
     "ഈ ആപ്പ് പൊതുവായ വിവരങ്ങൾക്ക് മാത്രം; വൈദ്യേതര ഉപദേശം, രോഗനിർണയം, ചികിത്സ "
     "അല്ല.",
     ['കീറ്റോ', 'ഡയറി', 'മാക്രോ', 'GKI', 'ഗ്ലൂക്കോസ്', 'BHB']),
    ('mn', 'Монгол',
     'Кето тэмдэглэл ба GKI',
     'Оффлайн глюкоз + BHB GKI тооцоолууртай хувийн кето тэмдэглэл.',
     "N Keto Tracker бол хувийн, нээлттэй эхийн кето тэмдэглэл юм. Хоол, "
     "макро, цэвэр нүүрс-ус бичнэ үү; ижил сешнд глюкоз + цусны кетон (BHB) "
     "ил тод томьёогоор GKI-г тооцоолно. Жин, шинж тэмдэг, долоо хоногийн "
     "төлөвлөгөө, худалдан авах жагсаалт төхөөрөмж дээр үлдэнэ. Таны "
     "эрүүл мэндийн өгөгдөл хаашаа ч явдаггүй, бүртгэл шаардлагагүй. Зар сурталчилгаа "
     "байхгүй, худалдан авалт байхгүй. Гэрэл ба харанхуй сэдэв. 68 хэл. Энэ "
     "апп нь ерөнхий мэдээлэлд зориулагдсан; эмнэлгийн зөвлөгөө, оношилгоо, "
     "эмчилгээ биш.",
     ['кето', 'тэмдэглэл', 'макро', 'GKI', 'глюкоз', 'BHB']),
    ('mr', 'मराठी',
     'किटो डायरी आणि GKI',
     'ऑफलाइन ग्लुकोज + BHB GKI कॅल्क्युलेटरसह खाजगी किटो डायरी.',
     "N Keto Tracker हे खाजगी, ओपन-सोर्स किटो डायरी आहे. अन्न, मॅक्रो "
     "आणि निव्वळ कर्ब्स नोंदवा; त्याच सत्रात ग्लुकोज + रक्तातील कीटोन "
     "(BHB) पारदर्शक सूत्रासह GKI मोजतात. वजन, लक्षणे, साप्ताहिक योजना आणि "
     "खरेदी यादी डिव्हाइसवर राहतात. तुमचा आरोग्य डेटा कुठेही जात नाही, "
     "खात्याची गरज नाही. जाहिरात नाही, खरेदी नाही. लाइट आणि डार्क थीम. 68 "
     "भाषा. हे अॅप केवळ सामान्य माहितीसाठी आहे; वैद्यकीय सल्ला, निदान किंवा "
     "उपचार नाही.",
     ['किटो', 'डायरी', 'मॅक्रो', 'GKI', 'ग्लुकोज', 'BHB']),
    ('ms', 'Bahasa Melayu',
     'Diari keto & penjejak GKI',
     'Diari keto peribadi dengan kalkulator GKI glukosa + BHB luar talian.',
     "N Keto Tracker ialah diari keto peribadi sumber terbuka. Catat "
     "makanan, makro dan karbohidrat bersih; glukosa + keton darah (BHB) "
     "dalam sesi yang sama mengira GKI dengan formula yang telus. Berat, "
     "gejala, rancangan mingguan dan senarai belanja kekal di peranti. "
     "Data kesihatan anda tidak ke mana-mana, tiada akaun diperlukan. "
     "Tiada iklan, tiada pembelian. Tema terang dan gelap. 68 bahasa. "
     "Aplikasi ini hanya untuk maklumat umum; bukan nasihat perubatan, "
     "diagnosis atau rawatan.",
     ['keto', 'diari', 'makro', 'GKI', 'glukosa', 'BHB']),
    ('my', 'မြန်မာ',
     'Keto မှတ်တမ်းနှင့် GKI',
     'အော့ဖ်လိုင်းဂလူကိုစ် + BHB GKI တွက်စက်ဖြင့် ပုဂ္ဂိုလ်ရေး keto မှတ်တမ်း။',
     "N Keto Tracker သည် ပုဂ္ဂိုလ်ရေး open-source keto မှတ်တမ်းဖြစ်သည်။ အစားအစာ၊ "
     "macro နှင့် net carb များကို မှတ်တမ်းတင်ပါ။ session တစ်ခုတည်းတွင် ဂလူကိုစ် + "
     "သွေးကီတွန် (BHB) ဖြင့် GKI ကို ပွင့်လင်းသော ဖော်မြူလာဖြင့် တွက်ပေးသည်။ "
     "ကိုယ်အလေးချိန်၊ လက္ခဏာများ၊ အပတ်စဉ်အစီအစဉ်နှင့် စျေးဝယ်စာရင်းတို့ကို "
     "စက်တွင်သိမ်းထားသည်။ ကျန်းမာရေးဒေတာများ ဘယ်ကိုမှ မသွားပါ၊ အကောင့်မလိုပါ။ "
     "ကြော်ငြာမရှိ၊ ဝယ်ယူမှုမရှိ။ အလင်း/မှောင် အပြင်အဆင်။ ၆၈ ဘာသာ။ "
     "ဤ app သည် ယေဘုယျအချက်အလက်အတွက်သာ ဖြစ်သည်; ဆေးဘက်ဆိုင်ရာ အကြံပြုချက်၊ "
     "ရောဂါရှာဖွေခြင်း သို့မဟုတ် ကုသမှု မဟုတ်ပါ။",
     ['keto', 'မှတ်တမ်း', 'macro', 'GKI', 'ဂလူကိုစ်', 'BHB']),
    ('ne', 'नेपाली',
     'किटो डायरी र GKI',
     'अफलाइन ग्लुकोज + BHB GKI क्याल्कुलेटर सहित निजी किटो डायरी।',
     "N Keto Tracker एक निजी, ओपन-सोर्स किटो डायरी हो। खाना, म्याक्रो र "
     "नेट कार्बहरू रेकर्ड गर्नुहोस्; एउटै सत्रमा ग्लुकोज + रगतको कीटोन "
     "(BHB) ले पारदर्शी सूत्रसहित GKI गणना गर्छ। तौल, लक्षण, साप्ताहिक योजना "
     "र किनमेल सूची उपकरणमा रहन्छ। तपाईंको स्वास्थ्य डेटा कतै जाँदैन, खाता "
     "आवश्यक छैन। कुनै विज्ञापन छैन, कुनै खरिद छैन। हल्का र गाढा थिम। ६८ "
     "भाषा। यो एप केवल सामान्य जानकारीको लागि हो; यो चिकित्सा सल्लाह, निदान "
     "वा उपचार होइन।",
     ['किटो', 'डायरी', 'म्याक्रो', 'GKI', 'ग्लुकोज', 'BHB']),
    ('nl', 'Nederlands',
     'Keto dagboek & GKI',
     'Privé keto dagboek met offline glucose + BHB GKI rekenmachine.',
     "N Keto Tracker is een privé open source keto dagboek. Log maaltijden, "
     "macro's en netto koolhydraten; glucose + bloedketonen (BHB) in dezelfde "
     "sessie berekenen GKI met transparante formule. Gewicht, symptomen, "
     "weekplan en boodschappenlijst blijven op het apparaat. Je "
     "gezondheidsgegevens gaan nergens heen, geen account nodig. Geen "
     "advertenties, geen aankopen. Licht en donker thema. 68 talen. Deze "
     "app is alleen voor algemene informatie; geen medisch advies, "
     "diagnose of behandeling.",
     ['keto', 'dagboek', 'macro', 'GKI', 'glucose', 'BHB']),
    ('pa', 'ਪੰਜਾਬੀ',
     'ਕੀਟੋ ਡਾਇਰੀ ਅਤੇ GKI',
     'ਔਫਲਾਈਨ ਗਲੂਕੋਜ਼ + BHB GKI ਕੈਲਕੁਲੇਟਰ ਨਾਲ ਨਿੱਜੀ ਕੀਟੋ ਡਾਇਰੀ।',
     "N Keto Tracker ਇੱਕ ਨਿੱਜੀ, ਓਪਨ-ਸੋਰਸ ਕੀਟੋ ਡਾਇਰੀ ਹੈ। ਖੁਰਾਕਾਂ, ਮੈਕਰੋ ਅਤੇ ਸ਼ੁੱਧ "
     "ਕਾਰਬ ਰਿਕਾਰਡ ਕਰੋ; ਇੱਕੋ ਸੈਸ਼ਨ ਵਿੱਚ ਗਲੂਕੋਜ਼ + ਖੂਨ ਕੀਟੋਨ (BHB) ਪਾਰਦਰਸ਼ੀ "
     "ਫਾਰਮੂਲੇ ਨਾਲ GKI ਦੀ ਗਣਨਾ ਕਰਦੇ ਹਨ। ਭਾਰ, ਲੱਛਣ, ਹਫਤਾਵਾਰੀ ਯੋਜਨਾ ਅਤੇ ਖਰੀਦਦਾਰੀ "
     "ਸੂਚੀ ਡਿਵਾਈਸ ਤੇ ਰਹਿੰਦੀ ਹੈ। ਤੁਹਾਡਾ ਸਿਹਤ ਡੈਟਾ ਕਿਤੇ ਨਹੀਂ ਜਾਂਦਾ, ਖਾਤੇ ਦੀ ਲੋੜ "
     "ਨਹੀਂ। ਕੋਈ ਵਿਗਿਆਪਨ ਨਹੀਂ, ਕੋਈ ਖਰੀਦ ਨਹੀਂ। ਹਲਕਾ ਅਤੇ ਗੂੜਾ ਥੀਮ। 68 ਭਾਸ਼ਾਵਾਂ। "
     "ਇਹ ਐਪ ਸਿਰਫ਼ ਆਮ ਜਾਣਕਾਰੀ ਲਈ ਹੈ; ਇਹ ਡਾਕਟਰੀ ਸਲਾਹ, ਨਿਦਾਨ ਜਾਂ ਇਲਾਜ ਨਹੀਂ।",
     ['ਕੀਟੋ', 'ਡਾਇਰੀ', 'ਮੈਕਰੋ', 'GKI', 'ਗਲੂਕੋਜ਼', 'BHB']),
    ('pl', 'Polski',
     'Dziennik keto i GKI',
     'Prywatny dziennik keto z offline kalkulatorem GKI glukoza + BHB.',
     "N Keto Tracker to prywatny, otwartoźródłowy dziennik keto. Rejestruj "
     "posiłki, makro i węglowodany netto; glukoza + ketony we krwi (BHB) w "
     "tej samej sesji obliczają GKI z przejrzystym wzorem. Waga, objawy, "
     "plan tygodniowy i lista zakupów pozostają na urządzeniu. Dane "
     "zdrowotne nigdzie nie wychodzą, konto nie jest potrzebne. Bez reklam, "
     "bez zakupów. Motyw jasny i ciemny. 68 języków. Ta aplikacja służy "
     "wyłącznie do ogólnych informacji; nie jest poradą medyczną, diagnozą "
     "ani leczeniem.",
     ['keto', 'dziennik', 'makro', 'GKI', 'glukoza', 'BHB']),
    ('ro', 'Română',
     'Jurnal keto și GKI',
     'Jurnal keto privat cu calculator GKI offline glucoză + BHB.',
     "N Keto Tracker este un jurnal keto privat și open source. Înregistrează "
     "mese, macro și carbohidrați net; glucoză + cetone din sânge (BHB) "
     "în aceeași sesiune calculează GKI cu o formulă transparentă. Greutate, "
     "simptome, plan săptămânal și listă de cumpărături rămân pe "
     "dispozitiv. Datele tale de sănătate nu ies nicăieri, fără cont. Fără "
     "reclame, fără cumpărături. Temă deschisă și închisă. 68 limbi. "
     "Această aplicație este doar informativă; nu este sfat medical, "
     "diagnostic sau tratament.",
     ['keto', 'jurnal', 'macro', 'GKI', 'glucoză', 'BHB']),
    ('si', 'සිංහල',
     'කීටෝ සටහන සහ GKI',
     'නොබැඳි ග්ලූකෝස් + BHB GKI කැල්කියුලේටරය සහිත පුද්ගලික කීටෝ සටහන.',
     "N Keto Tracker යනු පුද්ගලික, විවෘත කේත කීටෝ සටහනකි. ආහාර, මැක්‍රෝ "
     "සහ ශුද්ධිම කාබන් ඇතුළත් කරන්න; එකම සැසියක ග්ලූකෝස් + රුධිර කීටෝන (BHB) "
     "පාරදෘශ්‍ය සූත්‍රයකින් GKI ගණනය කරයි. බර, රෝග ලක්ෂණ, සතික සැලැස්ම "
     "සහ සාප්පු යාමේ ලැයිස්තුව උපාංගය තුළ පවතී. ඔබේ සෞඛ්‍ය දත්ත "
     "කිසිම තැනකට නොයන අතර ගිණුමක් අවශ්‍ය නැත. දැන්වීම් නැත, මිලදී ගැනීම් නැත. "
     "දීප්තිමත් සහ අඳුරු තේමා. භාෂා 68. මෙම යෙදුම සාමාන්‍ය තොරතුරු සඳහා පමණි; "
     "එය වෛද්‍ය උපදෙස්, රෝග විනිශ්චය හෝ ප්‍රතිකාර නොවේ.",
     ['කීටෝ', 'සටහන', 'මැක්‍රෝ', 'GKI', 'ග්ලූකෝස්', 'BHB']),
    ('sk', 'Slovenčina',
     'Keto denník a GKI',
     'Súkromný keto denník s offline GKI kalkulátorom glukóza + BHB.',
     "N Keto Tracker je súkromný open-source keto denník. Zaznamenávajte "
     "jedlá, makro a čisté sacharidy; glukóza + ketóny v krvi (BHB) v "
     "rovnakej relácii počítajú GKI s transparentným vzorcom. Váha, "
     "príznaky, týždenný plán a nákupný zoznam zostávajú v zariadení. Vaše "
     "zdravotné dáta nikam neodchádzajú, žiadny účet. Žiadne reklamy, "
     "žiadne nákupy. Svetlý a tmavý motív. 68 jazykov. Táto aplikácia slúži "
     "len na všeobecné informácie; nie je lekárskou radou, diagnózou ani "
     "liečbou.",
     ['keto', 'denník', 'makro', 'GKI', 'glukóza', 'BHB']),
    ('sl', 'Slovenščina',
     'Keto dnevnik in GKI',
     'Zasebni keto dnevnik z offline GKI kalkulatorjem glukoza + BHB.',
     "N Keto Tracker je zasebni odprtokodni keto dnevnik. Beležite obroke, "
     "makro in neto ogljikove hidrate; glukoza + ketoni v krvi (BHB) v "
     "istem zasedanju izračunajo GKI s pregledno formulo. Teža, simptomi, "
     "tedenski načrt in nakupovalni seznam ostanejo v napravi. Vaši "
     "zdravstveni podatki nikamor ne gredo, brez računa. Brez oglasov, "
     "brez nakupov. Svetla in temna tema. 68 jezikov. Ta aplikacija je "
     "samo za splošne informacije; ni zdravniški nasvet, diagnoza ali "
     "zdravljenje.",
     ['keto', 'dnevnik', 'makro', 'GKI', 'glukoza', 'BHB']),
    ('sq', 'Shqip',
     'Ditari keto dhe GKI',
     'Ditar privat keto me kalkulator GKI glukozë + BHB jashtë linje.',
     "N Keto Tracker është një ditar privat keto me burim të hapur. Regjistroni "
     "vakte, makro dhe karbohidrate neto; glukoza + ketone gjaku (BHB) në "
     "të njëjtën sesion llogarisin GKI me formulë transparente. Pesha, "
     "simptomat, plani javor dhe lista e blerjeve qëndrojnë në pajisje. "
     "Të dhënat tuaja shëndetësore nuk shkojnë askund, pa llogari. Pa "
     "reklama, pa blerje. Temë e çelët dhe e errët. 68 gjuhë. Kjo aplikacion "
     "është vetëm për informacion të përgjithshëm; nuk është këshillë "
     "mjekësore, diagnozë ose trajtim.",
     ['keto', 'ditar', 'makro', 'GKI', 'glukozë', 'BHB']),
    ('sr', 'Српски',
     'Кето дневник и GKI',
     'Приватни кето дневник са офлајн GKI калкулатором глукоза + BHB.',
     "N Keto Tracker је приватни кето дневник отвореног кода. Бележите "
     "оброке, макро и нето угљене хидрате; глукоза + кетони у крви (BHB) "
     "у истој сесији рачунају GKI са транспарентном формулом. Тежина, "
     "симптоми, недељни план и листа за куповину остају на уређају. Ваши "
     "здравствени подаци никуда не излазе, без налога. Без реклама, без "
     "куповине. Светла и тамна тема. 68 језика. Ова апликација је само за "
     "опште информације; није медицински савет, дијагноза или лечење.",
     ['кето', 'дневник', 'макро', 'GKI', 'глукоза', 'BHB']),
    ('sv', 'Svenska',
     'Keto-dagbok & GKI',
     'Privat keto-dagbok med offline GKI-kalkylator glukos + BHB.',
     "N Keto Tracker är en privat dagbok med öppen källkod för keto. Logga "
     "måltider, makro och netto kolhydrater; glukos + blodketoner (BHB) i "
     "samma session beräknar GKI med en transparent formel. Vikt, "
     "symptom, veckoplan och inköpslista stannar på enheten. Dina "
     "hälsouppgifter lämnar aldrig enheten, inget konto behövs. Inga "
     "annonser, inga köp. Ljust och mörkt tema. 68 språk. Den här appen är "
     "bara för allmän information; inte medicinsk rådgivning, diagnos "
     "eller behandling.",
     ['keto', 'dagbok', 'makro', 'GKI', 'glukos', 'BHB']),
    ('sw', 'Kiswahili',
     'Diaries keto na GKI',
     'Diaries binafsi keto yenye kikokotoo GKI glukosi + BHB nje ya mtandao.',
     "N Keto Tracker ni diaries binafsi ya keto yenye msimbo wazi. Kumbuka "
     "milo, makro na kabohidrati halisi; glukosi + ketoni damu (BHB) "
     "katika kikao kile kile huhesabu GKI kwa fomula wazi. Uzito, dalili, "
     "mpango wa wiki na orodha ya ununuzi zinaingia kwenye kifaa. Data "
     "yako ya afia haipoti mahali popote, hakuna akaunti inayohitajika. "
     "Hakuna matangazo, hakuna ununuzi. Mandhari ya mwanga na giza. Lugha "
     "68. Programu hii ni kwa taarifa jumla tu; si ushauri wa kimatibabu, "
     "uchunguzi au matibabu.",
     ['keto', 'diaries', 'makro', 'GKI', 'glukosi', 'BHB']),
    ('ta', 'தமிழ்',
     'கீட்டோ நாட்குறிப்பு & GKI',
     'ஆஃப்லைன் குளுக்கோஸ் + BHB GKI கால்குலேட்டர் கொண்ட தனிப்பட்ட கீட்டோ நாட்குறிப்பு.',
     "N Keto Tracker என்பது தனிப்பட்ட, திறந்த மூல கீட்டோ நாட்குறிப்பு. "
     "உணவு, மேக்ரோ மற்றும் நிகர கார்ப்ஸை பதிவு செய்யுங்கள்; அதே "
     "அமர்வில் குளுக்கோஸ் + இரத்த கீட்டோன்கள் (BHB) வெளிப்படையான சூத்திரத்துடன் "
     "GKI ஐ கணக்கிடுகின்றன. எடை, அறிகுறிகள், வாராந்திர திட்டம் மற்றும் "
     "ஷாப்பிங் பட்டியல் சாதனத்தில் இருக்கும். உங்கள் சுகாதார தரவு எங்கும் "
     "செல்லாது, கணக்கு தேவையில்லை. விளம்பரம் இல்லை, வாங்குதல் இல்லை. "
     "ஒளி மற்றும் இருண்ட தீம். 68 மொழிகள். இந்த பயன்பாடு பொதுவான "
     "தகவலுக்காக மட்டுமே; இது மருத்துவ ஆலோசனை, நோய் கண்டறிதல் அல்லது "
     "சிகிச்சை அல்ல.",
     ['கீட்டோ', 'நாட்குறிப்பு', 'மேக்ரோ', 'GKI', 'குளுக்கோஸ்', 'BHB']),
    ('te', 'తెలుగు',
     'కీటో డైరీ & GKI',
     'ఆఫ్‌లైన్ గ్లూకోజ్ + BHB GKI కాలిక్యులేటర్‌తో ప్రైవేట్ కీటో డైరీ.',
     "N Keto Tracker ఒక ప్రైవేట్, ఓపెన్-సోర్స్ కీటో డైరీ. ఆహారం, "
     "మాక్రో మరియు నికర కార్బ్‌లను రికార్డ్ చేయండి; అదే సెషన్‌లో గ్లూకోజ్ + "
     "రక్త కీటోన్‌లు (BHB) పారదర్శక ఫార్ములాతో GKI లెక్కిస్తాయి. బరువు, "
     "లక్షణాలు, వారపు ప్లాన్ మరియు షాపింగ్ జాబితా పరికరంలో ఉంటాయి. "
     "మీ ఆరోగ్య డేటా ఎక్కడికీ వెళ్ళదు, ఖాతా అవసరం లేదు. ప్రకటనలు లేవు, "
     "కొనుగోళ్లు లేవు. లైట్ మరియు డార్క్ థీమ్. 68 భాషలు. ఈ యాప్ "
     "సాధారణ సమాచారం కోసం మాత్రమే; ఇది వైద్య సలహా, నిర్ధారణ లేదా చికిత్స "
     "కాదు.",
     ['కీటో', 'డైరీ', 'మాక్రో', 'GKI', 'గ్లూకోజ్', 'BHB']),
    ('th', 'ไทย',
     'ไดอารี่คีโตและ GKI',
     'ไดอารี่คีโตส่วนตัวพร้อมเครื่องคำนวณ GKI กลูโคส + BHB แบบออฟไลน์.',
     "N Keto Tracker คือไดอารี่คีโตส่วนตัวแบบโอเพนซอร์ส บันทึกมื้ออาหาร "
     "มาโครและคาร์บสุทธิ กลูโคส + คีโตนในเลือด (BHB) ในเซสชันเดียวกัน "
     "คำนวณ GKI พร้อมเปิดเผยสูตรอย่างโปร่งใส น้ำหนัก อาการ แผนรายสัปดาห์ "
     "และรายการช้อปปิ้งอยู่บนอุปกรณ์ ข้อมูลสุขภาพไม่ถูกส่งออกไป ไม่ต้องใช้บัญชี "
     "ไม่มีโฆษณา ไม่มีการซื้อ ธีมสว่างและมืด 68 ภาษา แอปนี้เป็นข้อมูลทั่วไปเท่านั้น "
     "ไม่ใช่คำแนะนำทางการแพทย์ การวินิจฉัย หรือการรักษา.",
     ['คีโต', 'ไดอารี่', 'มาโคร', 'GKI', 'กลูโคส', 'BHB']),
    ('uk', 'Українська',
     'Кето-щоденник і GKI',
     'Приватний кето-щоденник з офлайн GKI калькулятором глюкоза + BHB.',
     "N Keto Tracker — приватний, відкритий кето-щоденник. Записуйте страви, "
     "макроси та чисті вуглеводи; глюкоза + кетони крові (BHB) в одній сесії "
     "обчислюють GKI з прозорою формулою. Вага, симптоми, тижневий план і "
     "список покупок залишаються на пристрої. Дані про здоров'я нікуди не "
     "йдуть, акаунт не потрібен. Без реклами, без покупок. Світла й темна "
     "теми. 68 мов. Цей застосунок лише для загальної інформації; не є "
     "медичною порадою, діагнозом чи лікуванням.",
     ['кето', 'щоденник', 'макро', 'GKI', 'глюкоза', 'BHB']),
    ('ur', 'اردو',
     'کیٹو ڈائری اور GKI',
     'آف لائن گلوکوز + BHB GKI کیلکولیٹر کے ساتھ نجی کیٹو ڈائری۔',
     "N Keto Tracker ایک نجی، اوپن سورس کیٹو ڈائری ہے۔ کھانے، میکرو اور "
     "خالص کاربوہائیڈریٹس ریکارڈ کریں۔ ایک ہی سیشن میں گلوکوز + خون کے "
     "کیٹونز (BHB) شفاف فارمولے کے ساتھ GKI کا حساب لگاتے ہیں۔ وزن، "
     "علامات، ہفتہ وار منصوبہ اور خریداری کی فہرست ڈیوائس پر رہتی ہے۔ آپ کا "
     "صحت کا ڈیٹا کہیں نہیں جاتا، اکاؤنٹ کی ضرورت نہیں۔ کوئی اشتہار نہیں، "
     "کوئی خریداری نہیں۔ ہلکی اور گہری تھیم۔ 68 زبانیں۔ یہ ایپ صرف عمومی "
     "معلومات کے لیے ہے؛ یہ طبی مشورہ، تشخیص یا علاج نہیں۔",
     ['کیٹو', 'ڈائری', 'میکرو', 'GKI', 'گلوکوز', 'BHB']),
    ('vi', 'Tiếng Việt',
     'Nhật ký keto & theo dõi GKI',
     'Nhật ký keto riêng tư với máy tính GKI glucose + BHB ngoại tuyến.',
     "N Keto Tracker là nhật ký keto riêng tư mã nguồn mở. Ghi lại bữa ăn, "
     "macro và carb ròng; glucose + ketone máu (BHB) trong cùng phiên "
     "tính GKI với công thức minh bạch. Cân nặng, triệu chứng, kế hoạch "
     "tuần và danh sách mua sắm ở lại trên thiết bị. Dữ liệu sức khỏe "
     "không đi đâu, không cần tài khoản. Không quảng cáo, không mua hàng. "
     "Chủ đề sáng và tối. 68 ngôn ngữ. Ứng dụng này chỉ dành cho thông tin "
     "chung; không phải lời khuyên y tế, chẩn đoán hay điều trị.",
     ['keto', 'nhật ký', 'macro', 'GKI', 'glucose', 'BHB']),
    ('zu', 'isiZulu',
     'I-diary keto ne-GKI',
     'I-diary yangasese keto enekhophuthi ye-GKI ye-glucose + BHB.',
     "I-N Keto Tracker yi-diary yangasese ye-keto yomthombo ovulekile. "
     "Bhala ukudla, i-macro kanye ne-net carbs; i-glucose + i-ketone "
     "yegazi (BHB) kwisifundo esifanayo ibala i-GKI ngefomula ebonakalayo. "
     "Isisindo, izimpawu, uhlelo lwasonto namalisti okuthenga kuhlala "
     "kudivayisi. Idatha yakho yezempilo ayiphumi, akukho i-akhawunti "
     "edingekayo. Akukho izikhangiso, akukho ukuthenga. Izinhlobo ezikhanyayo "
     "nezimnyama. Izilimi ezingama-68. Lo mphelelisi unolwazi jikelele "
     "kuphela; awusiso iseluleko sezokwelapha, ukuxilongwa noma ukwelashwa.",
     ['keto', 'i-diary', 'i-macro', 'GKI', 'i-glucose', 'BHB']),
]


def main():
    for code, native, subtitle, short, long_desc, keywords in T:
        path = os.path.join(OUT_DIR, f'STORE_LISTING_{code.upper()}.md')
        lines = [
            f'# Store Listing — {native} ({code})',
            '',
            '> Generated by `tool/gen_store_listings.py` from the EN/TR '
            'templates; copy-pasted into the store console.',
            '',
            f'**App name (≤30):** N Keto Tracker',
            f'**Subtitle (≤30):** {subtitle}',
            '',
            f'**Short description (≤80):** {short}',
            '',
            '**Long description:**',
            '',
            long_desc,
            '',
            f'**Keywords:** {", ".join(keywords)}',
            '',
            '**Category:** Health & Fitness',
            '**Content rating:** Everyone (medical disclaimer enforced)',
            '**Age:** 18+ (locked by onboarding risk screening)',
            '',
            '**Screenshots:** see `docs/marketing/screenshots/`',
            '',
        ]
        with open(path, 'w', encoding='utf-8') as f:
            f.write('\n'.join(lines))
    print(f'Wrote {len(T)} store listing files to {OUT_DIR}')


if __name__ == '__main__':
    main()
