import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// T25 kanıt provenance testleri (MASTER_PROMPT §16.5): her kayıtta
/// kaynak kimliği + kanıt sınıfı + inceleme tarihi; DOI/PMID/PMCID
/// biçimi; hastalığa özel işaret zorunlu.
void main() {
  final doc = jsonDecode(
    File('assets/seed/evidence.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  final sources = (doc['sources'] as List).cast<Map<String, dynamic>>();

  test('7 kaynak mevcut', () {
    expect(sources.length, 7);
  });

  test('her kaynakta provenance alanlarının tamamı dolu', () {
    for (final s in sources) {
      for (final key in [
        'id',
        'titleTr',
        'titleEn',
        'plainSummaryTr',
        'plainSummaryEn',
        'claimTr',
        'claimEn',
        'evidenceLevel',
        'studyType',
        'population',
        'year',
        'authors',
        'journal',
        'canonicalUrl',
        'accessedAt',
        'limitationsTr',
        'limitationsEn',
      ]) {
        expect(
          (s[key] ?? '').toString().trim(),
          isNotEmpty,
          reason: '${s['id']}: $key boş',
        );
      }
      // En az bir tanımlayıcı (doi/pmid/pmcid).
      expect(
        (s['doi'] ?? s['pmid'] ?? s['pmcid'] ?? ''),
        isNotEmpty,
        reason: '${s['id']}: en az bir tanımlayıcı olmalı',
      );
      // Kanıt sınıfı E1–E6.
      expect(s['evidenceLevel'], matches(RegExp(r'^E[1-6]$')));
      // diseaseSpecific işareti zorunlu (varsayılan görünüm filtresi).
      expect(s['diseaseSpecific'], isA<bool>());
    }
  });

  test('DOI/PMCID biçimleri geçerli (kırık tanımlayıcı build engeli)', () {
    for (final s in sources) {
      final doi = s['doi'] as String?;
      if (doi != null) {
        expect(
          doi,
          matches(RegExp(r'^10\.\d{4,9}/\S+$')),
          reason: '${s['id']}: DOI biçimi',
        );
      }
      final pmcid = s['pmcid'] as String?;
      if (pmcid != null) {
        expect(
          pmcid,
          matches(RegExp(r'^PMC\d+$')),
          reason: '${s['id']}: PMCID biçimi',
        );
      }
      final pmid = s['pmid'] as int?;
      if (pmid != null) {
        expect(pmid, greaterThan(0));
      }
    }
  });

  test('5. kaynak Amaral LJ (T2 düzeltmesi uygulandı)', () {
    final amaral = sources.singleWhere((s) => s['id'] == 'ev-phase1-2025');
    expect((amaral['authors'] as List).first, 'Amaral LJ');
  });

  test('genel kaynaklar varsayılan görünümde yeterli; hastalığa özel '
      'işaretli', () {
    final general = sources
        .where((s) => !(s['diseaseSpecific'] as bool))
        .toList();
    final disease = sources.where((s) => s['diseaseSpecific'] as bool).toList();
    expect(general, isNotEmpty, reason: 'varsayılan görünüm boş olamaz');
    expect(disease, isNotEmpty, reason: 'hastalığa özel bölüm boş olamaz');
    // Genel kaynaklarda hastalık kelimesi geçmemeli (AC4: ana görünüm
    // hastalık çağrışımı içermemeli).
    for (final s in general) {
      final text = jsonEncode(s).toLowerCase();
      for (final word in ['glioblastoma', 'glioma', 'cancer', 'brain tumor']) {
        expect(
          text.contains(word),
          isFalse,
          reason: '${s['id']}: genel kaynakta hastalık kelimesi: $word',
        );
      }
    }
  });
}
