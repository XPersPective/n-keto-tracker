/// Hesap motoru formül sürümü (MASTER_PROMPT §2.4).
///
/// Formül veya birim dönüşümü değişirse bu sürüm artar; o zaman bilimsel
/// kaynak gözden geçirmesi, migration etkisi ve güncellenmiş referans
/// vektörleri olmadan merge YAPILAMAZ. Tüm hesap sonuçları bu sürümle
/// etiketlenir; UI/grafik/export aynı etiketi gösterir.
const String formulaVersion = 'gki-v1';

/// MASTER_PROMPT §2.4'ün normatif dönüştürücüsü: mg/dL → mmol/L.
///
/// Birincil kaynak (Meidenbauer 2015) 18,016 kullanır; spec 18,0'ı sabitler
/// ve 90/18 = 5,0 → GKI 2,0 referansını kilitler. Karar kaydı:
/// docs/research/EVIDENCE_VERIFICATION.md → 'Dönüşüm katsayısı kaydı'.
const double glucoseMgDlToMmolL = 18.0;
