"""PB-032: yeni walking anahtarlarını 67 dile ekler.

Eklenen anahtarlar:
  walkingStrengthDayTitle — kuvvet günü başlığı
  walkingProtocolNote     — kuvvet/esneme protokolü (ACSM 2011)
"""
import io
import json
import os
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

ARB_DIR = os.path.normpath(
    os.path.join(os.path.dirname(__file__), '..', 'lib', 'app', 'l10n')
)

T = {
    'af': {'walkingStrengthDayTitle': 'Kragdag', 'walkingProtocolNote': 'Kragdaedae fokus groot spiergroepe plus balans en koördinasie. Voeg gentle stretching by: ongeveer 60 sekondes per spiergroep op minstens 2 dae/week (ACSM 2011).'},
    'ar': {'walkingStrengthDayTitle': 'يوم القوة', 'walkingProtocolNote': 'تستهدف أيام القوة مجموعات العضلات الرئيسيةAdditionally التوازن والتنسيق. أضف تمددًا لطيفًا: نحو 60 ثانية لكل مجموعة عضلية يوميًا على الأقل (ACSM 2011).'},
    'az': {'walkingStrengthDayTitle': 'Güc günü', 'walkingProtocolNote': 'Güc günləri əsas əzələ qruplarını, həmçinin balans və koordinasiyanı hədəfləyir. Yüngül dartışma əlavə edin: hər əzələ qrupu üçün təxminən 60 saniyə, həftədə ən azı 2 gün (ACSM 2011).'},
    'be': {'walkingStrengthDayTitle': 'Дзень сілы', 'walkingProtocolNote': 'Дні сілы накіраваны на асноўныя группы мышцаў, а таксама на раўнавагу і каардынацыю. Дадайце лёгкае расцяжванне: каля 60 секунд на кожную групу мышцаў, тыдзень на меней 2 дні (ACSM 2011).'},
    'bg': {'walkingStrengthDayTitle': 'Ден за сила', 'walkingProtocolNote': 'Дните за сила насочват основните мускулни групи, както и баланса и координацията. Добавете леко разтягане: около 60 секунди за всяка мускулна група, поне 2 дни седмично (ACSM 2011).'},
    'bn': {'walkingStrengthDayTitle': 'শক্তির দিন', 'walkingProtocolNote': 'শক্তির দিনগুলি প্রধান পেশি গোষ্ঠী এবং ভারসাম্য ও সমন্বয়কে লক্ষ্য করে। হালকা স্ট্রেচ যোগ করুন: প্রতি পেশি গোষ্ঠীতে প্রায় 60 সেকেন্ড, সপ্তাহে অন্তত 2 দিন (ACSM 2011)।'},
    'ca': {'walkingStrengthDayTitle': 'Dia de força', 'walkingProtocolNote': 'Els dies de forçaenyatenen els principals grups musculars, així com l\'equilibri i la coordinació. Afegeix un estirament suau: uns 60 segons per grup muscular almenys 2 dies per setmana (ACSM 2011).'},
    'cs': {'walkingStrengthDayTitle': 'Den posilování', 'walkingProtocolNote': 'Dny posilování míří na hlavní svalové skupiny, stejně jako na rovnováhu a koordinaci. Přidejte jemné protažení: asi 60 sekund na svalovou skupinu, nejméně 2 dny v týdnu (ACSM 2011).'},
    'da': {'walkingStrengthDayTitle': 'Styrketræningsdag', 'walkingProtocolNote': 'Styrketræningsdage fokuserer på de store muskelgrupper samt balance og koordination. Tilføj let strækning: cirka 60 sekunder pr. muskelgruppe mindst 2 dage om ugen (ACSM 2011).'},
    'de': {'walkingStrengthDayTitle': 'Krafttag', 'walkingProtocolNote': 'Krafttage richten sich auf die großen Muskelgruppen sowie Balance und Koordination. Ergänze sanftes Dehnen: etwa 60 Sekunden pro Muskelgruppe an mindestens 2 Tagen pro Woche (ACSM 2011).'},
    'el': {'walkingStrengthDayTitle': 'Ημέρα δύναμης', 'walkingProtocolNote': 'Οι ημέρες δύναμης στοχεύουν τις κύριες μυϊκές ομάδες, καθώς και την ισορροπία και τον συντονισμό. Προσθέστε ήπια διάταση: περίπου 60 δευτερόλεπτα ανά μυϊκή ομάδα, τουλάχιστο 2 μέρες την εβδομάδα (ACSM 2011).'},
    'es': {'walkingStrengthDayTitle': 'Día de fuerza', 'walkingProtocolNote': 'Los días de fuerza se dirigen a los principales grupos musculares, además del equilibrio y la coordinación. Añade estiramiento suave: unos 60 segundos por grupo muscular al menos 2 días por semana (ACSM 2011).'},
    'et': {'walkingStrengthDayTitle': 'Jõupäev', 'walkingProtocolNote': 'Jõupäevad suunduvad pearühmade lihastele ning tasakaalu ja koordinatsioonile. Lisa õrn venitus: umbes 60 sekundit lihasrühma kohta vähemalt 2 päeva nädalas (ACSM 2011).'},
    'eu': {'walkingStrengthDayTitle': 'Indartze eguna', 'walkingProtocolNote': 'Indartze egunak muskulu talde handienak, baita orokortasuna eta koordinazioa ere zentratzen dituzte. Gehitu luzatxo aratza: 60 segundo inguru muskulu talde bakoitzeko, astean gutxienez 2 egunetan (ACSM 2011).'},
    'fa': {'walkingStrengthDayTitle': 'روز قدرت', 'walkingProtocolNote': 'روزهای قدرت بر گروه‌های اصلی عضلانی و نیز تعادل و هماهنگی تمرکز دارند. کشش ملایم اضافه کنید: حدود ۶۰ ثانیه برای هر گروه عضلانی، دست‌کم ۲ روز در هفته (ACSM 2011).'},
    'fi': {'walkingStrengthDayTitle': 'Voimapäivä', 'walkingProtocolNote': 'Voimapäivät kohdistuvat suuriin lihasryhmiin sekä tasapainoon ja koordinaatioon. Lisää kevyt venyttely: noin 60 sekuntia lihasryhmää kohti vähintään 2 päivänä viikossa (ACSM 2011).'},
    'fil': {'walkingStrengthDayTitle': 'Araw ng lakas', 'walkingProtocolNote': 'Ang mga araw ng lakas ay nakatuon sa pangunahing grupo ng kalamunan, pati na rin sa balanse at koordinasyon. Magdagdag ng banayad na pag-stretch: mga 60 segundo bawat grupo ng kalamutan sa hindi bababa sa 2 araw kada linggo (ACSM 2011).'},
    'fr': {'walkingStrengthDayTitle': 'Jour de renforcement', 'walkingProtocolNote': 'Les jours de renforcement ciblent les principaux groupes musculaires, ainsi que l\'équilibre et la coordination. Ajoutez un étirement doux : environ 60 secondes par groupe musculaire, au moins 2 jours par semaine (ACSM 2011).'},
    'gl': {'walkingStrengthDayTitle': 'Día de forza', 'walkingProtocolNote': 'Os días de forza diríxense aos principais grupos musculares, así como ao equilibrio e á coordinación. Engade estiramento suave: uns 60 segundos por grupo muscular ao menos 2 días por semana (ACSM 2011).'},
    'gu': {'walkingStrengthDayTitle': 'શક્તિનો દિવસ', 'walkingProtocolNote': 'શક્તિના દિવસો મુખ્ય માંસપેશી જૂથો તેમજ સંતુલન અને સંકાય પર ધ્યાન આપે છે. હળવું સ્ટ્રેચ ઉમેરો: દરેક માંસપેશી જૂથ માટે લગભગ 60 સેકંડ, અઠવાડિયામાં ઓછામાં ઓછા 2 દિવસ (ACSM 2011).'},
    'he': {'walkingStrengthDayTitle': 'יום כוח', 'walkingProtocolNote': 'ימי הכוח מתמקדים בקבוצות השרירים העיקריות, וכן בשיווי משקל ובתיאום. מוסיפים מתיחה עדינה: כ-60 שניות לכל קבוצת שרירים, ביותר מ-2 ימים בשבוע (ACSM 2011).'},
    'hi': {'walkingStrengthDayTitle': 'स्ट्रेंथ का दिन', 'walkingProtocolNote': 'स्ट्रेंथ दिन मुख्य मांसपेशी समूहों के साथ संतुलन और समन्वय पर भी केंद्रित होते हैं। हल्का स्ट्रेच जोड़ें: प्रति मांसपेशी समूह लगभग 60 सेकंड, सप्ताह में कम से कम 2 दिन (ACSM 2011)।'},
    'hr': {'walkingStrengthDayTitle': 'Dan snage', 'walkingProtocolNote': 'Dani snage usmjeravaju na glavne skupine mišića, kao i na ravnotežu i koordinaciju. Dodajte nježno istezanje: oko 60 sekundi po mišićnoj skupini najmanje 2 dana u tjednu (ACSM 2011).'},
    'hu': {'walkingStrengthDayTitle': 'Edzésnap', 'walkingProtocolNote': 'Az edzésnapok a fő izomcsoportokra, valamint az egyensúlyra és a koordinációra fókuszálnak. Adjunk enyhe nyújtást: izomcsoportonként körülbelül 60 másodperc, hetente legalább 2 napon (ACSM 2011).'},
    'hy': {'walkingStrengthDayTitle': 'Ուժի օր', 'walkingProtocolNote': 'Ուժի օրերին ուշադրություն է դարձվում հիմնական մկնային խմբերին, ինչպես նաև հավաստտականությանը և համաժամանոլացմանը։ Ավելացրեք մեղմ ձգում՝ յուրաքանչյուր մկնային խումբի համար մոտ 60 վայրկյան, շաբաթվա առանջան 2 օր (ACSM 2011)։'},
    'id': {'walkingStrengthDayTitle': 'Hari kekuatan', 'walkingProtocolNote': 'Hari kekuatan berfokus pada kelompok otot utama, serta keseimbangan dan koordinasi. Tambahkan peregangan ringan: sekitar 60 detik per kelompok otot, minimal 2 hari per minggu (ACSM 2011).'},
    'is': {'walkingStrengthDayTitle': 'Þjálfunardagur', 'walkingProtocolNote': 'Þjálfunardagar beina að stæðustu vöðlahópunum og einnig jafnvægi og samhæfningu. Bættu við léttri teygingu: um 60 sekúndur fyrir hverja vöðlahópu, að minnsta kosti 2 daga í viku (ACSM 2011).'},
    'it': {'walkingStrengthDayTitle': 'Giorno di forza', 'walkingProtocolNote': 'I giorni di forza si concentrano sui principali gruppi muscolari, oltre che su equilibrio e coordinazione. Aggiungi un allungamento leggero: circa 60 secondi per gruppo muscolare, almeno 2 giorni a settimana (ACSM 2011).'},
    'ja': {'walkingStrengthDayTitle': '筋力の日', 'walkingProtocolNote': '筋力の日は主な筋群に加え、バランスと協調性にも焦点を当てます。やさしいストレッチを加えましょう：筋群あたり約60秒、週2日以上（ACSM 2011）。'},
    'ka': {'walkingStrengthDayTitle': 'ძალის დღე', 'walkingProtocolNote': 'ძალის დღეები მიმართულია მთავარ კუნთხოვლებზე, ასევე ბალანსსა და კოორდინაციაზე. დაამატეთ მსუბუქი გაჭიმვა: დაახლოებით 60 წამი კუნთხის ჯგუფიდან, კვირაში სულ მცირე 2 დღე (ACSM 2011).'},
    'kk': {'walkingStrengthDayTitle': 'Күш салу күні', 'walkingProtocolNote': 'Күш салу күндері негізгі бұлшық топтарына, сондай-ақ тең және үйлесімділікке бағыт алады. Жұмсақ созу қосыңыз: бұлшық топтарына шамамен 60 секунд, аптасына кемінде 2 күн (ACSM 2011).'},
    'kn': {'walkingStrengthDayTitle': 'ಶಕ್ತಿ ದಿನ', 'walkingProtocolNote': 'ಶಕ್ತಿ ದಿನಗಳು ಮುಖ್ಯ ಪ್ರಮುಖ ಕಂಪುಗಳ ಜೊತೆಗೆ ಸಮತೋಲನ ಮತ್ತು ಸಂಯೋಜನೆಯನ್ನು ಸೇರಿಸುತ್ತವೆ. ಸೌಮ್ಯ ಸ್ಟ್ರೆಚ್ ಸೇರಿಸಿ: ಪ್ರತಿ ಕಂಪು ಗುಂಪಿಗೆ ಸುಮಾರು 60 ಸೆಕೆಂಡ್, ವಾರಕ್ಕೆ ಕನಿಷ್ಠ 2 ದಿನ (ACSM 2011).'},
    'ko': {'walkingStrengthDayTitle': '근력의 날', 'walkingProtocolNote': '근력의 날은 주요 근육군뿐 아니라 균형과 협응력에도 초점을 맞춥니다. 가벼운 스트레칭을 더하세요: 근육군당 약 60초, 주 2일 이상 (ACSM 2011).'},
    'ky': {'walkingStrengthDayTitle': 'Күч оюн күнү', 'walkingProtocolNote': 'Күч оюн күндөрү негизги булдук топторуна, ошондой эле баланс жана координацияга багыт алат. Жумшак созуу кошкуңуз: ар бир булдук тобуна болжолу менен 60 секунд, жумасына кеминде 2 күн (ACSM 2011).'},
    'lo': {'walkingStrengthDayTitle': 'ວັນອອກກໍາ', 'walkingProtocolNote': 'ວັນອອກກໍາມູ່ເທົ່າກັບກຸ່ມລັດໃຫ້ກັບເນື່ອງກຸ່ມລັດຫຼັກໃຫໍໆ ແລະຄວາມສมດຸນຂອງຕົວເຮັດ. ເພີ່ມເຕີການຢືດຢົດແນວໆ: ປະມາດ 60 ວິນາທີ ຕໍ່ ກຸ່ມລັດໜຶ່ງ, ຢ່າງໜ້ຍາມັນ 2 ມື້ຕ່ອາສາດ (ACSM 2011).'},
    'lt': {'walkingStrengthDayTitle': 'Stiprėjimo diena', 'walkingProtocolNote': 'Stiprėjimo dienos nukreipiamos į pagrindines raumenų grupes, taip pat į pusiausvyrą ir koordinaciją. Pridėkite švelnų tempimą: apie 60 sekundžių kiekvienai raumenų grupei bent 2 dienas per savaitę (ACSM 2011).'},
    'lv': {'walkingStrengthDayTitle': 'Spēka diena', 'walkingProtocolNote': 'Spēka dienas ir vērstas uz lielākajām muskuļu grupām, kā arī uz līdzsvaru un koordināciju. Pievienojiet maigu stiepšanu: apmēram 60 sekundes katrai muskuļu grupai vismaz 2 dienas nedēļā (ACSM 2011).'},
    'mk': {'walkingStrengthDayTitle': 'Ден на сила', 'walkingProtocolNote': 'Дените на сила се насочуваат кон главните мускулни групи, како и кон рамнотежата и координацијата. Додадете нежно растегнување: околу 60 секунди по мускулна група, најмалку 2 дена неделно (ACSM 2011).'},
    'ml': {'walkingStrengthDayTitle': 'സ്റ്റ്രെംഗ്ത് ദിവസം', 'walkingProtocolNote': 'സ്റ്റ്രെംഗ്ത് ദിവസങ്ങൾ പ്രധാന മസ്കിൾ ഗ്രൂപ്പുകളെയും സന്തുലനവും ഏകോപനിയേഷനും ലക്ഷ്യമാക്കുന്നു. നേരിയ സ്ട്രെച്ചിംഗ് ചേർക്കുക: ഓരോ മസ്കിൾ ഗ്രൂപ്പിനും ഏകദേശം 60 സെക്കൻഡ്, ആഴ്ചയിൽ കുറഞ്ഞത് 2 ദിവസം (ACSM 2011).'},
    'mn': {'walkingStrengthDayTitle': 'Хүчний өдөр', 'walkingProtocolNote': 'Хүчний өдрүүд үндсэн булчингийн бүлгүүдэд мөн тэнцэтгэл, зохион байгуулалтад чиглэнэ. Зөөхөн сунгалт нэмээрэй: булчингийн бүлэг бүрт ойролцоогоор 60 секунд, долоо хоногт дор хаяж 2 өдөр (ACSM 2011).'},
    'mr': {'walkingStrengthDayTitle': 'ताकदीचा दिवस', 'walkingProtocolNote': 'ताकदीच्या दिवशी मुख्य स्नायुंचे गट तसेच संतुलन आणि समन्वय यांना लक्ष्य करतात. हलके स्ट्रेच जोडा: प्रत्येक स्नायु गटासाठी सुमारे 60 सेकंद, आठवड्याला किमान 2 दिवस (ACSM 2011).'},
    'ms': {'walkingStrengthDayTitle': 'Hari kekuatan', 'walkingProtocolNote': 'Hari kekuatan menyasarkan kumpulan otot utama serta imbangan dan koordinasi. Tambah regangan perlahan: kira-kira 60 saat setiap kumpulan otot, sekurang-kurangnya 2 hari seminggu (ACSM 2011).'},
    'my': {'walkingStrengthDayTitle': 'အားကစားနေ့', 'walkingProtocolNote': 'အားကစားနေ့များသည် အဓိကကိုလ်အုပ်စုများအပြင် ချိန်ချင်းမှုနှင့် တည်ငိမ်ကျမှုကိုလည်း အမြင့်အစားပြုသည်။ ညင်းသောလှအနည်းလျော့ရှည်းမှု ထည့်ပါ။ ကိုလ်အုပ်စုတစ်ခုလျှင် ၆၀ စက္ကန့်ခန့်၊ ရက်တစ်ပတ်လျှင် အနည်းဆုံး ၂ ရက် (ACSM 2011)။'},
    'ne': {'walkingStrengthDayTitle': 'बल दिन', 'walkingProtocolNote': 'बल दिनहरू मुख्य मांसपेशी समूहहरूका साथै सन्तुलन र समन्वयमा पनि केन्द्रित हुन्छन्। हल्का स्ट्रेच थप्नुहोस्: प्रत्येक मांसपेशी समूहमा लगभग 60 सेकेन्ड, हप्तामा कम्तीमा 2 दिन (ACSM 2011)।'},
    'nl': {'walkingStrengthDayTitle': 'Krachtdag', 'walkingProtocolNote': 'Krachtdagen richten zich op de grote spiergroepen, plus balans en coördinatie. Voeg gentle reksoefeningen toe: ongeveer 60 seconden per spiergroep, minstens 2 dagen per week (ACSM 2011).'},
    'pa': {'walkingStrengthDayTitle': 'ਤਾਕਤ ਦਾ ਦਿਨ', 'walkingProtocolNote': 'ਤਾਕਤ ਵਾਲੇ ਦਿਨ ਮੁੱਖ ਪੱਠਾਂ ਗਰੁੱਪਾਂ ਦੇ ਨਾਲ-ਨਾਲ ਸੰਤੁਲਨ ਅਤੇ ਤਾਲਮੇਲ ਨੂੰ ਧਿਆਨ ਦਿੰਦੇ ਹਨ। ਹਲਕਾ ਖਿੱਚੋ ਜੋੜੋ: ਹਰ ਪੱਠਾਂ ਗਰੁੱਪ ਲਈ ਲਗਭਗ 60 ਸਕਿੰਟ, ਹਫ਼ਤੇ ਵਿੱਚ ਘੱਟੋ-ਘੱਟ 2 ਦਿਨ (ACSM 2011)।'},
    'pl': {'walkingStrengthDayTitle': 'Dzień siły', 'walkingProtocolNote': 'Dni siły koncentrują się na głównych grupach mięśniowych, a także na równowadze i koordynacji. Dodaj delikatne rozciąganie: około 60 sekund na grupę mięśniową, co najmniej 2 dni w tygodniu (ACSM 2011).'},
    'pt': {'walkingStrengthDayTitle': 'Dia de força', 'walkingProtocolNote': 'Os dias de força concentram-se nos principais grupos musculares, além do equilíbrio e da coordenação. Adicione alongamento suave: cerca de 60 segundos por grupo muscular, pelo menos 2 dias por semana (ACSM 2011).'},
    'ro': {'walkingStrengthDayTitle': 'Zi de forță', 'walkingProtocolNote': 'Zilele de forță vizează principalele grupe musculare, precum și echilibrul și coordonarea. Adaugă întindere ușoară: aproximativ 60 de secunde pe grup muscular, cel puțin 2 zile pe săptămână (ACSM 2011).'},
    'ru': {'walkingStrengthDayTitle': 'День силы', 'walkingProtocolNote': 'Дни силы направлены на основные группы мышц, а также на равновесие и координацию. Добавьте мягкую растяжку: около 60 секунд на каждую группу мышц, минимум 2 дня в неделю (ACSM 2011).'},
    'si': {'walkingStrengthDayTitle': 'බල දිනය', 'walkingProtocolNote': 'බල දින මධ්‍ය මසුන් ක෫ිතික සමුහිත කණ්ඩෝප සමඟ ඉන්ද්‍රියතා සහ සංයමනය ද ඉලක්ෂ කරයි. මෘදු දිරුම්බාගැනීමක් එක් කරන්න: සෑම මසුන් ක෫ිතික කාණ්ඩයකට ආසන්න තත්පර 60, සතියට අවම වශයෙන් දින 2 (ACSM 2011).'},
    'sk': {'walkingStrengthDayTitle': 'Deň silového tréningu', 'walkingProtocolNote': 'Dni silového tréningu smerujú na hlavné svalové skupiny, ako aj na rovnováhu a koordináciu. Pridajte jemné naťahovanie: približne 60 sekúnd na svalovú skupinu, najmenej 2 dni v týždni (ACSM 2011).'},
    'sl': {'walkingStrengthDayTitle': 'Dan moči', 'walkingProtocolNote': 'Dani moči so usmerjeni na glavne skupine mišic ter ravnotežje in koordinacijo. Dodajte nežno raztegovanje: približno 60 sekund na mišično skupino, najmanj 2 dni na teden (ACSM 2011).'},
    'sq': {'walkingStrengthDayTitle': 'Ditë i forcës', 'walkingProtocolNote': 'Ditët e forcës synojnë grupet kryesore muskulore, si dhe balancën dhe koordinimin. Shtoni një shtjellje të butë: rreth 60 sekonda për çdo grup muskulor, të paktën 2 ditë në javë (ACSM 2011).'},
    'sr': {'walkingStrengthDayTitle': 'Дан снаге', 'walkingProtocolNote': 'Дан снаге су усмерени на главне групе мишића, као и на равнотежу и координацију. Додајте нежно истезање: око 60 секунди по мишићној групи, најмање 2 дана недељно (ACSM 2011).'},
    'sv': {'walkingStrengthDayTitle': 'Styrkedag', 'walkingProtocolNote': 'Styrkedagar riktar sig till de stora muskelgrupperna samt balans och koordination. Lägg till mjuk stretching: cirka 60 sekunder per muskelgrupp, minst 2 dagar i veckan (ACSM 2011).'},
    'sw': {'walkingStrengthDayTitle': 'Siku ya nguvu', 'walkingProtocolNote': 'Siku za nguvu zinalenga makundi makubwa ya misuli, pamoja na usawa na uratibitaji. Ongeza nyumbani mwake: sekunde 60 kwa kila kundi la misuli, angalau siku 2 kwa wiki (ACSM 2011).'},
    'ta': {'walkingStrengthDayTitle': 'வலிமை நாள்', 'walkingProtocolNote': 'வலிமை நாட்கள் முக்கிய தசைக் குழுக்களையும், சமநிலையையும் ஒருங்கிணைப்பையும் நோக்குகின்றன. மென்மையான நீட்சியைச் சேர்க்கவும்: ஒவ்வொரு தசைக் குழுவிற்கும் சுமார் 60 வினாடிகள், வாரத்திற்கு குறைந்தது 2 நாட்கள் (ACSM 2011).'},
    'te': {'walkingStrengthDayTitle': 'బలం రోజు', 'walkingProtocolNote': 'బల రోజులు ప్రధాన కండరాల సమూహాలతో పాటు సమతుల్యత, నియంత్రణను కూడా లక్ష్యంగా తీసుకుంటాయి. మృదువైన స్ట్రెచ్ చేర్చండి: ప్రతి కండరాల సమూహానికి సుమారు 60 సెకన్లు, వారానికి కనీసం 2 రోజులు (ACSM 2011).'},
    'th': {'walkingStrengthDayTitle': 'วันออกกำลังกาย', 'walkingProtocolNote': 'วันออกกำลังกายเน้นกลุ่มกล้ามเนื้อหลัก รวมถึงสมดุลและการประสานงาน เพิ่มการยืดเหยื่อยอยอย่างเบา ๆ ประมาณ 60 วินาทีต่อกลุ่มกล้ามเนื้อ อย่างน้อย 2 วันต่อสัปดาห์ (ACSM 2011)'},
    'tr': {'walkingStrengthDayTitle': 'Kuvvet günü', 'walkingProtocolNote': 'Kuvvet günleri ana kas gruplarını, ayrıca denge ve koordinasyonu hedefler. Hafif esneme ekleyin: kas grubu başına yaklaşık 60 saniye, haftada en az 2 gün (ACSM 2011).'},
    'uk': {'walkingStrengthDayTitle': 'День сили', 'walkingProtocolNote': 'Дні сили спрямовані на основні групи м’язів, а також на рівновагу та координацію. Додайте м’яке розтягнення: близько 60 секунд на кожну групу м’язів, щонайменше 2 дні на тиждень (ACSM 2011).'},
    'ur': {'walkingStrengthDayTitle': 'طاقت کا دن', 'walkingProtocolNote': 'طاقت کے دن بنیادی عضلاتی گروپوں کے ساتھ ساتھ توازن اور协调 پر بھی توجہ دیتے ہیں۔ ہلکا کھینچو شامل کریں: ہر عضلاتی گروپ کے لیے تقریباً 60 سیکنڈ، ہفتے میں کم از کم 2 دن (ACSM 2011)۔'},
    'vi': {'walkingStrengthDayTitle': 'Ngày tập lực', 'walkingProtocolNote': 'Các ngày tập lực nhắm vào nhóm cơ chính, cũng như sự cân bằng và phối hợp. Hãy thêm động tác co giãn nhẹ: khoảng 60 giây mỗi nhóm cơ, ít nhất 2 ngày mỗi tuần (ACSM 2011).'},
    'zh': {'walkingStrengthDayTitle': '力量训练日', 'walkingProtocolNote': '力量训练日针对主要肌群，同时兼顾平衡与协调。加入轻柔拉伸：每个肌群约 60 秒，每周至少 2 天（ACSM 2011）。'},
    'zh_Hant': {'walkingStrengthDayTitle': '力量訓練日', 'walkingProtocolNote': '力量訓練日針對主要肌群，同時兼顧平衡與協調。加入輕柔拉伸：每個肌群約 60 秒，每週至少 2 天（ACSM 2011）。'},
    'zu': {'walkingStrengthDayTitle': 'Usuku lokomhlaba', 'walkingProtocolNote': 'Izinsuku zomhlaba zijolisana amaqembu amakhulu emisiphetho kanye nokulinganisa nokuhamba. Faka ukukhala okucophobela: cishe imizuzu engamashumi amahlanu ngqoqobo lemhasela, okungenani izinsuku ezi-two ngesonto (ACSM 2011).'},
}


def main() -> int:
    if not os.path.isdir(ARB_DIR):
        print(f'ARB dizini bulunamadı: {ARB_DIR}', file=sys.stderr)
        return 1
    updated = 0
    for fname in sorted(os.listdir(ARB_DIR)):
        if not fname.startswith('app_') or not fname.endswith('.arb'):
            continue
        lang = fname[len('app_'):-len('.arb')]
        if lang == 'en':
            continue
        if lang not in T:
            print(f'  ! eksik çeviri: {lang}', file=sys.stderr)
            return 2
        path = os.path.join(ARB_DIR, fname)
        with open(path, 'r', encoding='utf-8') as f:
            doc = json.load(f)
        changed = False
        for key, val in T[lang].items():
            if key not in doc:
                doc[key] = val
                changed = True
        if changed:
            with open(path, 'w', encoding='utf-8') as f:
                json.dump(doc, f, ensure_ascii=False, indent=2)
                f.write('\n')
            updated += 1
    print(f'Güncellenen dil: {updated}')
    return 0


if __name__ == '__main__':
    sys.exit(main())