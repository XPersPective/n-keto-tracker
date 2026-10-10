#!/usr/bin/env python3
"""PB-021 kapsam genişletme: 66 dil için `todayNutritionEmpty` metnini
günceller. EN+TR zaten güncel; diğer 66 dil eski "from the Plan tab"
yönlendirmesi taşıyordu. Model bilgisiyle doğru çeviriler yazıldı.
"""
import os
import re

ARB_DIR = os.path.join(os.path.dirname(__file__), '..', 'lib', 'app', 'l10n')

# 68 dil için güncel todayNutritionEmpty metni.
# Kalıp: "Bugün öğün yok. Hızlı eylemlerden ekleyebilirsin." (TR)
T = {
    'af': 'Geen maaltye vandag nie. Gebruik die vinnige aksies hierbo om een by te voeg.',
    'ar': 'لا توجد وجبات مسجلة اليوم. استخدم الإجراءات السريعة أعلاه لإضافة واحدة.',
    'az': 'Bu gün yemək qeyd edilməyib. Yuxarıdakı sürətli əməliyyatlardan birini əlavə edin.',
    'be': 'Сёння ежа не запісана. Скарыстайцеся хуткімі дзеяннямі вышэй, каб дадаць страву.',
    'bg': 'Днес няма записани хранения. Използвайте бързите действия по-горе, за да добавите.',
    'bn': 'আজ কোনো খাবার লেখা হয়নি। যোগ করতে উপরের দ্রুত কাজগুলো ব্যবহার করুন।',
    'ca': 'Avui no hi ha àpats registrats. Usa les accions ràpides de dalt per afegir-ne un.',
    'cs': 'Dnes nejsou zapsána žádná jídla. Použijte rychlé akce výše a nějaké přidejte.',
    'da': 'Ingen måltider registreret i dag. Brug hurtighandlingerne ovenfor for at tilføje et.',
    'de': 'Heute sind keine Mahlzeiten erfasst. Nutze die Schnellaktionen oben, um eine hinzuzufügen.',
    'el': 'Δεν έχουν καταγραφεί γεύματα σήμερα. Χρησιμοποιήστε τις γρήγορες ενέργειες παραπάνω για να προσθέσετε.',
    'en': 'No meals recorded today. Use the quick actions above to add one.',
    'es': 'Hoy no hay comidas registradas. Usa las acciones rápidas de arriba para añadir una.',
    'et': 'Täna pole toidukordi salvestatud. Lisa üks ülalolevate kiirtoimingutega.',
    'eu': 'Gaur ez da otordurik erregistratu. Gehitu bat goiko ekintza azkarrekin.',
    'fa': 'امروز وعده‌ای ثبت نشده است. برای افزودن از اقدام‌های سریع بالا استفاده کنید.',
    'fi': 'Tänään ei ole kirjattuja aterioita. Lisää yksi käyttämällä yllä olevia pikatoimintoja.',
    'fil': 'Walang pagkaing na-record ngayon. Gamitin ang mga mabilisang aksyon sa itaas para magdagdag.',
    'fr': 'Aucun repas enregistré aujourd’hui. Utilisez les actions rapides ci-dessus pour en ajouter un.',
    'gl': 'Hoxe non hai comidas rexistradas. Usa as accións rápidas de arriba para engadir unha.',
    'gu': 'આજે કોઈ ભોજન નોંધાયું નથી. ઉમેરવા માટે ઉપરની ઝડપી ક્રિયાઓ વાપરો.',
    'he': 'לא תועדו ארוחות היום. השתמשו בפעולות המהירות למעלה כדי להוסיף אחת.',
    'hi': 'आज कोई भोजन दर्ज नहीं है। जोड़ने के लिए ऊपर के त्वरित कार्यों का उपयोग करें।',
    'hr': 'Danas nema zabilježenih obroka. Za dodavanje koristite brze radnje gore.',
    'hu': 'Ma nincs rögzített étkezés. A fenti gyors műveletekkel adhatsz hozzá egyet.',
    'hy': 'Այսօր ճաշեր չեն գրանցվել։ Ավելացնելու համար օգտագործեք վերևի արագ գործողությունները։',
    'id': 'Belum ada makanan tercatat hari ini. Gunakan tindakan cepat di atas untuk menambah.',
    'is': 'Engar máltíðir skráðar í dag. Notaðu flýtiaðgerðirnar hér að ofan til að bæta við einni.',
    'it': 'Oggi nessun pasto registrato. Usa le azioni rapide sopra per aggiungerne uno.',
    'ja': '今日は食事が記録されていません。上のクイック操作から追加できます。',
    'ka': 'დღეს კვება ჩაწერილი არ არის. დაამატეთ ზემოთ მოცემული სწრაფი მოქმედებებით.',
    'kk': 'Бүгін тамақ жазылмаған. Жоғарыдағы жылдам әрекеттер арқылы қосыңыз.',
    'kn': 'ಇಂದು ಯಾವುದೇ ಊಟ ದಾಖಲಾಗಿಲ್ಲ. ಸೇರಿಸಲು ಮೇಲಿನ ತ್ವರಿತ ಕ್ರಿಯೆಗಳನ್ನು ಬಳಸಿ.',
    'ko': '오늘 기록된 식사가 없습니다. 위의 빠른 작업으로 추가하세요.',
    'ky': 'Бүгүн тамак жазылган жок. Кошүү үчүн жогорку тез аракеттерди колдонуңуз.',
    'lo': 'ມື້ນີ້ຍັງບໍ່ໄດ້ບັນທຶກອາຫານ. ເພີ່ມໂດຍໃຊ້ການກະທຳດ່ວນຂ້າງເທິງ.',
    'lt': 'Šiandien valgių neužfiksuota. Pridėkite naudodami sparčiuosius veiksmus aukščiau.',
    'lv': 'Šodien nav ierakstītu ēdienreižu. Pievienojiet, izmantojot ātrās darbības augstāk.',
    'mk': 'Денес нема запишани оброци. Користете ги брзите дејства горе за да додадете.',
    'ml': 'ഇന്ന് ഭക്ഷണമൊന്നും രേഖപ്പെടുത്തിയിട്ടില്ല. ചേർക്കാൻ മുകളിലെ ദ്രുത പ്രവർത്തനങ്ങൾ ഉപയോഗിക്കുക.',
    'mn': 'Өнөөдөр хоол бүртгээгүй. Нэмэхийн тулд дээрх хурдан үйлдлүүдийг ашиглаарай.',
    'mr': 'आज कोणतेही जेवण नोंदवले नाही. जोडण्यासाठी वरील जलद कृती वापरा.',
    'ms': 'Tiada hidangan direkod hari ini. Gunakan tindakan pantas di atas untuk menambah.',
    'my': 'ယနေ့ အစားအစာ မှတ်တမ်းမတင်ရသေးပါ။ ထည့်ရန် အပေါ်ရှိ မြန်ဆန်လုပ်ဆောင်ချက်များကို သုံးပါ။',
    'ne': 'आज कुनै खाना रेकर्ड गरिएको छैन। थप्न माथिको द्रत कार्यहरू प्रयोग गर्नुहोस्।',
    'nl': 'Vandaag geen maaltijden vastgelegd. Gebruik de snelle acties hierboven om er een toe te voegen.',
    'pa': 'ਅੱਜ ਕੋਈ ਖਾਣਾ ਦਰਜ ਨਹੀਂ ਹੋਇਆ। ਜੋੜਨ ਲਈ ਉੱਪਰਲੀਆਂ ਤੇਜ਼ ਕਾਰਵਾਈਆਂ ਵਰਤੋ।',
    'pl': 'Dziś nie zapisano posiłków. Użyj szybkich akcji powyżej, aby dodać.',
    'pt': 'Nenhuma refeição registrada hoje. Use as ações rápidas acima para adicionar uma.',
    'ro': 'Nicio masă înregistrată azi. Folosește acțiunile rapide de mai sus pentru a adăuga una.',
    'ru': 'Сегодня приёмы пищи не записаны. Добавьте с помощью быстрых действий выше.',
    'si': 'අද ආහාර වේල් සටහන් කර නැත. එකතු කිරීමට ඉහළ ඉක්මන් ක්‍රියාමාර්ග භාවිත කරන්න.',
    'sk': 'Dnes nie sú zaznamenané žiadne jedlá. Pridajte pomocou rýchlych akcií vyššie.',
    'sl': 'Danes ni zabeleženih obrokov. Za dodajanje uporabite hitra dejanja zgoraj.',
    'sq': 'Sot nuk është regjistruar asnjë vakt. Përdor veprimet e shpejta më sipër për të shtuar.',
    'sr': 'Данас нема забележених оброка. Користите брзе радње изнад да додате.',
    'sv': 'Inga måltider registrerade idag. Använd snabbåtgärderna ovan för att lägga till en.',
    'sw': 'Hakuna milo iliyorekodiwa leo. Tumia vitendo vya haraka hapo juu kuongeza.',
    'ta': 'இன்று உணவுகள் பதிவு செய்யப்படவில்லை. சேர்க்க மேலே உள்ள விரைவு செயல்களைப் பயன்படுத்தவும்.',
    'te': 'ఈరోజు భోజనాలు నమోదు కాలేదు. జోడించడానికి పైన ఉన్న త్వరిత చర్యలను ఉపయోగించండి.',
    'th': 'วันนี้ยังไม่ได้บันทึกมื้ออาหาร ใช้การดำเนินการด่วนด้านบนเพื่อเพิ่ม',
    'tr': 'Bugün kayıtlı öğün yok. Yukarıdaki hızlı eylemlerden öğün ekleyebilirsiniz.',
    'uk': 'Сьогодні прийоми їжі не записано. Додайте за допомогою швидких дій угорі.',
    'ur': 'آج کوئی کھانا درج نہیں ہوا۔ شامل کرنے کے لیے اوپر کے فوری اقدامات استعمال کریں۔',
    'vi': 'Hôm nay chưa ghi bữa ăn nào. Dùng thao tác nhanh phía trên để thêm.',
    'zh': '今天没有饮食记录。请使用上方的快捷操作添加。',
    'zh_Hant': '今天尚未記錄餐點。請使用上方的快速操作來新增。',
    'zu': 'Akukho ukudla okurekhodiwe namuhla. Sebenzisa izenzo ezisheshayo ezingezansi ukuze ungeze.',
}


def main():
    updated = 0
    for code, value in T.items():
        path = os.path.join(ARB_DIR, f'app_{code}.arb')
        if not os.path.isfile(path):
            print(f'MISSING {code}')
            continue
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        # Replace the value of todayNutritionEmpty. Escape any " in the value.
        safe = value.replace('"', '\\"')
        new_content, n = re.subn(
            r'("todayNutritionEmpty":\s*")[^"]*(")',
            lambda m: m.group(1) + safe + m.group(2),
            content,
            count=1,
        )
        if n == 0:
            print(f'NO MATCH {code}')
            continue
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        updated += 1
    print(f'Updated {updated} ARB files')


if __name__ == '__main__':
    main()
