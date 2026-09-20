import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'database.dart';

/// Kanıt kütüphanesi seed yükleyici (T25, MASTER_PROMPT §2.3).
/// Idempotent; içerik sürümü ContentVersion'a yazılır.
class EvidenceSeeder {
  EvidenceSeeder(this._db);

  final AppDatabase _db;

  static const String contentId = 'evidence';

  Future<int> seedFromAssets() async {
    final raw = await rootBundle.loadString('assets/seed/evidence.json');
    return seedFromJsonString(raw);
  }

  Future<int> seedFromJsonString(String raw) async {
    final doc = jsonDecode(raw) as Map<String, dynamic>;
    final sources = (doc['sources'] as List).cast<Map<String, dynamic>>();
    final version = doc['contentVersion'] as String;

    return _db.transaction(() async {
      var inserted = 0;
      for (final s in sources) {
        final id = s['id'] as String;
        final exists = await (_db.select(
          _db.evidenceSource,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        if (exists != null) continue;
        await _db
            .into(_db.evidenceSource)
            .insert(
              EvidenceSourceCompanion.insert(
                id: id,
                titleTr: s['titleTr'] as String,
                titleEn: s['titleEn'] as String,
                plainSummaryTr: s['plainSummaryTr'] as String,
                plainSummaryEn: s['plainSummaryEn'] as String,
                evidenceLevel: s['evidenceLevel'] as String,
                studyType: s['studyType'] as String,
                population: s['population'] as String,
                sampleSize: Value(s['sampleSize'] as int?),
                year: s['year'] as int,
                authorsCsv: (s['authors'] as List).cast<String>().join(','),
                journal: s['journal'] as String,
                doi: Value(s['doi'] as String?),
                pmid: Value(s['pmid'] as int?),
                pmcid: Value(s['pmcid'] as String?),
                canonicalUrl: s['canonicalUrl'] as String,
                accessedAtIso: s['accessedAt'] as String,
                contentVersion: version,
                lastReviewedAtIso:
                    s['accessedAt'] as String, // inceleme: derleme tarihi
                reviewedByRole: 'AI derleme; uzman incelemesi beklemede',
                limitationsTr: s['limitationsTr'] as String,
                limitationsEn: s['limitationsEn'] as String,
                conflictsOrFundingNoteTr: Value(s['conflictsTr'] as String?),
                conflictsOrFundingNoteEn: Value(s['conflictsEn'] as String?),
              ),
            );
        inserted++;
      }
      final versionExists =
          await (_db.select(_db.contentVersion)..where(
                (c) => c.id.equals(contentId) & c.version.equals(version),
              ))
              .getSingleOrNull();
      if (versionExists == null) {
        await _db
            .into(_db.contentVersion)
            .insert(
              ContentVersionCompanion.insert(
                id: contentId,
                version: version,
                releasedAtIso: doc['releasedAt'] as String? ?? '',
                changeLogTr: Value(doc['changeLogTr'] as String?),
                changeLogEn: Value(doc['changeLogEn'] as String?),
              ),
            );
      }
      return inserted;
    });
  }
}
