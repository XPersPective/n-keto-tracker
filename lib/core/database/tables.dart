import 'package:drift/drift.dart';

/// N Keto Tracker veri modeli — MASTER_PROMPT §13'teki 27 tablo.
///
/// Kimlik stratejisi (çakışma yasağı):
/// - Seed içerik tabloları (Food, Recipe, SymptomDefinition, ContextTag,
///   EvidenceSource, EvidenceClaim, ContentVersion) TEXT birincil anahtar
///   kullanır; kullanıcı ekleri `user:` önekiyle UUID taşır.
/// - Salt kullanıcı tabloları INTEGER autoincrement kullanır.
///
/// Zaman stratejisi (MASTER §3.3): tüm zamanlar UTC; ölçüm anındaki yerel
/// UTC farkı dakika cinsinden ayrı sütunda saklanır.
///
/// Cascade kararları bilinçlidir ve tablo başına yorumla belirtilmiştir.

// ─── 1. AppSettings ─────────────────────────────────────────────────────────

@DataClassName('AppSettingsRow')
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get languageCode => text().nullable()();
  TextColumn get themeMode => text().nullable()();
  TextColumn get preferredCarbType =>
      text().withDefault(const Constant('net'))();
  IntColumn get matchingWindowMinutes =>
      integer().withDefault(const Constant(5))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
}

// ─── 2. ConsentRecords ──────────────────────────────────────────────────────

@DataClassName('ConsentRecordsRow')
class ConsentRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get consentVersion => text()();
  TextColumn get languageCode => text()();
  DateTimeColumn get acceptedAtUtc => dateTime()();
  TextColumn get textSha256 => text()();
}

// ─── 3. UserProfile ─────────────────────────────────────────────────────────

@DataClassName('UserProfileRow')
class UserProfile extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get birthYear => integer().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get currentWeightKg => real().nullable()();
  TextColumn get activityLevel => text().nullable()();
  // Mifflin–St Jeor katsayısı: cinsiyet kimliği DEĞİL, denklemin iki
  // doğrulanmış katsayısından biri (MASTER §4 adım 6); null = atlandı.
  TextColumn get energyCoefficient => text().nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();
}

// ─── 4. RiskScreening ───────────────────────────────────────────────────────

@DataClassName('RiskScreeningRow')
class RiskScreening extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get screenedAtUtc => dateTime()();
  BoolColumn get hasDiabetes => boolean()();
  BoolColumn get usesGlucoseLoweringMedication => boolean()();
  BoolColumn get pregnantOrBreastfeeding => boolean()();
  BoolColumn get kidneyLiverPancreasDisease => boolean()();
  BoolColumn get eatingDisorderHistory => boolean()();
  BoolColumn get unintentionalWeightLoss => boolean()();
  BoolColumn get under18 => boolean()();
  TextColumn get note => text().nullable()();
}

// ─── 5. EnergyEstimate ──────────────────────────────────────────────────────

@DataClassName('EnergyEstimateRow')
class EnergyEstimate extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Profil silinirse tahmin geçmişi de anlamsızdır → CASCADE.
  IntColumn get userProfileId =>
      integer().references(UserProfile, #id, onDelete: KeyAction.cascade)();
  RealColumn get reeKcal => real()();
  RealColumn get tdeeKcal => real()();
  TextColumn get formulaVersion => text()();
  TextColumn get inputsJson => text()();
  DateTimeColumn get computedAtUtc => dateTime()();
}

// ─── 6. Goal ────────────────────────────────────────────────────────────────

/// Üç hedef türü ASLA birleşmez (MASTER §6.5): researchReference /
/// clinicianTarget / personalTrackingGoal.
@DataClassName('GoalRow')
class Goal extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get goalType => text()();
  TextColumn get metric => text()();
  RealColumn get targetValue => real()();
  RealColumn get rangeLow => real().nullable()();
  RealColumn get rangeHigh => real().nullable()();
  // researchReference kaynaklı bantlar kanıt kaydına bağlıdır.
  TextColumn get sourceEvidenceId => text().nullable()();
  // clinicianTarget: kim verdi, ne zaman verdi (uygulama üretmez/doğrulamaz).
  TextColumn get clinicianName => text().nullable()();
  TextColumn get clinicianGivenAtIso => text().nullable()();
  TextColumn get personalNote => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAtUtc => dateTime()();
}

// ─── 7. Food ────────────────────────────────────────────────────────────────

@DataClassName('FoodRow')
class Food extends Table {
  TextColumn get id => text()();
  TextColumn get canonicalName => text()();
  TextColumn get nameTr => text().nullable()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get category => text()();
  RealColumn get kcalPer100g => real()();
  RealColumn get proteinGPer100g => real()();
  RealColumn get fatGPer100g => real()();
  RealColumn get carbohydrateTotalGPer100g => real()();
  RealColumn get fiberGPer100g => real().withDefault(const Constant(0))();
  RealColumn get netCarbGPer100g => real()();
  TextColumn get dataSource => text()();
  TextColumn get sourceVersion => text().nullable()();
  TextColumn get sourceRecordId => text().nullable()();
  TextColumn get license => text().nullable()();
  TextColumn get lastReviewedAtIso => text().nullable()();
  BoolColumn get isUserCreated =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 8. ServingOption ───────────────────────────────────────────────────────

@DataClassName('ServingOptionRow')
class ServingOption extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Besin silinince porsiyon seçenekleri de anlamsız → CASCADE.
  TextColumn get foodId =>
      text().references(Food, #id, onDelete: KeyAction.cascade)();
  TextColumn get labelTr => text().nullable()();
  TextColumn get labelEn => text().nullable()();
  RealColumn get gramsPerServing => real()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}

// ─── 9. Recipe ──────────────────────────────────────────────────────────────

@DataClassName('RecipeRow')
class Recipe extends Table {
  TextColumn get id => text()();
  TextColumn get titleTr => text().nullable()();
  TextColumn get titleEn => text().nullable()();
  IntColumn get servings => integer()();
  IntColumn get prepMinutes => integer().nullable()();
  TextColumn get allergensCsv => text().nullable()();
  TextColumn get stepsTr => text().nullable()();
  TextColumn get stepsEn => text().nullable()();
  TextColumn get storageNoteTr => text().nullable()();
  TextColumn get storageNoteEn => text().nullable()();
  TextColumn get netCarbMethodNote => text().nullable()();
  BoolColumn get isUserCreated =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAtUtc => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 10. RecipeIngredient ───────────────────────────────────────────────────

@DataClassName('RecipeIngredientRow')
class RecipeIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Tarif silinince malzemeleri de gider → CASCADE.
  TextColumn get recipeId =>
      text().references(Recipe, #id, onDelete: KeyAction.cascade)();
  // Kullanımdaki besin silinemez → RESTRICT (tarif bozulmasın).
  TextColumn get foodId =>
      text().references(Food, #id, onDelete: KeyAction.restrict)();
  RealColumn get grams => real()();
}

// ─── 11. Meal ───────────────────────────────────────────────────────────────

@DataClassName('MealRow')
class Meal extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mealType => text()();
  TextColumn get customName => text().nullable()();
  DateTimeColumn get eatenAtUtc => dateTime()();
  IntColumn get localOffsetMinutes => integer()();
  TextColumn get note => text().nullable()();
  // Hızlı tekrar/favori (MASTER §8.2): kullanıcı işaretler.
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

// ─── 12. MealItem ───────────────────────────────────────────────────────────

@DataClassName('MealItemRow')
class MealItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Öğün silinince öğe de gider → CASCADE.
  IntColumn get mealId =>
      integer().references(Meal, #id, onDelete: KeyAction.cascade)();
  TextColumn get foodId =>
      text().references(Food, #id, onDelete: KeyAction.restrict)();
  TextColumn get recipeId =>
      text().nullable().references(Recipe, #id, onDelete: KeyAction.restrict)();
  RealColumn get grams => real()();
  RealColumn get servingsCount => real().nullable()();
  // Kullanıcı etiketten özel net karb beyanı (MASTER §8.1).
  RealColumn get userNetCarbOverrideG => real().nullable()();
}

// ─── 13. GlucoseMeasurement ─────────────────────────────────────────────────

@DataClassName('GlucoseMeasurementRow')
class GlucoseMeasurement extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get rawValue => real()();
  TextColumn get rawUnit => text()(); // 'mg_dL' | 'mmol_L'
  RealColumn get mmolL => real()(); // normalize değer
  DateTimeColumn get measuredAtUtc => dateTime()();
  IntColumn get localOffsetMinutes => integer()();
  TextColumn get sourceType => text()(); // fingerstick|lab|cgm_manual|other
  // Bağlam etiketleri ContextTag.id JSON dizisi (MASTER §5.2).
  TextColumn get contextTagIdsJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get note => text().nullable()();
}

// ─── 14. KetoneMeasurement ──────────────────────────────────────────────────

@DataClassName('KetoneMeasurementRow')
class KetoneMeasurement extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get rawValue => real()();
  TextColumn get rawUnit => text().withDefault(const Constant('mmol_L'))();
  RealColumn get mmolL => real()();
  // Yalnız 'blood' GKI hesabına girer; idrar/nefes eğitim kaydıdır.
  TextColumn get subtype => text().withDefault(const Constant('blood'))();
  DateTimeColumn get measuredAtUtc => dateTime()();
  IntColumn get localOffsetMinutes => integer()();
  TextColumn get sourceType => text().nullable()();
  TextColumn get contextTagIdsJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get note => text().nullable()();
}

// ─── 15. MeasurementSession ─────────────────────────────────────────────────

@DataClassName('MeasurementSessionRow')
class MeasurementSession extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Oturum, ölçümlere referans verir (MASTER §13). Ölçüm silinirse oturum
  // satırı KALIR: FK SET NULL + isValid=false ile geçersizleştirilir ve
  // kullanıcıya bildirilir (MASTER §6.3) — denetim izi korunur.
  IntColumn get glucoseId => integer().nullable().references(
    GlucoseMeasurement,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get ketoneId => integer().nullable().references(
    KetoneMeasurement,
    #id,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get gkiValue => real()();
  TextColumn get formulaVersion => text()();
  IntColumn get matchDifferenceMinutes => integer().nullable()();
  TextColumn get matchKind => text()(); // simultaneous|approximate
  BoolColumn get confirmedByUser => boolean()();
  DateTimeColumn get computedAtUtc => dateTime()();
  BoolColumn get isValid => boolean().withDefault(const Constant(true))();
}

// ─── 16. WeightEntry ────────────────────────────────────────────────────────

@DataClassName('WeightEntryRow')
class WeightEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get rawValue => real()();
  TextColumn get rawUnit => text()(); // 'kg' | 'lb'
  RealColumn get kg => real()(); // normalize değer
  DateTimeColumn get measuredAtUtc => dateTime()();
  IntColumn get localOffsetMinutes => integer()();
  TextColumn get conditionNote => text().nullable()();
  TextColumn get note => text().nullable()();
}

// ─── 17. SymptomDefinition ──────────────────────────────────────────────────

@DataClassName('SymptomDefinitionRow')
class SymptomDefinition extends Table {
  TextColumn get id => text()();
  TextColumn get nameTr => text()();
  TextColumn get nameEn => text()();
  BoolColumn get isUserCreated =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 18. SymptomEntry ───────────────────────────────────────────────────────

@DataClassName('SymptomEntryRow')
class SymptomEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Kullanımdaki tanım silinemez → RESTRICT.
  TextColumn get symptomDefinitionId =>
      text().references(SymptomDefinition, #id, onDelete: KeyAction.restrict)();
  IntColumn get severity => integer()(); // 0–10
  DateTimeColumn get startedAtUtc => dateTime().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();
}

// ─── 19. ContextTag ─────────────────────────────────────────────────────────

@DataClassName('ContextTagRow')
class ContextTag extends Table {
  TextColumn get id => text()();
  TextColumn get labelTr => text()();
  TextColumn get labelEn => text()();
  BoolColumn get isUserCreated =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 20. MealPlan ───────────────────────────────────────────────────────────

@DataClassName('MealPlanRow')
class MealPlan extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get startDateIso => text()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();
}

// ─── 21. MealPlanEntry ──────────────────────────────────────────────────────

@DataClassName('MealPlanEntryRow')
class MealPlanEntry extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Plan silinince girdileri de gider → CASCADE.
  IntColumn get mealPlanId =>
      integer().references(MealPlan, #id, onDelete: KeyAction.cascade)();
  IntColumn get dayOffset => integer()(); // 0–6
  TextColumn get mealType => text()();
  TextColumn get recipeId =>
      text().nullable().references(Recipe, #id, onDelete: KeyAction.restrict)();
  RealColumn get servings => real()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
}

// ─── 22. ShoppingList ───────────────────────────────────────────────────────

@DataClassName('ShoppingListRow')
class ShoppingList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get dateStartIso => text().nullable()();
  TextColumn get dateEndIso => text().nullable()();
  DateTimeColumn get createdAtUtc => dateTime()();
}

// ─── 23. ShoppingListItem ───────────────────────────────────────────────────

@DataClassName('ShoppingListItemRow')
class ShoppingListItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Liste silinince maddeleri de gider → CASCADE.
  IntColumn get shoppingListId =>
      integer().references(ShoppingList, #id, onDelete: KeyAction.cascade)();
  TextColumn get foodId =>
      text().nullable().references(Food, #id, onDelete: KeyAction.restrict)();
  // Manuel madde: besin referansı yok, serbest metin.
  TextColumn get label => text().nullable()();
  RealColumn get quantityGrams => real().nullable()();
  TextColumn get quantityDisplay => text().nullable()();
  TextColumn get category => text().nullable()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
}

// ─── 24. EvidenceSource ─────────────────────────────────────────────────────

/// Alanları docs/EVIDENCE_SCHEMA.md birebir karşılık gelir.
@DataClassName('EvidenceSourceRow')
class EvidenceSource extends Table {
  TextColumn get id => text()();
  TextColumn get titleTr => text()();
  TextColumn get titleEn => text()();
  TextColumn get plainSummaryTr => text()();
  TextColumn get plainSummaryEn => text()();
  TextColumn get evidenceLevel => text()(); // E1–E6
  TextColumn get studyType => text()();
  TextColumn get population => text()();
  IntColumn get sampleSize => integer().nullable()();
  IntColumn get year => integer()();
  TextColumn get authorsCsv => text()();
  TextColumn get journal => text()();
  TextColumn get doi => text().nullable()();
  IntColumn get pmid => integer().nullable()();
  TextColumn get pmcid => text().nullable()();
  TextColumn get canonicalUrl => text()();
  TextColumn get accessedAtIso => text()();
  TextColumn get contentVersion => text()();
  TextColumn get lastReviewedAtIso => text()();
  TextColumn get reviewedByRole => text()();
  TextColumn get limitationsTr => text()();
  TextColumn get limitationsEn => text()();
  TextColumn get conflictsOrFundingNoteTr => text().nullable()();
  TextColumn get conflictsOrFundingNoteEn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 25. EvidenceClaim ──────────────────────────────────────────────────────

@DataClassName('EvidenceClaimRow')
class EvidenceClaim extends Table {
  TextColumn get id => text()();
  // Kaynak silinince iddia da gider → CASCADE (kaynaksız iddia yasak).
  TextColumn get sourceId =>
      text().references(EvidenceSource, #id, onDelete: KeyAction.cascade)();
  TextColumn get textTr => text()();
  TextColumn get textEn => text()();
  TextColumn get evidenceLevel => text()();
  TextColumn get linkedFeatureIdsCsv => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 26. ContentVersion ─────────────────────────────────────────────────────

@DataClassName('ContentVersionRow')
class ContentVersion extends Table {
  TextColumn get id => text()(); // içerik paketi: 'evidence'|'foods'|'recipes'
  TextColumn get version => text()();
  TextColumn get releasedAtIso => text()();
  TextColumn get changeLogTr => text().nullable()();
  TextColumn get changeLogEn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── 27. ExportHistory ──────────────────────────────────────────────────────

/// Yalnız metadata; dosya içeriği saklanmaz (MASTER §13).
@DataClassName('ExportHistoryRow')
class ExportHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get exportedAtUtc => dateTime()();
  TextColumn get format => text()(); // csv | json
  IntColumn get recordCount => integer().nullable()();
  IntColumn get schemaVersion => integer()();
  TextColumn get appVersion => text()();
  TextColumn get note => text().nullable()();
}
