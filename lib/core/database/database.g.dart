// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredCarbTypeMeta = const VerificationMeta(
    'preferredCarbType',
  );
  @override
  late final GeneratedColumn<String> preferredCarbType =
      GeneratedColumn<String>(
        'preferred_carb_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('net'),
      );
  static const VerificationMeta _matchingWindowMinutesMeta =
      const VerificationMeta('matchingWindowMinutes');
  @override
  late final GeneratedColumn<int> matchingWindowMinutes = GeneratedColumn<int>(
    'matching_window_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    languageCode,
    themeMode,
    preferredCarbType,
    matchingWindowMinutes,
    onboardingCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('preferred_carb_type')) {
      context.handle(
        _preferredCarbTypeMeta,
        preferredCarbType.isAcceptableOrUnknown(
          data['preferred_carb_type']!,
          _preferredCarbTypeMeta,
        ),
      );
    }
    if (data.containsKey('matching_window_minutes')) {
      context.handle(
        _matchingWindowMinutesMeta,
        matchingWindowMinutes.isAcceptableOrUnknown(
          data['matching_window_minutes']!,
          _matchingWindowMinutesMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      ),
      preferredCarbType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_carb_type'],
      )!,
      matchingWindowMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}matching_window_minutes'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingsRow extends DataClass implements Insertable<AppSettingsRow> {
  final int id;
  final String? languageCode;
  final String? themeMode;
  final String preferredCarbType;
  final int matchingWindowMinutes;
  final bool onboardingCompleted;
  const AppSettingsRow({
    required this.id,
    this.languageCode,
    this.themeMode,
    required this.preferredCarbType,
    required this.matchingWindowMinutes,
    required this.onboardingCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    if (!nullToAbsent || themeMode != null) {
      map['theme_mode'] = Variable<String>(themeMode);
    }
    map['preferred_carb_type'] = Variable<String>(preferredCarbType);
    map['matching_window_minutes'] = Variable<int>(matchingWindowMinutes);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      themeMode: themeMode == null && nullToAbsent
          ? const Value.absent()
          : Value(themeMode),
      preferredCarbType: Value(preferredCarbType),
      matchingWindowMinutes: Value(matchingWindowMinutes),
      onboardingCompleted: Value(onboardingCompleted),
    );
  }

  factory AppSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      languageCode: serializer.fromJson<String?>(json['languageCode']),
      themeMode: serializer.fromJson<String?>(json['themeMode']),
      preferredCarbType: serializer.fromJson<String>(json['preferredCarbType']),
      matchingWindowMinutes: serializer.fromJson<int>(
        json['matchingWindowMinutes'],
      ),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'languageCode': serializer.toJson<String?>(languageCode),
      'themeMode': serializer.toJson<String?>(themeMode),
      'preferredCarbType': serializer.toJson<String>(preferredCarbType),
      'matchingWindowMinutes': serializer.toJson<int>(matchingWindowMinutes),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
    };
  }

  AppSettingsRow copyWith({
    int? id,
    Value<String?> languageCode = const Value.absent(),
    Value<String?> themeMode = const Value.absent(),
    String? preferredCarbType,
    int? matchingWindowMinutes,
    bool? onboardingCompleted,
  }) => AppSettingsRow(
    id: id ?? this.id,
    languageCode: languageCode.present ? languageCode.value : this.languageCode,
    themeMode: themeMode.present ? themeMode.value : this.themeMode,
    preferredCarbType: preferredCarbType ?? this.preferredCarbType,
    matchingWindowMinutes: matchingWindowMinutes ?? this.matchingWindowMinutes,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
  );
  AppSettingsRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      preferredCarbType: data.preferredCarbType.present
          ? data.preferredCarbType.value
          : this.preferredCarbType,
      matchingWindowMinutes: data.matchingWindowMinutes.present
          ? data.matchingWindowMinutes.value
          : this.matchingWindowMinutes,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsRow(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('preferredCarbType: $preferredCarbType, ')
          ..write('matchingWindowMinutes: $matchingWindowMinutes, ')
          ..write('onboardingCompleted: $onboardingCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    languageCode,
    themeMode,
    preferredCarbType,
    matchingWindowMinutes,
    onboardingCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsRow &&
          other.id == this.id &&
          other.languageCode == this.languageCode &&
          other.themeMode == this.themeMode &&
          other.preferredCarbType == this.preferredCarbType &&
          other.matchingWindowMinutes == this.matchingWindowMinutes &&
          other.onboardingCompleted == this.onboardingCompleted);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingsRow> {
  final Value<int> id;
  final Value<String?> languageCode;
  final Value<String?> themeMode;
  final Value<String> preferredCarbType;
  final Value<int> matchingWindowMinutes;
  final Value<bool> onboardingCompleted;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.preferredCarbType = const Value.absent(),
    this.matchingWindowMinutes = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.preferredCarbType = const Value.absent(),
    this.matchingWindowMinutes = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AppSettingsRow> custom({
    Expression<int>? id,
    Expression<String>? languageCode,
    Expression<String>? themeMode,
    Expression<String>? preferredCarbType,
    Expression<int>? matchingWindowMinutes,
    Expression<bool>? onboardingCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (themeMode != null) 'theme_mode': themeMode,
      if (preferredCarbType != null) 'preferred_carb_type': preferredCarbType,
      if (matchingWindowMinutes != null)
        'matching_window_minutes': matchingWindowMinutes,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? languageCode,
    Value<String?>? themeMode,
    Value<String>? preferredCarbType,
    Value<int>? matchingWindowMinutes,
    Value<bool>? onboardingCompleted,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      preferredCarbType: preferredCarbType ?? this.preferredCarbType,
      matchingWindowMinutes:
          matchingWindowMinutes ?? this.matchingWindowMinutes,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (preferredCarbType.present) {
      map['preferred_carb_type'] = Variable<String>(preferredCarbType.value);
    }
    if (matchingWindowMinutes.present) {
      map['matching_window_minutes'] = Variable<int>(
        matchingWindowMinutes.value,
      );
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('themeMode: $themeMode, ')
          ..write('preferredCarbType: $preferredCarbType, ')
          ..write('matchingWindowMinutes: $matchingWindowMinutes, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsentRecordsTable extends ConsentRecords
    with TableInfo<$ConsentRecordsTable, ConsentRecordsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsentRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _consentVersionMeta = const VerificationMeta(
    'consentVersion',
  );
  @override
  late final GeneratedColumn<String> consentVersion = GeneratedColumn<String>(
    'consent_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acceptedAtUtcMeta = const VerificationMeta(
    'acceptedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> acceptedAtUtc =
      GeneratedColumn<DateTime>(
        'accepted_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _textSha256Meta = const VerificationMeta(
    'textSha256',
  );
  @override
  late final GeneratedColumn<String> textSha256 = GeneratedColumn<String>(
    'text_sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    consentVersion,
    languageCode,
    acceptedAtUtc,
    textSha256,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consent_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsentRecordsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('consent_version')) {
      context.handle(
        _consentVersionMeta,
        consentVersion.isAcceptableOrUnknown(
          data['consent_version']!,
          _consentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_consentVersionMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('accepted_at_utc')) {
      context.handle(
        _acceptedAtUtcMeta,
        acceptedAtUtc.isAcceptableOrUnknown(
          data['accepted_at_utc']!,
          _acceptedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_acceptedAtUtcMeta);
    }
    if (data.containsKey('text_sha256')) {
      context.handle(
        _textSha256Meta,
        textSha256.isAcceptableOrUnknown(data['text_sha256']!, _textSha256Meta),
      );
    } else if (isInserting) {
      context.missing(_textSha256Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsentRecordsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsentRecordsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      consentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}consent_version'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      acceptedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accepted_at_utc'],
      )!,
      textSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_sha256'],
      )!,
    );
  }

  @override
  $ConsentRecordsTable createAlias(String alias) {
    return $ConsentRecordsTable(attachedDatabase, alias);
  }
}

class ConsentRecordsRow extends DataClass
    implements Insertable<ConsentRecordsRow> {
  final int id;
  final String consentVersion;
  final String languageCode;
  final DateTime acceptedAtUtc;
  final String textSha256;
  const ConsentRecordsRow({
    required this.id,
    required this.consentVersion,
    required this.languageCode,
    required this.acceptedAtUtc,
    required this.textSha256,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['consent_version'] = Variable<String>(consentVersion);
    map['language_code'] = Variable<String>(languageCode);
    map['accepted_at_utc'] = Variable<DateTime>(acceptedAtUtc);
    map['text_sha256'] = Variable<String>(textSha256);
    return map;
  }

  ConsentRecordsCompanion toCompanion(bool nullToAbsent) {
    return ConsentRecordsCompanion(
      id: Value(id),
      consentVersion: Value(consentVersion),
      languageCode: Value(languageCode),
      acceptedAtUtc: Value(acceptedAtUtc),
      textSha256: Value(textSha256),
    );
  }

  factory ConsentRecordsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsentRecordsRow(
      id: serializer.fromJson<int>(json['id']),
      consentVersion: serializer.fromJson<String>(json['consentVersion']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      acceptedAtUtc: serializer.fromJson<DateTime>(json['acceptedAtUtc']),
      textSha256: serializer.fromJson<String>(json['textSha256']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'consentVersion': serializer.toJson<String>(consentVersion),
      'languageCode': serializer.toJson<String>(languageCode),
      'acceptedAtUtc': serializer.toJson<DateTime>(acceptedAtUtc),
      'textSha256': serializer.toJson<String>(textSha256),
    };
  }

  ConsentRecordsRow copyWith({
    int? id,
    String? consentVersion,
    String? languageCode,
    DateTime? acceptedAtUtc,
    String? textSha256,
  }) => ConsentRecordsRow(
    id: id ?? this.id,
    consentVersion: consentVersion ?? this.consentVersion,
    languageCode: languageCode ?? this.languageCode,
    acceptedAtUtc: acceptedAtUtc ?? this.acceptedAtUtc,
    textSha256: textSha256 ?? this.textSha256,
  );
  ConsentRecordsRow copyWithCompanion(ConsentRecordsCompanion data) {
    return ConsentRecordsRow(
      id: data.id.present ? data.id.value : this.id,
      consentVersion: data.consentVersion.present
          ? data.consentVersion.value
          : this.consentVersion,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      acceptedAtUtc: data.acceptedAtUtc.present
          ? data.acceptedAtUtc.value
          : this.acceptedAtUtc,
      textSha256: data.textSha256.present
          ? data.textSha256.value
          : this.textSha256,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsentRecordsRow(')
          ..write('id: $id, ')
          ..write('consentVersion: $consentVersion, ')
          ..write('languageCode: $languageCode, ')
          ..write('acceptedAtUtc: $acceptedAtUtc, ')
          ..write('textSha256: $textSha256')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, consentVersion, languageCode, acceptedAtUtc, textSha256);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsentRecordsRow &&
          other.id == this.id &&
          other.consentVersion == this.consentVersion &&
          other.languageCode == this.languageCode &&
          other.acceptedAtUtc == this.acceptedAtUtc &&
          other.textSha256 == this.textSha256);
}

class ConsentRecordsCompanion extends UpdateCompanion<ConsentRecordsRow> {
  final Value<int> id;
  final Value<String> consentVersion;
  final Value<String> languageCode;
  final Value<DateTime> acceptedAtUtc;
  final Value<String> textSha256;
  const ConsentRecordsCompanion({
    this.id = const Value.absent(),
    this.consentVersion = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.acceptedAtUtc = const Value.absent(),
    this.textSha256 = const Value.absent(),
  });
  ConsentRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String consentVersion,
    required String languageCode,
    required DateTime acceptedAtUtc,
    required String textSha256,
  }) : consentVersion = Value(consentVersion),
       languageCode = Value(languageCode),
       acceptedAtUtc = Value(acceptedAtUtc),
       textSha256 = Value(textSha256);
  static Insertable<ConsentRecordsRow> custom({
    Expression<int>? id,
    Expression<String>? consentVersion,
    Expression<String>? languageCode,
    Expression<DateTime>? acceptedAtUtc,
    Expression<String>? textSha256,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (consentVersion != null) 'consent_version': consentVersion,
      if (languageCode != null) 'language_code': languageCode,
      if (acceptedAtUtc != null) 'accepted_at_utc': acceptedAtUtc,
      if (textSha256 != null) 'text_sha256': textSha256,
    });
  }

  ConsentRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? consentVersion,
    Value<String>? languageCode,
    Value<DateTime>? acceptedAtUtc,
    Value<String>? textSha256,
  }) {
    return ConsentRecordsCompanion(
      id: id ?? this.id,
      consentVersion: consentVersion ?? this.consentVersion,
      languageCode: languageCode ?? this.languageCode,
      acceptedAtUtc: acceptedAtUtc ?? this.acceptedAtUtc,
      textSha256: textSha256 ?? this.textSha256,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (consentVersion.present) {
      map['consent_version'] = Variable<String>(consentVersion.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (acceptedAtUtc.present) {
      map['accepted_at_utc'] = Variable<DateTime>(acceptedAtUtc.value);
    }
    if (textSha256.present) {
      map['text_sha256'] = Variable<String>(textSha256.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsentRecordsCompanion(')
          ..write('id: $id, ')
          ..write('consentVersion: $consentVersion, ')
          ..write('languageCode: $languageCode, ')
          ..write('acceptedAtUtc: $acceptedAtUtc, ')
          ..write('textSha256: $textSha256')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTable extends UserProfile
    with TableInfo<$UserProfileTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _birthYearMeta = const VerificationMeta(
    'birthYear',
  );
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
    'birth_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentWeightKgMeta = const VerificationMeta(
    'currentWeightKg',
  );
  @override
  late final GeneratedColumn<double> currentWeightKg = GeneratedColumn<double>(
    'current_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityLevelMeta = const VerificationMeta(
    'activityLevel',
  );
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
    'activity_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _energyCoefficientMeta = const VerificationMeta(
    'energyCoefficient',
  );
  @override
  late final GeneratedColumn<String> energyCoefficient =
      GeneratedColumn<String>(
        'energy_coefficient',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtUtcMeta = const VerificationMeta(
    'updatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtUtc = GeneratedColumn<DateTime>(
    'updated_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    birthYear,
    heightCm,
    currentWeightKg,
    activityLevel,
    energyCoefficient,
    createdAtUtc,
    updatedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('birth_year')) {
      context.handle(
        _birthYearMeta,
        birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('current_weight_kg')) {
      context.handle(
        _currentWeightKgMeta,
        currentWeightKg.isAcceptableOrUnknown(
          data['current_weight_kg']!,
          _currentWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('activity_level')) {
      context.handle(
        _activityLevelMeta,
        activityLevel.isAcceptableOrUnknown(
          data['activity_level']!,
          _activityLevelMeta,
        ),
      );
    }
    if (data.containsKey('energy_coefficient')) {
      context.handle(
        _energyCoefficientMeta,
        energyCoefficient.isAcceptableOrUnknown(
          data['energy_coefficient']!,
          _energyCoefficientMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
        _updatedAtUtcMeta,
        updatedAtUtc.isAcceptableOrUnknown(
          data['updated_at_utc']!,
          _updatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      birthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_year'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      currentWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_weight_kg'],
      ),
      activityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_level'],
      ),
      energyCoefficient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_coefficient'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      updatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_utc'],
      )!,
    );
  }

  @override
  $UserProfileTable createAlias(String alias) {
    return $UserProfileTable(attachedDatabase, alias);
  }
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final int id;
  final int? birthYear;
  final double? heightCm;
  final double? currentWeightKg;
  final String? activityLevel;
  final String? energyCoefficient;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
  const UserProfileRow({
    required this.id,
    this.birthYear,
    this.heightCm,
    this.currentWeightKg,
    this.activityLevel,
    this.energyCoefficient,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || birthYear != null) {
      map['birth_year'] = Variable<int>(birthYear);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || currentWeightKg != null) {
      map['current_weight_kg'] = Variable<double>(currentWeightKg);
    }
    if (!nullToAbsent || activityLevel != null) {
      map['activity_level'] = Variable<String>(activityLevel);
    }
    if (!nullToAbsent || energyCoefficient != null) {
      map['energy_coefficient'] = Variable<String>(energyCoefficient);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc);
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      id: Value(id),
      birthYear: birthYear == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYear),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      currentWeightKg: currentWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(currentWeightKg),
      activityLevel: activityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(activityLevel),
      energyCoefficient: energyCoefficient == null && nullToAbsent
          ? const Value.absent()
          : Value(energyCoefficient),
      createdAtUtc: Value(createdAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
    );
  }

  factory UserProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<int>(json['id']),
      birthYear: serializer.fromJson<int?>(json['birthYear']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      currentWeightKg: serializer.fromJson<double?>(json['currentWeightKg']),
      activityLevel: serializer.fromJson<String?>(json['activityLevel']),
      energyCoefficient: serializer.fromJson<String?>(
        json['energyCoefficient'],
      ),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      updatedAtUtc: serializer.fromJson<DateTime>(json['updatedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'birthYear': serializer.toJson<int?>(birthYear),
      'heightCm': serializer.toJson<double?>(heightCm),
      'currentWeightKg': serializer.toJson<double?>(currentWeightKg),
      'activityLevel': serializer.toJson<String?>(activityLevel),
      'energyCoefficient': serializer.toJson<String?>(energyCoefficient),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'updatedAtUtc': serializer.toJson<DateTime>(updatedAtUtc),
    };
  }

  UserProfileRow copyWith({
    int? id,
    Value<int?> birthYear = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> currentWeightKg = const Value.absent(),
    Value<String?> activityLevel = const Value.absent(),
    Value<String?> energyCoefficient = const Value.absent(),
    DateTime? createdAtUtc,
    DateTime? updatedAtUtc,
  }) => UserProfileRow(
    id: id ?? this.id,
    birthYear: birthYear.present ? birthYear.value : this.birthYear,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    currentWeightKg: currentWeightKg.present
        ? currentWeightKg.value
        : this.currentWeightKg,
    activityLevel: activityLevel.present
        ? activityLevel.value
        : this.activityLevel,
    energyCoefficient: energyCoefficient.present
        ? energyCoefficient.value
        : this.energyCoefficient,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
  );
  UserProfileRow copyWithCompanion(UserProfileCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      currentWeightKg: data.currentWeightKg.present
          ? data.currentWeightKg.value
          : this.currentWeightKg,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      energyCoefficient: data.energyCoefficient.present
          ? data.energyCoefficient.value
          : this.energyCoefficient,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('birthYear: $birthYear, ')
          ..write('heightCm: $heightCm, ')
          ..write('currentWeightKg: $currentWeightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('energyCoefficient: $energyCoefficient, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    birthYear,
    heightCm,
    currentWeightKg,
    activityLevel,
    energyCoefficient,
    createdAtUtc,
    updatedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.birthYear == this.birthYear &&
          other.heightCm == this.heightCm &&
          other.currentWeightKg == this.currentWeightKg &&
          other.activityLevel == this.activityLevel &&
          other.energyCoefficient == this.energyCoefficient &&
          other.createdAtUtc == this.createdAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc);
}

class UserProfileCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<int> id;
  final Value<int?> birthYear;
  final Value<double?> heightCm;
  final Value<double?> currentWeightKg;
  final Value<String?> activityLevel;
  final Value<String?> energyCoefficient;
  final Value<DateTime> createdAtUtc;
  final Value<DateTime> updatedAtUtc;
  const UserProfileCompanion({
    this.id = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.currentWeightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.energyCoefficient = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
  });
  UserProfileCompanion.insert({
    this.id = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.currentWeightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.energyCoefficient = const Value.absent(),
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
  }) : createdAtUtc = Value(createdAtUtc),
       updatedAtUtc = Value(updatedAtUtc);
  static Insertable<UserProfileRow> custom({
    Expression<int>? id,
    Expression<int>? birthYear,
    Expression<double>? heightCm,
    Expression<double>? currentWeightKg,
    Expression<String>? activityLevel,
    Expression<String>? energyCoefficient,
    Expression<DateTime>? createdAtUtc,
    Expression<DateTime>? updatedAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (birthYear != null) 'birth_year': birthYear,
      if (heightCm != null) 'height_cm': heightCm,
      if (currentWeightKg != null) 'current_weight_kg': currentWeightKg,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (energyCoefficient != null) 'energy_coefficient': energyCoefficient,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
    });
  }

  UserProfileCompanion copyWith({
    Value<int>? id,
    Value<int?>? birthYear,
    Value<double?>? heightCm,
    Value<double?>? currentWeightKg,
    Value<String?>? activityLevel,
    Value<String?>? energyCoefficient,
    Value<DateTime>? createdAtUtc,
    Value<DateTime>? updatedAtUtc,
  }) {
    return UserProfileCompanion(
      id: id ?? this.id,
      birthYear: birthYear ?? this.birthYear,
      heightCm: heightCm ?? this.heightCm,
      currentWeightKg: currentWeightKg ?? this.currentWeightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      energyCoefficient: energyCoefficient ?? this.energyCoefficient,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (currentWeightKg.present) {
      map['current_weight_kg'] = Variable<double>(currentWeightKg.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    if (energyCoefficient.present) {
      map['energy_coefficient'] = Variable<String>(energyCoefficient.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('id: $id, ')
          ..write('birthYear: $birthYear, ')
          ..write('heightCm: $heightCm, ')
          ..write('currentWeightKg: $currentWeightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('energyCoefficient: $energyCoefficient, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }
}

class $RiskScreeningTable extends RiskScreening
    with TableInfo<$RiskScreeningTable, RiskScreeningRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RiskScreeningTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _screenedAtUtcMeta = const VerificationMeta(
    'screenedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> screenedAtUtc =
      GeneratedColumn<DateTime>(
        'screened_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _hasDiabetesMeta = const VerificationMeta(
    'hasDiabetes',
  );
  @override
  late final GeneratedColumn<bool> hasDiabetes = GeneratedColumn<bool>(
    'has_diabetes',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_diabetes" IN (0, 1))',
    ),
  );
  static const VerificationMeta _usesGlucoseLoweringMedicationMeta =
      const VerificationMeta('usesGlucoseLoweringMedication');
  @override
  late final GeneratedColumn<bool> usesGlucoseLoweringMedication =
      GeneratedColumn<bool>(
        'uses_glucose_lowering_medication',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("uses_glucose_lowering_medication" IN (0, 1))',
        ),
      );
  static const VerificationMeta _pregnantOrBreastfeedingMeta =
      const VerificationMeta('pregnantOrBreastfeeding');
  @override
  late final GeneratedColumn<bool> pregnantOrBreastfeeding =
      GeneratedColumn<bool>(
        'pregnant_or_breastfeeding',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pregnant_or_breastfeeding" IN (0, 1))',
        ),
      );
  static const VerificationMeta _kidneyLiverPancreasDiseaseMeta =
      const VerificationMeta('kidneyLiverPancreasDisease');
  @override
  late final GeneratedColumn<bool> kidneyLiverPancreasDisease =
      GeneratedColumn<bool>(
        'kidney_liver_pancreas_disease',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("kidney_liver_pancreas_disease" IN (0, 1))',
        ),
      );
  static const VerificationMeta _eatingDisorderHistoryMeta =
      const VerificationMeta('eatingDisorderHistory');
  @override
  late final GeneratedColumn<bool> eatingDisorderHistory =
      GeneratedColumn<bool>(
        'eating_disorder_history',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("eating_disorder_history" IN (0, 1))',
        ),
      );
  static const VerificationMeta _unintentionalWeightLossMeta =
      const VerificationMeta('unintentionalWeightLoss');
  @override
  late final GeneratedColumn<bool> unintentionalWeightLoss =
      GeneratedColumn<bool>(
        'unintentional_weight_loss',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("unintentional_weight_loss" IN (0, 1))',
        ),
      );
  static const VerificationMeta _under18Meta = const VerificationMeta(
    'under18',
  );
  @override
  late final GeneratedColumn<bool> under18 = GeneratedColumn<bool>(
    'under18',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("under18" IN (0, 1))',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    screenedAtUtc,
    hasDiabetes,
    usesGlucoseLoweringMedication,
    pregnantOrBreastfeeding,
    kidneyLiverPancreasDisease,
    eatingDisorderHistory,
    unintentionalWeightLoss,
    under18,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'risk_screening';
  @override
  VerificationContext validateIntegrity(
    Insertable<RiskScreeningRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('screened_at_utc')) {
      context.handle(
        _screenedAtUtcMeta,
        screenedAtUtc.isAcceptableOrUnknown(
          data['screened_at_utc']!,
          _screenedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_screenedAtUtcMeta);
    }
    if (data.containsKey('has_diabetes')) {
      context.handle(
        _hasDiabetesMeta,
        hasDiabetes.isAcceptableOrUnknown(
          data['has_diabetes']!,
          _hasDiabetesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasDiabetesMeta);
    }
    if (data.containsKey('uses_glucose_lowering_medication')) {
      context.handle(
        _usesGlucoseLoweringMedicationMeta,
        usesGlucoseLoweringMedication.isAcceptableOrUnknown(
          data['uses_glucose_lowering_medication']!,
          _usesGlucoseLoweringMedicationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usesGlucoseLoweringMedicationMeta);
    }
    if (data.containsKey('pregnant_or_breastfeeding')) {
      context.handle(
        _pregnantOrBreastfeedingMeta,
        pregnantOrBreastfeeding.isAcceptableOrUnknown(
          data['pregnant_or_breastfeeding']!,
          _pregnantOrBreastfeedingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pregnantOrBreastfeedingMeta);
    }
    if (data.containsKey('kidney_liver_pancreas_disease')) {
      context.handle(
        _kidneyLiverPancreasDiseaseMeta,
        kidneyLiverPancreasDisease.isAcceptableOrUnknown(
          data['kidney_liver_pancreas_disease']!,
          _kidneyLiverPancreasDiseaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kidneyLiverPancreasDiseaseMeta);
    }
    if (data.containsKey('eating_disorder_history')) {
      context.handle(
        _eatingDisorderHistoryMeta,
        eatingDisorderHistory.isAcceptableOrUnknown(
          data['eating_disorder_history']!,
          _eatingDisorderHistoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eatingDisorderHistoryMeta);
    }
    if (data.containsKey('unintentional_weight_loss')) {
      context.handle(
        _unintentionalWeightLossMeta,
        unintentionalWeightLoss.isAcceptableOrUnknown(
          data['unintentional_weight_loss']!,
          _unintentionalWeightLossMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unintentionalWeightLossMeta);
    }
    if (data.containsKey('under18')) {
      context.handle(
        _under18Meta,
        under18.isAcceptableOrUnknown(data['under18']!, _under18Meta),
      );
    } else if (isInserting) {
      context.missing(_under18Meta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RiskScreeningRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RiskScreeningRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      screenedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}screened_at_utc'],
      )!,
      hasDiabetes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_diabetes'],
      )!,
      usesGlucoseLoweringMedication: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}uses_glucose_lowering_medication'],
      )!,
      pregnantOrBreastfeeding: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pregnant_or_breastfeeding'],
      )!,
      kidneyLiverPancreasDisease: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}kidney_liver_pancreas_disease'],
      )!,
      eatingDisorderHistory: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}eating_disorder_history'],
      )!,
      unintentionalWeightLoss: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unintentional_weight_loss'],
      )!,
      under18: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}under18'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $RiskScreeningTable createAlias(String alias) {
    return $RiskScreeningTable(attachedDatabase, alias);
  }
}

class RiskScreeningRow extends DataClass
    implements Insertable<RiskScreeningRow> {
  final int id;
  final DateTime screenedAtUtc;
  final bool hasDiabetes;
  final bool usesGlucoseLoweringMedication;
  final bool pregnantOrBreastfeeding;
  final bool kidneyLiverPancreasDisease;
  final bool eatingDisorderHistory;
  final bool unintentionalWeightLoss;
  final bool under18;
  final String? note;
  const RiskScreeningRow({
    required this.id,
    required this.screenedAtUtc,
    required this.hasDiabetes,
    required this.usesGlucoseLoweringMedication,
    required this.pregnantOrBreastfeeding,
    required this.kidneyLiverPancreasDisease,
    required this.eatingDisorderHistory,
    required this.unintentionalWeightLoss,
    required this.under18,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['screened_at_utc'] = Variable<DateTime>(screenedAtUtc);
    map['has_diabetes'] = Variable<bool>(hasDiabetes);
    map['uses_glucose_lowering_medication'] = Variable<bool>(
      usesGlucoseLoweringMedication,
    );
    map['pregnant_or_breastfeeding'] = Variable<bool>(pregnantOrBreastfeeding);
    map['kidney_liver_pancreas_disease'] = Variable<bool>(
      kidneyLiverPancreasDisease,
    );
    map['eating_disorder_history'] = Variable<bool>(eatingDisorderHistory);
    map['unintentional_weight_loss'] = Variable<bool>(unintentionalWeightLoss);
    map['under18'] = Variable<bool>(under18);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  RiskScreeningCompanion toCompanion(bool nullToAbsent) {
    return RiskScreeningCompanion(
      id: Value(id),
      screenedAtUtc: Value(screenedAtUtc),
      hasDiabetes: Value(hasDiabetes),
      usesGlucoseLoweringMedication: Value(usesGlucoseLoweringMedication),
      pregnantOrBreastfeeding: Value(pregnantOrBreastfeeding),
      kidneyLiverPancreasDisease: Value(kidneyLiverPancreasDisease),
      eatingDisorderHistory: Value(eatingDisorderHistory),
      unintentionalWeightLoss: Value(unintentionalWeightLoss),
      under18: Value(under18),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory RiskScreeningRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RiskScreeningRow(
      id: serializer.fromJson<int>(json['id']),
      screenedAtUtc: serializer.fromJson<DateTime>(json['screenedAtUtc']),
      hasDiabetes: serializer.fromJson<bool>(json['hasDiabetes']),
      usesGlucoseLoweringMedication: serializer.fromJson<bool>(
        json['usesGlucoseLoweringMedication'],
      ),
      pregnantOrBreastfeeding: serializer.fromJson<bool>(
        json['pregnantOrBreastfeeding'],
      ),
      kidneyLiverPancreasDisease: serializer.fromJson<bool>(
        json['kidneyLiverPancreasDisease'],
      ),
      eatingDisorderHistory: serializer.fromJson<bool>(
        json['eatingDisorderHistory'],
      ),
      unintentionalWeightLoss: serializer.fromJson<bool>(
        json['unintentionalWeightLoss'],
      ),
      under18: serializer.fromJson<bool>(json['under18']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'screenedAtUtc': serializer.toJson<DateTime>(screenedAtUtc),
      'hasDiabetes': serializer.toJson<bool>(hasDiabetes),
      'usesGlucoseLoweringMedication': serializer.toJson<bool>(
        usesGlucoseLoweringMedication,
      ),
      'pregnantOrBreastfeeding': serializer.toJson<bool>(
        pregnantOrBreastfeeding,
      ),
      'kidneyLiverPancreasDisease': serializer.toJson<bool>(
        kidneyLiverPancreasDisease,
      ),
      'eatingDisorderHistory': serializer.toJson<bool>(eatingDisorderHistory),
      'unintentionalWeightLoss': serializer.toJson<bool>(
        unintentionalWeightLoss,
      ),
      'under18': serializer.toJson<bool>(under18),
      'note': serializer.toJson<String?>(note),
    };
  }

  RiskScreeningRow copyWith({
    int? id,
    DateTime? screenedAtUtc,
    bool? hasDiabetes,
    bool? usesGlucoseLoweringMedication,
    bool? pregnantOrBreastfeeding,
    bool? kidneyLiverPancreasDisease,
    bool? eatingDisorderHistory,
    bool? unintentionalWeightLoss,
    bool? under18,
    Value<String?> note = const Value.absent(),
  }) => RiskScreeningRow(
    id: id ?? this.id,
    screenedAtUtc: screenedAtUtc ?? this.screenedAtUtc,
    hasDiabetes: hasDiabetes ?? this.hasDiabetes,
    usesGlucoseLoweringMedication:
        usesGlucoseLoweringMedication ?? this.usesGlucoseLoweringMedication,
    pregnantOrBreastfeeding:
        pregnantOrBreastfeeding ?? this.pregnantOrBreastfeeding,
    kidneyLiverPancreasDisease:
        kidneyLiverPancreasDisease ?? this.kidneyLiverPancreasDisease,
    eatingDisorderHistory: eatingDisorderHistory ?? this.eatingDisorderHistory,
    unintentionalWeightLoss:
        unintentionalWeightLoss ?? this.unintentionalWeightLoss,
    under18: under18 ?? this.under18,
    note: note.present ? note.value : this.note,
  );
  RiskScreeningRow copyWithCompanion(RiskScreeningCompanion data) {
    return RiskScreeningRow(
      id: data.id.present ? data.id.value : this.id,
      screenedAtUtc: data.screenedAtUtc.present
          ? data.screenedAtUtc.value
          : this.screenedAtUtc,
      hasDiabetes: data.hasDiabetes.present
          ? data.hasDiabetes.value
          : this.hasDiabetes,
      usesGlucoseLoweringMedication: data.usesGlucoseLoweringMedication.present
          ? data.usesGlucoseLoweringMedication.value
          : this.usesGlucoseLoweringMedication,
      pregnantOrBreastfeeding: data.pregnantOrBreastfeeding.present
          ? data.pregnantOrBreastfeeding.value
          : this.pregnantOrBreastfeeding,
      kidneyLiverPancreasDisease: data.kidneyLiverPancreasDisease.present
          ? data.kidneyLiverPancreasDisease.value
          : this.kidneyLiverPancreasDisease,
      eatingDisorderHistory: data.eatingDisorderHistory.present
          ? data.eatingDisorderHistory.value
          : this.eatingDisorderHistory,
      unintentionalWeightLoss: data.unintentionalWeightLoss.present
          ? data.unintentionalWeightLoss.value
          : this.unintentionalWeightLoss,
      under18: data.under18.present ? data.under18.value : this.under18,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RiskScreeningRow(')
          ..write('id: $id, ')
          ..write('screenedAtUtc: $screenedAtUtc, ')
          ..write('hasDiabetes: $hasDiabetes, ')
          ..write(
            'usesGlucoseLoweringMedication: $usesGlucoseLoweringMedication, ',
          )
          ..write('pregnantOrBreastfeeding: $pregnantOrBreastfeeding, ')
          ..write('kidneyLiverPancreasDisease: $kidneyLiverPancreasDisease, ')
          ..write('eatingDisorderHistory: $eatingDisorderHistory, ')
          ..write('unintentionalWeightLoss: $unintentionalWeightLoss, ')
          ..write('under18: $under18, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    screenedAtUtc,
    hasDiabetes,
    usesGlucoseLoweringMedication,
    pregnantOrBreastfeeding,
    kidneyLiverPancreasDisease,
    eatingDisorderHistory,
    unintentionalWeightLoss,
    under18,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RiskScreeningRow &&
          other.id == this.id &&
          other.screenedAtUtc == this.screenedAtUtc &&
          other.hasDiabetes == this.hasDiabetes &&
          other.usesGlucoseLoweringMedication ==
              this.usesGlucoseLoweringMedication &&
          other.pregnantOrBreastfeeding == this.pregnantOrBreastfeeding &&
          other.kidneyLiverPancreasDisease == this.kidneyLiverPancreasDisease &&
          other.eatingDisorderHistory == this.eatingDisorderHistory &&
          other.unintentionalWeightLoss == this.unintentionalWeightLoss &&
          other.under18 == this.under18 &&
          other.note == this.note);
}

class RiskScreeningCompanion extends UpdateCompanion<RiskScreeningRow> {
  final Value<int> id;
  final Value<DateTime> screenedAtUtc;
  final Value<bool> hasDiabetes;
  final Value<bool> usesGlucoseLoweringMedication;
  final Value<bool> pregnantOrBreastfeeding;
  final Value<bool> kidneyLiverPancreasDisease;
  final Value<bool> eatingDisorderHistory;
  final Value<bool> unintentionalWeightLoss;
  final Value<bool> under18;
  final Value<String?> note;
  const RiskScreeningCompanion({
    this.id = const Value.absent(),
    this.screenedAtUtc = const Value.absent(),
    this.hasDiabetes = const Value.absent(),
    this.usesGlucoseLoweringMedication = const Value.absent(),
    this.pregnantOrBreastfeeding = const Value.absent(),
    this.kidneyLiverPancreasDisease = const Value.absent(),
    this.eatingDisorderHistory = const Value.absent(),
    this.unintentionalWeightLoss = const Value.absent(),
    this.under18 = const Value.absent(),
    this.note = const Value.absent(),
  });
  RiskScreeningCompanion.insert({
    this.id = const Value.absent(),
    required DateTime screenedAtUtc,
    required bool hasDiabetes,
    required bool usesGlucoseLoweringMedication,
    required bool pregnantOrBreastfeeding,
    required bool kidneyLiverPancreasDisease,
    required bool eatingDisorderHistory,
    required bool unintentionalWeightLoss,
    required bool under18,
    this.note = const Value.absent(),
  }) : screenedAtUtc = Value(screenedAtUtc),
       hasDiabetes = Value(hasDiabetes),
       usesGlucoseLoweringMedication = Value(usesGlucoseLoweringMedication),
       pregnantOrBreastfeeding = Value(pregnantOrBreastfeeding),
       kidneyLiverPancreasDisease = Value(kidneyLiverPancreasDisease),
       eatingDisorderHistory = Value(eatingDisorderHistory),
       unintentionalWeightLoss = Value(unintentionalWeightLoss),
       under18 = Value(under18);
  static Insertable<RiskScreeningRow> custom({
    Expression<int>? id,
    Expression<DateTime>? screenedAtUtc,
    Expression<bool>? hasDiabetes,
    Expression<bool>? usesGlucoseLoweringMedication,
    Expression<bool>? pregnantOrBreastfeeding,
    Expression<bool>? kidneyLiverPancreasDisease,
    Expression<bool>? eatingDisorderHistory,
    Expression<bool>? unintentionalWeightLoss,
    Expression<bool>? under18,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (screenedAtUtc != null) 'screened_at_utc': screenedAtUtc,
      if (hasDiabetes != null) 'has_diabetes': hasDiabetes,
      if (usesGlucoseLoweringMedication != null)
        'uses_glucose_lowering_medication': usesGlucoseLoweringMedication,
      if (pregnantOrBreastfeeding != null)
        'pregnant_or_breastfeeding': pregnantOrBreastfeeding,
      if (kidneyLiverPancreasDisease != null)
        'kidney_liver_pancreas_disease': kidneyLiverPancreasDisease,
      if (eatingDisorderHistory != null)
        'eating_disorder_history': eatingDisorderHistory,
      if (unintentionalWeightLoss != null)
        'unintentional_weight_loss': unintentionalWeightLoss,
      if (under18 != null) 'under18': under18,
      if (note != null) 'note': note,
    });
  }

  RiskScreeningCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? screenedAtUtc,
    Value<bool>? hasDiabetes,
    Value<bool>? usesGlucoseLoweringMedication,
    Value<bool>? pregnantOrBreastfeeding,
    Value<bool>? kidneyLiverPancreasDisease,
    Value<bool>? eatingDisorderHistory,
    Value<bool>? unintentionalWeightLoss,
    Value<bool>? under18,
    Value<String?>? note,
  }) {
    return RiskScreeningCompanion(
      id: id ?? this.id,
      screenedAtUtc: screenedAtUtc ?? this.screenedAtUtc,
      hasDiabetes: hasDiabetes ?? this.hasDiabetes,
      usesGlucoseLoweringMedication:
          usesGlucoseLoweringMedication ?? this.usesGlucoseLoweringMedication,
      pregnantOrBreastfeeding:
          pregnantOrBreastfeeding ?? this.pregnantOrBreastfeeding,
      kidneyLiverPancreasDisease:
          kidneyLiverPancreasDisease ?? this.kidneyLiverPancreasDisease,
      eatingDisorderHistory:
          eatingDisorderHistory ?? this.eatingDisorderHistory,
      unintentionalWeightLoss:
          unintentionalWeightLoss ?? this.unintentionalWeightLoss,
      under18: under18 ?? this.under18,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (screenedAtUtc.present) {
      map['screened_at_utc'] = Variable<DateTime>(screenedAtUtc.value);
    }
    if (hasDiabetes.present) {
      map['has_diabetes'] = Variable<bool>(hasDiabetes.value);
    }
    if (usesGlucoseLoweringMedication.present) {
      map['uses_glucose_lowering_medication'] = Variable<bool>(
        usesGlucoseLoweringMedication.value,
      );
    }
    if (pregnantOrBreastfeeding.present) {
      map['pregnant_or_breastfeeding'] = Variable<bool>(
        pregnantOrBreastfeeding.value,
      );
    }
    if (kidneyLiverPancreasDisease.present) {
      map['kidney_liver_pancreas_disease'] = Variable<bool>(
        kidneyLiverPancreasDisease.value,
      );
    }
    if (eatingDisorderHistory.present) {
      map['eating_disorder_history'] = Variable<bool>(
        eatingDisorderHistory.value,
      );
    }
    if (unintentionalWeightLoss.present) {
      map['unintentional_weight_loss'] = Variable<bool>(
        unintentionalWeightLoss.value,
      );
    }
    if (under18.present) {
      map['under18'] = Variable<bool>(under18.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RiskScreeningCompanion(')
          ..write('id: $id, ')
          ..write('screenedAtUtc: $screenedAtUtc, ')
          ..write('hasDiabetes: $hasDiabetes, ')
          ..write(
            'usesGlucoseLoweringMedication: $usesGlucoseLoweringMedication, ',
          )
          ..write('pregnantOrBreastfeeding: $pregnantOrBreastfeeding, ')
          ..write('kidneyLiverPancreasDisease: $kidneyLiverPancreasDisease, ')
          ..write('eatingDisorderHistory: $eatingDisorderHistory, ')
          ..write('unintentionalWeightLoss: $unintentionalWeightLoss, ')
          ..write('under18: $under18, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $EnergyEstimateTable extends EnergyEstimate
    with TableInfo<$EnergyEstimateTable, EnergyEstimateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnergyEstimateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userProfileIdMeta = const VerificationMeta(
    'userProfileId',
  );
  @override
  late final GeneratedColumn<int> userProfileId = GeneratedColumn<int>(
    'user_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profile (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reeKcalMeta = const VerificationMeta(
    'reeKcal',
  );
  @override
  late final GeneratedColumn<double> reeKcal = GeneratedColumn<double>(
    'ree_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tdeeKcalMeta = const VerificationMeta(
    'tdeeKcal',
  );
  @override
  late final GeneratedColumn<double> tdeeKcal = GeneratedColumn<double>(
    'tdee_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formulaVersionMeta = const VerificationMeta(
    'formulaVersion',
  );
  @override
  late final GeneratedColumn<String> formulaVersion = GeneratedColumn<String>(
    'formula_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputsJsonMeta = const VerificationMeta(
    'inputsJson',
  );
  @override
  late final GeneratedColumn<String> inputsJson = GeneratedColumn<String>(
    'inputs_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _computedAtUtcMeta = const VerificationMeta(
    'computedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> computedAtUtc =
      GeneratedColumn<DateTime>(
        'computed_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userProfileId,
    reeKcal,
    tdeeKcal,
    formulaVersion,
    inputsJson,
    computedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'energy_estimate';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnergyEstimateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_profile_id')) {
      context.handle(
        _userProfileIdMeta,
        userProfileId.isAcceptableOrUnknown(
          data['user_profile_id']!,
          _userProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userProfileIdMeta);
    }
    if (data.containsKey('ree_kcal')) {
      context.handle(
        _reeKcalMeta,
        reeKcal.isAcceptableOrUnknown(data['ree_kcal']!, _reeKcalMeta),
      );
    } else if (isInserting) {
      context.missing(_reeKcalMeta);
    }
    if (data.containsKey('tdee_kcal')) {
      context.handle(
        _tdeeKcalMeta,
        tdeeKcal.isAcceptableOrUnknown(data['tdee_kcal']!, _tdeeKcalMeta),
      );
    } else if (isInserting) {
      context.missing(_tdeeKcalMeta);
    }
    if (data.containsKey('formula_version')) {
      context.handle(
        _formulaVersionMeta,
        formulaVersion.isAcceptableOrUnknown(
          data['formula_version']!,
          _formulaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formulaVersionMeta);
    }
    if (data.containsKey('inputs_json')) {
      context.handle(
        _inputsJsonMeta,
        inputsJson.isAcceptableOrUnknown(data['inputs_json']!, _inputsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_inputsJsonMeta);
    }
    if (data.containsKey('computed_at_utc')) {
      context.handle(
        _computedAtUtcMeta,
        computedAtUtc.isAcceptableOrUnknown(
          data['computed_at_utc']!,
          _computedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_computedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnergyEstimateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnergyEstimateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_profile_id'],
      )!,
      reeKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ree_kcal'],
      )!,
      tdeeKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tdee_kcal'],
      )!,
      formulaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula_version'],
      )!,
      inputsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inputs_json'],
      )!,
      computedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}computed_at_utc'],
      )!,
    );
  }

  @override
  $EnergyEstimateTable createAlias(String alias) {
    return $EnergyEstimateTable(attachedDatabase, alias);
  }
}

class EnergyEstimateRow extends DataClass
    implements Insertable<EnergyEstimateRow> {
  final int id;
  final int userProfileId;
  final double reeKcal;
  final double tdeeKcal;
  final String formulaVersion;
  final String inputsJson;
  final DateTime computedAtUtc;
  const EnergyEstimateRow({
    required this.id,
    required this.userProfileId,
    required this.reeKcal,
    required this.tdeeKcal,
    required this.formulaVersion,
    required this.inputsJson,
    required this.computedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_profile_id'] = Variable<int>(userProfileId);
    map['ree_kcal'] = Variable<double>(reeKcal);
    map['tdee_kcal'] = Variable<double>(tdeeKcal);
    map['formula_version'] = Variable<String>(formulaVersion);
    map['inputs_json'] = Variable<String>(inputsJson);
    map['computed_at_utc'] = Variable<DateTime>(computedAtUtc);
    return map;
  }

  EnergyEstimateCompanion toCompanion(bool nullToAbsent) {
    return EnergyEstimateCompanion(
      id: Value(id),
      userProfileId: Value(userProfileId),
      reeKcal: Value(reeKcal),
      tdeeKcal: Value(tdeeKcal),
      formulaVersion: Value(formulaVersion),
      inputsJson: Value(inputsJson),
      computedAtUtc: Value(computedAtUtc),
    );
  }

  factory EnergyEstimateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnergyEstimateRow(
      id: serializer.fromJson<int>(json['id']),
      userProfileId: serializer.fromJson<int>(json['userProfileId']),
      reeKcal: serializer.fromJson<double>(json['reeKcal']),
      tdeeKcal: serializer.fromJson<double>(json['tdeeKcal']),
      formulaVersion: serializer.fromJson<String>(json['formulaVersion']),
      inputsJson: serializer.fromJson<String>(json['inputsJson']),
      computedAtUtc: serializer.fromJson<DateTime>(json['computedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userProfileId': serializer.toJson<int>(userProfileId),
      'reeKcal': serializer.toJson<double>(reeKcal),
      'tdeeKcal': serializer.toJson<double>(tdeeKcal),
      'formulaVersion': serializer.toJson<String>(formulaVersion),
      'inputsJson': serializer.toJson<String>(inputsJson),
      'computedAtUtc': serializer.toJson<DateTime>(computedAtUtc),
    };
  }

  EnergyEstimateRow copyWith({
    int? id,
    int? userProfileId,
    double? reeKcal,
    double? tdeeKcal,
    String? formulaVersion,
    String? inputsJson,
    DateTime? computedAtUtc,
  }) => EnergyEstimateRow(
    id: id ?? this.id,
    userProfileId: userProfileId ?? this.userProfileId,
    reeKcal: reeKcal ?? this.reeKcal,
    tdeeKcal: tdeeKcal ?? this.tdeeKcal,
    formulaVersion: formulaVersion ?? this.formulaVersion,
    inputsJson: inputsJson ?? this.inputsJson,
    computedAtUtc: computedAtUtc ?? this.computedAtUtc,
  );
  EnergyEstimateRow copyWithCompanion(EnergyEstimateCompanion data) {
    return EnergyEstimateRow(
      id: data.id.present ? data.id.value : this.id,
      userProfileId: data.userProfileId.present
          ? data.userProfileId.value
          : this.userProfileId,
      reeKcal: data.reeKcal.present ? data.reeKcal.value : this.reeKcal,
      tdeeKcal: data.tdeeKcal.present ? data.tdeeKcal.value : this.tdeeKcal,
      formulaVersion: data.formulaVersion.present
          ? data.formulaVersion.value
          : this.formulaVersion,
      inputsJson: data.inputsJson.present
          ? data.inputsJson.value
          : this.inputsJson,
      computedAtUtc: data.computedAtUtc.present
          ? data.computedAtUtc.value
          : this.computedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnergyEstimateRow(')
          ..write('id: $id, ')
          ..write('userProfileId: $userProfileId, ')
          ..write('reeKcal: $reeKcal, ')
          ..write('tdeeKcal: $tdeeKcal, ')
          ..write('formulaVersion: $formulaVersion, ')
          ..write('inputsJson: $inputsJson, ')
          ..write('computedAtUtc: $computedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userProfileId,
    reeKcal,
    tdeeKcal,
    formulaVersion,
    inputsJson,
    computedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnergyEstimateRow &&
          other.id == this.id &&
          other.userProfileId == this.userProfileId &&
          other.reeKcal == this.reeKcal &&
          other.tdeeKcal == this.tdeeKcal &&
          other.formulaVersion == this.formulaVersion &&
          other.inputsJson == this.inputsJson &&
          other.computedAtUtc == this.computedAtUtc);
}

class EnergyEstimateCompanion extends UpdateCompanion<EnergyEstimateRow> {
  final Value<int> id;
  final Value<int> userProfileId;
  final Value<double> reeKcal;
  final Value<double> tdeeKcal;
  final Value<String> formulaVersion;
  final Value<String> inputsJson;
  final Value<DateTime> computedAtUtc;
  const EnergyEstimateCompanion({
    this.id = const Value.absent(),
    this.userProfileId = const Value.absent(),
    this.reeKcal = const Value.absent(),
    this.tdeeKcal = const Value.absent(),
    this.formulaVersion = const Value.absent(),
    this.inputsJson = const Value.absent(),
    this.computedAtUtc = const Value.absent(),
  });
  EnergyEstimateCompanion.insert({
    this.id = const Value.absent(),
    required int userProfileId,
    required double reeKcal,
    required double tdeeKcal,
    required String formulaVersion,
    required String inputsJson,
    required DateTime computedAtUtc,
  }) : userProfileId = Value(userProfileId),
       reeKcal = Value(reeKcal),
       tdeeKcal = Value(tdeeKcal),
       formulaVersion = Value(formulaVersion),
       inputsJson = Value(inputsJson),
       computedAtUtc = Value(computedAtUtc);
  static Insertable<EnergyEstimateRow> custom({
    Expression<int>? id,
    Expression<int>? userProfileId,
    Expression<double>? reeKcal,
    Expression<double>? tdeeKcal,
    Expression<String>? formulaVersion,
    Expression<String>? inputsJson,
    Expression<DateTime>? computedAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userProfileId != null) 'user_profile_id': userProfileId,
      if (reeKcal != null) 'ree_kcal': reeKcal,
      if (tdeeKcal != null) 'tdee_kcal': tdeeKcal,
      if (formulaVersion != null) 'formula_version': formulaVersion,
      if (inputsJson != null) 'inputs_json': inputsJson,
      if (computedAtUtc != null) 'computed_at_utc': computedAtUtc,
    });
  }

  EnergyEstimateCompanion copyWith({
    Value<int>? id,
    Value<int>? userProfileId,
    Value<double>? reeKcal,
    Value<double>? tdeeKcal,
    Value<String>? formulaVersion,
    Value<String>? inputsJson,
    Value<DateTime>? computedAtUtc,
  }) {
    return EnergyEstimateCompanion(
      id: id ?? this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      reeKcal: reeKcal ?? this.reeKcal,
      tdeeKcal: tdeeKcal ?? this.tdeeKcal,
      formulaVersion: formulaVersion ?? this.formulaVersion,
      inputsJson: inputsJson ?? this.inputsJson,
      computedAtUtc: computedAtUtc ?? this.computedAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userProfileId.present) {
      map['user_profile_id'] = Variable<int>(userProfileId.value);
    }
    if (reeKcal.present) {
      map['ree_kcal'] = Variable<double>(reeKcal.value);
    }
    if (tdeeKcal.present) {
      map['tdee_kcal'] = Variable<double>(tdeeKcal.value);
    }
    if (formulaVersion.present) {
      map['formula_version'] = Variable<String>(formulaVersion.value);
    }
    if (inputsJson.present) {
      map['inputs_json'] = Variable<String>(inputsJson.value);
    }
    if (computedAtUtc.present) {
      map['computed_at_utc'] = Variable<DateTime>(computedAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnergyEstimateCompanion(')
          ..write('id: $id, ')
          ..write('userProfileId: $userProfileId, ')
          ..write('reeKcal: $reeKcal, ')
          ..write('tdeeKcal: $tdeeKcal, ')
          ..write('formulaVersion: $formulaVersion, ')
          ..write('inputsJson: $inputsJson, ')
          ..write('computedAtUtc: $computedAtUtc')
          ..write(')'))
        .toString();
  }
}

class $GoalTable extends Goal with TableInfo<$GoalTable, GoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rangeLowMeta = const VerificationMeta(
    'rangeLow',
  );
  @override
  late final GeneratedColumn<double> rangeLow = GeneratedColumn<double>(
    'range_low',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rangeHighMeta = const VerificationMeta(
    'rangeHigh',
  );
  @override
  late final GeneratedColumn<double> rangeHigh = GeneratedColumn<double>(
    'range_high',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceEvidenceIdMeta = const VerificationMeta(
    'sourceEvidenceId',
  );
  @override
  late final GeneratedColumn<String> sourceEvidenceId = GeneratedColumn<String>(
    'source_evidence_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicianNameMeta = const VerificationMeta(
    'clinicianName',
  );
  @override
  late final GeneratedColumn<String> clinicianName = GeneratedColumn<String>(
    'clinician_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicianGivenAtIsoMeta =
      const VerificationMeta('clinicianGivenAtIso');
  @override
  late final GeneratedColumn<String> clinicianGivenAtIso =
      GeneratedColumn<String>(
        'clinician_given_at_iso',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _personalNoteMeta = const VerificationMeta(
    'personalNote',
  );
  @override
  late final GeneratedColumn<String> personalNote = GeneratedColumn<String>(
    'personal_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalType,
    metric,
    targetValue,
    rangeLow,
    rangeHigh,
    sourceEvidenceId,
    clinicianName,
    clinicianGivenAtIso,
    personalNote,
    isActive,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_goalTypeMeta);
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('range_low')) {
      context.handle(
        _rangeLowMeta,
        rangeLow.isAcceptableOrUnknown(data['range_low']!, _rangeLowMeta),
      );
    }
    if (data.containsKey('range_high')) {
      context.handle(
        _rangeHighMeta,
        rangeHigh.isAcceptableOrUnknown(data['range_high']!, _rangeHighMeta),
      );
    }
    if (data.containsKey('source_evidence_id')) {
      context.handle(
        _sourceEvidenceIdMeta,
        sourceEvidenceId.isAcceptableOrUnknown(
          data['source_evidence_id']!,
          _sourceEvidenceIdMeta,
        ),
      );
    }
    if (data.containsKey('clinician_name')) {
      context.handle(
        _clinicianNameMeta,
        clinicianName.isAcceptableOrUnknown(
          data['clinician_name']!,
          _clinicianNameMeta,
        ),
      );
    }
    if (data.containsKey('clinician_given_at_iso')) {
      context.handle(
        _clinicianGivenAtIsoMeta,
        clinicianGivenAtIso.isAcceptableOrUnknown(
          data['clinician_given_at_iso']!,
          _clinicianGivenAtIsoMeta,
        ),
      );
    }
    if (data.containsKey('personal_note')) {
      context.handle(
        _personalNoteMeta,
        personalNote.isAcceptableOrUnknown(
          data['personal_note']!,
          _personalNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      rangeLow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}range_low'],
      ),
      rangeHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}range_high'],
      ),
      sourceEvidenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_evidence_id'],
      ),
      clinicianName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinician_name'],
      ),
      clinicianGivenAtIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinician_given_at_iso'],
      ),
      personalNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $GoalTable createAlias(String alias) {
    return $GoalTable(attachedDatabase, alias);
  }
}

class GoalRow extends DataClass implements Insertable<GoalRow> {
  final int id;
  final String goalType;
  final String metric;
  final double targetValue;
  final double? rangeLow;
  final double? rangeHigh;
  final String? sourceEvidenceId;
  final String? clinicianName;
  final String? clinicianGivenAtIso;
  final String? personalNote;
  final bool isActive;
  final DateTime createdAtUtc;
  const GoalRow({
    required this.id,
    required this.goalType,
    required this.metric,
    required this.targetValue,
    this.rangeLow,
    this.rangeHigh,
    this.sourceEvidenceId,
    this.clinicianName,
    this.clinicianGivenAtIso,
    this.personalNote,
    required this.isActive,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['goal_type'] = Variable<String>(goalType);
    map['metric'] = Variable<String>(metric);
    map['target_value'] = Variable<double>(targetValue);
    if (!nullToAbsent || rangeLow != null) {
      map['range_low'] = Variable<double>(rangeLow);
    }
    if (!nullToAbsent || rangeHigh != null) {
      map['range_high'] = Variable<double>(rangeHigh);
    }
    if (!nullToAbsent || sourceEvidenceId != null) {
      map['source_evidence_id'] = Variable<String>(sourceEvidenceId);
    }
    if (!nullToAbsent || clinicianName != null) {
      map['clinician_name'] = Variable<String>(clinicianName);
    }
    if (!nullToAbsent || clinicianGivenAtIso != null) {
      map['clinician_given_at_iso'] = Variable<String>(clinicianGivenAtIso);
    }
    if (!nullToAbsent || personalNote != null) {
      map['personal_note'] = Variable<String>(personalNote);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  GoalCompanion toCompanion(bool nullToAbsent) {
    return GoalCompanion(
      id: Value(id),
      goalType: Value(goalType),
      metric: Value(metric),
      targetValue: Value(targetValue),
      rangeLow: rangeLow == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeLow),
      rangeHigh: rangeHigh == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeHigh),
      sourceEvidenceId: sourceEvidenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceEvidenceId),
      clinicianName: clinicianName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicianName),
      clinicianGivenAtIso: clinicianGivenAtIso == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicianGivenAtIso),
      personalNote: personalNote == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNote),
      isActive: Value(isActive),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory GoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRow(
      id: serializer.fromJson<int>(json['id']),
      goalType: serializer.fromJson<String>(json['goalType']),
      metric: serializer.fromJson<String>(json['metric']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      rangeLow: serializer.fromJson<double?>(json['rangeLow']),
      rangeHigh: serializer.fromJson<double?>(json['rangeHigh']),
      sourceEvidenceId: serializer.fromJson<String?>(json['sourceEvidenceId']),
      clinicianName: serializer.fromJson<String?>(json['clinicianName']),
      clinicianGivenAtIso: serializer.fromJson<String?>(
        json['clinicianGivenAtIso'],
      ),
      personalNote: serializer.fromJson<String?>(json['personalNote']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'goalType': serializer.toJson<String>(goalType),
      'metric': serializer.toJson<String>(metric),
      'targetValue': serializer.toJson<double>(targetValue),
      'rangeLow': serializer.toJson<double?>(rangeLow),
      'rangeHigh': serializer.toJson<double?>(rangeHigh),
      'sourceEvidenceId': serializer.toJson<String?>(sourceEvidenceId),
      'clinicianName': serializer.toJson<String?>(clinicianName),
      'clinicianGivenAtIso': serializer.toJson<String?>(clinicianGivenAtIso),
      'personalNote': serializer.toJson<String?>(personalNote),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  GoalRow copyWith({
    int? id,
    String? goalType,
    String? metric,
    double? targetValue,
    Value<double?> rangeLow = const Value.absent(),
    Value<double?> rangeHigh = const Value.absent(),
    Value<String?> sourceEvidenceId = const Value.absent(),
    Value<String?> clinicianName = const Value.absent(),
    Value<String?> clinicianGivenAtIso = const Value.absent(),
    Value<String?> personalNote = const Value.absent(),
    bool? isActive,
    DateTime? createdAtUtc,
  }) => GoalRow(
    id: id ?? this.id,
    goalType: goalType ?? this.goalType,
    metric: metric ?? this.metric,
    targetValue: targetValue ?? this.targetValue,
    rangeLow: rangeLow.present ? rangeLow.value : this.rangeLow,
    rangeHigh: rangeHigh.present ? rangeHigh.value : this.rangeHigh,
    sourceEvidenceId: sourceEvidenceId.present
        ? sourceEvidenceId.value
        : this.sourceEvidenceId,
    clinicianName: clinicianName.present
        ? clinicianName.value
        : this.clinicianName,
    clinicianGivenAtIso: clinicianGivenAtIso.present
        ? clinicianGivenAtIso.value
        : this.clinicianGivenAtIso,
    personalNote: personalNote.present ? personalNote.value : this.personalNote,
    isActive: isActive ?? this.isActive,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  GoalRow copyWithCompanion(GoalCompanion data) {
    return GoalRow(
      id: data.id.present ? data.id.value : this.id,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      metric: data.metric.present ? data.metric.value : this.metric,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      rangeLow: data.rangeLow.present ? data.rangeLow.value : this.rangeLow,
      rangeHigh: data.rangeHigh.present ? data.rangeHigh.value : this.rangeHigh,
      sourceEvidenceId: data.sourceEvidenceId.present
          ? data.sourceEvidenceId.value
          : this.sourceEvidenceId,
      clinicianName: data.clinicianName.present
          ? data.clinicianName.value
          : this.clinicianName,
      clinicianGivenAtIso: data.clinicianGivenAtIso.present
          ? data.clinicianGivenAtIso.value
          : this.clinicianGivenAtIso,
      personalNote: data.personalNote.present
          ? data.personalNote.value
          : this.personalNote,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalRow(')
          ..write('id: $id, ')
          ..write('goalType: $goalType, ')
          ..write('metric: $metric, ')
          ..write('targetValue: $targetValue, ')
          ..write('rangeLow: $rangeLow, ')
          ..write('rangeHigh: $rangeHigh, ')
          ..write('sourceEvidenceId: $sourceEvidenceId, ')
          ..write('clinicianName: $clinicianName, ')
          ..write('clinicianGivenAtIso: $clinicianGivenAtIso, ')
          ..write('personalNote: $personalNote, ')
          ..write('isActive: $isActive, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    goalType,
    metric,
    targetValue,
    rangeLow,
    rangeHigh,
    sourceEvidenceId,
    clinicianName,
    clinicianGivenAtIso,
    personalNote,
    isActive,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRow &&
          other.id == this.id &&
          other.goalType == this.goalType &&
          other.metric == this.metric &&
          other.targetValue == this.targetValue &&
          other.rangeLow == this.rangeLow &&
          other.rangeHigh == this.rangeHigh &&
          other.sourceEvidenceId == this.sourceEvidenceId &&
          other.clinicianName == this.clinicianName &&
          other.clinicianGivenAtIso == this.clinicianGivenAtIso &&
          other.personalNote == this.personalNote &&
          other.isActive == this.isActive &&
          other.createdAtUtc == this.createdAtUtc);
}

class GoalCompanion extends UpdateCompanion<GoalRow> {
  final Value<int> id;
  final Value<String> goalType;
  final Value<String> metric;
  final Value<double> targetValue;
  final Value<double?> rangeLow;
  final Value<double?> rangeHigh;
  final Value<String?> sourceEvidenceId;
  final Value<String?> clinicianName;
  final Value<String?> clinicianGivenAtIso;
  final Value<String?> personalNote;
  final Value<bool> isActive;
  final Value<DateTime> createdAtUtc;
  const GoalCompanion({
    this.id = const Value.absent(),
    this.goalType = const Value.absent(),
    this.metric = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.rangeLow = const Value.absent(),
    this.rangeHigh = const Value.absent(),
    this.sourceEvidenceId = const Value.absent(),
    this.clinicianName = const Value.absent(),
    this.clinicianGivenAtIso = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
  });
  GoalCompanion.insert({
    this.id = const Value.absent(),
    required String goalType,
    required String metric,
    required double targetValue,
    this.rangeLow = const Value.absent(),
    this.rangeHigh = const Value.absent(),
    this.sourceEvidenceId = const Value.absent(),
    this.clinicianName = const Value.absent(),
    this.clinicianGivenAtIso = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAtUtc,
  }) : goalType = Value(goalType),
       metric = Value(metric),
       targetValue = Value(targetValue),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<GoalRow> custom({
    Expression<int>? id,
    Expression<String>? goalType,
    Expression<String>? metric,
    Expression<double>? targetValue,
    Expression<double>? rangeLow,
    Expression<double>? rangeHigh,
    Expression<String>? sourceEvidenceId,
    Expression<String>? clinicianName,
    Expression<String>? clinicianGivenAtIso,
    Expression<String>? personalNote,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalType != null) 'goal_type': goalType,
      if (metric != null) 'metric': metric,
      if (targetValue != null) 'target_value': targetValue,
      if (rangeLow != null) 'range_low': rangeLow,
      if (rangeHigh != null) 'range_high': rangeHigh,
      if (sourceEvidenceId != null) 'source_evidence_id': sourceEvidenceId,
      if (clinicianName != null) 'clinician_name': clinicianName,
      if (clinicianGivenAtIso != null)
        'clinician_given_at_iso': clinicianGivenAtIso,
      if (personalNote != null) 'personal_note': personalNote,
      if (isActive != null) 'is_active': isActive,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
    });
  }

  GoalCompanion copyWith({
    Value<int>? id,
    Value<String>? goalType,
    Value<String>? metric,
    Value<double>? targetValue,
    Value<double?>? rangeLow,
    Value<double?>? rangeHigh,
    Value<String?>? sourceEvidenceId,
    Value<String?>? clinicianName,
    Value<String?>? clinicianGivenAtIso,
    Value<String?>? personalNote,
    Value<bool>? isActive,
    Value<DateTime>? createdAtUtc,
  }) {
    return GoalCompanion(
      id: id ?? this.id,
      goalType: goalType ?? this.goalType,
      metric: metric ?? this.metric,
      targetValue: targetValue ?? this.targetValue,
      rangeLow: rangeLow ?? this.rangeLow,
      rangeHigh: rangeHigh ?? this.rangeHigh,
      sourceEvidenceId: sourceEvidenceId ?? this.sourceEvidenceId,
      clinicianName: clinicianName ?? this.clinicianName,
      clinicianGivenAtIso: clinicianGivenAtIso ?? this.clinicianGivenAtIso,
      personalNote: personalNote ?? this.personalNote,
      isActive: isActive ?? this.isActive,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (rangeLow.present) {
      map['range_low'] = Variable<double>(rangeLow.value);
    }
    if (rangeHigh.present) {
      map['range_high'] = Variable<double>(rangeHigh.value);
    }
    if (sourceEvidenceId.present) {
      map['source_evidence_id'] = Variable<String>(sourceEvidenceId.value);
    }
    if (clinicianName.present) {
      map['clinician_name'] = Variable<String>(clinicianName.value);
    }
    if (clinicianGivenAtIso.present) {
      map['clinician_given_at_iso'] = Variable<String>(
        clinicianGivenAtIso.value,
      );
    }
    if (personalNote.present) {
      map['personal_note'] = Variable<String>(personalNote.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalCompanion(')
          ..write('id: $id, ')
          ..write('goalType: $goalType, ')
          ..write('metric: $metric, ')
          ..write('targetValue: $targetValue, ')
          ..write('rangeLow: $rangeLow, ')
          ..write('rangeHigh: $rangeHigh, ')
          ..write('sourceEvidenceId: $sourceEvidenceId, ')
          ..write('clinicianName: $clinicianName, ')
          ..write('clinicianGivenAtIso: $clinicianGivenAtIso, ')
          ..write('personalNote: $personalNote, ')
          ..write('isActive: $isActive, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }
}

class $FoodTable extends Food with TableInfo<$FoodTable, FoodRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canonicalNameMeta = const VerificationMeta(
    'canonicalName',
  );
  @override
  late final GeneratedColumn<String> canonicalName = GeneratedColumn<String>(
    'canonical_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
    'name_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kcalPer100gMeta = const VerificationMeta(
    'kcalPer100g',
  );
  @override
  late final GeneratedColumn<double> kcalPer100g = GeneratedColumn<double>(
    'kcal_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGPer100gMeta = const VerificationMeta(
    'proteinGPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinGPer100g = GeneratedColumn<double>(
    'protein_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatGPer100gMeta = const VerificationMeta(
    'fatGPer100g',
  );
  @override
  late final GeneratedColumn<double> fatGPer100g = GeneratedColumn<double>(
    'fat_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbohydrateTotalGPer100gMeta =
      const VerificationMeta('carbohydrateTotalGPer100g');
  @override
  late final GeneratedColumn<double> carbohydrateTotalGPer100g =
      GeneratedColumn<double>(
        'carbohydrate_total_g_per100g',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fiberGPer100gMeta = const VerificationMeta(
    'fiberGPer100g',
  );
  @override
  late final GeneratedColumn<double> fiberGPer100g = GeneratedColumn<double>(
    'fiber_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _netCarbGPer100gMeta = const VerificationMeta(
    'netCarbGPer100g',
  );
  @override
  late final GeneratedColumn<double> netCarbGPer100g = GeneratedColumn<double>(
    'net_carb_g_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataSourceMeta = const VerificationMeta(
    'dataSource',
  );
  @override
  late final GeneratedColumn<String> dataSource = GeneratedColumn<String>(
    'data_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceVersionMeta = const VerificationMeta(
    'sourceVersion',
  );
  @override
  late final GeneratedColumn<String> sourceVersion = GeneratedColumn<String>(
    'source_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceRecordIdMeta = const VerificationMeta(
    'sourceRecordId',
  );
  @override
  late final GeneratedColumn<String> sourceRecordId = GeneratedColumn<String>(
    'source_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseMeta = const VerificationMeta(
    'license',
  );
  @override
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
    'license',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReviewedAtIsoMeta = const VerificationMeta(
    'lastReviewedAtIso',
  );
  @override
  late final GeneratedColumn<String> lastReviewedAtIso =
      GeneratedColumn<String>(
        'last_reviewed_at_iso',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    canonicalName,
    nameTr,
    nameEn,
    category,
    kcalPer100g,
    proteinGPer100g,
    fatGPer100g,
    carbohydrateTotalGPer100g,
    fiberGPer100g,
    netCarbGPer100g,
    dataSource,
    sourceVersion,
    sourceRecordId,
    license,
    lastReviewedAtIso,
    isUserCreated,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('canonical_name')) {
      context.handle(
        _canonicalNameMeta,
        canonicalName.isAcceptableOrUnknown(
          data['canonical_name']!,
          _canonicalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalNameMeta);
    }
    if (data.containsKey('name_tr')) {
      context.handle(
        _nameTrMeta,
        nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('kcal_per100g')) {
      context.handle(
        _kcalPer100gMeta,
        kcalPer100g.isAcceptableOrUnknown(
          data['kcal_per100g']!,
          _kcalPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kcalPer100gMeta);
    }
    if (data.containsKey('protein_g_per100g')) {
      context.handle(
        _proteinGPer100gMeta,
        proteinGPer100g.isAcceptableOrUnknown(
          data['protein_g_per100g']!,
          _proteinGPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinGPer100gMeta);
    }
    if (data.containsKey('fat_g_per100g')) {
      context.handle(
        _fatGPer100gMeta,
        fatGPer100g.isAcceptableOrUnknown(
          data['fat_g_per100g']!,
          _fatGPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fatGPer100gMeta);
    }
    if (data.containsKey('carbohydrate_total_g_per100g')) {
      context.handle(
        _carbohydrateTotalGPer100gMeta,
        carbohydrateTotalGPer100g.isAcceptableOrUnknown(
          data['carbohydrate_total_g_per100g']!,
          _carbohydrateTotalGPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbohydrateTotalGPer100gMeta);
    }
    if (data.containsKey('fiber_g_per100g')) {
      context.handle(
        _fiberGPer100gMeta,
        fiberGPer100g.isAcceptableOrUnknown(
          data['fiber_g_per100g']!,
          _fiberGPer100gMeta,
        ),
      );
    }
    if (data.containsKey('net_carb_g_per100g')) {
      context.handle(
        _netCarbGPer100gMeta,
        netCarbGPer100g.isAcceptableOrUnknown(
          data['net_carb_g_per100g']!,
          _netCarbGPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_netCarbGPer100gMeta);
    }
    if (data.containsKey('data_source')) {
      context.handle(
        _dataSourceMeta,
        dataSource.isAcceptableOrUnknown(data['data_source']!, _dataSourceMeta),
      );
    } else if (isInserting) {
      context.missing(_dataSourceMeta);
    }
    if (data.containsKey('source_version')) {
      context.handle(
        _sourceVersionMeta,
        sourceVersion.isAcceptableOrUnknown(
          data['source_version']!,
          _sourceVersionMeta,
        ),
      );
    }
    if (data.containsKey('source_record_id')) {
      context.handle(
        _sourceRecordIdMeta,
        sourceRecordId.isAcceptableOrUnknown(
          data['source_record_id']!,
          _sourceRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('license')) {
      context.handle(
        _licenseMeta,
        license.isAcceptableOrUnknown(data['license']!, _licenseMeta),
      );
    }
    if (data.containsKey('last_reviewed_at_iso')) {
      context.handle(
        _lastReviewedAtIsoMeta,
        lastReviewedAtIso.isAcceptableOrUnknown(
          data['last_reviewed_at_iso']!,
          _lastReviewedAtIsoMeta,
        ),
      );
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      canonicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_name'],
      )!,
      nameTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_tr'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      kcalPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_per100g'],
      )!,
      proteinGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g_per100g'],
      )!,
      fatGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g_per100g'],
      )!,
      carbohydrateTotalGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohydrate_total_g_per100g'],
      )!,
      fiberGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_g_per100g'],
      )!,
      netCarbGPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_carb_g_per100g'],
      )!,
      dataSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_source'],
      )!,
      sourceVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_version'],
      ),
      sourceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_record_id'],
      ),
      license: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license'],
      ),
      lastReviewedAtIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_reviewed_at_iso'],
      ),
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FoodTable createAlias(String alias) {
    return $FoodTable(attachedDatabase, alias);
  }
}

class FoodRow extends DataClass implements Insertable<FoodRow> {
  final String id;
  final String canonicalName;
  final String? nameTr;
  final String? nameEn;
  final String category;
  final double kcalPer100g;
  final double proteinGPer100g;
  final double fatGPer100g;
  final double carbohydrateTotalGPer100g;
  final double fiberGPer100g;
  final double netCarbGPer100g;
  final String dataSource;
  final String? sourceVersion;
  final String? sourceRecordId;
  final String? license;
  final String? lastReviewedAtIso;
  final bool isUserCreated;
  final String? notes;
  const FoodRow({
    required this.id,
    required this.canonicalName,
    this.nameTr,
    this.nameEn,
    required this.category,
    required this.kcalPer100g,
    required this.proteinGPer100g,
    required this.fatGPer100g,
    required this.carbohydrateTotalGPer100g,
    required this.fiberGPer100g,
    required this.netCarbGPer100g,
    required this.dataSource,
    this.sourceVersion,
    this.sourceRecordId,
    this.license,
    this.lastReviewedAtIso,
    required this.isUserCreated,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['canonical_name'] = Variable<String>(canonicalName);
    if (!nullToAbsent || nameTr != null) {
      map['name_tr'] = Variable<String>(nameTr);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    map['category'] = Variable<String>(category);
    map['kcal_per100g'] = Variable<double>(kcalPer100g);
    map['protein_g_per100g'] = Variable<double>(proteinGPer100g);
    map['fat_g_per100g'] = Variable<double>(fatGPer100g);
    map['carbohydrate_total_g_per100g'] = Variable<double>(
      carbohydrateTotalGPer100g,
    );
    map['fiber_g_per100g'] = Variable<double>(fiberGPer100g);
    map['net_carb_g_per100g'] = Variable<double>(netCarbGPer100g);
    map['data_source'] = Variable<String>(dataSource);
    if (!nullToAbsent || sourceVersion != null) {
      map['source_version'] = Variable<String>(sourceVersion);
    }
    if (!nullToAbsent || sourceRecordId != null) {
      map['source_record_id'] = Variable<String>(sourceRecordId);
    }
    if (!nullToAbsent || license != null) {
      map['license'] = Variable<String>(license);
    }
    if (!nullToAbsent || lastReviewedAtIso != null) {
      map['last_reviewed_at_iso'] = Variable<String>(lastReviewedAtIso);
    }
    map['is_user_created'] = Variable<bool>(isUserCreated);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FoodCompanion toCompanion(bool nullToAbsent) {
    return FoodCompanion(
      id: Value(id),
      canonicalName: Value(canonicalName),
      nameTr: nameTr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameTr),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      category: Value(category),
      kcalPer100g: Value(kcalPer100g),
      proteinGPer100g: Value(proteinGPer100g),
      fatGPer100g: Value(fatGPer100g),
      carbohydrateTotalGPer100g: Value(carbohydrateTotalGPer100g),
      fiberGPer100g: Value(fiberGPer100g),
      netCarbGPer100g: Value(netCarbGPer100g),
      dataSource: Value(dataSource),
      sourceVersion: sourceVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceVersion),
      sourceRecordId: sourceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecordId),
      license: license == null && nullToAbsent
          ? const Value.absent()
          : Value(license),
      lastReviewedAtIso: lastReviewedAtIso == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAtIso),
      isUserCreated: Value(isUserCreated),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FoodRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodRow(
      id: serializer.fromJson<String>(json['id']),
      canonicalName: serializer.fromJson<String>(json['canonicalName']),
      nameTr: serializer.fromJson<String?>(json['nameTr']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      category: serializer.fromJson<String>(json['category']),
      kcalPer100g: serializer.fromJson<double>(json['kcalPer100g']),
      proteinGPer100g: serializer.fromJson<double>(json['proteinGPer100g']),
      fatGPer100g: serializer.fromJson<double>(json['fatGPer100g']),
      carbohydrateTotalGPer100g: serializer.fromJson<double>(
        json['carbohydrateTotalGPer100g'],
      ),
      fiberGPer100g: serializer.fromJson<double>(json['fiberGPer100g']),
      netCarbGPer100g: serializer.fromJson<double>(json['netCarbGPer100g']),
      dataSource: serializer.fromJson<String>(json['dataSource']),
      sourceVersion: serializer.fromJson<String?>(json['sourceVersion']),
      sourceRecordId: serializer.fromJson<String?>(json['sourceRecordId']),
      license: serializer.fromJson<String?>(json['license']),
      lastReviewedAtIso: serializer.fromJson<String?>(
        json['lastReviewedAtIso'],
      ),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'canonicalName': serializer.toJson<String>(canonicalName),
      'nameTr': serializer.toJson<String?>(nameTr),
      'nameEn': serializer.toJson<String?>(nameEn),
      'category': serializer.toJson<String>(category),
      'kcalPer100g': serializer.toJson<double>(kcalPer100g),
      'proteinGPer100g': serializer.toJson<double>(proteinGPer100g),
      'fatGPer100g': serializer.toJson<double>(fatGPer100g),
      'carbohydrateTotalGPer100g': serializer.toJson<double>(
        carbohydrateTotalGPer100g,
      ),
      'fiberGPer100g': serializer.toJson<double>(fiberGPer100g),
      'netCarbGPer100g': serializer.toJson<double>(netCarbGPer100g),
      'dataSource': serializer.toJson<String>(dataSource),
      'sourceVersion': serializer.toJson<String?>(sourceVersion),
      'sourceRecordId': serializer.toJson<String?>(sourceRecordId),
      'license': serializer.toJson<String?>(license),
      'lastReviewedAtIso': serializer.toJson<String?>(lastReviewedAtIso),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FoodRow copyWith({
    String? id,
    String? canonicalName,
    Value<String?> nameTr = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    String? category,
    double? kcalPer100g,
    double? proteinGPer100g,
    double? fatGPer100g,
    double? carbohydrateTotalGPer100g,
    double? fiberGPer100g,
    double? netCarbGPer100g,
    String? dataSource,
    Value<String?> sourceVersion = const Value.absent(),
    Value<String?> sourceRecordId = const Value.absent(),
    Value<String?> license = const Value.absent(),
    Value<String?> lastReviewedAtIso = const Value.absent(),
    bool? isUserCreated,
    Value<String?> notes = const Value.absent(),
  }) => FoodRow(
    id: id ?? this.id,
    canonicalName: canonicalName ?? this.canonicalName,
    nameTr: nameTr.present ? nameTr.value : this.nameTr,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    category: category ?? this.category,
    kcalPer100g: kcalPer100g ?? this.kcalPer100g,
    proteinGPer100g: proteinGPer100g ?? this.proteinGPer100g,
    fatGPer100g: fatGPer100g ?? this.fatGPer100g,
    carbohydrateTotalGPer100g:
        carbohydrateTotalGPer100g ?? this.carbohydrateTotalGPer100g,
    fiberGPer100g: fiberGPer100g ?? this.fiberGPer100g,
    netCarbGPer100g: netCarbGPer100g ?? this.netCarbGPer100g,
    dataSource: dataSource ?? this.dataSource,
    sourceVersion: sourceVersion.present
        ? sourceVersion.value
        : this.sourceVersion,
    sourceRecordId: sourceRecordId.present
        ? sourceRecordId.value
        : this.sourceRecordId,
    license: license.present ? license.value : this.license,
    lastReviewedAtIso: lastReviewedAtIso.present
        ? lastReviewedAtIso.value
        : this.lastReviewedAtIso,
    isUserCreated: isUserCreated ?? this.isUserCreated,
    notes: notes.present ? notes.value : this.notes,
  );
  FoodRow copyWithCompanion(FoodCompanion data) {
    return FoodRow(
      id: data.id.present ? data.id.value : this.id,
      canonicalName: data.canonicalName.present
          ? data.canonicalName.value
          : this.canonicalName,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      category: data.category.present ? data.category.value : this.category,
      kcalPer100g: data.kcalPer100g.present
          ? data.kcalPer100g.value
          : this.kcalPer100g,
      proteinGPer100g: data.proteinGPer100g.present
          ? data.proteinGPer100g.value
          : this.proteinGPer100g,
      fatGPer100g: data.fatGPer100g.present
          ? data.fatGPer100g.value
          : this.fatGPer100g,
      carbohydrateTotalGPer100g: data.carbohydrateTotalGPer100g.present
          ? data.carbohydrateTotalGPer100g.value
          : this.carbohydrateTotalGPer100g,
      fiberGPer100g: data.fiberGPer100g.present
          ? data.fiberGPer100g.value
          : this.fiberGPer100g,
      netCarbGPer100g: data.netCarbGPer100g.present
          ? data.netCarbGPer100g.value
          : this.netCarbGPer100g,
      dataSource: data.dataSource.present
          ? data.dataSource.value
          : this.dataSource,
      sourceVersion: data.sourceVersion.present
          ? data.sourceVersion.value
          : this.sourceVersion,
      sourceRecordId: data.sourceRecordId.present
          ? data.sourceRecordId.value
          : this.sourceRecordId,
      license: data.license.present ? data.license.value : this.license,
      lastReviewedAtIso: data.lastReviewedAtIso.present
          ? data.lastReviewedAtIso.value
          : this.lastReviewedAtIso,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodRow(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('carbohydrateTotalGPer100g: $carbohydrateTotalGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('netCarbGPer100g: $netCarbGPer100g, ')
          ..write('dataSource: $dataSource, ')
          ..write('sourceVersion: $sourceVersion, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('license: $license, ')
          ..write('lastReviewedAtIso: $lastReviewedAtIso, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    canonicalName,
    nameTr,
    nameEn,
    category,
    kcalPer100g,
    proteinGPer100g,
    fatGPer100g,
    carbohydrateTotalGPer100g,
    fiberGPer100g,
    netCarbGPer100g,
    dataSource,
    sourceVersion,
    sourceRecordId,
    license,
    lastReviewedAtIso,
    isUserCreated,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodRow &&
          other.id == this.id &&
          other.canonicalName == this.canonicalName &&
          other.nameTr == this.nameTr &&
          other.nameEn == this.nameEn &&
          other.category == this.category &&
          other.kcalPer100g == this.kcalPer100g &&
          other.proteinGPer100g == this.proteinGPer100g &&
          other.fatGPer100g == this.fatGPer100g &&
          other.carbohydrateTotalGPer100g == this.carbohydrateTotalGPer100g &&
          other.fiberGPer100g == this.fiberGPer100g &&
          other.netCarbGPer100g == this.netCarbGPer100g &&
          other.dataSource == this.dataSource &&
          other.sourceVersion == this.sourceVersion &&
          other.sourceRecordId == this.sourceRecordId &&
          other.license == this.license &&
          other.lastReviewedAtIso == this.lastReviewedAtIso &&
          other.isUserCreated == this.isUserCreated &&
          other.notes == this.notes);
}

class FoodCompanion extends UpdateCompanion<FoodRow> {
  final Value<String> id;
  final Value<String> canonicalName;
  final Value<String?> nameTr;
  final Value<String?> nameEn;
  final Value<String> category;
  final Value<double> kcalPer100g;
  final Value<double> proteinGPer100g;
  final Value<double> fatGPer100g;
  final Value<double> carbohydrateTotalGPer100g;
  final Value<double> fiberGPer100g;
  final Value<double> netCarbGPer100g;
  final Value<String> dataSource;
  final Value<String?> sourceVersion;
  final Value<String?> sourceRecordId;
  final Value<String?> license;
  final Value<String?> lastReviewedAtIso;
  final Value<bool> isUserCreated;
  final Value<String?> notes;
  final Value<int> rowid;
  const FoodCompanion({
    this.id = const Value.absent(),
    this.canonicalName = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.category = const Value.absent(),
    this.kcalPer100g = const Value.absent(),
    this.proteinGPer100g = const Value.absent(),
    this.fatGPer100g = const Value.absent(),
    this.carbohydrateTotalGPer100g = const Value.absent(),
    this.fiberGPer100g = const Value.absent(),
    this.netCarbGPer100g = const Value.absent(),
    this.dataSource = const Value.absent(),
    this.sourceVersion = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    this.license = const Value.absent(),
    this.lastReviewedAtIso = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodCompanion.insert({
    required String id,
    required String canonicalName,
    this.nameTr = const Value.absent(),
    this.nameEn = const Value.absent(),
    required String category,
    required double kcalPer100g,
    required double proteinGPer100g,
    required double fatGPer100g,
    required double carbohydrateTotalGPer100g,
    this.fiberGPer100g = const Value.absent(),
    required double netCarbGPer100g,
    required String dataSource,
    this.sourceVersion = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    this.license = const Value.absent(),
    this.lastReviewedAtIso = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       canonicalName = Value(canonicalName),
       category = Value(category),
       kcalPer100g = Value(kcalPer100g),
       proteinGPer100g = Value(proteinGPer100g),
       fatGPer100g = Value(fatGPer100g),
       carbohydrateTotalGPer100g = Value(carbohydrateTotalGPer100g),
       netCarbGPer100g = Value(netCarbGPer100g),
       dataSource = Value(dataSource);
  static Insertable<FoodRow> custom({
    Expression<String>? id,
    Expression<String>? canonicalName,
    Expression<String>? nameTr,
    Expression<String>? nameEn,
    Expression<String>? category,
    Expression<double>? kcalPer100g,
    Expression<double>? proteinGPer100g,
    Expression<double>? fatGPer100g,
    Expression<double>? carbohydrateTotalGPer100g,
    Expression<double>? fiberGPer100g,
    Expression<double>? netCarbGPer100g,
    Expression<String>? dataSource,
    Expression<String>? sourceVersion,
    Expression<String>? sourceRecordId,
    Expression<String>? license,
    Expression<String>? lastReviewedAtIso,
    Expression<bool>? isUserCreated,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (canonicalName != null) 'canonical_name': canonicalName,
      if (nameTr != null) 'name_tr': nameTr,
      if (nameEn != null) 'name_en': nameEn,
      if (category != null) 'category': category,
      if (kcalPer100g != null) 'kcal_per100g': kcalPer100g,
      if (proteinGPer100g != null) 'protein_g_per100g': proteinGPer100g,
      if (fatGPer100g != null) 'fat_g_per100g': fatGPer100g,
      if (carbohydrateTotalGPer100g != null)
        'carbohydrate_total_g_per100g': carbohydrateTotalGPer100g,
      if (fiberGPer100g != null) 'fiber_g_per100g': fiberGPer100g,
      if (netCarbGPer100g != null) 'net_carb_g_per100g': netCarbGPer100g,
      if (dataSource != null) 'data_source': dataSource,
      if (sourceVersion != null) 'source_version': sourceVersion,
      if (sourceRecordId != null) 'source_record_id': sourceRecordId,
      if (license != null) 'license': license,
      if (lastReviewedAtIso != null) 'last_reviewed_at_iso': lastReviewedAtIso,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodCompanion copyWith({
    Value<String>? id,
    Value<String>? canonicalName,
    Value<String?>? nameTr,
    Value<String?>? nameEn,
    Value<String>? category,
    Value<double>? kcalPer100g,
    Value<double>? proteinGPer100g,
    Value<double>? fatGPer100g,
    Value<double>? carbohydrateTotalGPer100g,
    Value<double>? fiberGPer100g,
    Value<double>? netCarbGPer100g,
    Value<String>? dataSource,
    Value<String?>? sourceVersion,
    Value<String?>? sourceRecordId,
    Value<String?>? license,
    Value<String?>? lastReviewedAtIso,
    Value<bool>? isUserCreated,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return FoodCompanion(
      id: id ?? this.id,
      canonicalName: canonicalName ?? this.canonicalName,
      nameTr: nameTr ?? this.nameTr,
      nameEn: nameEn ?? this.nameEn,
      category: category ?? this.category,
      kcalPer100g: kcalPer100g ?? this.kcalPer100g,
      proteinGPer100g: proteinGPer100g ?? this.proteinGPer100g,
      fatGPer100g: fatGPer100g ?? this.fatGPer100g,
      carbohydrateTotalGPer100g:
          carbohydrateTotalGPer100g ?? this.carbohydrateTotalGPer100g,
      fiberGPer100g: fiberGPer100g ?? this.fiberGPer100g,
      netCarbGPer100g: netCarbGPer100g ?? this.netCarbGPer100g,
      dataSource: dataSource ?? this.dataSource,
      sourceVersion: sourceVersion ?? this.sourceVersion,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      license: license ?? this.license,
      lastReviewedAtIso: lastReviewedAtIso ?? this.lastReviewedAtIso,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (canonicalName.present) {
      map['canonical_name'] = Variable<String>(canonicalName.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (kcalPer100g.present) {
      map['kcal_per100g'] = Variable<double>(kcalPer100g.value);
    }
    if (proteinGPer100g.present) {
      map['protein_g_per100g'] = Variable<double>(proteinGPer100g.value);
    }
    if (fatGPer100g.present) {
      map['fat_g_per100g'] = Variable<double>(fatGPer100g.value);
    }
    if (carbohydrateTotalGPer100g.present) {
      map['carbohydrate_total_g_per100g'] = Variable<double>(
        carbohydrateTotalGPer100g.value,
      );
    }
    if (fiberGPer100g.present) {
      map['fiber_g_per100g'] = Variable<double>(fiberGPer100g.value);
    }
    if (netCarbGPer100g.present) {
      map['net_carb_g_per100g'] = Variable<double>(netCarbGPer100g.value);
    }
    if (dataSource.present) {
      map['data_source'] = Variable<String>(dataSource.value);
    }
    if (sourceVersion.present) {
      map['source_version'] = Variable<String>(sourceVersion.value);
    }
    if (sourceRecordId.present) {
      map['source_record_id'] = Variable<String>(sourceRecordId.value);
    }
    if (license.present) {
      map['license'] = Variable<String>(license.value);
    }
    if (lastReviewedAtIso.present) {
      map['last_reviewed_at_iso'] = Variable<String>(lastReviewedAtIso.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodCompanion(')
          ..write('id: $id, ')
          ..write('canonicalName: $canonicalName, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('kcalPer100g: $kcalPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('carbohydrateTotalGPer100g: $carbohydrateTotalGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('netCarbGPer100g: $netCarbGPer100g, ')
          ..write('dataSource: $dataSource, ')
          ..write('sourceVersion: $sourceVersion, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('license: $license, ')
          ..write('lastReviewedAtIso: $lastReviewedAtIso, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServingOptionTable extends ServingOption
    with TableInfo<$ServingOptionTable, ServingOptionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServingOptionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelTrMeta = const VerificationMeta(
    'labelTr',
  );
  @override
  late final GeneratedColumn<String> labelTr = GeneratedColumn<String>(
    'label_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelEnMeta = const VerificationMeta(
    'labelEn',
  );
  @override
  late final GeneratedColumn<String> labelEn = GeneratedColumn<String>(
    'label_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gramsPerServingMeta = const VerificationMeta(
    'gramsPerServing',
  );
  @override
  late final GeneratedColumn<double> gramsPerServing = GeneratedColumn<double>(
    'grams_per_serving',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodId,
    labelTr,
    labelEn,
    gramsPerServing,
    isDefault,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'serving_option';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServingOptionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('label_tr')) {
      context.handle(
        _labelTrMeta,
        labelTr.isAcceptableOrUnknown(data['label_tr']!, _labelTrMeta),
      );
    }
    if (data.containsKey('label_en')) {
      context.handle(
        _labelEnMeta,
        labelEn.isAcceptableOrUnknown(data['label_en']!, _labelEnMeta),
      );
    }
    if (data.containsKey('grams_per_serving')) {
      context.handle(
        _gramsPerServingMeta,
        gramsPerServing.isAcceptableOrUnknown(
          data['grams_per_serving']!,
          _gramsPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gramsPerServingMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServingOptionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServingOptionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      labelTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_tr'],
      ),
      labelEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_en'],
      ),
      gramsPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams_per_serving'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $ServingOptionTable createAlias(String alias) {
    return $ServingOptionTable(attachedDatabase, alias);
  }
}

class ServingOptionRow extends DataClass
    implements Insertable<ServingOptionRow> {
  final int id;
  final String foodId;
  final String? labelTr;
  final String? labelEn;
  final double gramsPerServing;
  final bool isDefault;
  const ServingOptionRow({
    required this.id,
    required this.foodId,
    this.labelTr,
    this.labelEn,
    required this.gramsPerServing,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['food_id'] = Variable<String>(foodId);
    if (!nullToAbsent || labelTr != null) {
      map['label_tr'] = Variable<String>(labelTr);
    }
    if (!nullToAbsent || labelEn != null) {
      map['label_en'] = Variable<String>(labelEn);
    }
    map['grams_per_serving'] = Variable<double>(gramsPerServing);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  ServingOptionCompanion toCompanion(bool nullToAbsent) {
    return ServingOptionCompanion(
      id: Value(id),
      foodId: Value(foodId),
      labelTr: labelTr == null && nullToAbsent
          ? const Value.absent()
          : Value(labelTr),
      labelEn: labelEn == null && nullToAbsent
          ? const Value.absent()
          : Value(labelEn),
      gramsPerServing: Value(gramsPerServing),
      isDefault: Value(isDefault),
    );
  }

  factory ServingOptionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServingOptionRow(
      id: serializer.fromJson<int>(json['id']),
      foodId: serializer.fromJson<String>(json['foodId']),
      labelTr: serializer.fromJson<String?>(json['labelTr']),
      labelEn: serializer.fromJson<String?>(json['labelEn']),
      gramsPerServing: serializer.fromJson<double>(json['gramsPerServing']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'foodId': serializer.toJson<String>(foodId),
      'labelTr': serializer.toJson<String?>(labelTr),
      'labelEn': serializer.toJson<String?>(labelEn),
      'gramsPerServing': serializer.toJson<double>(gramsPerServing),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  ServingOptionRow copyWith({
    int? id,
    String? foodId,
    Value<String?> labelTr = const Value.absent(),
    Value<String?> labelEn = const Value.absent(),
    double? gramsPerServing,
    bool? isDefault,
  }) => ServingOptionRow(
    id: id ?? this.id,
    foodId: foodId ?? this.foodId,
    labelTr: labelTr.present ? labelTr.value : this.labelTr,
    labelEn: labelEn.present ? labelEn.value : this.labelEn,
    gramsPerServing: gramsPerServing ?? this.gramsPerServing,
    isDefault: isDefault ?? this.isDefault,
  );
  ServingOptionRow copyWithCompanion(ServingOptionCompanion data) {
    return ServingOptionRow(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      labelTr: data.labelTr.present ? data.labelTr.value : this.labelTr,
      labelEn: data.labelEn.present ? data.labelEn.value : this.labelEn,
      gramsPerServing: data.gramsPerServing.present
          ? data.gramsPerServing.value
          : this.gramsPerServing,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServingOptionRow(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('labelTr: $labelTr, ')
          ..write('labelEn: $labelEn, ')
          ..write('gramsPerServing: $gramsPerServing, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, foodId, labelTr, labelEn, gramsPerServing, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServingOptionRow &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.labelTr == this.labelTr &&
          other.labelEn == this.labelEn &&
          other.gramsPerServing == this.gramsPerServing &&
          other.isDefault == this.isDefault);
}

class ServingOptionCompanion extends UpdateCompanion<ServingOptionRow> {
  final Value<int> id;
  final Value<String> foodId;
  final Value<String?> labelTr;
  final Value<String?> labelEn;
  final Value<double> gramsPerServing;
  final Value<bool> isDefault;
  const ServingOptionCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.labelTr = const Value.absent(),
    this.labelEn = const Value.absent(),
    this.gramsPerServing = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  ServingOptionCompanion.insert({
    this.id = const Value.absent(),
    required String foodId,
    this.labelTr = const Value.absent(),
    this.labelEn = const Value.absent(),
    required double gramsPerServing,
    this.isDefault = const Value.absent(),
  }) : foodId = Value(foodId),
       gramsPerServing = Value(gramsPerServing);
  static Insertable<ServingOptionRow> custom({
    Expression<int>? id,
    Expression<String>? foodId,
    Expression<String>? labelTr,
    Expression<String>? labelEn,
    Expression<double>? gramsPerServing,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (labelTr != null) 'label_tr': labelTr,
      if (labelEn != null) 'label_en': labelEn,
      if (gramsPerServing != null) 'grams_per_serving': gramsPerServing,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  ServingOptionCompanion copyWith({
    Value<int>? id,
    Value<String>? foodId,
    Value<String?>? labelTr,
    Value<String?>? labelEn,
    Value<double>? gramsPerServing,
    Value<bool>? isDefault,
  }) {
    return ServingOptionCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      labelTr: labelTr ?? this.labelTr,
      labelEn: labelEn ?? this.labelEn,
      gramsPerServing: gramsPerServing ?? this.gramsPerServing,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (labelTr.present) {
      map['label_tr'] = Variable<String>(labelTr.value);
    }
    if (labelEn.present) {
      map['label_en'] = Variable<String>(labelEn.value);
    }
    if (gramsPerServing.present) {
      map['grams_per_serving'] = Variable<double>(gramsPerServing.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServingOptionCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('labelTr: $labelTr, ')
          ..write('labelEn: $labelEn, ')
          ..write('gramsPerServing: $gramsPerServing, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $RecipeTable extends Recipe with TableInfo<$RecipeTable, RecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleTrMeta = const VerificationMeta(
    'titleTr',
  );
  @override
  late final GeneratedColumn<String> titleTr = GeneratedColumn<String>(
    'title_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepMinutesMeta = const VerificationMeta(
    'prepMinutes',
  );
  @override
  late final GeneratedColumn<int> prepMinutes = GeneratedColumn<int>(
    'prep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergensCsvMeta = const VerificationMeta(
    'allergensCsv',
  );
  @override
  late final GeneratedColumn<String> allergensCsv = GeneratedColumn<String>(
    'allergens_csv',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsTrMeta = const VerificationMeta(
    'stepsTr',
  );
  @override
  late final GeneratedColumn<String> stepsTr = GeneratedColumn<String>(
    'steps_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsEnMeta = const VerificationMeta(
    'stepsEn',
  );
  @override
  late final GeneratedColumn<String> stepsEn = GeneratedColumn<String>(
    'steps_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storageNoteTrMeta = const VerificationMeta(
    'storageNoteTr',
  );
  @override
  late final GeneratedColumn<String> storageNoteTr = GeneratedColumn<String>(
    'storage_note_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storageNoteEnMeta = const VerificationMeta(
    'storageNoteEn',
  );
  @override
  late final GeneratedColumn<String> storageNoteEn = GeneratedColumn<String>(
    'storage_note_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _netCarbMethodNoteMeta = const VerificationMeta(
    'netCarbMethodNote',
  );
  @override
  late final GeneratedColumn<String> netCarbMethodNote =
      GeneratedColumn<String>(
        'net_carb_method_note',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titleTr,
    titleEn,
    servings,
    prepMinutes,
    allergensCsv,
    stepsTr,
    stepsEn,
    storageNoteTr,
    storageNoteEn,
    netCarbMethodNote,
    isUserCreated,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title_tr')) {
      context.handle(
        _titleTrMeta,
        titleTr.isAcceptableOrUnknown(data['title_tr']!, _titleTrMeta),
      );
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    if (data.containsKey('prep_minutes')) {
      context.handle(
        _prepMinutesMeta,
        prepMinutes.isAcceptableOrUnknown(
          data['prep_minutes']!,
          _prepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('allergens_csv')) {
      context.handle(
        _allergensCsvMeta,
        allergensCsv.isAcceptableOrUnknown(
          data['allergens_csv']!,
          _allergensCsvMeta,
        ),
      );
    }
    if (data.containsKey('steps_tr')) {
      context.handle(
        _stepsTrMeta,
        stepsTr.isAcceptableOrUnknown(data['steps_tr']!, _stepsTrMeta),
      );
    }
    if (data.containsKey('steps_en')) {
      context.handle(
        _stepsEnMeta,
        stepsEn.isAcceptableOrUnknown(data['steps_en']!, _stepsEnMeta),
      );
    }
    if (data.containsKey('storage_note_tr')) {
      context.handle(
        _storageNoteTrMeta,
        storageNoteTr.isAcceptableOrUnknown(
          data['storage_note_tr']!,
          _storageNoteTrMeta,
        ),
      );
    }
    if (data.containsKey('storage_note_en')) {
      context.handle(
        _storageNoteEnMeta,
        storageNoteEn.isAcceptableOrUnknown(
          data['storage_note_en']!,
          _storageNoteEnMeta,
        ),
      );
    }
    if (data.containsKey('net_carb_method_note')) {
      context.handle(
        _netCarbMethodNoteMeta,
        netCarbMethodNote.isAcceptableOrUnknown(
          data['net_carb_method_note']!,
          _netCarbMethodNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titleTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_tr'],
      ),
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      prepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_minutes'],
      ),
      allergensCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergens_csv'],
      ),
      stepsTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps_tr'],
      ),
      stepsEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps_en'],
      ),
      storageNoteTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_note_tr'],
      ),
      storageNoteEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_note_en'],
      ),
      netCarbMethodNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}net_carb_method_note'],
      ),
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $RecipeTable createAlias(String alias) {
    return $RecipeTable(attachedDatabase, alias);
  }
}

class RecipeRow extends DataClass implements Insertable<RecipeRow> {
  final String id;
  final String? titleTr;
  final String? titleEn;
  final int servings;
  final int? prepMinutes;
  final String? allergensCsv;
  final String? stepsTr;
  final String? stepsEn;
  final String? storageNoteTr;
  final String? storageNoteEn;
  final String? netCarbMethodNote;
  final bool isUserCreated;
  final DateTime createdAtUtc;
  const RecipeRow({
    required this.id,
    this.titleTr,
    this.titleEn,
    required this.servings,
    this.prepMinutes,
    this.allergensCsv,
    this.stepsTr,
    this.stepsEn,
    this.storageNoteTr,
    this.storageNoteEn,
    this.netCarbMethodNote,
    required this.isUserCreated,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || titleTr != null) {
      map['title_tr'] = Variable<String>(titleTr);
    }
    if (!nullToAbsent || titleEn != null) {
      map['title_en'] = Variable<String>(titleEn);
    }
    map['servings'] = Variable<int>(servings);
    if (!nullToAbsent || prepMinutes != null) {
      map['prep_minutes'] = Variable<int>(prepMinutes);
    }
    if (!nullToAbsent || allergensCsv != null) {
      map['allergens_csv'] = Variable<String>(allergensCsv);
    }
    if (!nullToAbsent || stepsTr != null) {
      map['steps_tr'] = Variable<String>(stepsTr);
    }
    if (!nullToAbsent || stepsEn != null) {
      map['steps_en'] = Variable<String>(stepsEn);
    }
    if (!nullToAbsent || storageNoteTr != null) {
      map['storage_note_tr'] = Variable<String>(storageNoteTr);
    }
    if (!nullToAbsent || storageNoteEn != null) {
      map['storage_note_en'] = Variable<String>(storageNoteEn);
    }
    if (!nullToAbsent || netCarbMethodNote != null) {
      map['net_carb_method_note'] = Variable<String>(netCarbMethodNote);
    }
    map['is_user_created'] = Variable<bool>(isUserCreated);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  RecipeCompanion toCompanion(bool nullToAbsent) {
    return RecipeCompanion(
      id: Value(id),
      titleTr: titleTr == null && nullToAbsent
          ? const Value.absent()
          : Value(titleTr),
      titleEn: titleEn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEn),
      servings: Value(servings),
      prepMinutes: prepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(prepMinutes),
      allergensCsv: allergensCsv == null && nullToAbsent
          ? const Value.absent()
          : Value(allergensCsv),
      stepsTr: stepsTr == null && nullToAbsent
          ? const Value.absent()
          : Value(stepsTr),
      stepsEn: stepsEn == null && nullToAbsent
          ? const Value.absent()
          : Value(stepsEn),
      storageNoteTr: storageNoteTr == null && nullToAbsent
          ? const Value.absent()
          : Value(storageNoteTr),
      storageNoteEn: storageNoteEn == null && nullToAbsent
          ? const Value.absent()
          : Value(storageNoteEn),
      netCarbMethodNote: netCarbMethodNote == null && nullToAbsent
          ? const Value.absent()
          : Value(netCarbMethodNote),
      isUserCreated: Value(isUserCreated),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory RecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeRow(
      id: serializer.fromJson<String>(json['id']),
      titleTr: serializer.fromJson<String?>(json['titleTr']),
      titleEn: serializer.fromJson<String?>(json['titleEn']),
      servings: serializer.fromJson<int>(json['servings']),
      prepMinutes: serializer.fromJson<int?>(json['prepMinutes']),
      allergensCsv: serializer.fromJson<String?>(json['allergensCsv']),
      stepsTr: serializer.fromJson<String?>(json['stepsTr']),
      stepsEn: serializer.fromJson<String?>(json['stepsEn']),
      storageNoteTr: serializer.fromJson<String?>(json['storageNoteTr']),
      storageNoteEn: serializer.fromJson<String?>(json['storageNoteEn']),
      netCarbMethodNote: serializer.fromJson<String?>(
        json['netCarbMethodNote'],
      ),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titleTr': serializer.toJson<String?>(titleTr),
      'titleEn': serializer.toJson<String?>(titleEn),
      'servings': serializer.toJson<int>(servings),
      'prepMinutes': serializer.toJson<int?>(prepMinutes),
      'allergensCsv': serializer.toJson<String?>(allergensCsv),
      'stepsTr': serializer.toJson<String?>(stepsTr),
      'stepsEn': serializer.toJson<String?>(stepsEn),
      'storageNoteTr': serializer.toJson<String?>(storageNoteTr),
      'storageNoteEn': serializer.toJson<String?>(storageNoteEn),
      'netCarbMethodNote': serializer.toJson<String?>(netCarbMethodNote),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  RecipeRow copyWith({
    String? id,
    Value<String?> titleTr = const Value.absent(),
    Value<String?> titleEn = const Value.absent(),
    int? servings,
    Value<int?> prepMinutes = const Value.absent(),
    Value<String?> allergensCsv = const Value.absent(),
    Value<String?> stepsTr = const Value.absent(),
    Value<String?> stepsEn = const Value.absent(),
    Value<String?> storageNoteTr = const Value.absent(),
    Value<String?> storageNoteEn = const Value.absent(),
    Value<String?> netCarbMethodNote = const Value.absent(),
    bool? isUserCreated,
    DateTime? createdAtUtc,
  }) => RecipeRow(
    id: id ?? this.id,
    titleTr: titleTr.present ? titleTr.value : this.titleTr,
    titleEn: titleEn.present ? titleEn.value : this.titleEn,
    servings: servings ?? this.servings,
    prepMinutes: prepMinutes.present ? prepMinutes.value : this.prepMinutes,
    allergensCsv: allergensCsv.present ? allergensCsv.value : this.allergensCsv,
    stepsTr: stepsTr.present ? stepsTr.value : this.stepsTr,
    stepsEn: stepsEn.present ? stepsEn.value : this.stepsEn,
    storageNoteTr: storageNoteTr.present
        ? storageNoteTr.value
        : this.storageNoteTr,
    storageNoteEn: storageNoteEn.present
        ? storageNoteEn.value
        : this.storageNoteEn,
    netCarbMethodNote: netCarbMethodNote.present
        ? netCarbMethodNote.value
        : this.netCarbMethodNote,
    isUserCreated: isUserCreated ?? this.isUserCreated,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  RecipeRow copyWithCompanion(RecipeCompanion data) {
    return RecipeRow(
      id: data.id.present ? data.id.value : this.id,
      titleTr: data.titleTr.present ? data.titleTr.value : this.titleTr,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      servings: data.servings.present ? data.servings.value : this.servings,
      prepMinutes: data.prepMinutes.present
          ? data.prepMinutes.value
          : this.prepMinutes,
      allergensCsv: data.allergensCsv.present
          ? data.allergensCsv.value
          : this.allergensCsv,
      stepsTr: data.stepsTr.present ? data.stepsTr.value : this.stepsTr,
      stepsEn: data.stepsEn.present ? data.stepsEn.value : this.stepsEn,
      storageNoteTr: data.storageNoteTr.present
          ? data.storageNoteTr.value
          : this.storageNoteTr,
      storageNoteEn: data.storageNoteEn.present
          ? data.storageNoteEn.value
          : this.storageNoteEn,
      netCarbMethodNote: data.netCarbMethodNote.present
          ? data.netCarbMethodNote.value
          : this.netCarbMethodNote,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeRow(')
          ..write('id: $id, ')
          ..write('titleTr: $titleTr, ')
          ..write('titleEn: $titleEn, ')
          ..write('servings: $servings, ')
          ..write('prepMinutes: $prepMinutes, ')
          ..write('allergensCsv: $allergensCsv, ')
          ..write('stepsTr: $stepsTr, ')
          ..write('stepsEn: $stepsEn, ')
          ..write('storageNoteTr: $storageNoteTr, ')
          ..write('storageNoteEn: $storageNoteEn, ')
          ..write('netCarbMethodNote: $netCarbMethodNote, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titleTr,
    titleEn,
    servings,
    prepMinutes,
    allergensCsv,
    stepsTr,
    stepsEn,
    storageNoteTr,
    storageNoteEn,
    netCarbMethodNote,
    isUserCreated,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeRow &&
          other.id == this.id &&
          other.titleTr == this.titleTr &&
          other.titleEn == this.titleEn &&
          other.servings == this.servings &&
          other.prepMinutes == this.prepMinutes &&
          other.allergensCsv == this.allergensCsv &&
          other.stepsTr == this.stepsTr &&
          other.stepsEn == this.stepsEn &&
          other.storageNoteTr == this.storageNoteTr &&
          other.storageNoteEn == this.storageNoteEn &&
          other.netCarbMethodNote == this.netCarbMethodNote &&
          other.isUserCreated == this.isUserCreated &&
          other.createdAtUtc == this.createdAtUtc);
}

class RecipeCompanion extends UpdateCompanion<RecipeRow> {
  final Value<String> id;
  final Value<String?> titleTr;
  final Value<String?> titleEn;
  final Value<int> servings;
  final Value<int?> prepMinutes;
  final Value<String?> allergensCsv;
  final Value<String?> stepsTr;
  final Value<String?> stepsEn;
  final Value<String?> storageNoteTr;
  final Value<String?> storageNoteEn;
  final Value<String?> netCarbMethodNote;
  final Value<bool> isUserCreated;
  final Value<DateTime> createdAtUtc;
  final Value<int> rowid;
  const RecipeCompanion({
    this.id = const Value.absent(),
    this.titleTr = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.servings = const Value.absent(),
    this.prepMinutes = const Value.absent(),
    this.allergensCsv = const Value.absent(),
    this.stepsTr = const Value.absent(),
    this.stepsEn = const Value.absent(),
    this.storageNoteTr = const Value.absent(),
    this.storageNoteEn = const Value.absent(),
    this.netCarbMethodNote = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeCompanion.insert({
    required String id,
    this.titleTr = const Value.absent(),
    this.titleEn = const Value.absent(),
    required int servings,
    this.prepMinutes = const Value.absent(),
    this.allergensCsv = const Value.absent(),
    this.stepsTr = const Value.absent(),
    this.stepsEn = const Value.absent(),
    this.storageNoteTr = const Value.absent(),
    this.storageNoteEn = const Value.absent(),
    this.netCarbMethodNote = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    required DateTime createdAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       servings = Value(servings),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<RecipeRow> custom({
    Expression<String>? id,
    Expression<String>? titleTr,
    Expression<String>? titleEn,
    Expression<int>? servings,
    Expression<int>? prepMinutes,
    Expression<String>? allergensCsv,
    Expression<String>? stepsTr,
    Expression<String>? stepsEn,
    Expression<String>? storageNoteTr,
    Expression<String>? storageNoteEn,
    Expression<String>? netCarbMethodNote,
    Expression<bool>? isUserCreated,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleTr != null) 'title_tr': titleTr,
      if (titleEn != null) 'title_en': titleEn,
      if (servings != null) 'servings': servings,
      if (prepMinutes != null) 'prep_minutes': prepMinutes,
      if (allergensCsv != null) 'allergens_csv': allergensCsv,
      if (stepsTr != null) 'steps_tr': stepsTr,
      if (stepsEn != null) 'steps_en': stepsEn,
      if (storageNoteTr != null) 'storage_note_tr': storageNoteTr,
      if (storageNoteEn != null) 'storage_note_en': storageNoteEn,
      if (netCarbMethodNote != null) 'net_carb_method_note': netCarbMethodNote,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeCompanion copyWith({
    Value<String>? id,
    Value<String?>? titleTr,
    Value<String?>? titleEn,
    Value<int>? servings,
    Value<int?>? prepMinutes,
    Value<String?>? allergensCsv,
    Value<String?>? stepsTr,
    Value<String?>? stepsEn,
    Value<String?>? storageNoteTr,
    Value<String?>? storageNoteEn,
    Value<String?>? netCarbMethodNote,
    Value<bool>? isUserCreated,
    Value<DateTime>? createdAtUtc,
    Value<int>? rowid,
  }) {
    return RecipeCompanion(
      id: id ?? this.id,
      titleTr: titleTr ?? this.titleTr,
      titleEn: titleEn ?? this.titleEn,
      servings: servings ?? this.servings,
      prepMinutes: prepMinutes ?? this.prepMinutes,
      allergensCsv: allergensCsv ?? this.allergensCsv,
      stepsTr: stepsTr ?? this.stepsTr,
      stepsEn: stepsEn ?? this.stepsEn,
      storageNoteTr: storageNoteTr ?? this.storageNoteTr,
      storageNoteEn: storageNoteEn ?? this.storageNoteEn,
      netCarbMethodNote: netCarbMethodNote ?? this.netCarbMethodNote,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titleTr.present) {
      map['title_tr'] = Variable<String>(titleTr.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (prepMinutes.present) {
      map['prep_minutes'] = Variable<int>(prepMinutes.value);
    }
    if (allergensCsv.present) {
      map['allergens_csv'] = Variable<String>(allergensCsv.value);
    }
    if (stepsTr.present) {
      map['steps_tr'] = Variable<String>(stepsTr.value);
    }
    if (stepsEn.present) {
      map['steps_en'] = Variable<String>(stepsEn.value);
    }
    if (storageNoteTr.present) {
      map['storage_note_tr'] = Variable<String>(storageNoteTr.value);
    }
    if (storageNoteEn.present) {
      map['storage_note_en'] = Variable<String>(storageNoteEn.value);
    }
    if (netCarbMethodNote.present) {
      map['net_carb_method_note'] = Variable<String>(netCarbMethodNote.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeCompanion(')
          ..write('id: $id, ')
          ..write('titleTr: $titleTr, ')
          ..write('titleEn: $titleEn, ')
          ..write('servings: $servings, ')
          ..write('prepMinutes: $prepMinutes, ')
          ..write('allergensCsv: $allergensCsv, ')
          ..write('stepsTr: $stepsTr, ')
          ..write('stepsEn: $stepsEn, ')
          ..write('storageNoteTr: $storageNoteTr, ')
          ..write('storageNoteEn: $storageNoteEn, ')
          ..write('netCarbMethodNote: $netCarbMethodNote, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientTable extends RecipeIngredient
    with TableInfo<$RecipeIngredientTable, RecipeIngredientRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipe (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recipeId, foodId, grams];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredient';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredientRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeIngredientRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredientRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
    );
  }

  @override
  $RecipeIngredientTable createAlias(String alias) {
    return $RecipeIngredientTable(attachedDatabase, alias);
  }
}

class RecipeIngredientRow extends DataClass
    implements Insertable<RecipeIngredientRow> {
  final int id;
  final String recipeId;
  final String foodId;
  final double grams;
  const RecipeIngredientRow({
    required this.id,
    required this.recipeId,
    required this.foodId,
    required this.grams,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['food_id'] = Variable<String>(foodId);
    map['grams'] = Variable<double>(grams);
    return map;
  }

  RecipeIngredientCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      foodId: Value(foodId),
      grams: Value(grams),
    );
  }

  factory RecipeIngredientRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredientRow(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      grams: serializer.fromJson<double>(json['grams']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'foodId': serializer.toJson<String>(foodId),
      'grams': serializer.toJson<double>(grams),
    };
  }

  RecipeIngredientRow copyWith({
    int? id,
    String? recipeId,
    String? foodId,
    double? grams,
  }) => RecipeIngredientRow(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    foodId: foodId ?? this.foodId,
    grams: grams ?? this.grams,
  );
  RecipeIngredientRow copyWithCompanion(RecipeIngredientCompanion data) {
    return RecipeIngredientRow(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      grams: data.grams.present ? data.grams.value : this.grams,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientRow(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('foodId: $foodId, ')
          ..write('grams: $grams')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeId, foodId, grams);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredientRow &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.foodId == this.foodId &&
          other.grams == this.grams);
}

class RecipeIngredientCompanion extends UpdateCompanion<RecipeIngredientRow> {
  final Value<int> id;
  final Value<String> recipeId;
  final Value<String> foodId;
  final Value<double> grams;
  const RecipeIngredientCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.grams = const Value.absent(),
  });
  RecipeIngredientCompanion.insert({
    this.id = const Value.absent(),
    required String recipeId,
    required String foodId,
    required double grams,
  }) : recipeId = Value(recipeId),
       foodId = Value(foodId),
       grams = Value(grams);
  static Insertable<RecipeIngredientRow> custom({
    Expression<int>? id,
    Expression<String>? recipeId,
    Expression<String>? foodId,
    Expression<double>? grams,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (foodId != null) 'food_id': foodId,
      if (grams != null) 'grams': grams,
    });
  }

  RecipeIngredientCompanion copyWith({
    Value<int>? id,
    Value<String>? recipeId,
    Value<String>? foodId,
    Value<double>? grams,
  }) {
    return RecipeIngredientCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      foodId: foodId ?? this.foodId,
      grams: grams ?? this.grams,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('foodId: $foodId, ')
          ..write('grams: $grams')
          ..write(')'))
        .toString();
  }
}

class $MealTable extends Meal with TableInfo<$MealTable, MealRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customNameMeta = const VerificationMeta(
    'customName',
  );
  @override
  late final GeneratedColumn<String> customName = GeneratedColumn<String>(
    'custom_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eatenAtUtcMeta = const VerificationMeta(
    'eatenAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> eatenAtUtc = GeneratedColumn<DateTime>(
    'eaten_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localOffsetMinutesMeta =
      const VerificationMeta('localOffsetMinutes');
  @override
  late final GeneratedColumn<int> localOffsetMinutes = GeneratedColumn<int>(
    'local_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealType,
    customName,
    eatenAtUtc,
    localOffsetMinutes,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('custom_name')) {
      context.handle(
        _customNameMeta,
        customName.isAcceptableOrUnknown(data['custom_name']!, _customNameMeta),
      );
    }
    if (data.containsKey('eaten_at_utc')) {
      context.handle(
        _eatenAtUtcMeta,
        eatenAtUtc.isAcceptableOrUnknown(
          data['eaten_at_utc']!,
          _eatenAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eatenAtUtcMeta);
    }
    if (data.containsKey('local_offset_minutes')) {
      context.handle(
        _localOffsetMinutesMeta,
        localOffsetMinutes.isAcceptableOrUnknown(
          data['local_offset_minutes']!,
          _localOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localOffsetMinutesMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      customName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_name'],
      ),
      eatenAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}eaten_at_utc'],
      )!,
      localOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_offset_minutes'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $MealTable createAlias(String alias) {
    return $MealTable(attachedDatabase, alias);
  }
}

class MealRow extends DataClass implements Insertable<MealRow> {
  final int id;
  final String mealType;
  final String? customName;
  final DateTime eatenAtUtc;
  final int localOffsetMinutes;
  final String? note;
  const MealRow({
    required this.id,
    required this.mealType,
    this.customName,
    required this.eatenAtUtc,
    required this.localOffsetMinutes,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_type'] = Variable<String>(mealType);
    if (!nullToAbsent || customName != null) {
      map['custom_name'] = Variable<String>(customName);
    }
    map['eaten_at_utc'] = Variable<DateTime>(eatenAtUtc);
    map['local_offset_minutes'] = Variable<int>(localOffsetMinutes);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MealCompanion toCompanion(bool nullToAbsent) {
    return MealCompanion(
      id: Value(id),
      mealType: Value(mealType),
      customName: customName == null && nullToAbsent
          ? const Value.absent()
          : Value(customName),
      eatenAtUtc: Value(eatenAtUtc),
      localOffsetMinutes: Value(localOffsetMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory MealRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealRow(
      id: serializer.fromJson<int>(json['id']),
      mealType: serializer.fromJson<String>(json['mealType']),
      customName: serializer.fromJson<String?>(json['customName']),
      eatenAtUtc: serializer.fromJson<DateTime>(json['eatenAtUtc']),
      localOffsetMinutes: serializer.fromJson<int>(json['localOffsetMinutes']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealType': serializer.toJson<String>(mealType),
      'customName': serializer.toJson<String?>(customName),
      'eatenAtUtc': serializer.toJson<DateTime>(eatenAtUtc),
      'localOffsetMinutes': serializer.toJson<int>(localOffsetMinutes),
      'note': serializer.toJson<String?>(note),
    };
  }

  MealRow copyWith({
    int? id,
    String? mealType,
    Value<String?> customName = const Value.absent(),
    DateTime? eatenAtUtc,
    int? localOffsetMinutes,
    Value<String?> note = const Value.absent(),
  }) => MealRow(
    id: id ?? this.id,
    mealType: mealType ?? this.mealType,
    customName: customName.present ? customName.value : this.customName,
    eatenAtUtc: eatenAtUtc ?? this.eatenAtUtc,
    localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
    note: note.present ? note.value : this.note,
  );
  MealRow copyWithCompanion(MealCompanion data) {
    return MealRow(
      id: data.id.present ? data.id.value : this.id,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      customName: data.customName.present
          ? data.customName.value
          : this.customName,
      eatenAtUtc: data.eatenAtUtc.present
          ? data.eatenAtUtc.value
          : this.eatenAtUtc,
      localOffsetMinutes: data.localOffsetMinutes.present
          ? data.localOffsetMinutes.value
          : this.localOffsetMinutes,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealRow(')
          ..write('id: $id, ')
          ..write('mealType: $mealType, ')
          ..write('customName: $customName, ')
          ..write('eatenAtUtc: $eatenAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealType,
    customName,
    eatenAtUtc,
    localOffsetMinutes,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealRow &&
          other.id == this.id &&
          other.mealType == this.mealType &&
          other.customName == this.customName &&
          other.eatenAtUtc == this.eatenAtUtc &&
          other.localOffsetMinutes == this.localOffsetMinutes &&
          other.note == this.note);
}

class MealCompanion extends UpdateCompanion<MealRow> {
  final Value<int> id;
  final Value<String> mealType;
  final Value<String?> customName;
  final Value<DateTime> eatenAtUtc;
  final Value<int> localOffsetMinutes;
  final Value<String?> note;
  const MealCompanion({
    this.id = const Value.absent(),
    this.mealType = const Value.absent(),
    this.customName = const Value.absent(),
    this.eatenAtUtc = const Value.absent(),
    this.localOffsetMinutes = const Value.absent(),
    this.note = const Value.absent(),
  });
  MealCompanion.insert({
    this.id = const Value.absent(),
    required String mealType,
    this.customName = const Value.absent(),
    required DateTime eatenAtUtc,
    required int localOffsetMinutes,
    this.note = const Value.absent(),
  }) : mealType = Value(mealType),
       eatenAtUtc = Value(eatenAtUtc),
       localOffsetMinutes = Value(localOffsetMinutes);
  static Insertable<MealRow> custom({
    Expression<int>? id,
    Expression<String>? mealType,
    Expression<String>? customName,
    Expression<DateTime>? eatenAtUtc,
    Expression<int>? localOffsetMinutes,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealType != null) 'meal_type': mealType,
      if (customName != null) 'custom_name': customName,
      if (eatenAtUtc != null) 'eaten_at_utc': eatenAtUtc,
      if (localOffsetMinutes != null)
        'local_offset_minutes': localOffsetMinutes,
      if (note != null) 'note': note,
    });
  }

  MealCompanion copyWith({
    Value<int>? id,
    Value<String>? mealType,
    Value<String?>? customName,
    Value<DateTime>? eatenAtUtc,
    Value<int>? localOffsetMinutes,
    Value<String?>? note,
  }) {
    return MealCompanion(
      id: id ?? this.id,
      mealType: mealType ?? this.mealType,
      customName: customName ?? this.customName,
      eatenAtUtc: eatenAtUtc ?? this.eatenAtUtc,
      localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (customName.present) {
      map['custom_name'] = Variable<String>(customName.value);
    }
    if (eatenAtUtc.present) {
      map['eaten_at_utc'] = Variable<DateTime>(eatenAtUtc.value);
    }
    if (localOffsetMinutes.present) {
      map['local_offset_minutes'] = Variable<int>(localOffsetMinutes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealCompanion(')
          ..write('id: $id, ')
          ..write('mealType: $mealType, ')
          ..write('customName: $customName, ')
          ..write('eatenAtUtc: $eatenAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $MealItemTable extends MealItem
    with TableInfo<$MealItemTable, MealItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<int> mealId = GeneratedColumn<int>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipe (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingsCountMeta = const VerificationMeta(
    'servingsCount',
  );
  @override
  late final GeneratedColumn<double> servingsCount = GeneratedColumn<double>(
    'servings_count',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userNetCarbOverrideGMeta =
      const VerificationMeta('userNetCarbOverrideG');
  @override
  late final GeneratedColumn<double> userNetCarbOverrideG =
      GeneratedColumn<double>(
        'user_net_carb_override_g',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealId,
    foodId,
    recipeId,
    grams,
    servingsCount,
    userNetCarbOverrideG,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    if (data.containsKey('servings_count')) {
      context.handle(
        _servingsCountMeta,
        servingsCount.isAcceptableOrUnknown(
          data['servings_count']!,
          _servingsCountMeta,
        ),
      );
    }
    if (data.containsKey('user_net_carb_override_g')) {
      context.handle(
        _userNetCarbOverrideGMeta,
        userNetCarbOverrideG.isAcceptableOrUnknown(
          data['user_net_carb_override_g']!,
          _userNetCarbOverrideGMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      ),
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
      servingsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}servings_count'],
      ),
      userNetCarbOverrideG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}user_net_carb_override_g'],
      ),
    );
  }

  @override
  $MealItemTable createAlias(String alias) {
    return $MealItemTable(attachedDatabase, alias);
  }
}

class MealItemRow extends DataClass implements Insertable<MealItemRow> {
  final int id;
  final int mealId;
  final String foodId;
  final String? recipeId;
  final double grams;
  final double? servingsCount;
  final double? userNetCarbOverrideG;
  const MealItemRow({
    required this.id,
    required this.mealId,
    required this.foodId,
    this.recipeId,
    required this.grams,
    this.servingsCount,
    this.userNetCarbOverrideG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_id'] = Variable<int>(mealId);
    map['food_id'] = Variable<String>(foodId);
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<String>(recipeId);
    }
    map['grams'] = Variable<double>(grams);
    if (!nullToAbsent || servingsCount != null) {
      map['servings_count'] = Variable<double>(servingsCount);
    }
    if (!nullToAbsent || userNetCarbOverrideG != null) {
      map['user_net_carb_override_g'] = Variable<double>(userNetCarbOverrideG);
    }
    return map;
  }

  MealItemCompanion toCompanion(bool nullToAbsent) {
    return MealItemCompanion(
      id: Value(id),
      mealId: Value(mealId),
      foodId: Value(foodId),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      grams: Value(grams),
      servingsCount: servingsCount == null && nullToAbsent
          ? const Value.absent()
          : Value(servingsCount),
      userNetCarbOverrideG: userNetCarbOverrideG == null && nullToAbsent
          ? const Value.absent()
          : Value(userNetCarbOverrideG),
    );
  }

  factory MealItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealItemRow(
      id: serializer.fromJson<int>(json['id']),
      mealId: serializer.fromJson<int>(json['mealId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      recipeId: serializer.fromJson<String?>(json['recipeId']),
      grams: serializer.fromJson<double>(json['grams']),
      servingsCount: serializer.fromJson<double?>(json['servingsCount']),
      userNetCarbOverrideG: serializer.fromJson<double?>(
        json['userNetCarbOverrideG'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealId': serializer.toJson<int>(mealId),
      'foodId': serializer.toJson<String>(foodId),
      'recipeId': serializer.toJson<String?>(recipeId),
      'grams': serializer.toJson<double>(grams),
      'servingsCount': serializer.toJson<double?>(servingsCount),
      'userNetCarbOverrideG': serializer.toJson<double?>(userNetCarbOverrideG),
    };
  }

  MealItemRow copyWith({
    int? id,
    int? mealId,
    String? foodId,
    Value<String?> recipeId = const Value.absent(),
    double? grams,
    Value<double?> servingsCount = const Value.absent(),
    Value<double?> userNetCarbOverrideG = const Value.absent(),
  }) => MealItemRow(
    id: id ?? this.id,
    mealId: mealId ?? this.mealId,
    foodId: foodId ?? this.foodId,
    recipeId: recipeId.present ? recipeId.value : this.recipeId,
    grams: grams ?? this.grams,
    servingsCount: servingsCount.present
        ? servingsCount.value
        : this.servingsCount,
    userNetCarbOverrideG: userNetCarbOverrideG.present
        ? userNetCarbOverrideG.value
        : this.userNetCarbOverrideG,
  );
  MealItemRow copyWithCompanion(MealItemCompanion data) {
    return MealItemRow(
      id: data.id.present ? data.id.value : this.id,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      grams: data.grams.present ? data.grams.value : this.grams,
      servingsCount: data.servingsCount.present
          ? data.servingsCount.value
          : this.servingsCount,
      userNetCarbOverrideG: data.userNetCarbOverrideG.present
          ? data.userNetCarbOverrideG.value
          : this.userNetCarbOverrideG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealItemRow(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('foodId: $foodId, ')
          ..write('recipeId: $recipeId, ')
          ..write('grams: $grams, ')
          ..write('servingsCount: $servingsCount, ')
          ..write('userNetCarbOverrideG: $userNetCarbOverrideG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealId,
    foodId,
    recipeId,
    grams,
    servingsCount,
    userNetCarbOverrideG,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealItemRow &&
          other.id == this.id &&
          other.mealId == this.mealId &&
          other.foodId == this.foodId &&
          other.recipeId == this.recipeId &&
          other.grams == this.grams &&
          other.servingsCount == this.servingsCount &&
          other.userNetCarbOverrideG == this.userNetCarbOverrideG);
}

class MealItemCompanion extends UpdateCompanion<MealItemRow> {
  final Value<int> id;
  final Value<int> mealId;
  final Value<String> foodId;
  final Value<String?> recipeId;
  final Value<double> grams;
  final Value<double?> servingsCount;
  final Value<double?> userNetCarbOverrideG;
  const MealItemCompanion({
    this.id = const Value.absent(),
    this.mealId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.grams = const Value.absent(),
    this.servingsCount = const Value.absent(),
    this.userNetCarbOverrideG = const Value.absent(),
  });
  MealItemCompanion.insert({
    this.id = const Value.absent(),
    required int mealId,
    required String foodId,
    this.recipeId = const Value.absent(),
    required double grams,
    this.servingsCount = const Value.absent(),
    this.userNetCarbOverrideG = const Value.absent(),
  }) : mealId = Value(mealId),
       foodId = Value(foodId),
       grams = Value(grams);
  static Insertable<MealItemRow> custom({
    Expression<int>? id,
    Expression<int>? mealId,
    Expression<String>? foodId,
    Expression<String>? recipeId,
    Expression<double>? grams,
    Expression<double>? servingsCount,
    Expression<double>? userNetCarbOverrideG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealId != null) 'meal_id': mealId,
      if (foodId != null) 'food_id': foodId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (grams != null) 'grams': grams,
      if (servingsCount != null) 'servings_count': servingsCount,
      if (userNetCarbOverrideG != null)
        'user_net_carb_override_g': userNetCarbOverrideG,
    });
  }

  MealItemCompanion copyWith({
    Value<int>? id,
    Value<int>? mealId,
    Value<String>? foodId,
    Value<String?>? recipeId,
    Value<double>? grams,
    Value<double?>? servingsCount,
    Value<double?>? userNetCarbOverrideG,
  }) {
    return MealItemCompanion(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      foodId: foodId ?? this.foodId,
      recipeId: recipeId ?? this.recipeId,
      grams: grams ?? this.grams,
      servingsCount: servingsCount ?? this.servingsCount,
      userNetCarbOverrideG: userNetCarbOverrideG ?? this.userNetCarbOverrideG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<int>(mealId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    if (servingsCount.present) {
      map['servings_count'] = Variable<double>(servingsCount.value);
    }
    if (userNetCarbOverrideG.present) {
      map['user_net_carb_override_g'] = Variable<double>(
        userNetCarbOverrideG.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealItemCompanion(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('foodId: $foodId, ')
          ..write('recipeId: $recipeId, ')
          ..write('grams: $grams, ')
          ..write('servingsCount: $servingsCount, ')
          ..write('userNetCarbOverrideG: $userNetCarbOverrideG')
          ..write(')'))
        .toString();
  }
}

class $GlucoseMeasurementTable extends GlucoseMeasurement
    with TableInfo<$GlucoseMeasurementTable, GlucoseMeasurementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlucoseMeasurementTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<double> rawValue = GeneratedColumn<double>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawUnitMeta = const VerificationMeta(
    'rawUnit',
  );
  @override
  late final GeneratedColumn<String> rawUnit = GeneratedColumn<String>(
    'raw_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mmolLMeta = const VerificationMeta('mmolL');
  @override
  late final GeneratedColumn<double> mmolL = GeneratedColumn<double>(
    'mmol_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measuredAtUtcMeta = const VerificationMeta(
    'measuredAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAtUtc =
      GeneratedColumn<DateTime>(
        'measured_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _localOffsetMinutesMeta =
      const VerificationMeta('localOffsetMinutes');
  @override
  late final GeneratedColumn<int> localOffsetMinutes = GeneratedColumn<int>(
    'local_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextTagIdsJsonMeta = const VerificationMeta(
    'contextTagIdsJson',
  );
  @override
  late final GeneratedColumn<String> contextTagIdsJson =
      GeneratedColumn<String>(
        'context_tag_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    rawUnit,
    mmolL,
    measuredAtUtc,
    localOffsetMinutes,
    sourceType,
    contextTagIdsJson,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'glucose_measurement';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlucoseMeasurementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('raw_unit')) {
      context.handle(
        _rawUnitMeta,
        rawUnit.isAcceptableOrUnknown(data['raw_unit']!, _rawUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_rawUnitMeta);
    }
    if (data.containsKey('mmol_l')) {
      context.handle(
        _mmolLMeta,
        mmolL.isAcceptableOrUnknown(data['mmol_l']!, _mmolLMeta),
      );
    } else if (isInserting) {
      context.missing(_mmolLMeta);
    }
    if (data.containsKey('measured_at_utc')) {
      context.handle(
        _measuredAtUtcMeta,
        measuredAtUtc.isAcceptableOrUnknown(
          data['measured_at_utc']!,
          _measuredAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measuredAtUtcMeta);
    }
    if (data.containsKey('local_offset_minutes')) {
      context.handle(
        _localOffsetMinutesMeta,
        localOffsetMinutes.isAcceptableOrUnknown(
          data['local_offset_minutes']!,
          _localOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localOffsetMinutesMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('context_tag_ids_json')) {
      context.handle(
        _contextTagIdsJsonMeta,
        contextTagIdsJson.isAcceptableOrUnknown(
          data['context_tag_ids_json']!,
          _contextTagIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlucoseMeasurementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlucoseMeasurementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_value'],
      )!,
      rawUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_unit'],
      )!,
      mmolL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mmol_l'],
      )!,
      measuredAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at_utc'],
      )!,
      localOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_offset_minutes'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      contextTagIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_tag_ids_json'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $GlucoseMeasurementTable createAlias(String alias) {
    return $GlucoseMeasurementTable(attachedDatabase, alias);
  }
}

class GlucoseMeasurementRow extends DataClass
    implements Insertable<GlucoseMeasurementRow> {
  final int id;
  final double rawValue;
  final String rawUnit;
  final double mmolL;
  final DateTime measuredAtUtc;
  final int localOffsetMinutes;
  final String sourceType;
  final String contextTagIdsJson;
  final String? note;
  const GlucoseMeasurementRow({
    required this.id,
    required this.rawValue,
    required this.rawUnit,
    required this.mmolL,
    required this.measuredAtUtc,
    required this.localOffsetMinutes,
    required this.sourceType,
    required this.contextTagIdsJson,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_value'] = Variable<double>(rawValue);
    map['raw_unit'] = Variable<String>(rawUnit);
    map['mmol_l'] = Variable<double>(mmolL);
    map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc);
    map['local_offset_minutes'] = Variable<int>(localOffsetMinutes);
    map['source_type'] = Variable<String>(sourceType);
    map['context_tag_ids_json'] = Variable<String>(contextTagIdsJson);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  GlucoseMeasurementCompanion toCompanion(bool nullToAbsent) {
    return GlucoseMeasurementCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      rawUnit: Value(rawUnit),
      mmolL: Value(mmolL),
      measuredAtUtc: Value(measuredAtUtc),
      localOffsetMinutes: Value(localOffsetMinutes),
      sourceType: Value(sourceType),
      contextTagIdsJson: Value(contextTagIdsJson),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory GlucoseMeasurementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlucoseMeasurementRow(
      id: serializer.fromJson<int>(json['id']),
      rawValue: serializer.fromJson<double>(json['rawValue']),
      rawUnit: serializer.fromJson<String>(json['rawUnit']),
      mmolL: serializer.fromJson<double>(json['mmolL']),
      measuredAtUtc: serializer.fromJson<DateTime>(json['measuredAtUtc']),
      localOffsetMinutes: serializer.fromJson<int>(json['localOffsetMinutes']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      contextTagIdsJson: serializer.fromJson<String>(json['contextTagIdsJson']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawValue': serializer.toJson<double>(rawValue),
      'rawUnit': serializer.toJson<String>(rawUnit),
      'mmolL': serializer.toJson<double>(mmolL),
      'measuredAtUtc': serializer.toJson<DateTime>(measuredAtUtc),
      'localOffsetMinutes': serializer.toJson<int>(localOffsetMinutes),
      'sourceType': serializer.toJson<String>(sourceType),
      'contextTagIdsJson': serializer.toJson<String>(contextTagIdsJson),
      'note': serializer.toJson<String?>(note),
    };
  }

  GlucoseMeasurementRow copyWith({
    int? id,
    double? rawValue,
    String? rawUnit,
    double? mmolL,
    DateTime? measuredAtUtc,
    int? localOffsetMinutes,
    String? sourceType,
    String? contextTagIdsJson,
    Value<String?> note = const Value.absent(),
  }) => GlucoseMeasurementRow(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    rawUnit: rawUnit ?? this.rawUnit,
    mmolL: mmolL ?? this.mmolL,
    measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
    localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
    sourceType: sourceType ?? this.sourceType,
    contextTagIdsJson: contextTagIdsJson ?? this.contextTagIdsJson,
    note: note.present ? note.value : this.note,
  );
  GlucoseMeasurementRow copyWithCompanion(GlucoseMeasurementCompanion data) {
    return GlucoseMeasurementRow(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      rawUnit: data.rawUnit.present ? data.rawUnit.value : this.rawUnit,
      mmolL: data.mmolL.present ? data.mmolL.value : this.mmolL,
      measuredAtUtc: data.measuredAtUtc.present
          ? data.measuredAtUtc.value
          : this.measuredAtUtc,
      localOffsetMinutes: data.localOffsetMinutes.present
          ? data.localOffsetMinutes.value
          : this.localOffsetMinutes,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      contextTagIdsJson: data.contextTagIdsJson.present
          ? data.contextTagIdsJson.value
          : this.contextTagIdsJson,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseMeasurementRow(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('mmolL: $mmolL, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextTagIdsJson: $contextTagIdsJson, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    rawUnit,
    mmolL,
    measuredAtUtc,
    localOffsetMinutes,
    sourceType,
    contextTagIdsJson,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlucoseMeasurementRow &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.rawUnit == this.rawUnit &&
          other.mmolL == this.mmolL &&
          other.measuredAtUtc == this.measuredAtUtc &&
          other.localOffsetMinutes == this.localOffsetMinutes &&
          other.sourceType == this.sourceType &&
          other.contextTagIdsJson == this.contextTagIdsJson &&
          other.note == this.note);
}

class GlucoseMeasurementCompanion
    extends UpdateCompanion<GlucoseMeasurementRow> {
  final Value<int> id;
  final Value<double> rawValue;
  final Value<String> rawUnit;
  final Value<double> mmolL;
  final Value<DateTime> measuredAtUtc;
  final Value<int> localOffsetMinutes;
  final Value<String> sourceType;
  final Value<String> contextTagIdsJson;
  final Value<String?> note;
  const GlucoseMeasurementCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.rawUnit = const Value.absent(),
    this.mmolL = const Value.absent(),
    this.measuredAtUtc = const Value.absent(),
    this.localOffsetMinutes = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.contextTagIdsJson = const Value.absent(),
    this.note = const Value.absent(),
  });
  GlucoseMeasurementCompanion.insert({
    this.id = const Value.absent(),
    required double rawValue,
    required String rawUnit,
    required double mmolL,
    required DateTime measuredAtUtc,
    required int localOffsetMinutes,
    required String sourceType,
    this.contextTagIdsJson = const Value.absent(),
    this.note = const Value.absent(),
  }) : rawValue = Value(rawValue),
       rawUnit = Value(rawUnit),
       mmolL = Value(mmolL),
       measuredAtUtc = Value(measuredAtUtc),
       localOffsetMinutes = Value(localOffsetMinutes),
       sourceType = Value(sourceType);
  static Insertable<GlucoseMeasurementRow> custom({
    Expression<int>? id,
    Expression<double>? rawValue,
    Expression<String>? rawUnit,
    Expression<double>? mmolL,
    Expression<DateTime>? measuredAtUtc,
    Expression<int>? localOffsetMinutes,
    Expression<String>? sourceType,
    Expression<String>? contextTagIdsJson,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (rawUnit != null) 'raw_unit': rawUnit,
      if (mmolL != null) 'mmol_l': mmolL,
      if (measuredAtUtc != null) 'measured_at_utc': measuredAtUtc,
      if (localOffsetMinutes != null)
        'local_offset_minutes': localOffsetMinutes,
      if (sourceType != null) 'source_type': sourceType,
      if (contextTagIdsJson != null) 'context_tag_ids_json': contextTagIdsJson,
      if (note != null) 'note': note,
    });
  }

  GlucoseMeasurementCompanion copyWith({
    Value<int>? id,
    Value<double>? rawValue,
    Value<String>? rawUnit,
    Value<double>? mmolL,
    Value<DateTime>? measuredAtUtc,
    Value<int>? localOffsetMinutes,
    Value<String>? sourceType,
    Value<String>? contextTagIdsJson,
    Value<String?>? note,
  }) {
    return GlucoseMeasurementCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      rawUnit: rawUnit ?? this.rawUnit,
      mmolL: mmolL ?? this.mmolL,
      measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
      localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
      sourceType: sourceType ?? this.sourceType,
      contextTagIdsJson: contextTagIdsJson ?? this.contextTagIdsJson,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<double>(rawValue.value);
    }
    if (rawUnit.present) {
      map['raw_unit'] = Variable<String>(rawUnit.value);
    }
    if (mmolL.present) {
      map['mmol_l'] = Variable<double>(mmolL.value);
    }
    if (measuredAtUtc.present) {
      map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc.value);
    }
    if (localOffsetMinutes.present) {
      map['local_offset_minutes'] = Variable<int>(localOffsetMinutes.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (contextTagIdsJson.present) {
      map['context_tag_ids_json'] = Variable<String>(contextTagIdsJson.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseMeasurementCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('mmolL: $mmolL, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextTagIdsJson: $contextTagIdsJson, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $KetoneMeasurementTable extends KetoneMeasurement
    with TableInfo<$KetoneMeasurementTable, KetoneMeasurementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KetoneMeasurementTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<double> rawValue = GeneratedColumn<double>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawUnitMeta = const VerificationMeta(
    'rawUnit',
  );
  @override
  late final GeneratedColumn<String> rawUnit = GeneratedColumn<String>(
    'raw_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mmol_L'),
  );
  static const VerificationMeta _mmolLMeta = const VerificationMeta('mmolL');
  @override
  late final GeneratedColumn<double> mmolL = GeneratedColumn<double>(
    'mmol_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtypeMeta = const VerificationMeta(
    'subtype',
  );
  @override
  late final GeneratedColumn<String> subtype = GeneratedColumn<String>(
    'subtype',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('blood'),
  );
  static const VerificationMeta _measuredAtUtcMeta = const VerificationMeta(
    'measuredAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAtUtc =
      GeneratedColumn<DateTime>(
        'measured_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _localOffsetMinutesMeta =
      const VerificationMeta('localOffsetMinutes');
  @override
  late final GeneratedColumn<int> localOffsetMinutes = GeneratedColumn<int>(
    'local_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contextTagIdsJsonMeta = const VerificationMeta(
    'contextTagIdsJson',
  );
  @override
  late final GeneratedColumn<String> contextTagIdsJson =
      GeneratedColumn<String>(
        'context_tag_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    rawUnit,
    mmolL,
    subtype,
    measuredAtUtc,
    localOffsetMinutes,
    sourceType,
    contextTagIdsJson,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ketone_measurement';
  @override
  VerificationContext validateIntegrity(
    Insertable<KetoneMeasurementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('raw_unit')) {
      context.handle(
        _rawUnitMeta,
        rawUnit.isAcceptableOrUnknown(data['raw_unit']!, _rawUnitMeta),
      );
    }
    if (data.containsKey('mmol_l')) {
      context.handle(
        _mmolLMeta,
        mmolL.isAcceptableOrUnknown(data['mmol_l']!, _mmolLMeta),
      );
    } else if (isInserting) {
      context.missing(_mmolLMeta);
    }
    if (data.containsKey('subtype')) {
      context.handle(
        _subtypeMeta,
        subtype.isAcceptableOrUnknown(data['subtype']!, _subtypeMeta),
      );
    }
    if (data.containsKey('measured_at_utc')) {
      context.handle(
        _measuredAtUtcMeta,
        measuredAtUtc.isAcceptableOrUnknown(
          data['measured_at_utc']!,
          _measuredAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measuredAtUtcMeta);
    }
    if (data.containsKey('local_offset_minutes')) {
      context.handle(
        _localOffsetMinutesMeta,
        localOffsetMinutes.isAcceptableOrUnknown(
          data['local_offset_minutes']!,
          _localOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localOffsetMinutesMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('context_tag_ids_json')) {
      context.handle(
        _contextTagIdsJsonMeta,
        contextTagIdsJson.isAcceptableOrUnknown(
          data['context_tag_ids_json']!,
          _contextTagIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KetoneMeasurementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KetoneMeasurementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_value'],
      )!,
      rawUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_unit'],
      )!,
      mmolL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mmol_l'],
      )!,
      subtype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtype'],
      )!,
      measuredAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at_utc'],
      )!,
      localOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_offset_minutes'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      ),
      contextTagIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_tag_ids_json'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $KetoneMeasurementTable createAlias(String alias) {
    return $KetoneMeasurementTable(attachedDatabase, alias);
  }
}

class KetoneMeasurementRow extends DataClass
    implements Insertable<KetoneMeasurementRow> {
  final int id;
  final double rawValue;
  final String rawUnit;
  final double mmolL;
  final String subtype;
  final DateTime measuredAtUtc;
  final int localOffsetMinutes;
  final String? sourceType;
  final String contextTagIdsJson;
  final String? note;
  const KetoneMeasurementRow({
    required this.id,
    required this.rawValue,
    required this.rawUnit,
    required this.mmolL,
    required this.subtype,
    required this.measuredAtUtc,
    required this.localOffsetMinutes,
    this.sourceType,
    required this.contextTagIdsJson,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_value'] = Variable<double>(rawValue);
    map['raw_unit'] = Variable<String>(rawUnit);
    map['mmol_l'] = Variable<double>(mmolL);
    map['subtype'] = Variable<String>(subtype);
    map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc);
    map['local_offset_minutes'] = Variable<int>(localOffsetMinutes);
    if (!nullToAbsent || sourceType != null) {
      map['source_type'] = Variable<String>(sourceType);
    }
    map['context_tag_ids_json'] = Variable<String>(contextTagIdsJson);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  KetoneMeasurementCompanion toCompanion(bool nullToAbsent) {
    return KetoneMeasurementCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      rawUnit: Value(rawUnit),
      mmolL: Value(mmolL),
      subtype: Value(subtype),
      measuredAtUtc: Value(measuredAtUtc),
      localOffsetMinutes: Value(localOffsetMinutes),
      sourceType: sourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceType),
      contextTagIdsJson: Value(contextTagIdsJson),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory KetoneMeasurementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KetoneMeasurementRow(
      id: serializer.fromJson<int>(json['id']),
      rawValue: serializer.fromJson<double>(json['rawValue']),
      rawUnit: serializer.fromJson<String>(json['rawUnit']),
      mmolL: serializer.fromJson<double>(json['mmolL']),
      subtype: serializer.fromJson<String>(json['subtype']),
      measuredAtUtc: serializer.fromJson<DateTime>(json['measuredAtUtc']),
      localOffsetMinutes: serializer.fromJson<int>(json['localOffsetMinutes']),
      sourceType: serializer.fromJson<String?>(json['sourceType']),
      contextTagIdsJson: serializer.fromJson<String>(json['contextTagIdsJson']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawValue': serializer.toJson<double>(rawValue),
      'rawUnit': serializer.toJson<String>(rawUnit),
      'mmolL': serializer.toJson<double>(mmolL),
      'subtype': serializer.toJson<String>(subtype),
      'measuredAtUtc': serializer.toJson<DateTime>(measuredAtUtc),
      'localOffsetMinutes': serializer.toJson<int>(localOffsetMinutes),
      'sourceType': serializer.toJson<String?>(sourceType),
      'contextTagIdsJson': serializer.toJson<String>(contextTagIdsJson),
      'note': serializer.toJson<String?>(note),
    };
  }

  KetoneMeasurementRow copyWith({
    int? id,
    double? rawValue,
    String? rawUnit,
    double? mmolL,
    String? subtype,
    DateTime? measuredAtUtc,
    int? localOffsetMinutes,
    Value<String?> sourceType = const Value.absent(),
    String? contextTagIdsJson,
    Value<String?> note = const Value.absent(),
  }) => KetoneMeasurementRow(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    rawUnit: rawUnit ?? this.rawUnit,
    mmolL: mmolL ?? this.mmolL,
    subtype: subtype ?? this.subtype,
    measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
    localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
    sourceType: sourceType.present ? sourceType.value : this.sourceType,
    contextTagIdsJson: contextTagIdsJson ?? this.contextTagIdsJson,
    note: note.present ? note.value : this.note,
  );
  KetoneMeasurementRow copyWithCompanion(KetoneMeasurementCompanion data) {
    return KetoneMeasurementRow(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      rawUnit: data.rawUnit.present ? data.rawUnit.value : this.rawUnit,
      mmolL: data.mmolL.present ? data.mmolL.value : this.mmolL,
      subtype: data.subtype.present ? data.subtype.value : this.subtype,
      measuredAtUtc: data.measuredAtUtc.present
          ? data.measuredAtUtc.value
          : this.measuredAtUtc,
      localOffsetMinutes: data.localOffsetMinutes.present
          ? data.localOffsetMinutes.value
          : this.localOffsetMinutes,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      contextTagIdsJson: data.contextTagIdsJson.present
          ? data.contextTagIdsJson.value
          : this.contextTagIdsJson,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KetoneMeasurementRow(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('mmolL: $mmolL, ')
          ..write('subtype: $subtype, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextTagIdsJson: $contextTagIdsJson, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    rawUnit,
    mmolL,
    subtype,
    measuredAtUtc,
    localOffsetMinutes,
    sourceType,
    contextTagIdsJson,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KetoneMeasurementRow &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.rawUnit == this.rawUnit &&
          other.mmolL == this.mmolL &&
          other.subtype == this.subtype &&
          other.measuredAtUtc == this.measuredAtUtc &&
          other.localOffsetMinutes == this.localOffsetMinutes &&
          other.sourceType == this.sourceType &&
          other.contextTagIdsJson == this.contextTagIdsJson &&
          other.note == this.note);
}

class KetoneMeasurementCompanion extends UpdateCompanion<KetoneMeasurementRow> {
  final Value<int> id;
  final Value<double> rawValue;
  final Value<String> rawUnit;
  final Value<double> mmolL;
  final Value<String> subtype;
  final Value<DateTime> measuredAtUtc;
  final Value<int> localOffsetMinutes;
  final Value<String?> sourceType;
  final Value<String> contextTagIdsJson;
  final Value<String?> note;
  const KetoneMeasurementCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.rawUnit = const Value.absent(),
    this.mmolL = const Value.absent(),
    this.subtype = const Value.absent(),
    this.measuredAtUtc = const Value.absent(),
    this.localOffsetMinutes = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.contextTagIdsJson = const Value.absent(),
    this.note = const Value.absent(),
  });
  KetoneMeasurementCompanion.insert({
    this.id = const Value.absent(),
    required double rawValue,
    this.rawUnit = const Value.absent(),
    required double mmolL,
    this.subtype = const Value.absent(),
    required DateTime measuredAtUtc,
    required int localOffsetMinutes,
    this.sourceType = const Value.absent(),
    this.contextTagIdsJson = const Value.absent(),
    this.note = const Value.absent(),
  }) : rawValue = Value(rawValue),
       mmolL = Value(mmolL),
       measuredAtUtc = Value(measuredAtUtc),
       localOffsetMinutes = Value(localOffsetMinutes);
  static Insertable<KetoneMeasurementRow> custom({
    Expression<int>? id,
    Expression<double>? rawValue,
    Expression<String>? rawUnit,
    Expression<double>? mmolL,
    Expression<String>? subtype,
    Expression<DateTime>? measuredAtUtc,
    Expression<int>? localOffsetMinutes,
    Expression<String>? sourceType,
    Expression<String>? contextTagIdsJson,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (rawUnit != null) 'raw_unit': rawUnit,
      if (mmolL != null) 'mmol_l': mmolL,
      if (subtype != null) 'subtype': subtype,
      if (measuredAtUtc != null) 'measured_at_utc': measuredAtUtc,
      if (localOffsetMinutes != null)
        'local_offset_minutes': localOffsetMinutes,
      if (sourceType != null) 'source_type': sourceType,
      if (contextTagIdsJson != null) 'context_tag_ids_json': contextTagIdsJson,
      if (note != null) 'note': note,
    });
  }

  KetoneMeasurementCompanion copyWith({
    Value<int>? id,
    Value<double>? rawValue,
    Value<String>? rawUnit,
    Value<double>? mmolL,
    Value<String>? subtype,
    Value<DateTime>? measuredAtUtc,
    Value<int>? localOffsetMinutes,
    Value<String?>? sourceType,
    Value<String>? contextTagIdsJson,
    Value<String?>? note,
  }) {
    return KetoneMeasurementCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      rawUnit: rawUnit ?? this.rawUnit,
      mmolL: mmolL ?? this.mmolL,
      subtype: subtype ?? this.subtype,
      measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
      localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
      sourceType: sourceType ?? this.sourceType,
      contextTagIdsJson: contextTagIdsJson ?? this.contextTagIdsJson,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<double>(rawValue.value);
    }
    if (rawUnit.present) {
      map['raw_unit'] = Variable<String>(rawUnit.value);
    }
    if (mmolL.present) {
      map['mmol_l'] = Variable<double>(mmolL.value);
    }
    if (subtype.present) {
      map['subtype'] = Variable<String>(subtype.value);
    }
    if (measuredAtUtc.present) {
      map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc.value);
    }
    if (localOffsetMinutes.present) {
      map['local_offset_minutes'] = Variable<int>(localOffsetMinutes.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (contextTagIdsJson.present) {
      map['context_tag_ids_json'] = Variable<String>(contextTagIdsJson.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KetoneMeasurementCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('mmolL: $mmolL, ')
          ..write('subtype: $subtype, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('sourceType: $sourceType, ')
          ..write('contextTagIdsJson: $contextTagIdsJson, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $MeasurementSessionTable extends MeasurementSession
    with TableInfo<$MeasurementSessionTable, MeasurementSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementSessionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _glucoseIdMeta = const VerificationMeta(
    'glucoseId',
  );
  @override
  late final GeneratedColumn<int> glucoseId = GeneratedColumn<int>(
    'glucose_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES glucose_measurement (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _ketoneIdMeta = const VerificationMeta(
    'ketoneId',
  );
  @override
  late final GeneratedColumn<int> ketoneId = GeneratedColumn<int>(
    'ketone_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ketone_measurement (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _gkiValueMeta = const VerificationMeta(
    'gkiValue',
  );
  @override
  late final GeneratedColumn<double> gkiValue = GeneratedColumn<double>(
    'gki_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formulaVersionMeta = const VerificationMeta(
    'formulaVersion',
  );
  @override
  late final GeneratedColumn<String> formulaVersion = GeneratedColumn<String>(
    'formula_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchDifferenceMinutesMeta =
      const VerificationMeta('matchDifferenceMinutes');
  @override
  late final GeneratedColumn<int> matchDifferenceMinutes = GeneratedColumn<int>(
    'match_difference_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchKindMeta = const VerificationMeta(
    'matchKind',
  );
  @override
  late final GeneratedColumn<String> matchKind = GeneratedColumn<String>(
    'match_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedByUserMeta = const VerificationMeta(
    'confirmedByUser',
  );
  @override
  late final GeneratedColumn<bool> confirmedByUser = GeneratedColumn<bool>(
    'confirmed_by_user',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("confirmed_by_user" IN (0, 1))',
    ),
  );
  static const VerificationMeta _computedAtUtcMeta = const VerificationMeta(
    'computedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> computedAtUtc =
      GeneratedColumn<DateTime>(
        'computed_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isValidMeta = const VerificationMeta(
    'isValid',
  );
  @override
  late final GeneratedColumn<bool> isValid = GeneratedColumn<bool>(
    'is_valid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_valid" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    glucoseId,
    ketoneId,
    gkiValue,
    formulaVersion,
    matchDifferenceMinutes,
    matchKind,
    confirmedByUser,
    computedAtUtc,
    isValid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurement_session';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeasurementSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('glucose_id')) {
      context.handle(
        _glucoseIdMeta,
        glucoseId.isAcceptableOrUnknown(data['glucose_id']!, _glucoseIdMeta),
      );
    }
    if (data.containsKey('ketone_id')) {
      context.handle(
        _ketoneIdMeta,
        ketoneId.isAcceptableOrUnknown(data['ketone_id']!, _ketoneIdMeta),
      );
    }
    if (data.containsKey('gki_value')) {
      context.handle(
        _gkiValueMeta,
        gkiValue.isAcceptableOrUnknown(data['gki_value']!, _gkiValueMeta),
      );
    } else if (isInserting) {
      context.missing(_gkiValueMeta);
    }
    if (data.containsKey('formula_version')) {
      context.handle(
        _formulaVersionMeta,
        formulaVersion.isAcceptableOrUnknown(
          data['formula_version']!,
          _formulaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formulaVersionMeta);
    }
    if (data.containsKey('match_difference_minutes')) {
      context.handle(
        _matchDifferenceMinutesMeta,
        matchDifferenceMinutes.isAcceptableOrUnknown(
          data['match_difference_minutes']!,
          _matchDifferenceMinutesMeta,
        ),
      );
    }
    if (data.containsKey('match_kind')) {
      context.handle(
        _matchKindMeta,
        matchKind.isAcceptableOrUnknown(data['match_kind']!, _matchKindMeta),
      );
    } else if (isInserting) {
      context.missing(_matchKindMeta);
    }
    if (data.containsKey('confirmed_by_user')) {
      context.handle(
        _confirmedByUserMeta,
        confirmedByUser.isAcceptableOrUnknown(
          data['confirmed_by_user']!,
          _confirmedByUserMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confirmedByUserMeta);
    }
    if (data.containsKey('computed_at_utc')) {
      context.handle(
        _computedAtUtcMeta,
        computedAtUtc.isAcceptableOrUnknown(
          data['computed_at_utc']!,
          _computedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_computedAtUtcMeta);
    }
    if (data.containsKey('is_valid')) {
      context.handle(
        _isValidMeta,
        isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeasurementSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasurementSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      glucoseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}glucose_id'],
      ),
      ketoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ketone_id'],
      ),
      gkiValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gki_value'],
      )!,
      formulaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula_version'],
      )!,
      matchDifferenceMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_difference_minutes'],
      ),
      matchKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_kind'],
      )!,
      confirmedByUser: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}confirmed_by_user'],
      )!,
      computedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}computed_at_utc'],
      )!,
      isValid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_valid'],
      )!,
    );
  }

  @override
  $MeasurementSessionTable createAlias(String alias) {
    return $MeasurementSessionTable(attachedDatabase, alias);
  }
}

class MeasurementSessionRow extends DataClass
    implements Insertable<MeasurementSessionRow> {
  final int id;
  final int? glucoseId;
  final int? ketoneId;
  final double gkiValue;
  final String formulaVersion;
  final int? matchDifferenceMinutes;
  final String matchKind;
  final bool confirmedByUser;
  final DateTime computedAtUtc;
  final bool isValid;
  const MeasurementSessionRow({
    required this.id,
    this.glucoseId,
    this.ketoneId,
    required this.gkiValue,
    required this.formulaVersion,
    this.matchDifferenceMinutes,
    required this.matchKind,
    required this.confirmedByUser,
    required this.computedAtUtc,
    required this.isValid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || glucoseId != null) {
      map['glucose_id'] = Variable<int>(glucoseId);
    }
    if (!nullToAbsent || ketoneId != null) {
      map['ketone_id'] = Variable<int>(ketoneId);
    }
    map['gki_value'] = Variable<double>(gkiValue);
    map['formula_version'] = Variable<String>(formulaVersion);
    if (!nullToAbsent || matchDifferenceMinutes != null) {
      map['match_difference_minutes'] = Variable<int>(matchDifferenceMinutes);
    }
    map['match_kind'] = Variable<String>(matchKind);
    map['confirmed_by_user'] = Variable<bool>(confirmedByUser);
    map['computed_at_utc'] = Variable<DateTime>(computedAtUtc);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  MeasurementSessionCompanion toCompanion(bool nullToAbsent) {
    return MeasurementSessionCompanion(
      id: Value(id),
      glucoseId: glucoseId == null && nullToAbsent
          ? const Value.absent()
          : Value(glucoseId),
      ketoneId: ketoneId == null && nullToAbsent
          ? const Value.absent()
          : Value(ketoneId),
      gkiValue: Value(gkiValue),
      formulaVersion: Value(formulaVersion),
      matchDifferenceMinutes: matchDifferenceMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(matchDifferenceMinutes),
      matchKind: Value(matchKind),
      confirmedByUser: Value(confirmedByUser),
      computedAtUtc: Value(computedAtUtc),
      isValid: Value(isValid),
    );
  }

  factory MeasurementSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasurementSessionRow(
      id: serializer.fromJson<int>(json['id']),
      glucoseId: serializer.fromJson<int?>(json['glucoseId']),
      ketoneId: serializer.fromJson<int?>(json['ketoneId']),
      gkiValue: serializer.fromJson<double>(json['gkiValue']),
      formulaVersion: serializer.fromJson<String>(json['formulaVersion']),
      matchDifferenceMinutes: serializer.fromJson<int?>(
        json['matchDifferenceMinutes'],
      ),
      matchKind: serializer.fromJson<String>(json['matchKind']),
      confirmedByUser: serializer.fromJson<bool>(json['confirmedByUser']),
      computedAtUtc: serializer.fromJson<DateTime>(json['computedAtUtc']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'glucoseId': serializer.toJson<int?>(glucoseId),
      'ketoneId': serializer.toJson<int?>(ketoneId),
      'gkiValue': serializer.toJson<double>(gkiValue),
      'formulaVersion': serializer.toJson<String>(formulaVersion),
      'matchDifferenceMinutes': serializer.toJson<int?>(matchDifferenceMinutes),
      'matchKind': serializer.toJson<String>(matchKind),
      'confirmedByUser': serializer.toJson<bool>(confirmedByUser),
      'computedAtUtc': serializer.toJson<DateTime>(computedAtUtc),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  MeasurementSessionRow copyWith({
    int? id,
    Value<int?> glucoseId = const Value.absent(),
    Value<int?> ketoneId = const Value.absent(),
    double? gkiValue,
    String? formulaVersion,
    Value<int?> matchDifferenceMinutes = const Value.absent(),
    String? matchKind,
    bool? confirmedByUser,
    DateTime? computedAtUtc,
    bool? isValid,
  }) => MeasurementSessionRow(
    id: id ?? this.id,
    glucoseId: glucoseId.present ? glucoseId.value : this.glucoseId,
    ketoneId: ketoneId.present ? ketoneId.value : this.ketoneId,
    gkiValue: gkiValue ?? this.gkiValue,
    formulaVersion: formulaVersion ?? this.formulaVersion,
    matchDifferenceMinutes: matchDifferenceMinutes.present
        ? matchDifferenceMinutes.value
        : this.matchDifferenceMinutes,
    matchKind: matchKind ?? this.matchKind,
    confirmedByUser: confirmedByUser ?? this.confirmedByUser,
    computedAtUtc: computedAtUtc ?? this.computedAtUtc,
    isValid: isValid ?? this.isValid,
  );
  MeasurementSessionRow copyWithCompanion(MeasurementSessionCompanion data) {
    return MeasurementSessionRow(
      id: data.id.present ? data.id.value : this.id,
      glucoseId: data.glucoseId.present ? data.glucoseId.value : this.glucoseId,
      ketoneId: data.ketoneId.present ? data.ketoneId.value : this.ketoneId,
      gkiValue: data.gkiValue.present ? data.gkiValue.value : this.gkiValue,
      formulaVersion: data.formulaVersion.present
          ? data.formulaVersion.value
          : this.formulaVersion,
      matchDifferenceMinutes: data.matchDifferenceMinutes.present
          ? data.matchDifferenceMinutes.value
          : this.matchDifferenceMinutes,
      matchKind: data.matchKind.present ? data.matchKind.value : this.matchKind,
      confirmedByUser: data.confirmedByUser.present
          ? data.confirmedByUser.value
          : this.confirmedByUser,
      computedAtUtc: data.computedAtUtc.present
          ? data.computedAtUtc.value
          : this.computedAtUtc,
      isValid: data.isValid.present ? data.isValid.value : this.isValid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementSessionRow(')
          ..write('id: $id, ')
          ..write('glucoseId: $glucoseId, ')
          ..write('ketoneId: $ketoneId, ')
          ..write('gkiValue: $gkiValue, ')
          ..write('formulaVersion: $formulaVersion, ')
          ..write('matchDifferenceMinutes: $matchDifferenceMinutes, ')
          ..write('matchKind: $matchKind, ')
          ..write('confirmedByUser: $confirmedByUser, ')
          ..write('computedAtUtc: $computedAtUtc, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    glucoseId,
    ketoneId,
    gkiValue,
    formulaVersion,
    matchDifferenceMinutes,
    matchKind,
    confirmedByUser,
    computedAtUtc,
    isValid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasurementSessionRow &&
          other.id == this.id &&
          other.glucoseId == this.glucoseId &&
          other.ketoneId == this.ketoneId &&
          other.gkiValue == this.gkiValue &&
          other.formulaVersion == this.formulaVersion &&
          other.matchDifferenceMinutes == this.matchDifferenceMinutes &&
          other.matchKind == this.matchKind &&
          other.confirmedByUser == this.confirmedByUser &&
          other.computedAtUtc == this.computedAtUtc &&
          other.isValid == this.isValid);
}

class MeasurementSessionCompanion
    extends UpdateCompanion<MeasurementSessionRow> {
  final Value<int> id;
  final Value<int?> glucoseId;
  final Value<int?> ketoneId;
  final Value<double> gkiValue;
  final Value<String> formulaVersion;
  final Value<int?> matchDifferenceMinutes;
  final Value<String> matchKind;
  final Value<bool> confirmedByUser;
  final Value<DateTime> computedAtUtc;
  final Value<bool> isValid;
  const MeasurementSessionCompanion({
    this.id = const Value.absent(),
    this.glucoseId = const Value.absent(),
    this.ketoneId = const Value.absent(),
    this.gkiValue = const Value.absent(),
    this.formulaVersion = const Value.absent(),
    this.matchDifferenceMinutes = const Value.absent(),
    this.matchKind = const Value.absent(),
    this.confirmedByUser = const Value.absent(),
    this.computedAtUtc = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  MeasurementSessionCompanion.insert({
    this.id = const Value.absent(),
    this.glucoseId = const Value.absent(),
    this.ketoneId = const Value.absent(),
    required double gkiValue,
    required String formulaVersion,
    this.matchDifferenceMinutes = const Value.absent(),
    required String matchKind,
    required bool confirmedByUser,
    required DateTime computedAtUtc,
    this.isValid = const Value.absent(),
  }) : gkiValue = Value(gkiValue),
       formulaVersion = Value(formulaVersion),
       matchKind = Value(matchKind),
       confirmedByUser = Value(confirmedByUser),
       computedAtUtc = Value(computedAtUtc);
  static Insertable<MeasurementSessionRow> custom({
    Expression<int>? id,
    Expression<int>? glucoseId,
    Expression<int>? ketoneId,
    Expression<double>? gkiValue,
    Expression<String>? formulaVersion,
    Expression<int>? matchDifferenceMinutes,
    Expression<String>? matchKind,
    Expression<bool>? confirmedByUser,
    Expression<DateTime>? computedAtUtc,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (glucoseId != null) 'glucose_id': glucoseId,
      if (ketoneId != null) 'ketone_id': ketoneId,
      if (gkiValue != null) 'gki_value': gkiValue,
      if (formulaVersion != null) 'formula_version': formulaVersion,
      if (matchDifferenceMinutes != null)
        'match_difference_minutes': matchDifferenceMinutes,
      if (matchKind != null) 'match_kind': matchKind,
      if (confirmedByUser != null) 'confirmed_by_user': confirmedByUser,
      if (computedAtUtc != null) 'computed_at_utc': computedAtUtc,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  MeasurementSessionCompanion copyWith({
    Value<int>? id,
    Value<int?>? glucoseId,
    Value<int?>? ketoneId,
    Value<double>? gkiValue,
    Value<String>? formulaVersion,
    Value<int?>? matchDifferenceMinutes,
    Value<String>? matchKind,
    Value<bool>? confirmedByUser,
    Value<DateTime>? computedAtUtc,
    Value<bool>? isValid,
  }) {
    return MeasurementSessionCompanion(
      id: id ?? this.id,
      glucoseId: glucoseId ?? this.glucoseId,
      ketoneId: ketoneId ?? this.ketoneId,
      gkiValue: gkiValue ?? this.gkiValue,
      formulaVersion: formulaVersion ?? this.formulaVersion,
      matchDifferenceMinutes:
          matchDifferenceMinutes ?? this.matchDifferenceMinutes,
      matchKind: matchKind ?? this.matchKind,
      confirmedByUser: confirmedByUser ?? this.confirmedByUser,
      computedAtUtc: computedAtUtc ?? this.computedAtUtc,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (glucoseId.present) {
      map['glucose_id'] = Variable<int>(glucoseId.value);
    }
    if (ketoneId.present) {
      map['ketone_id'] = Variable<int>(ketoneId.value);
    }
    if (gkiValue.present) {
      map['gki_value'] = Variable<double>(gkiValue.value);
    }
    if (formulaVersion.present) {
      map['formula_version'] = Variable<String>(formulaVersion.value);
    }
    if (matchDifferenceMinutes.present) {
      map['match_difference_minutes'] = Variable<int>(
        matchDifferenceMinutes.value,
      );
    }
    if (matchKind.present) {
      map['match_kind'] = Variable<String>(matchKind.value);
    }
    if (confirmedByUser.present) {
      map['confirmed_by_user'] = Variable<bool>(confirmedByUser.value);
    }
    if (computedAtUtc.present) {
      map['computed_at_utc'] = Variable<DateTime>(computedAtUtc.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementSessionCompanion(')
          ..write('id: $id, ')
          ..write('glucoseId: $glucoseId, ')
          ..write('ketoneId: $ketoneId, ')
          ..write('gkiValue: $gkiValue, ')
          ..write('formulaVersion: $formulaVersion, ')
          ..write('matchDifferenceMinutes: $matchDifferenceMinutes, ')
          ..write('matchKind: $matchKind, ')
          ..write('confirmedByUser: $confirmedByUser, ')
          ..write('computedAtUtc: $computedAtUtc, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $WeightEntryTable extends WeightEntry
    with TableInfo<$WeightEntryTable, WeightEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<double> rawValue = GeneratedColumn<double>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawUnitMeta = const VerificationMeta(
    'rawUnit',
  );
  @override
  late final GeneratedColumn<String> rawUnit = GeneratedColumn<String>(
    'raw_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kgMeta = const VerificationMeta('kg');
  @override
  late final GeneratedColumn<double> kg = GeneratedColumn<double>(
    'kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measuredAtUtcMeta = const VerificationMeta(
    'measuredAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAtUtc =
      GeneratedColumn<DateTime>(
        'measured_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _localOffsetMinutesMeta =
      const VerificationMeta('localOffsetMinutes');
  @override
  late final GeneratedColumn<int> localOffsetMinutes = GeneratedColumn<int>(
    'local_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionNoteMeta = const VerificationMeta(
    'conditionNote',
  );
  @override
  late final GeneratedColumn<String> conditionNote = GeneratedColumn<String>(
    'condition_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    rawUnit,
    kg,
    measuredAtUtc,
    localOffsetMinutes,
    conditionNote,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('raw_unit')) {
      context.handle(
        _rawUnitMeta,
        rawUnit.isAcceptableOrUnknown(data['raw_unit']!, _rawUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_rawUnitMeta);
    }
    if (data.containsKey('kg')) {
      context.handle(_kgMeta, kg.isAcceptableOrUnknown(data['kg']!, _kgMeta));
    } else if (isInserting) {
      context.missing(_kgMeta);
    }
    if (data.containsKey('measured_at_utc')) {
      context.handle(
        _measuredAtUtcMeta,
        measuredAtUtc.isAcceptableOrUnknown(
          data['measured_at_utc']!,
          _measuredAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measuredAtUtcMeta);
    }
    if (data.containsKey('local_offset_minutes')) {
      context.handle(
        _localOffsetMinutesMeta,
        localOffsetMinutes.isAcceptableOrUnknown(
          data['local_offset_minutes']!,
          _localOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localOffsetMinutesMeta);
    }
    if (data.containsKey('condition_note')) {
      context.handle(
        _conditionNoteMeta,
        conditionNote.isAcceptableOrUnknown(
          data['condition_note']!,
          _conditionNoteMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_value'],
      )!,
      rawUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_unit'],
      )!,
      kg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kg'],
      )!,
      measuredAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at_utc'],
      )!,
      localOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_offset_minutes'],
      )!,
      conditionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_note'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WeightEntryTable createAlias(String alias) {
    return $WeightEntryTable(attachedDatabase, alias);
  }
}

class WeightEntryRow extends DataClass implements Insertable<WeightEntryRow> {
  final int id;
  final double rawValue;
  final String rawUnit;
  final double kg;
  final DateTime measuredAtUtc;
  final int localOffsetMinutes;
  final String? conditionNote;
  final String? note;
  const WeightEntryRow({
    required this.id,
    required this.rawValue,
    required this.rawUnit,
    required this.kg,
    required this.measuredAtUtc,
    required this.localOffsetMinutes,
    this.conditionNote,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_value'] = Variable<double>(rawValue);
    map['raw_unit'] = Variable<String>(rawUnit);
    map['kg'] = Variable<double>(kg);
    map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc);
    map['local_offset_minutes'] = Variable<int>(localOffsetMinutes);
    if (!nullToAbsent || conditionNote != null) {
      map['condition_note'] = Variable<String>(conditionNote);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WeightEntryCompanion toCompanion(bool nullToAbsent) {
    return WeightEntryCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      rawUnit: Value(rawUnit),
      kg: Value(kg),
      measuredAtUtc: Value(measuredAtUtc),
      localOffsetMinutes: Value(localOffsetMinutes),
      conditionNote: conditionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionNote),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WeightEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntryRow(
      id: serializer.fromJson<int>(json['id']),
      rawValue: serializer.fromJson<double>(json['rawValue']),
      rawUnit: serializer.fromJson<String>(json['rawUnit']),
      kg: serializer.fromJson<double>(json['kg']),
      measuredAtUtc: serializer.fromJson<DateTime>(json['measuredAtUtc']),
      localOffsetMinutes: serializer.fromJson<int>(json['localOffsetMinutes']),
      conditionNote: serializer.fromJson<String?>(json['conditionNote']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawValue': serializer.toJson<double>(rawValue),
      'rawUnit': serializer.toJson<String>(rawUnit),
      'kg': serializer.toJson<double>(kg),
      'measuredAtUtc': serializer.toJson<DateTime>(measuredAtUtc),
      'localOffsetMinutes': serializer.toJson<int>(localOffsetMinutes),
      'conditionNote': serializer.toJson<String?>(conditionNote),
      'note': serializer.toJson<String?>(note),
    };
  }

  WeightEntryRow copyWith({
    int? id,
    double? rawValue,
    String? rawUnit,
    double? kg,
    DateTime? measuredAtUtc,
    int? localOffsetMinutes,
    Value<String?> conditionNote = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => WeightEntryRow(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    rawUnit: rawUnit ?? this.rawUnit,
    kg: kg ?? this.kg,
    measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
    localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
    conditionNote: conditionNote.present
        ? conditionNote.value
        : this.conditionNote,
    note: note.present ? note.value : this.note,
  );
  WeightEntryRow copyWithCompanion(WeightEntryCompanion data) {
    return WeightEntryRow(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      rawUnit: data.rawUnit.present ? data.rawUnit.value : this.rawUnit,
      kg: data.kg.present ? data.kg.value : this.kg,
      measuredAtUtc: data.measuredAtUtc.present
          ? data.measuredAtUtc.value
          : this.measuredAtUtc,
      localOffsetMinutes: data.localOffsetMinutes.present
          ? data.localOffsetMinutes.value
          : this.localOffsetMinutes,
      conditionNote: data.conditionNote.present
          ? data.conditionNote.value
          : this.conditionNote,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntryRow(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('kg: $kg, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('conditionNote: $conditionNote, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    rawUnit,
    kg,
    measuredAtUtc,
    localOffsetMinutes,
    conditionNote,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntryRow &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.rawUnit == this.rawUnit &&
          other.kg == this.kg &&
          other.measuredAtUtc == this.measuredAtUtc &&
          other.localOffsetMinutes == this.localOffsetMinutes &&
          other.conditionNote == this.conditionNote &&
          other.note == this.note);
}

class WeightEntryCompanion extends UpdateCompanion<WeightEntryRow> {
  final Value<int> id;
  final Value<double> rawValue;
  final Value<String> rawUnit;
  final Value<double> kg;
  final Value<DateTime> measuredAtUtc;
  final Value<int> localOffsetMinutes;
  final Value<String?> conditionNote;
  final Value<String?> note;
  const WeightEntryCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.rawUnit = const Value.absent(),
    this.kg = const Value.absent(),
    this.measuredAtUtc = const Value.absent(),
    this.localOffsetMinutes = const Value.absent(),
    this.conditionNote = const Value.absent(),
    this.note = const Value.absent(),
  });
  WeightEntryCompanion.insert({
    this.id = const Value.absent(),
    required double rawValue,
    required String rawUnit,
    required double kg,
    required DateTime measuredAtUtc,
    required int localOffsetMinutes,
    this.conditionNote = const Value.absent(),
    this.note = const Value.absent(),
  }) : rawValue = Value(rawValue),
       rawUnit = Value(rawUnit),
       kg = Value(kg),
       measuredAtUtc = Value(measuredAtUtc),
       localOffsetMinutes = Value(localOffsetMinutes);
  static Insertable<WeightEntryRow> custom({
    Expression<int>? id,
    Expression<double>? rawValue,
    Expression<String>? rawUnit,
    Expression<double>? kg,
    Expression<DateTime>? measuredAtUtc,
    Expression<int>? localOffsetMinutes,
    Expression<String>? conditionNote,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (rawUnit != null) 'raw_unit': rawUnit,
      if (kg != null) 'kg': kg,
      if (measuredAtUtc != null) 'measured_at_utc': measuredAtUtc,
      if (localOffsetMinutes != null)
        'local_offset_minutes': localOffsetMinutes,
      if (conditionNote != null) 'condition_note': conditionNote,
      if (note != null) 'note': note,
    });
  }

  WeightEntryCompanion copyWith({
    Value<int>? id,
    Value<double>? rawValue,
    Value<String>? rawUnit,
    Value<double>? kg,
    Value<DateTime>? measuredAtUtc,
    Value<int>? localOffsetMinutes,
    Value<String?>? conditionNote,
    Value<String?>? note,
  }) {
    return WeightEntryCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      rawUnit: rawUnit ?? this.rawUnit,
      kg: kg ?? this.kg,
      measuredAtUtc: measuredAtUtc ?? this.measuredAtUtc,
      localOffsetMinutes: localOffsetMinutes ?? this.localOffsetMinutes,
      conditionNote: conditionNote ?? this.conditionNote,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<double>(rawValue.value);
    }
    if (rawUnit.present) {
      map['raw_unit'] = Variable<String>(rawUnit.value);
    }
    if (kg.present) {
      map['kg'] = Variable<double>(kg.value);
    }
    if (measuredAtUtc.present) {
      map['measured_at_utc'] = Variable<DateTime>(measuredAtUtc.value);
    }
    if (localOffsetMinutes.present) {
      map['local_offset_minutes'] = Variable<int>(localOffsetMinutes.value);
    }
    if (conditionNote.present) {
      map['condition_note'] = Variable<String>(conditionNote.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntryCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('rawUnit: $rawUnit, ')
          ..write('kg: $kg, ')
          ..write('measuredAtUtc: $measuredAtUtc, ')
          ..write('localOffsetMinutes: $localOffsetMinutes, ')
          ..write('conditionNote: $conditionNote, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SymptomDefinitionTable extends SymptomDefinition
    with TableInfo<$SymptomDefinitionTable, SymptomDefinitionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomDefinitionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
    'name_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameTr, nameEn, isUserCreated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_definition';
  @override
  VerificationContext validateIntegrity(
    Insertable<SymptomDefinitionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_tr')) {
      context.handle(
        _nameTrMeta,
        nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta),
      );
    } else if (isInserting) {
      context.missing(_nameTrMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomDefinitionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomDefinitionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_tr'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
    );
  }

  @override
  $SymptomDefinitionTable createAlias(String alias) {
    return $SymptomDefinitionTable(attachedDatabase, alias);
  }
}

class SymptomDefinitionRow extends DataClass
    implements Insertable<SymptomDefinitionRow> {
  final String id;
  final String nameTr;
  final String nameEn;
  final bool isUserCreated;
  const SymptomDefinitionRow({
    required this.id,
    required this.nameTr,
    required this.nameEn,
    required this.isUserCreated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_tr'] = Variable<String>(nameTr);
    map['name_en'] = Variable<String>(nameEn);
    map['is_user_created'] = Variable<bool>(isUserCreated);
    return map;
  }

  SymptomDefinitionCompanion toCompanion(bool nullToAbsent) {
    return SymptomDefinitionCompanion(
      id: Value(id),
      nameTr: Value(nameTr),
      nameEn: Value(nameEn),
      isUserCreated: Value(isUserCreated),
    );
  }

  factory SymptomDefinitionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomDefinitionRow(
      id: serializer.fromJson<String>(json['id']),
      nameTr: serializer.fromJson<String>(json['nameTr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameTr': serializer.toJson<String>(nameTr),
      'nameEn': serializer.toJson<String>(nameEn),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
    };
  }

  SymptomDefinitionRow copyWith({
    String? id,
    String? nameTr,
    String? nameEn,
    bool? isUserCreated,
  }) => SymptomDefinitionRow(
    id: id ?? this.id,
    nameTr: nameTr ?? this.nameTr,
    nameEn: nameEn ?? this.nameEn,
    isUserCreated: isUserCreated ?? this.isUserCreated,
  );
  SymptomDefinitionRow copyWithCompanion(SymptomDefinitionCompanion data) {
    return SymptomDefinitionRow(
      id: data.id.present ? data.id.value : this.id,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomDefinitionRow(')
          ..write('id: $id, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('isUserCreated: $isUserCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameTr, nameEn, isUserCreated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomDefinitionRow &&
          other.id == this.id &&
          other.nameTr == this.nameTr &&
          other.nameEn == this.nameEn &&
          other.isUserCreated == this.isUserCreated);
}

class SymptomDefinitionCompanion extends UpdateCompanion<SymptomDefinitionRow> {
  final Value<String> id;
  final Value<String> nameTr;
  final Value<String> nameEn;
  final Value<bool> isUserCreated;
  final Value<int> rowid;
  const SymptomDefinitionCompanion({
    this.id = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomDefinitionCompanion.insert({
    required String id,
    required String nameTr,
    required String nameEn,
    this.isUserCreated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameTr = Value(nameTr),
       nameEn = Value(nameEn);
  static Insertable<SymptomDefinitionRow> custom({
    Expression<String>? id,
    Expression<String>? nameTr,
    Expression<String>? nameEn,
    Expression<bool>? isUserCreated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameTr != null) 'name_tr': nameTr,
      if (nameEn != null) 'name_en': nameEn,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomDefinitionCompanion copyWith({
    Value<String>? id,
    Value<String>? nameTr,
    Value<String>? nameEn,
    Value<bool>? isUserCreated,
    Value<int>? rowid,
  }) {
    return SymptomDefinitionCompanion(
      id: id ?? this.id,
      nameTr: nameTr ?? this.nameTr,
      nameEn: nameEn ?? this.nameEn,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomDefinitionCompanion(')
          ..write('id: $id, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomEntryTable extends SymptomEntry
    with TableInfo<$SymptomEntryTable, SymptomEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _symptomDefinitionIdMeta =
      const VerificationMeta('symptomDefinitionId');
  @override
  late final GeneratedColumn<String> symptomDefinitionId =
      GeneratedColumn<String>(
        'symptom_definition_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES symptom_definition (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtUtcMeta = const VerificationMeta(
    'startedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> startedAtUtc = GeneratedColumn<DateTime>(
    'started_at_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    symptomDefinitionId,
    severity,
    startedAtUtc,
    durationMinutes,
    note,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptom_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<SymptomEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symptom_definition_id')) {
      context.handle(
        _symptomDefinitionIdMeta,
        symptomDefinitionId.isAcceptableOrUnknown(
          data['symptom_definition_id']!,
          _symptomDefinitionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_symptomDefinitionIdMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('started_at_utc')) {
      context.handle(
        _startedAtUtcMeta,
        startedAtUtc.isAcceptableOrUnknown(
          data['started_at_utc']!,
          _startedAtUtcMeta,
        ),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SymptomEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      symptomDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom_definition_id'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}severity'],
      )!,
      startedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at_utc'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $SymptomEntryTable createAlias(String alias) {
    return $SymptomEntryTable(attachedDatabase, alias);
  }
}

class SymptomEntryRow extends DataClass implements Insertable<SymptomEntryRow> {
  final int id;
  final String symptomDefinitionId;
  final int severity;
  final DateTime? startedAtUtc;
  final int? durationMinutes;
  final String? note;
  final DateTime createdAtUtc;
  const SymptomEntryRow({
    required this.id,
    required this.symptomDefinitionId,
    required this.severity,
    this.startedAtUtc,
    this.durationMinutes,
    this.note,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symptom_definition_id'] = Variable<String>(symptomDefinitionId);
    map['severity'] = Variable<int>(severity);
    if (!nullToAbsent || startedAtUtc != null) {
      map['started_at_utc'] = Variable<DateTime>(startedAtUtc);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  SymptomEntryCompanion toCompanion(bool nullToAbsent) {
    return SymptomEntryCompanion(
      id: Value(id),
      symptomDefinitionId: Value(symptomDefinitionId),
      severity: Value(severity),
      startedAtUtc: startedAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAtUtc),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory SymptomEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomEntryRow(
      id: serializer.fromJson<int>(json['id']),
      symptomDefinitionId: serializer.fromJson<String>(
        json['symptomDefinitionId'],
      ),
      severity: serializer.fromJson<int>(json['severity']),
      startedAtUtc: serializer.fromJson<DateTime?>(json['startedAtUtc']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      note: serializer.fromJson<String?>(json['note']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symptomDefinitionId': serializer.toJson<String>(symptomDefinitionId),
      'severity': serializer.toJson<int>(severity),
      'startedAtUtc': serializer.toJson<DateTime?>(startedAtUtc),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'note': serializer.toJson<String?>(note),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  SymptomEntryRow copyWith({
    int? id,
    String? symptomDefinitionId,
    int? severity,
    Value<DateTime?> startedAtUtc = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAtUtc,
  }) => SymptomEntryRow(
    id: id ?? this.id,
    symptomDefinitionId: symptomDefinitionId ?? this.symptomDefinitionId,
    severity: severity ?? this.severity,
    startedAtUtc: startedAtUtc.present ? startedAtUtc.value : this.startedAtUtc,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    note: note.present ? note.value : this.note,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  SymptomEntryRow copyWithCompanion(SymptomEntryCompanion data) {
    return SymptomEntryRow(
      id: data.id.present ? data.id.value : this.id,
      symptomDefinitionId: data.symptomDefinitionId.present
          ? data.symptomDefinitionId.value
          : this.symptomDefinitionId,
      severity: data.severity.present ? data.severity.value : this.severity,
      startedAtUtc: data.startedAtUtc.present
          ? data.startedAtUtc.value
          : this.startedAtUtc,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      note: data.note.present ? data.note.value : this.note,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntryRow(')
          ..write('id: $id, ')
          ..write('symptomDefinitionId: $symptomDefinitionId, ')
          ..write('severity: $severity, ')
          ..write('startedAtUtc: $startedAtUtc, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('note: $note, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    symptomDefinitionId,
    severity,
    startedAtUtc,
    durationMinutes,
    note,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomEntryRow &&
          other.id == this.id &&
          other.symptomDefinitionId == this.symptomDefinitionId &&
          other.severity == this.severity &&
          other.startedAtUtc == this.startedAtUtc &&
          other.durationMinutes == this.durationMinutes &&
          other.note == this.note &&
          other.createdAtUtc == this.createdAtUtc);
}

class SymptomEntryCompanion extends UpdateCompanion<SymptomEntryRow> {
  final Value<int> id;
  final Value<String> symptomDefinitionId;
  final Value<int> severity;
  final Value<DateTime?> startedAtUtc;
  final Value<int?> durationMinutes;
  final Value<String?> note;
  final Value<DateTime> createdAtUtc;
  const SymptomEntryCompanion({
    this.id = const Value.absent(),
    this.symptomDefinitionId = const Value.absent(),
    this.severity = const Value.absent(),
    this.startedAtUtc = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
  });
  SymptomEntryCompanion.insert({
    this.id = const Value.absent(),
    required String symptomDefinitionId,
    required int severity,
    this.startedAtUtc = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAtUtc,
  }) : symptomDefinitionId = Value(symptomDefinitionId),
       severity = Value(severity),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<SymptomEntryRow> custom({
    Expression<int>? id,
    Expression<String>? symptomDefinitionId,
    Expression<int>? severity,
    Expression<DateTime>? startedAtUtc,
    Expression<int>? durationMinutes,
    Expression<String>? note,
    Expression<DateTime>? createdAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symptomDefinitionId != null)
        'symptom_definition_id': symptomDefinitionId,
      if (severity != null) 'severity': severity,
      if (startedAtUtc != null) 'started_at_utc': startedAtUtc,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (note != null) 'note': note,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
    });
  }

  SymptomEntryCompanion copyWith({
    Value<int>? id,
    Value<String>? symptomDefinitionId,
    Value<int>? severity,
    Value<DateTime?>? startedAtUtc,
    Value<int?>? durationMinutes,
    Value<String?>? note,
    Value<DateTime>? createdAtUtc,
  }) {
    return SymptomEntryCompanion(
      id: id ?? this.id,
      symptomDefinitionId: symptomDefinitionId ?? this.symptomDefinitionId,
      severity: severity ?? this.severity,
      startedAtUtc: startedAtUtc ?? this.startedAtUtc,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      note: note ?? this.note,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symptomDefinitionId.present) {
      map['symptom_definition_id'] = Variable<String>(
        symptomDefinitionId.value,
      );
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (startedAtUtc.present) {
      map['started_at_utc'] = Variable<DateTime>(startedAtUtc.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomEntryCompanion(')
          ..write('id: $id, ')
          ..write('symptomDefinitionId: $symptomDefinitionId, ')
          ..write('severity: $severity, ')
          ..write('startedAtUtc: $startedAtUtc, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('note: $note, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }
}

class $ContextTagTable extends ContextTag
    with TableInfo<$ContextTagTable, ContextTagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContextTagTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelTrMeta = const VerificationMeta(
    'labelTr',
  );
  @override
  late final GeneratedColumn<String> labelTr = GeneratedColumn<String>(
    'label_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelEnMeta = const VerificationMeta(
    'labelEn',
  );
  @override
  late final GeneratedColumn<String> labelEn = GeneratedColumn<String>(
    'label_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, labelTr, labelEn, isUserCreated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'context_tag';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContextTagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label_tr')) {
      context.handle(
        _labelTrMeta,
        labelTr.isAcceptableOrUnknown(data['label_tr']!, _labelTrMeta),
      );
    } else if (isInserting) {
      context.missing(_labelTrMeta);
    }
    if (data.containsKey('label_en')) {
      context.handle(
        _labelEnMeta,
        labelEn.isAcceptableOrUnknown(data['label_en']!, _labelEnMeta),
      );
    } else if (isInserting) {
      context.missing(_labelEnMeta);
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContextTagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContextTagRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      labelTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_tr'],
      )!,
      labelEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_en'],
      )!,
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
    );
  }

  @override
  $ContextTagTable createAlias(String alias) {
    return $ContextTagTable(attachedDatabase, alias);
  }
}

class ContextTagRow extends DataClass implements Insertable<ContextTagRow> {
  final String id;
  final String labelTr;
  final String labelEn;
  final bool isUserCreated;
  const ContextTagRow({
    required this.id,
    required this.labelTr,
    required this.labelEn,
    required this.isUserCreated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label_tr'] = Variable<String>(labelTr);
    map['label_en'] = Variable<String>(labelEn);
    map['is_user_created'] = Variable<bool>(isUserCreated);
    return map;
  }

  ContextTagCompanion toCompanion(bool nullToAbsent) {
    return ContextTagCompanion(
      id: Value(id),
      labelTr: Value(labelTr),
      labelEn: Value(labelEn),
      isUserCreated: Value(isUserCreated),
    );
  }

  factory ContextTagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContextTagRow(
      id: serializer.fromJson<String>(json['id']),
      labelTr: serializer.fromJson<String>(json['labelTr']),
      labelEn: serializer.fromJson<String>(json['labelEn']),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'labelTr': serializer.toJson<String>(labelTr),
      'labelEn': serializer.toJson<String>(labelEn),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
    };
  }

  ContextTagRow copyWith({
    String? id,
    String? labelTr,
    String? labelEn,
    bool? isUserCreated,
  }) => ContextTagRow(
    id: id ?? this.id,
    labelTr: labelTr ?? this.labelTr,
    labelEn: labelEn ?? this.labelEn,
    isUserCreated: isUserCreated ?? this.isUserCreated,
  );
  ContextTagRow copyWithCompanion(ContextTagCompanion data) {
    return ContextTagRow(
      id: data.id.present ? data.id.value : this.id,
      labelTr: data.labelTr.present ? data.labelTr.value : this.labelTr,
      labelEn: data.labelEn.present ? data.labelEn.value : this.labelEn,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContextTagRow(')
          ..write('id: $id, ')
          ..write('labelTr: $labelTr, ')
          ..write('labelEn: $labelEn, ')
          ..write('isUserCreated: $isUserCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, labelTr, labelEn, isUserCreated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContextTagRow &&
          other.id == this.id &&
          other.labelTr == this.labelTr &&
          other.labelEn == this.labelEn &&
          other.isUserCreated == this.isUserCreated);
}

class ContextTagCompanion extends UpdateCompanion<ContextTagRow> {
  final Value<String> id;
  final Value<String> labelTr;
  final Value<String> labelEn;
  final Value<bool> isUserCreated;
  final Value<int> rowid;
  const ContextTagCompanion({
    this.id = const Value.absent(),
    this.labelTr = const Value.absent(),
    this.labelEn = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContextTagCompanion.insert({
    required String id,
    required String labelTr,
    required String labelEn,
    this.isUserCreated = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       labelTr = Value(labelTr),
       labelEn = Value(labelEn);
  static Insertable<ContextTagRow> custom({
    Expression<String>? id,
    Expression<String>? labelTr,
    Expression<String>? labelEn,
    Expression<bool>? isUserCreated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (labelTr != null) 'label_tr': labelTr,
      if (labelEn != null) 'label_en': labelEn,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContextTagCompanion copyWith({
    Value<String>? id,
    Value<String>? labelTr,
    Value<String>? labelEn,
    Value<bool>? isUserCreated,
    Value<int>? rowid,
  }) {
    return ContextTagCompanion(
      id: id ?? this.id,
      labelTr: labelTr ?? this.labelTr,
      labelEn: labelEn ?? this.labelEn,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (labelTr.present) {
      map['label_tr'] = Variable<String>(labelTr.value);
    }
    if (labelEn.present) {
      map['label_en'] = Variable<String>(labelEn.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContextTagCompanion(')
          ..write('id: $id, ')
          ..write('labelTr: $labelTr, ')
          ..write('labelEn: $labelEn, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealPlanTable extends MealPlan
    with TableInfo<$MealPlanTable, MealPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startDateIsoMeta = const VerificationMeta(
    'startDateIso',
  );
  @override
  late final GeneratedColumn<String> startDateIso = GeneratedColumn<String>(
    'start_date_iso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, startDateIso, name, createdAtUtc];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date_iso')) {
      context.handle(
        _startDateIsoMeta,
        startDateIso.isAcceptableOrUnknown(
          data['start_date_iso']!,
          _startDateIsoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startDateIsoMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startDateIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date_iso'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $MealPlanTable createAlias(String alias) {
    return $MealPlanTable(attachedDatabase, alias);
  }
}

class MealPlanRow extends DataClass implements Insertable<MealPlanRow> {
  final int id;
  final String startDateIso;
  final String? name;
  final DateTime createdAtUtc;
  const MealPlanRow({
    required this.id,
    required this.startDateIso,
    this.name,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date_iso'] = Variable<String>(startDateIso);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  MealPlanCompanion toCompanion(bool nullToAbsent) {
    return MealPlanCompanion(
      id: Value(id),
      startDateIso: Value(startDateIso),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory MealPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlanRow(
      id: serializer.fromJson<int>(json['id']),
      startDateIso: serializer.fromJson<String>(json['startDateIso']),
      name: serializer.fromJson<String?>(json['name']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDateIso': serializer.toJson<String>(startDateIso),
      'name': serializer.toJson<String?>(name),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  MealPlanRow copyWith({
    int? id,
    String? startDateIso,
    Value<String?> name = const Value.absent(),
    DateTime? createdAtUtc,
  }) => MealPlanRow(
    id: id ?? this.id,
    startDateIso: startDateIso ?? this.startDateIso,
    name: name.present ? name.value : this.name,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  MealPlanRow copyWithCompanion(MealPlanCompanion data) {
    return MealPlanRow(
      id: data.id.present ? data.id.value : this.id,
      startDateIso: data.startDateIso.present
          ? data.startDateIso.value
          : this.startDateIso,
      name: data.name.present ? data.name.value : this.name,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanRow(')
          ..write('id: $id, ')
          ..write('startDateIso: $startDateIso, ')
          ..write('name: $name, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startDateIso, name, createdAtUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlanRow &&
          other.id == this.id &&
          other.startDateIso == this.startDateIso &&
          other.name == this.name &&
          other.createdAtUtc == this.createdAtUtc);
}

class MealPlanCompanion extends UpdateCompanion<MealPlanRow> {
  final Value<int> id;
  final Value<String> startDateIso;
  final Value<String?> name;
  final Value<DateTime> createdAtUtc;
  const MealPlanCompanion({
    this.id = const Value.absent(),
    this.startDateIso = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
  });
  MealPlanCompanion.insert({
    this.id = const Value.absent(),
    required String startDateIso,
    this.name = const Value.absent(),
    required DateTime createdAtUtc,
  }) : startDateIso = Value(startDateIso),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<MealPlanRow> custom({
    Expression<int>? id,
    Expression<String>? startDateIso,
    Expression<String>? name,
    Expression<DateTime>? createdAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDateIso != null) 'start_date_iso': startDateIso,
      if (name != null) 'name': name,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
    });
  }

  MealPlanCompanion copyWith({
    Value<int>? id,
    Value<String>? startDateIso,
    Value<String?>? name,
    Value<DateTime>? createdAtUtc,
  }) {
    return MealPlanCompanion(
      id: id ?? this.id,
      startDateIso: startDateIso ?? this.startDateIso,
      name: name ?? this.name,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDateIso.present) {
      map['start_date_iso'] = Variable<String>(startDateIso.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanCompanion(')
          ..write('id: $id, ')
          ..write('startDateIso: $startDateIso, ')
          ..write('name: $name, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }
}

class $MealPlanEntryTable extends MealPlanEntry
    with TableInfo<$MealPlanEntryTable, MealPlanEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlanEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mealPlanIdMeta = const VerificationMeta(
    'mealPlanId',
  );
  @override
  late final GeneratedColumn<int> mealPlanId = GeneratedColumn<int>(
    'meal_plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_plan (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayOffsetMeta = const VerificationMeta(
    'dayOffset',
  );
  @override
  late final GeneratedColumn<int> dayOffset = GeneratedColumn<int>(
    'day_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipe (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<double> servings = GeneratedColumn<double>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealPlanId,
    dayOffset,
    mealType,
    recipeId,
    servings,
    completed,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plan_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlanEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_plan_id')) {
      context.handle(
        _mealPlanIdMeta,
        mealPlanId.isAcceptableOrUnknown(
          data['meal_plan_id']!,
          _mealPlanIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealPlanIdMeta);
    }
    if (data.containsKey('day_offset')) {
      context.handle(
        _dayOffsetMeta,
        dayOffset.isAcceptableOrUnknown(data['day_offset']!, _dayOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOffsetMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlanEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlanEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealPlanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_plan_id'],
      )!,
      dayOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_offset'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}servings'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $MealPlanEntryTable createAlias(String alias) {
    return $MealPlanEntryTable(attachedDatabase, alias);
  }
}

class MealPlanEntryRow extends DataClass
    implements Insertable<MealPlanEntryRow> {
  final int id;
  final int mealPlanId;
  final int dayOffset;
  final String mealType;
  final String? recipeId;
  final double servings;
  final bool completed;
  final String? note;
  const MealPlanEntryRow({
    required this.id,
    required this.mealPlanId,
    required this.dayOffset,
    required this.mealType,
    this.recipeId,
    required this.servings,
    required this.completed,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_plan_id'] = Variable<int>(mealPlanId);
    map['day_offset'] = Variable<int>(dayOffset);
    map['meal_type'] = Variable<String>(mealType);
    if (!nullToAbsent || recipeId != null) {
      map['recipe_id'] = Variable<String>(recipeId);
    }
    map['servings'] = Variable<double>(servings);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MealPlanEntryCompanion toCompanion(bool nullToAbsent) {
    return MealPlanEntryCompanion(
      id: Value(id),
      mealPlanId: Value(mealPlanId),
      dayOffset: Value(dayOffset),
      mealType: Value(mealType),
      recipeId: recipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipeId),
      servings: Value(servings),
      completed: Value(completed),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory MealPlanEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlanEntryRow(
      id: serializer.fromJson<int>(json['id']),
      mealPlanId: serializer.fromJson<int>(json['mealPlanId']),
      dayOffset: serializer.fromJson<int>(json['dayOffset']),
      mealType: serializer.fromJson<String>(json['mealType']),
      recipeId: serializer.fromJson<String?>(json['recipeId']),
      servings: serializer.fromJson<double>(json['servings']),
      completed: serializer.fromJson<bool>(json['completed']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealPlanId': serializer.toJson<int>(mealPlanId),
      'dayOffset': serializer.toJson<int>(dayOffset),
      'mealType': serializer.toJson<String>(mealType),
      'recipeId': serializer.toJson<String?>(recipeId),
      'servings': serializer.toJson<double>(servings),
      'completed': serializer.toJson<bool>(completed),
      'note': serializer.toJson<String?>(note),
    };
  }

  MealPlanEntryRow copyWith({
    int? id,
    int? mealPlanId,
    int? dayOffset,
    String? mealType,
    Value<String?> recipeId = const Value.absent(),
    double? servings,
    bool? completed,
    Value<String?> note = const Value.absent(),
  }) => MealPlanEntryRow(
    id: id ?? this.id,
    mealPlanId: mealPlanId ?? this.mealPlanId,
    dayOffset: dayOffset ?? this.dayOffset,
    mealType: mealType ?? this.mealType,
    recipeId: recipeId.present ? recipeId.value : this.recipeId,
    servings: servings ?? this.servings,
    completed: completed ?? this.completed,
    note: note.present ? note.value : this.note,
  );
  MealPlanEntryRow copyWithCompanion(MealPlanEntryCompanion data) {
    return MealPlanEntryRow(
      id: data.id.present ? data.id.value : this.id,
      mealPlanId: data.mealPlanId.present
          ? data.mealPlanId.value
          : this.mealPlanId,
      dayOffset: data.dayOffset.present ? data.dayOffset.value : this.dayOffset,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      servings: data.servings.present ? data.servings.value : this.servings,
      completed: data.completed.present ? data.completed.value : this.completed,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanEntryRow(')
          ..write('id: $id, ')
          ..write('mealPlanId: $mealPlanId, ')
          ..write('dayOffset: $dayOffset, ')
          ..write('mealType: $mealType, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings, ')
          ..write('completed: $completed, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mealPlanId,
    dayOffset,
    mealType,
    recipeId,
    servings,
    completed,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlanEntryRow &&
          other.id == this.id &&
          other.mealPlanId == this.mealPlanId &&
          other.dayOffset == this.dayOffset &&
          other.mealType == this.mealType &&
          other.recipeId == this.recipeId &&
          other.servings == this.servings &&
          other.completed == this.completed &&
          other.note == this.note);
}

class MealPlanEntryCompanion extends UpdateCompanion<MealPlanEntryRow> {
  final Value<int> id;
  final Value<int> mealPlanId;
  final Value<int> dayOffset;
  final Value<String> mealType;
  final Value<String?> recipeId;
  final Value<double> servings;
  final Value<bool> completed;
  final Value<String?> note;
  const MealPlanEntryCompanion({
    this.id = const Value.absent(),
    this.mealPlanId = const Value.absent(),
    this.dayOffset = const Value.absent(),
    this.mealType = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.servings = const Value.absent(),
    this.completed = const Value.absent(),
    this.note = const Value.absent(),
  });
  MealPlanEntryCompanion.insert({
    this.id = const Value.absent(),
    required int mealPlanId,
    required int dayOffset,
    required String mealType,
    this.recipeId = const Value.absent(),
    required double servings,
    this.completed = const Value.absent(),
    this.note = const Value.absent(),
  }) : mealPlanId = Value(mealPlanId),
       dayOffset = Value(dayOffset),
       mealType = Value(mealType),
       servings = Value(servings);
  static Insertable<MealPlanEntryRow> custom({
    Expression<int>? id,
    Expression<int>? mealPlanId,
    Expression<int>? dayOffset,
    Expression<String>? mealType,
    Expression<String>? recipeId,
    Expression<double>? servings,
    Expression<bool>? completed,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealPlanId != null) 'meal_plan_id': mealPlanId,
      if (dayOffset != null) 'day_offset': dayOffset,
      if (mealType != null) 'meal_type': mealType,
      if (recipeId != null) 'recipe_id': recipeId,
      if (servings != null) 'servings': servings,
      if (completed != null) 'completed': completed,
      if (note != null) 'note': note,
    });
  }

  MealPlanEntryCompanion copyWith({
    Value<int>? id,
    Value<int>? mealPlanId,
    Value<int>? dayOffset,
    Value<String>? mealType,
    Value<String?>? recipeId,
    Value<double>? servings,
    Value<bool>? completed,
    Value<String?>? note,
  }) {
    return MealPlanEntryCompanion(
      id: id ?? this.id,
      mealPlanId: mealPlanId ?? this.mealPlanId,
      dayOffset: dayOffset ?? this.dayOffset,
      mealType: mealType ?? this.mealType,
      recipeId: recipeId ?? this.recipeId,
      servings: servings ?? this.servings,
      completed: completed ?? this.completed,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealPlanId.present) {
      map['meal_plan_id'] = Variable<int>(mealPlanId.value);
    }
    if (dayOffset.present) {
      map['day_offset'] = Variable<int>(dayOffset.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (servings.present) {
      map['servings'] = Variable<double>(servings.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlanEntryCompanion(')
          ..write('id: $id, ')
          ..write('mealPlanId: $mealPlanId, ')
          ..write('dayOffset: $dayOffset, ')
          ..write('mealType: $mealType, ')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings, ')
          ..write('completed: $completed, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $ShoppingListTable extends ShoppingList
    with TableInfo<$ShoppingListTable, ShoppingListRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateStartIsoMeta = const VerificationMeta(
    'dateStartIso',
  );
  @override
  late final GeneratedColumn<String> dateStartIso = GeneratedColumn<String>(
    'date_start_iso',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateEndIsoMeta = const VerificationMeta(
    'dateEndIso',
  );
  @override
  late final GeneratedColumn<String> dateEndIso = GeneratedColumn<String>(
    'date_end_iso',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    dateStartIso,
    dateEndIso,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingListRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date_start_iso')) {
      context.handle(
        _dateStartIsoMeta,
        dateStartIso.isAcceptableOrUnknown(
          data['date_start_iso']!,
          _dateStartIsoMeta,
        ),
      );
    }
    if (data.containsKey('date_end_iso')) {
      context.handle(
        _dateEndIsoMeta,
        dateEndIso.isAcceptableOrUnknown(
          data['date_end_iso']!,
          _dateEndIsoMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingListRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingListRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      dateStartIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_start_iso'],
      ),
      dateEndIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_end_iso'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $ShoppingListTable createAlias(String alias) {
    return $ShoppingListTable(attachedDatabase, alias);
  }
}

class ShoppingListRow extends DataClass implements Insertable<ShoppingListRow> {
  final int id;
  final String title;
  final String? dateStartIso;
  final String? dateEndIso;
  final DateTime createdAtUtc;
  const ShoppingListRow({
    required this.id,
    required this.title,
    this.dateStartIso,
    this.dateEndIso,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || dateStartIso != null) {
      map['date_start_iso'] = Variable<String>(dateStartIso);
    }
    if (!nullToAbsent || dateEndIso != null) {
      map['date_end_iso'] = Variable<String>(dateEndIso);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  ShoppingListCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListCompanion(
      id: Value(id),
      title: Value(title),
      dateStartIso: dateStartIso == null && nullToAbsent
          ? const Value.absent()
          : Value(dateStartIso),
      dateEndIso: dateEndIso == null && nullToAbsent
          ? const Value.absent()
          : Value(dateEndIso),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory ShoppingListRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingListRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dateStartIso: serializer.fromJson<String?>(json['dateStartIso']),
      dateEndIso: serializer.fromJson<String?>(json['dateEndIso']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'dateStartIso': serializer.toJson<String?>(dateStartIso),
      'dateEndIso': serializer.toJson<String?>(dateEndIso),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  ShoppingListRow copyWith({
    int? id,
    String? title,
    Value<String?> dateStartIso = const Value.absent(),
    Value<String?> dateEndIso = const Value.absent(),
    DateTime? createdAtUtc,
  }) => ShoppingListRow(
    id: id ?? this.id,
    title: title ?? this.title,
    dateStartIso: dateStartIso.present ? dateStartIso.value : this.dateStartIso,
    dateEndIso: dateEndIso.present ? dateEndIso.value : this.dateEndIso,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  ShoppingListRow copyWithCompanion(ShoppingListCompanion data) {
    return ShoppingListRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      dateStartIso: data.dateStartIso.present
          ? data.dateStartIso.value
          : this.dateStartIso,
      dateEndIso: data.dateEndIso.present
          ? data.dateEndIso.value
          : this.dateEndIso,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateStartIso: $dateStartIso, ')
          ..write('dateEndIso: $dateEndIso, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, dateStartIso, dateEndIso, createdAtUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingListRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.dateStartIso == this.dateStartIso &&
          other.dateEndIso == this.dateEndIso &&
          other.createdAtUtc == this.createdAtUtc);
}

class ShoppingListCompanion extends UpdateCompanion<ShoppingListRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> dateStartIso;
  final Value<String?> dateEndIso;
  final Value<DateTime> createdAtUtc;
  const ShoppingListCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dateStartIso = const Value.absent(),
    this.dateEndIso = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
  });
  ShoppingListCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.dateStartIso = const Value.absent(),
    this.dateEndIso = const Value.absent(),
    required DateTime createdAtUtc,
  }) : title = Value(title),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<ShoppingListRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? dateStartIso,
    Expression<String>? dateEndIso,
    Expression<DateTime>? createdAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dateStartIso != null) 'date_start_iso': dateStartIso,
      if (dateEndIso != null) 'date_end_iso': dateEndIso,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
    });
  }

  ShoppingListCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? dateStartIso,
    Value<String?>? dateEndIso,
    Value<DateTime>? createdAtUtc,
  }) {
    return ShoppingListCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dateStartIso: dateStartIso ?? this.dateStartIso,
      dateEndIso: dateEndIso ?? this.dateEndIso,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dateStartIso.present) {
      map['date_start_iso'] = Variable<String>(dateStartIso.value);
    }
    if (dateEndIso.present) {
      map['date_end_iso'] = Variable<String>(dateEndIso.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateStartIso: $dateStartIso, ')
          ..write('dateEndIso: $dateEndIso, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }
}

class $ShoppingListItemTable extends ShoppingListItem
    with TableInfo<$ShoppingListItemTable, ShoppingListItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _shoppingListIdMeta = const VerificationMeta(
    'shoppingListId',
  );
  @override
  late final GeneratedColumn<int> shoppingListId = GeneratedColumn<int>(
    'shopping_list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shopping_list (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityGramsMeta = const VerificationMeta(
    'quantityGrams',
  );
  @override
  late final GeneratedColumn<double> quantityGrams = GeneratedColumn<double>(
    'quantity_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityDisplayMeta = const VerificationMeta(
    'quantityDisplay',
  );
  @override
  late final GeneratedColumn<String> quantityDisplay = GeneratedColumn<String>(
    'quantity_display',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shoppingListId,
    foodId,
    label,
    quantityGrams,
    quantityDisplay,
    category,
    isChecked,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_list_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingListItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shopping_list_id')) {
      context.handle(
        _shoppingListIdMeta,
        shoppingListId.isAcceptableOrUnknown(
          data['shopping_list_id']!,
          _shoppingListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shoppingListIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('quantity_grams')) {
      context.handle(
        _quantityGramsMeta,
        quantityGrams.isAcceptableOrUnknown(
          data['quantity_grams']!,
          _quantityGramsMeta,
        ),
      );
    }
    if (data.containsKey('quantity_display')) {
      context.handle(
        _quantityDisplayMeta,
        quantityDisplay.isAcceptableOrUnknown(
          data['quantity_display']!,
          _quantityDisplayMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingListItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingListItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      shoppingListId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shopping_list_id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      quantityGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_grams'],
      ),
      quantityDisplay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity_display'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
    );
  }

  @override
  $ShoppingListItemTable createAlias(String alias) {
    return $ShoppingListItemTable(attachedDatabase, alias);
  }
}

class ShoppingListItemRow extends DataClass
    implements Insertable<ShoppingListItemRow> {
  final int id;
  final int shoppingListId;
  final String? foodId;
  final String? label;
  final double? quantityGrams;
  final String? quantityDisplay;
  final String? category;
  final bool isChecked;
  const ShoppingListItemRow({
    required this.id,
    required this.shoppingListId,
    this.foodId,
    this.label,
    this.quantityGrams,
    this.quantityDisplay,
    this.category,
    required this.isChecked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shopping_list_id'] = Variable<int>(shoppingListId);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<String>(foodId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || quantityGrams != null) {
      map['quantity_grams'] = Variable<double>(quantityGrams);
    }
    if (!nullToAbsent || quantityDisplay != null) {
      map['quantity_display'] = Variable<String>(quantityDisplay);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_checked'] = Variable<bool>(isChecked);
    return map;
  }

  ShoppingListItemCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListItemCompanion(
      id: Value(id),
      shoppingListId: Value(shoppingListId),
      foodId: foodId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      quantityGrams: quantityGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityGrams),
      quantityDisplay: quantityDisplay == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityDisplay),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isChecked: Value(isChecked),
    );
  }

  factory ShoppingListItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingListItemRow(
      id: serializer.fromJson<int>(json['id']),
      shoppingListId: serializer.fromJson<int>(json['shoppingListId']),
      foodId: serializer.fromJson<String?>(json['foodId']),
      label: serializer.fromJson<String?>(json['label']),
      quantityGrams: serializer.fromJson<double?>(json['quantityGrams']),
      quantityDisplay: serializer.fromJson<String?>(json['quantityDisplay']),
      category: serializer.fromJson<String?>(json['category']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shoppingListId': serializer.toJson<int>(shoppingListId),
      'foodId': serializer.toJson<String?>(foodId),
      'label': serializer.toJson<String?>(label),
      'quantityGrams': serializer.toJson<double?>(quantityGrams),
      'quantityDisplay': serializer.toJson<String?>(quantityDisplay),
      'category': serializer.toJson<String?>(category),
      'isChecked': serializer.toJson<bool>(isChecked),
    };
  }

  ShoppingListItemRow copyWith({
    int? id,
    int? shoppingListId,
    Value<String?> foodId = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<double?> quantityGrams = const Value.absent(),
    Value<String?> quantityDisplay = const Value.absent(),
    Value<String?> category = const Value.absent(),
    bool? isChecked,
  }) => ShoppingListItemRow(
    id: id ?? this.id,
    shoppingListId: shoppingListId ?? this.shoppingListId,
    foodId: foodId.present ? foodId.value : this.foodId,
    label: label.present ? label.value : this.label,
    quantityGrams: quantityGrams.present
        ? quantityGrams.value
        : this.quantityGrams,
    quantityDisplay: quantityDisplay.present
        ? quantityDisplay.value
        : this.quantityDisplay,
    category: category.present ? category.value : this.category,
    isChecked: isChecked ?? this.isChecked,
  );
  ShoppingListItemRow copyWithCompanion(ShoppingListItemCompanion data) {
    return ShoppingListItemRow(
      id: data.id.present ? data.id.value : this.id,
      shoppingListId: data.shoppingListId.present
          ? data.shoppingListId.value
          : this.shoppingListId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      label: data.label.present ? data.label.value : this.label,
      quantityGrams: data.quantityGrams.present
          ? data.quantityGrams.value
          : this.quantityGrams,
      quantityDisplay: data.quantityDisplay.present
          ? data.quantityDisplay.value
          : this.quantityDisplay,
      category: data.category.present ? data.category.value : this.category,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemRow(')
          ..write('id: $id, ')
          ..write('shoppingListId: $shoppingListId, ')
          ..write('foodId: $foodId, ')
          ..write('label: $label, ')
          ..write('quantityGrams: $quantityGrams, ')
          ..write('quantityDisplay: $quantityDisplay, ')
          ..write('category: $category, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shoppingListId,
    foodId,
    label,
    quantityGrams,
    quantityDisplay,
    category,
    isChecked,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingListItemRow &&
          other.id == this.id &&
          other.shoppingListId == this.shoppingListId &&
          other.foodId == this.foodId &&
          other.label == this.label &&
          other.quantityGrams == this.quantityGrams &&
          other.quantityDisplay == this.quantityDisplay &&
          other.category == this.category &&
          other.isChecked == this.isChecked);
}

class ShoppingListItemCompanion extends UpdateCompanion<ShoppingListItemRow> {
  final Value<int> id;
  final Value<int> shoppingListId;
  final Value<String?> foodId;
  final Value<String?> label;
  final Value<double?> quantityGrams;
  final Value<String?> quantityDisplay;
  final Value<String?> category;
  final Value<bool> isChecked;
  const ShoppingListItemCompanion({
    this.id = const Value.absent(),
    this.shoppingListId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.label = const Value.absent(),
    this.quantityGrams = const Value.absent(),
    this.quantityDisplay = const Value.absent(),
    this.category = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  ShoppingListItemCompanion.insert({
    this.id = const Value.absent(),
    required int shoppingListId,
    this.foodId = const Value.absent(),
    this.label = const Value.absent(),
    this.quantityGrams = const Value.absent(),
    this.quantityDisplay = const Value.absent(),
    this.category = const Value.absent(),
    this.isChecked = const Value.absent(),
  }) : shoppingListId = Value(shoppingListId);
  static Insertable<ShoppingListItemRow> custom({
    Expression<int>? id,
    Expression<int>? shoppingListId,
    Expression<String>? foodId,
    Expression<String>? label,
    Expression<double>? quantityGrams,
    Expression<String>? quantityDisplay,
    Expression<String>? category,
    Expression<bool>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shoppingListId != null) 'shopping_list_id': shoppingListId,
      if (foodId != null) 'food_id': foodId,
      if (label != null) 'label': label,
      if (quantityGrams != null) 'quantity_grams': quantityGrams,
      if (quantityDisplay != null) 'quantity_display': quantityDisplay,
      if (category != null) 'category': category,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  ShoppingListItemCompanion copyWith({
    Value<int>? id,
    Value<int>? shoppingListId,
    Value<String?>? foodId,
    Value<String?>? label,
    Value<double?>? quantityGrams,
    Value<String?>? quantityDisplay,
    Value<String?>? category,
    Value<bool>? isChecked,
  }) {
    return ShoppingListItemCompanion(
      id: id ?? this.id,
      shoppingListId: shoppingListId ?? this.shoppingListId,
      foodId: foodId ?? this.foodId,
      label: label ?? this.label,
      quantityGrams: quantityGrams ?? this.quantityGrams,
      quantityDisplay: quantityDisplay ?? this.quantityDisplay,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shoppingListId.present) {
      map['shopping_list_id'] = Variable<int>(shoppingListId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (quantityGrams.present) {
      map['quantity_grams'] = Variable<double>(quantityGrams.value);
    }
    if (quantityDisplay.present) {
      map['quantity_display'] = Variable<String>(quantityDisplay.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemCompanion(')
          ..write('id: $id, ')
          ..write('shoppingListId: $shoppingListId, ')
          ..write('foodId: $foodId, ')
          ..write('label: $label, ')
          ..write('quantityGrams: $quantityGrams, ')
          ..write('quantityDisplay: $quantityDisplay, ')
          ..write('category: $category, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }
}

class $EvidenceSourceTable extends EvidenceSource
    with TableInfo<$EvidenceSourceTable, EvidenceSourceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvidenceSourceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleTrMeta = const VerificationMeta(
    'titleTr',
  );
  @override
  late final GeneratedColumn<String> titleTr = GeneratedColumn<String>(
    'title_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plainSummaryTrMeta = const VerificationMeta(
    'plainSummaryTr',
  );
  @override
  late final GeneratedColumn<String> plainSummaryTr = GeneratedColumn<String>(
    'plain_summary_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plainSummaryEnMeta = const VerificationMeta(
    'plainSummaryEn',
  );
  @override
  late final GeneratedColumn<String> plainSummaryEn = GeneratedColumn<String>(
    'plain_summary_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceLevelMeta = const VerificationMeta(
    'evidenceLevel',
  );
  @override
  late final GeneratedColumn<String> evidenceLevel = GeneratedColumn<String>(
    'evidence_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studyTypeMeta = const VerificationMeta(
    'studyType',
  );
  @override
  late final GeneratedColumn<String> studyType = GeneratedColumn<String>(
    'study_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _populationMeta = const VerificationMeta(
    'population',
  );
  @override
  late final GeneratedColumn<String> population = GeneratedColumn<String>(
    'population',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sampleSizeMeta = const VerificationMeta(
    'sampleSize',
  );
  @override
  late final GeneratedColumn<int> sampleSize = GeneratedColumn<int>(
    'sample_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorsCsvMeta = const VerificationMeta(
    'authorsCsv',
  );
  @override
  late final GeneratedColumn<String> authorsCsv = GeneratedColumn<String>(
    'authors_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _journalMeta = const VerificationMeta(
    'journal',
  );
  @override
  late final GeneratedColumn<String> journal = GeneratedColumn<String>(
    'journal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doiMeta = const VerificationMeta('doi');
  @override
  late final GeneratedColumn<String> doi = GeneratedColumn<String>(
    'doi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pmidMeta = const VerificationMeta('pmid');
  @override
  late final GeneratedColumn<int> pmid = GeneratedColumn<int>(
    'pmid',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pmcidMeta = const VerificationMeta('pmcid');
  @override
  late final GeneratedColumn<String> pmcid = GeneratedColumn<String>(
    'pmcid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canonicalUrlMeta = const VerificationMeta(
    'canonicalUrl',
  );
  @override
  late final GeneratedColumn<String> canonicalUrl = GeneratedColumn<String>(
    'canonical_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accessedAtIsoMeta = const VerificationMeta(
    'accessedAtIso',
  );
  @override
  late final GeneratedColumn<String> accessedAtIso = GeneratedColumn<String>(
    'accessed_at_iso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<String> contentVersion = GeneratedColumn<String>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReviewedAtIsoMeta = const VerificationMeta(
    'lastReviewedAtIso',
  );
  @override
  late final GeneratedColumn<String> lastReviewedAtIso =
      GeneratedColumn<String>(
        'last_reviewed_at_iso',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reviewedByRoleMeta = const VerificationMeta(
    'reviewedByRole',
  );
  @override
  late final GeneratedColumn<String> reviewedByRole = GeneratedColumn<String>(
    'reviewed_by_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _limitationsTrMeta = const VerificationMeta(
    'limitationsTr',
  );
  @override
  late final GeneratedColumn<String> limitationsTr = GeneratedColumn<String>(
    'limitations_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _limitationsEnMeta = const VerificationMeta(
    'limitationsEn',
  );
  @override
  late final GeneratedColumn<String> limitationsEn = GeneratedColumn<String>(
    'limitations_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conflictsOrFundingNoteTrMeta =
      const VerificationMeta('conflictsOrFundingNoteTr');
  @override
  late final GeneratedColumn<String> conflictsOrFundingNoteTr =
      GeneratedColumn<String>(
        'conflicts_or_funding_note_tr',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _conflictsOrFundingNoteEnMeta =
      const VerificationMeta('conflictsOrFundingNoteEn');
  @override
  late final GeneratedColumn<String> conflictsOrFundingNoteEn =
      GeneratedColumn<String>(
        'conflicts_or_funding_note_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titleTr,
    titleEn,
    plainSummaryTr,
    plainSummaryEn,
    evidenceLevel,
    studyType,
    population,
    sampleSize,
    year,
    authorsCsv,
    journal,
    doi,
    pmid,
    pmcid,
    canonicalUrl,
    accessedAtIso,
    contentVersion,
    lastReviewedAtIso,
    reviewedByRole,
    limitationsTr,
    limitationsEn,
    conflictsOrFundingNoteTr,
    conflictsOrFundingNoteEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evidence_source';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvidenceSourceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title_tr')) {
      context.handle(
        _titleTrMeta,
        titleTr.isAcceptableOrUnknown(data['title_tr']!, _titleTrMeta),
      );
    } else if (isInserting) {
      context.missing(_titleTrMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('plain_summary_tr')) {
      context.handle(
        _plainSummaryTrMeta,
        plainSummaryTr.isAcceptableOrUnknown(
          data['plain_summary_tr']!,
          _plainSummaryTrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plainSummaryTrMeta);
    }
    if (data.containsKey('plain_summary_en')) {
      context.handle(
        _plainSummaryEnMeta,
        plainSummaryEn.isAcceptableOrUnknown(
          data['plain_summary_en']!,
          _plainSummaryEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plainSummaryEnMeta);
    }
    if (data.containsKey('evidence_level')) {
      context.handle(
        _evidenceLevelMeta,
        evidenceLevel.isAcceptableOrUnknown(
          data['evidence_level']!,
          _evidenceLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evidenceLevelMeta);
    }
    if (data.containsKey('study_type')) {
      context.handle(
        _studyTypeMeta,
        studyType.isAcceptableOrUnknown(data['study_type']!, _studyTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_studyTypeMeta);
    }
    if (data.containsKey('population')) {
      context.handle(
        _populationMeta,
        population.isAcceptableOrUnknown(data['population']!, _populationMeta),
      );
    } else if (isInserting) {
      context.missing(_populationMeta);
    }
    if (data.containsKey('sample_size')) {
      context.handle(
        _sampleSizeMeta,
        sampleSize.isAcceptableOrUnknown(data['sample_size']!, _sampleSizeMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('authors_csv')) {
      context.handle(
        _authorsCsvMeta,
        authorsCsv.isAcceptableOrUnknown(data['authors_csv']!, _authorsCsvMeta),
      );
    } else if (isInserting) {
      context.missing(_authorsCsvMeta);
    }
    if (data.containsKey('journal')) {
      context.handle(
        _journalMeta,
        journal.isAcceptableOrUnknown(data['journal']!, _journalMeta),
      );
    } else if (isInserting) {
      context.missing(_journalMeta);
    }
    if (data.containsKey('doi')) {
      context.handle(
        _doiMeta,
        doi.isAcceptableOrUnknown(data['doi']!, _doiMeta),
      );
    }
    if (data.containsKey('pmid')) {
      context.handle(
        _pmidMeta,
        pmid.isAcceptableOrUnknown(data['pmid']!, _pmidMeta),
      );
    }
    if (data.containsKey('pmcid')) {
      context.handle(
        _pmcidMeta,
        pmcid.isAcceptableOrUnknown(data['pmcid']!, _pmcidMeta),
      );
    }
    if (data.containsKey('canonical_url')) {
      context.handle(
        _canonicalUrlMeta,
        canonicalUrl.isAcceptableOrUnknown(
          data['canonical_url']!,
          _canonicalUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalUrlMeta);
    }
    if (data.containsKey('accessed_at_iso')) {
      context.handle(
        _accessedAtIsoMeta,
        accessedAtIso.isAcceptableOrUnknown(
          data['accessed_at_iso']!,
          _accessedAtIsoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accessedAtIsoMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('last_reviewed_at_iso')) {
      context.handle(
        _lastReviewedAtIsoMeta,
        lastReviewedAtIso.isAcceptableOrUnknown(
          data['last_reviewed_at_iso']!,
          _lastReviewedAtIsoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastReviewedAtIsoMeta);
    }
    if (data.containsKey('reviewed_by_role')) {
      context.handle(
        _reviewedByRoleMeta,
        reviewedByRole.isAcceptableOrUnknown(
          data['reviewed_by_role']!,
          _reviewedByRoleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewedByRoleMeta);
    }
    if (data.containsKey('limitations_tr')) {
      context.handle(
        _limitationsTrMeta,
        limitationsTr.isAcceptableOrUnknown(
          data['limitations_tr']!,
          _limitationsTrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_limitationsTrMeta);
    }
    if (data.containsKey('limitations_en')) {
      context.handle(
        _limitationsEnMeta,
        limitationsEn.isAcceptableOrUnknown(
          data['limitations_en']!,
          _limitationsEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_limitationsEnMeta);
    }
    if (data.containsKey('conflicts_or_funding_note_tr')) {
      context.handle(
        _conflictsOrFundingNoteTrMeta,
        conflictsOrFundingNoteTr.isAcceptableOrUnknown(
          data['conflicts_or_funding_note_tr']!,
          _conflictsOrFundingNoteTrMeta,
        ),
      );
    }
    if (data.containsKey('conflicts_or_funding_note_en')) {
      context.handle(
        _conflictsOrFundingNoteEnMeta,
        conflictsOrFundingNoteEn.isAcceptableOrUnknown(
          data['conflicts_or_funding_note_en']!,
          _conflictsOrFundingNoteEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvidenceSourceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvidenceSourceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titleTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_tr'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      )!,
      plainSummaryTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plain_summary_tr'],
      )!,
      plainSummaryEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plain_summary_en'],
      )!,
      evidenceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_level'],
      )!,
      studyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_type'],
      )!,
      population: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}population'],
      )!,
      sampleSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_size'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      authorsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authors_csv'],
      )!,
      journal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}journal'],
      )!,
      doi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doi'],
      ),
      pmid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pmid'],
      ),
      pmcid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pmcid'],
      ),
      canonicalUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_url'],
      )!,
      accessedAtIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accessed_at_iso'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version'],
      )!,
      lastReviewedAtIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_reviewed_at_iso'],
      )!,
      reviewedByRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reviewed_by_role'],
      )!,
      limitationsTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}limitations_tr'],
      )!,
      limitationsEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}limitations_en'],
      )!,
      conflictsOrFundingNoteTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conflicts_or_funding_note_tr'],
      ),
      conflictsOrFundingNoteEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conflicts_or_funding_note_en'],
      ),
    );
  }

  @override
  $EvidenceSourceTable createAlias(String alias) {
    return $EvidenceSourceTable(attachedDatabase, alias);
  }
}

class EvidenceSourceRow extends DataClass
    implements Insertable<EvidenceSourceRow> {
  final String id;
  final String titleTr;
  final String titleEn;
  final String plainSummaryTr;
  final String plainSummaryEn;
  final String evidenceLevel;
  final String studyType;
  final String population;
  final int? sampleSize;
  final int year;
  final String authorsCsv;
  final String journal;
  final String? doi;
  final int? pmid;
  final String? pmcid;
  final String canonicalUrl;
  final String accessedAtIso;
  final String contentVersion;
  final String lastReviewedAtIso;
  final String reviewedByRole;
  final String limitationsTr;
  final String limitationsEn;
  final String? conflictsOrFundingNoteTr;
  final String? conflictsOrFundingNoteEn;
  const EvidenceSourceRow({
    required this.id,
    required this.titleTr,
    required this.titleEn,
    required this.plainSummaryTr,
    required this.plainSummaryEn,
    required this.evidenceLevel,
    required this.studyType,
    required this.population,
    this.sampleSize,
    required this.year,
    required this.authorsCsv,
    required this.journal,
    this.doi,
    this.pmid,
    this.pmcid,
    required this.canonicalUrl,
    required this.accessedAtIso,
    required this.contentVersion,
    required this.lastReviewedAtIso,
    required this.reviewedByRole,
    required this.limitationsTr,
    required this.limitationsEn,
    this.conflictsOrFundingNoteTr,
    this.conflictsOrFundingNoteEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title_tr'] = Variable<String>(titleTr);
    map['title_en'] = Variable<String>(titleEn);
    map['plain_summary_tr'] = Variable<String>(plainSummaryTr);
    map['plain_summary_en'] = Variable<String>(plainSummaryEn);
    map['evidence_level'] = Variable<String>(evidenceLevel);
    map['study_type'] = Variable<String>(studyType);
    map['population'] = Variable<String>(population);
    if (!nullToAbsent || sampleSize != null) {
      map['sample_size'] = Variable<int>(sampleSize);
    }
    map['year'] = Variable<int>(year);
    map['authors_csv'] = Variable<String>(authorsCsv);
    map['journal'] = Variable<String>(journal);
    if (!nullToAbsent || doi != null) {
      map['doi'] = Variable<String>(doi);
    }
    if (!nullToAbsent || pmid != null) {
      map['pmid'] = Variable<int>(pmid);
    }
    if (!nullToAbsent || pmcid != null) {
      map['pmcid'] = Variable<String>(pmcid);
    }
    map['canonical_url'] = Variable<String>(canonicalUrl);
    map['accessed_at_iso'] = Variable<String>(accessedAtIso);
    map['content_version'] = Variable<String>(contentVersion);
    map['last_reviewed_at_iso'] = Variable<String>(lastReviewedAtIso);
    map['reviewed_by_role'] = Variable<String>(reviewedByRole);
    map['limitations_tr'] = Variable<String>(limitationsTr);
    map['limitations_en'] = Variable<String>(limitationsEn);
    if (!nullToAbsent || conflictsOrFundingNoteTr != null) {
      map['conflicts_or_funding_note_tr'] = Variable<String>(
        conflictsOrFundingNoteTr,
      );
    }
    if (!nullToAbsent || conflictsOrFundingNoteEn != null) {
      map['conflicts_or_funding_note_en'] = Variable<String>(
        conflictsOrFundingNoteEn,
      );
    }
    return map;
  }

  EvidenceSourceCompanion toCompanion(bool nullToAbsent) {
    return EvidenceSourceCompanion(
      id: Value(id),
      titleTr: Value(titleTr),
      titleEn: Value(titleEn),
      plainSummaryTr: Value(plainSummaryTr),
      plainSummaryEn: Value(plainSummaryEn),
      evidenceLevel: Value(evidenceLevel),
      studyType: Value(studyType),
      population: Value(population),
      sampleSize: sampleSize == null && nullToAbsent
          ? const Value.absent()
          : Value(sampleSize),
      year: Value(year),
      authorsCsv: Value(authorsCsv),
      journal: Value(journal),
      doi: doi == null && nullToAbsent ? const Value.absent() : Value(doi),
      pmid: pmid == null && nullToAbsent ? const Value.absent() : Value(pmid),
      pmcid: pmcid == null && nullToAbsent
          ? const Value.absent()
          : Value(pmcid),
      canonicalUrl: Value(canonicalUrl),
      accessedAtIso: Value(accessedAtIso),
      contentVersion: Value(contentVersion),
      lastReviewedAtIso: Value(lastReviewedAtIso),
      reviewedByRole: Value(reviewedByRole),
      limitationsTr: Value(limitationsTr),
      limitationsEn: Value(limitationsEn),
      conflictsOrFundingNoteTr: conflictsOrFundingNoteTr == null && nullToAbsent
          ? const Value.absent()
          : Value(conflictsOrFundingNoteTr),
      conflictsOrFundingNoteEn: conflictsOrFundingNoteEn == null && nullToAbsent
          ? const Value.absent()
          : Value(conflictsOrFundingNoteEn),
    );
  }

  factory EvidenceSourceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvidenceSourceRow(
      id: serializer.fromJson<String>(json['id']),
      titleTr: serializer.fromJson<String>(json['titleTr']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      plainSummaryTr: serializer.fromJson<String>(json['plainSummaryTr']),
      plainSummaryEn: serializer.fromJson<String>(json['plainSummaryEn']),
      evidenceLevel: serializer.fromJson<String>(json['evidenceLevel']),
      studyType: serializer.fromJson<String>(json['studyType']),
      population: serializer.fromJson<String>(json['population']),
      sampleSize: serializer.fromJson<int?>(json['sampleSize']),
      year: serializer.fromJson<int>(json['year']),
      authorsCsv: serializer.fromJson<String>(json['authorsCsv']),
      journal: serializer.fromJson<String>(json['journal']),
      doi: serializer.fromJson<String?>(json['doi']),
      pmid: serializer.fromJson<int?>(json['pmid']),
      pmcid: serializer.fromJson<String?>(json['pmcid']),
      canonicalUrl: serializer.fromJson<String>(json['canonicalUrl']),
      accessedAtIso: serializer.fromJson<String>(json['accessedAtIso']),
      contentVersion: serializer.fromJson<String>(json['contentVersion']),
      lastReviewedAtIso: serializer.fromJson<String>(json['lastReviewedAtIso']),
      reviewedByRole: serializer.fromJson<String>(json['reviewedByRole']),
      limitationsTr: serializer.fromJson<String>(json['limitationsTr']),
      limitationsEn: serializer.fromJson<String>(json['limitationsEn']),
      conflictsOrFundingNoteTr: serializer.fromJson<String?>(
        json['conflictsOrFundingNoteTr'],
      ),
      conflictsOrFundingNoteEn: serializer.fromJson<String?>(
        json['conflictsOrFundingNoteEn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titleTr': serializer.toJson<String>(titleTr),
      'titleEn': serializer.toJson<String>(titleEn),
      'plainSummaryTr': serializer.toJson<String>(plainSummaryTr),
      'plainSummaryEn': serializer.toJson<String>(plainSummaryEn),
      'evidenceLevel': serializer.toJson<String>(evidenceLevel),
      'studyType': serializer.toJson<String>(studyType),
      'population': serializer.toJson<String>(population),
      'sampleSize': serializer.toJson<int?>(sampleSize),
      'year': serializer.toJson<int>(year),
      'authorsCsv': serializer.toJson<String>(authorsCsv),
      'journal': serializer.toJson<String>(journal),
      'doi': serializer.toJson<String?>(doi),
      'pmid': serializer.toJson<int?>(pmid),
      'pmcid': serializer.toJson<String?>(pmcid),
      'canonicalUrl': serializer.toJson<String>(canonicalUrl),
      'accessedAtIso': serializer.toJson<String>(accessedAtIso),
      'contentVersion': serializer.toJson<String>(contentVersion),
      'lastReviewedAtIso': serializer.toJson<String>(lastReviewedAtIso),
      'reviewedByRole': serializer.toJson<String>(reviewedByRole),
      'limitationsTr': serializer.toJson<String>(limitationsTr),
      'limitationsEn': serializer.toJson<String>(limitationsEn),
      'conflictsOrFundingNoteTr': serializer.toJson<String?>(
        conflictsOrFundingNoteTr,
      ),
      'conflictsOrFundingNoteEn': serializer.toJson<String?>(
        conflictsOrFundingNoteEn,
      ),
    };
  }

  EvidenceSourceRow copyWith({
    String? id,
    String? titleTr,
    String? titleEn,
    String? plainSummaryTr,
    String? plainSummaryEn,
    String? evidenceLevel,
    String? studyType,
    String? population,
    Value<int?> sampleSize = const Value.absent(),
    int? year,
    String? authorsCsv,
    String? journal,
    Value<String?> doi = const Value.absent(),
    Value<int?> pmid = const Value.absent(),
    Value<String?> pmcid = const Value.absent(),
    String? canonicalUrl,
    String? accessedAtIso,
    String? contentVersion,
    String? lastReviewedAtIso,
    String? reviewedByRole,
    String? limitationsTr,
    String? limitationsEn,
    Value<String?> conflictsOrFundingNoteTr = const Value.absent(),
    Value<String?> conflictsOrFundingNoteEn = const Value.absent(),
  }) => EvidenceSourceRow(
    id: id ?? this.id,
    titleTr: titleTr ?? this.titleTr,
    titleEn: titleEn ?? this.titleEn,
    plainSummaryTr: plainSummaryTr ?? this.plainSummaryTr,
    plainSummaryEn: plainSummaryEn ?? this.plainSummaryEn,
    evidenceLevel: evidenceLevel ?? this.evidenceLevel,
    studyType: studyType ?? this.studyType,
    population: population ?? this.population,
    sampleSize: sampleSize.present ? sampleSize.value : this.sampleSize,
    year: year ?? this.year,
    authorsCsv: authorsCsv ?? this.authorsCsv,
    journal: journal ?? this.journal,
    doi: doi.present ? doi.value : this.doi,
    pmid: pmid.present ? pmid.value : this.pmid,
    pmcid: pmcid.present ? pmcid.value : this.pmcid,
    canonicalUrl: canonicalUrl ?? this.canonicalUrl,
    accessedAtIso: accessedAtIso ?? this.accessedAtIso,
    contentVersion: contentVersion ?? this.contentVersion,
    lastReviewedAtIso: lastReviewedAtIso ?? this.lastReviewedAtIso,
    reviewedByRole: reviewedByRole ?? this.reviewedByRole,
    limitationsTr: limitationsTr ?? this.limitationsTr,
    limitationsEn: limitationsEn ?? this.limitationsEn,
    conflictsOrFundingNoteTr: conflictsOrFundingNoteTr.present
        ? conflictsOrFundingNoteTr.value
        : this.conflictsOrFundingNoteTr,
    conflictsOrFundingNoteEn: conflictsOrFundingNoteEn.present
        ? conflictsOrFundingNoteEn.value
        : this.conflictsOrFundingNoteEn,
  );
  EvidenceSourceRow copyWithCompanion(EvidenceSourceCompanion data) {
    return EvidenceSourceRow(
      id: data.id.present ? data.id.value : this.id,
      titleTr: data.titleTr.present ? data.titleTr.value : this.titleTr,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      plainSummaryTr: data.plainSummaryTr.present
          ? data.plainSummaryTr.value
          : this.plainSummaryTr,
      plainSummaryEn: data.plainSummaryEn.present
          ? data.plainSummaryEn.value
          : this.plainSummaryEn,
      evidenceLevel: data.evidenceLevel.present
          ? data.evidenceLevel.value
          : this.evidenceLevel,
      studyType: data.studyType.present ? data.studyType.value : this.studyType,
      population: data.population.present
          ? data.population.value
          : this.population,
      sampleSize: data.sampleSize.present
          ? data.sampleSize.value
          : this.sampleSize,
      year: data.year.present ? data.year.value : this.year,
      authorsCsv: data.authorsCsv.present
          ? data.authorsCsv.value
          : this.authorsCsv,
      journal: data.journal.present ? data.journal.value : this.journal,
      doi: data.doi.present ? data.doi.value : this.doi,
      pmid: data.pmid.present ? data.pmid.value : this.pmid,
      pmcid: data.pmcid.present ? data.pmcid.value : this.pmcid,
      canonicalUrl: data.canonicalUrl.present
          ? data.canonicalUrl.value
          : this.canonicalUrl,
      accessedAtIso: data.accessedAtIso.present
          ? data.accessedAtIso.value
          : this.accessedAtIso,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      lastReviewedAtIso: data.lastReviewedAtIso.present
          ? data.lastReviewedAtIso.value
          : this.lastReviewedAtIso,
      reviewedByRole: data.reviewedByRole.present
          ? data.reviewedByRole.value
          : this.reviewedByRole,
      limitationsTr: data.limitationsTr.present
          ? data.limitationsTr.value
          : this.limitationsTr,
      limitationsEn: data.limitationsEn.present
          ? data.limitationsEn.value
          : this.limitationsEn,
      conflictsOrFundingNoteTr: data.conflictsOrFundingNoteTr.present
          ? data.conflictsOrFundingNoteTr.value
          : this.conflictsOrFundingNoteTr,
      conflictsOrFundingNoteEn: data.conflictsOrFundingNoteEn.present
          ? data.conflictsOrFundingNoteEn.value
          : this.conflictsOrFundingNoteEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceSourceRow(')
          ..write('id: $id, ')
          ..write('titleTr: $titleTr, ')
          ..write('titleEn: $titleEn, ')
          ..write('plainSummaryTr: $plainSummaryTr, ')
          ..write('plainSummaryEn: $plainSummaryEn, ')
          ..write('evidenceLevel: $evidenceLevel, ')
          ..write('studyType: $studyType, ')
          ..write('population: $population, ')
          ..write('sampleSize: $sampleSize, ')
          ..write('year: $year, ')
          ..write('authorsCsv: $authorsCsv, ')
          ..write('journal: $journal, ')
          ..write('doi: $doi, ')
          ..write('pmid: $pmid, ')
          ..write('pmcid: $pmcid, ')
          ..write('canonicalUrl: $canonicalUrl, ')
          ..write('accessedAtIso: $accessedAtIso, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('lastReviewedAtIso: $lastReviewedAtIso, ')
          ..write('reviewedByRole: $reviewedByRole, ')
          ..write('limitationsTr: $limitationsTr, ')
          ..write('limitationsEn: $limitationsEn, ')
          ..write('conflictsOrFundingNoteTr: $conflictsOrFundingNoteTr, ')
          ..write('conflictsOrFundingNoteEn: $conflictsOrFundingNoteEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    titleTr,
    titleEn,
    plainSummaryTr,
    plainSummaryEn,
    evidenceLevel,
    studyType,
    population,
    sampleSize,
    year,
    authorsCsv,
    journal,
    doi,
    pmid,
    pmcid,
    canonicalUrl,
    accessedAtIso,
    contentVersion,
    lastReviewedAtIso,
    reviewedByRole,
    limitationsTr,
    limitationsEn,
    conflictsOrFundingNoteTr,
    conflictsOrFundingNoteEn,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvidenceSourceRow &&
          other.id == this.id &&
          other.titleTr == this.titleTr &&
          other.titleEn == this.titleEn &&
          other.plainSummaryTr == this.plainSummaryTr &&
          other.plainSummaryEn == this.plainSummaryEn &&
          other.evidenceLevel == this.evidenceLevel &&
          other.studyType == this.studyType &&
          other.population == this.population &&
          other.sampleSize == this.sampleSize &&
          other.year == this.year &&
          other.authorsCsv == this.authorsCsv &&
          other.journal == this.journal &&
          other.doi == this.doi &&
          other.pmid == this.pmid &&
          other.pmcid == this.pmcid &&
          other.canonicalUrl == this.canonicalUrl &&
          other.accessedAtIso == this.accessedAtIso &&
          other.contentVersion == this.contentVersion &&
          other.lastReviewedAtIso == this.lastReviewedAtIso &&
          other.reviewedByRole == this.reviewedByRole &&
          other.limitationsTr == this.limitationsTr &&
          other.limitationsEn == this.limitationsEn &&
          other.conflictsOrFundingNoteTr == this.conflictsOrFundingNoteTr &&
          other.conflictsOrFundingNoteEn == this.conflictsOrFundingNoteEn);
}

class EvidenceSourceCompanion extends UpdateCompanion<EvidenceSourceRow> {
  final Value<String> id;
  final Value<String> titleTr;
  final Value<String> titleEn;
  final Value<String> plainSummaryTr;
  final Value<String> plainSummaryEn;
  final Value<String> evidenceLevel;
  final Value<String> studyType;
  final Value<String> population;
  final Value<int?> sampleSize;
  final Value<int> year;
  final Value<String> authorsCsv;
  final Value<String> journal;
  final Value<String?> doi;
  final Value<int?> pmid;
  final Value<String?> pmcid;
  final Value<String> canonicalUrl;
  final Value<String> accessedAtIso;
  final Value<String> contentVersion;
  final Value<String> lastReviewedAtIso;
  final Value<String> reviewedByRole;
  final Value<String> limitationsTr;
  final Value<String> limitationsEn;
  final Value<String?> conflictsOrFundingNoteTr;
  final Value<String?> conflictsOrFundingNoteEn;
  final Value<int> rowid;
  const EvidenceSourceCompanion({
    this.id = const Value.absent(),
    this.titleTr = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.plainSummaryTr = const Value.absent(),
    this.plainSummaryEn = const Value.absent(),
    this.evidenceLevel = const Value.absent(),
    this.studyType = const Value.absent(),
    this.population = const Value.absent(),
    this.sampleSize = const Value.absent(),
    this.year = const Value.absent(),
    this.authorsCsv = const Value.absent(),
    this.journal = const Value.absent(),
    this.doi = const Value.absent(),
    this.pmid = const Value.absent(),
    this.pmcid = const Value.absent(),
    this.canonicalUrl = const Value.absent(),
    this.accessedAtIso = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.lastReviewedAtIso = const Value.absent(),
    this.reviewedByRole = const Value.absent(),
    this.limitationsTr = const Value.absent(),
    this.limitationsEn = const Value.absent(),
    this.conflictsOrFundingNoteTr = const Value.absent(),
    this.conflictsOrFundingNoteEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EvidenceSourceCompanion.insert({
    required String id,
    required String titleTr,
    required String titleEn,
    required String plainSummaryTr,
    required String plainSummaryEn,
    required String evidenceLevel,
    required String studyType,
    required String population,
    this.sampleSize = const Value.absent(),
    required int year,
    required String authorsCsv,
    required String journal,
    this.doi = const Value.absent(),
    this.pmid = const Value.absent(),
    this.pmcid = const Value.absent(),
    required String canonicalUrl,
    required String accessedAtIso,
    required String contentVersion,
    required String lastReviewedAtIso,
    required String reviewedByRole,
    required String limitationsTr,
    required String limitationsEn,
    this.conflictsOrFundingNoteTr = const Value.absent(),
    this.conflictsOrFundingNoteEn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titleTr = Value(titleTr),
       titleEn = Value(titleEn),
       plainSummaryTr = Value(plainSummaryTr),
       plainSummaryEn = Value(plainSummaryEn),
       evidenceLevel = Value(evidenceLevel),
       studyType = Value(studyType),
       population = Value(population),
       year = Value(year),
       authorsCsv = Value(authorsCsv),
       journal = Value(journal),
       canonicalUrl = Value(canonicalUrl),
       accessedAtIso = Value(accessedAtIso),
       contentVersion = Value(contentVersion),
       lastReviewedAtIso = Value(lastReviewedAtIso),
       reviewedByRole = Value(reviewedByRole),
       limitationsTr = Value(limitationsTr),
       limitationsEn = Value(limitationsEn);
  static Insertable<EvidenceSourceRow> custom({
    Expression<String>? id,
    Expression<String>? titleTr,
    Expression<String>? titleEn,
    Expression<String>? plainSummaryTr,
    Expression<String>? plainSummaryEn,
    Expression<String>? evidenceLevel,
    Expression<String>? studyType,
    Expression<String>? population,
    Expression<int>? sampleSize,
    Expression<int>? year,
    Expression<String>? authorsCsv,
    Expression<String>? journal,
    Expression<String>? doi,
    Expression<int>? pmid,
    Expression<String>? pmcid,
    Expression<String>? canonicalUrl,
    Expression<String>? accessedAtIso,
    Expression<String>? contentVersion,
    Expression<String>? lastReviewedAtIso,
    Expression<String>? reviewedByRole,
    Expression<String>? limitationsTr,
    Expression<String>? limitationsEn,
    Expression<String>? conflictsOrFundingNoteTr,
    Expression<String>? conflictsOrFundingNoteEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleTr != null) 'title_tr': titleTr,
      if (titleEn != null) 'title_en': titleEn,
      if (plainSummaryTr != null) 'plain_summary_tr': plainSummaryTr,
      if (plainSummaryEn != null) 'plain_summary_en': plainSummaryEn,
      if (evidenceLevel != null) 'evidence_level': evidenceLevel,
      if (studyType != null) 'study_type': studyType,
      if (population != null) 'population': population,
      if (sampleSize != null) 'sample_size': sampleSize,
      if (year != null) 'year': year,
      if (authorsCsv != null) 'authors_csv': authorsCsv,
      if (journal != null) 'journal': journal,
      if (doi != null) 'doi': doi,
      if (pmid != null) 'pmid': pmid,
      if (pmcid != null) 'pmcid': pmcid,
      if (canonicalUrl != null) 'canonical_url': canonicalUrl,
      if (accessedAtIso != null) 'accessed_at_iso': accessedAtIso,
      if (contentVersion != null) 'content_version': contentVersion,
      if (lastReviewedAtIso != null) 'last_reviewed_at_iso': lastReviewedAtIso,
      if (reviewedByRole != null) 'reviewed_by_role': reviewedByRole,
      if (limitationsTr != null) 'limitations_tr': limitationsTr,
      if (limitationsEn != null) 'limitations_en': limitationsEn,
      if (conflictsOrFundingNoteTr != null)
        'conflicts_or_funding_note_tr': conflictsOrFundingNoteTr,
      if (conflictsOrFundingNoteEn != null)
        'conflicts_or_funding_note_en': conflictsOrFundingNoteEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EvidenceSourceCompanion copyWith({
    Value<String>? id,
    Value<String>? titleTr,
    Value<String>? titleEn,
    Value<String>? plainSummaryTr,
    Value<String>? plainSummaryEn,
    Value<String>? evidenceLevel,
    Value<String>? studyType,
    Value<String>? population,
    Value<int?>? sampleSize,
    Value<int>? year,
    Value<String>? authorsCsv,
    Value<String>? journal,
    Value<String?>? doi,
    Value<int?>? pmid,
    Value<String?>? pmcid,
    Value<String>? canonicalUrl,
    Value<String>? accessedAtIso,
    Value<String>? contentVersion,
    Value<String>? lastReviewedAtIso,
    Value<String>? reviewedByRole,
    Value<String>? limitationsTr,
    Value<String>? limitationsEn,
    Value<String?>? conflictsOrFundingNoteTr,
    Value<String?>? conflictsOrFundingNoteEn,
    Value<int>? rowid,
  }) {
    return EvidenceSourceCompanion(
      id: id ?? this.id,
      titleTr: titleTr ?? this.titleTr,
      titleEn: titleEn ?? this.titleEn,
      plainSummaryTr: plainSummaryTr ?? this.plainSummaryTr,
      plainSummaryEn: plainSummaryEn ?? this.plainSummaryEn,
      evidenceLevel: evidenceLevel ?? this.evidenceLevel,
      studyType: studyType ?? this.studyType,
      population: population ?? this.population,
      sampleSize: sampleSize ?? this.sampleSize,
      year: year ?? this.year,
      authorsCsv: authorsCsv ?? this.authorsCsv,
      journal: journal ?? this.journal,
      doi: doi ?? this.doi,
      pmid: pmid ?? this.pmid,
      pmcid: pmcid ?? this.pmcid,
      canonicalUrl: canonicalUrl ?? this.canonicalUrl,
      accessedAtIso: accessedAtIso ?? this.accessedAtIso,
      contentVersion: contentVersion ?? this.contentVersion,
      lastReviewedAtIso: lastReviewedAtIso ?? this.lastReviewedAtIso,
      reviewedByRole: reviewedByRole ?? this.reviewedByRole,
      limitationsTr: limitationsTr ?? this.limitationsTr,
      limitationsEn: limitationsEn ?? this.limitationsEn,
      conflictsOrFundingNoteTr:
          conflictsOrFundingNoteTr ?? this.conflictsOrFundingNoteTr,
      conflictsOrFundingNoteEn:
          conflictsOrFundingNoteEn ?? this.conflictsOrFundingNoteEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titleTr.present) {
      map['title_tr'] = Variable<String>(titleTr.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (plainSummaryTr.present) {
      map['plain_summary_tr'] = Variable<String>(plainSummaryTr.value);
    }
    if (plainSummaryEn.present) {
      map['plain_summary_en'] = Variable<String>(plainSummaryEn.value);
    }
    if (evidenceLevel.present) {
      map['evidence_level'] = Variable<String>(evidenceLevel.value);
    }
    if (studyType.present) {
      map['study_type'] = Variable<String>(studyType.value);
    }
    if (population.present) {
      map['population'] = Variable<String>(population.value);
    }
    if (sampleSize.present) {
      map['sample_size'] = Variable<int>(sampleSize.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (authorsCsv.present) {
      map['authors_csv'] = Variable<String>(authorsCsv.value);
    }
    if (journal.present) {
      map['journal'] = Variable<String>(journal.value);
    }
    if (doi.present) {
      map['doi'] = Variable<String>(doi.value);
    }
    if (pmid.present) {
      map['pmid'] = Variable<int>(pmid.value);
    }
    if (pmcid.present) {
      map['pmcid'] = Variable<String>(pmcid.value);
    }
    if (canonicalUrl.present) {
      map['canonical_url'] = Variable<String>(canonicalUrl.value);
    }
    if (accessedAtIso.present) {
      map['accessed_at_iso'] = Variable<String>(accessedAtIso.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<String>(contentVersion.value);
    }
    if (lastReviewedAtIso.present) {
      map['last_reviewed_at_iso'] = Variable<String>(lastReviewedAtIso.value);
    }
    if (reviewedByRole.present) {
      map['reviewed_by_role'] = Variable<String>(reviewedByRole.value);
    }
    if (limitationsTr.present) {
      map['limitations_tr'] = Variable<String>(limitationsTr.value);
    }
    if (limitationsEn.present) {
      map['limitations_en'] = Variable<String>(limitationsEn.value);
    }
    if (conflictsOrFundingNoteTr.present) {
      map['conflicts_or_funding_note_tr'] = Variable<String>(
        conflictsOrFundingNoteTr.value,
      );
    }
    if (conflictsOrFundingNoteEn.present) {
      map['conflicts_or_funding_note_en'] = Variable<String>(
        conflictsOrFundingNoteEn.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceSourceCompanion(')
          ..write('id: $id, ')
          ..write('titleTr: $titleTr, ')
          ..write('titleEn: $titleEn, ')
          ..write('plainSummaryTr: $plainSummaryTr, ')
          ..write('plainSummaryEn: $plainSummaryEn, ')
          ..write('evidenceLevel: $evidenceLevel, ')
          ..write('studyType: $studyType, ')
          ..write('population: $population, ')
          ..write('sampleSize: $sampleSize, ')
          ..write('year: $year, ')
          ..write('authorsCsv: $authorsCsv, ')
          ..write('journal: $journal, ')
          ..write('doi: $doi, ')
          ..write('pmid: $pmid, ')
          ..write('pmcid: $pmcid, ')
          ..write('canonicalUrl: $canonicalUrl, ')
          ..write('accessedAtIso: $accessedAtIso, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('lastReviewedAtIso: $lastReviewedAtIso, ')
          ..write('reviewedByRole: $reviewedByRole, ')
          ..write('limitationsTr: $limitationsTr, ')
          ..write('limitationsEn: $limitationsEn, ')
          ..write('conflictsOrFundingNoteTr: $conflictsOrFundingNoteTr, ')
          ..write('conflictsOrFundingNoteEn: $conflictsOrFundingNoteEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EvidenceClaimTable extends EvidenceClaim
    with TableInfo<$EvidenceClaimTable, EvidenceClaimRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvidenceClaimTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES evidence_source (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _textTrMeta = const VerificationMeta('textTr');
  @override
  late final GeneratedColumn<String> textTr = GeneratedColumn<String>(
    'text_tr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceLevelMeta = const VerificationMeta(
    'evidenceLevel',
  );
  @override
  late final GeneratedColumn<String> evidenceLevel = GeneratedColumn<String>(
    'evidence_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkedFeatureIdsCsvMeta =
      const VerificationMeta('linkedFeatureIdsCsv');
  @override
  late final GeneratedColumn<String> linkedFeatureIdsCsv =
      GeneratedColumn<String>(
        'linked_feature_ids_csv',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceId,
    textTr,
    textEn,
    evidenceLevel,
    linkedFeatureIdsCsv,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evidence_claim';
  @override
  VerificationContext validateIntegrity(
    Insertable<EvidenceClaimRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('text_tr')) {
      context.handle(
        _textTrMeta,
        textTr.isAcceptableOrUnknown(data['text_tr']!, _textTrMeta),
      );
    } else if (isInserting) {
      context.missing(_textTrMeta);
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('evidence_level')) {
      context.handle(
        _evidenceLevelMeta,
        evidenceLevel.isAcceptableOrUnknown(
          data['evidence_level']!,
          _evidenceLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evidenceLevelMeta);
    }
    if (data.containsKey('linked_feature_ids_csv')) {
      context.handle(
        _linkedFeatureIdsCsvMeta,
        linkedFeatureIdsCsv.isAcceptableOrUnknown(
          data['linked_feature_ids_csv']!,
          _linkedFeatureIdsCsvMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvidenceClaimRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvidenceClaimRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      textTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_tr'],
      )!,
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      evidenceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_level'],
      )!,
      linkedFeatureIdsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_feature_ids_csv'],
      ),
    );
  }

  @override
  $EvidenceClaimTable createAlias(String alias) {
    return $EvidenceClaimTable(attachedDatabase, alias);
  }
}

class EvidenceClaimRow extends DataClass
    implements Insertable<EvidenceClaimRow> {
  final String id;
  final String sourceId;
  final String textTr;
  final String textEn;
  final String evidenceLevel;
  final String? linkedFeatureIdsCsv;
  const EvidenceClaimRow({
    required this.id,
    required this.sourceId,
    required this.textTr,
    required this.textEn,
    required this.evidenceLevel,
    this.linkedFeatureIdsCsv,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['text_tr'] = Variable<String>(textTr);
    map['text_en'] = Variable<String>(textEn);
    map['evidence_level'] = Variable<String>(evidenceLevel);
    if (!nullToAbsent || linkedFeatureIdsCsv != null) {
      map['linked_feature_ids_csv'] = Variable<String>(linkedFeatureIdsCsv);
    }
    return map;
  }

  EvidenceClaimCompanion toCompanion(bool nullToAbsent) {
    return EvidenceClaimCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      textTr: Value(textTr),
      textEn: Value(textEn),
      evidenceLevel: Value(evidenceLevel),
      linkedFeatureIdsCsv: linkedFeatureIdsCsv == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedFeatureIdsCsv),
    );
  }

  factory EvidenceClaimRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvidenceClaimRow(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      textTr: serializer.fromJson<String>(json['textTr']),
      textEn: serializer.fromJson<String>(json['textEn']),
      evidenceLevel: serializer.fromJson<String>(json['evidenceLevel']),
      linkedFeatureIdsCsv: serializer.fromJson<String?>(
        json['linkedFeatureIdsCsv'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceId': serializer.toJson<String>(sourceId),
      'textTr': serializer.toJson<String>(textTr),
      'textEn': serializer.toJson<String>(textEn),
      'evidenceLevel': serializer.toJson<String>(evidenceLevel),
      'linkedFeatureIdsCsv': serializer.toJson<String?>(linkedFeatureIdsCsv),
    };
  }

  EvidenceClaimRow copyWith({
    String? id,
    String? sourceId,
    String? textTr,
    String? textEn,
    String? evidenceLevel,
    Value<String?> linkedFeatureIdsCsv = const Value.absent(),
  }) => EvidenceClaimRow(
    id: id ?? this.id,
    sourceId: sourceId ?? this.sourceId,
    textTr: textTr ?? this.textTr,
    textEn: textEn ?? this.textEn,
    evidenceLevel: evidenceLevel ?? this.evidenceLevel,
    linkedFeatureIdsCsv: linkedFeatureIdsCsv.present
        ? linkedFeatureIdsCsv.value
        : this.linkedFeatureIdsCsv,
  );
  EvidenceClaimRow copyWithCompanion(EvidenceClaimCompanion data) {
    return EvidenceClaimRow(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      textTr: data.textTr.present ? data.textTr.value : this.textTr,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      evidenceLevel: data.evidenceLevel.present
          ? data.evidenceLevel.value
          : this.evidenceLevel,
      linkedFeatureIdsCsv: data.linkedFeatureIdsCsv.present
          ? data.linkedFeatureIdsCsv.value
          : this.linkedFeatureIdsCsv,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceClaimRow(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('textTr: $textTr, ')
          ..write('textEn: $textEn, ')
          ..write('evidenceLevel: $evidenceLevel, ')
          ..write('linkedFeatureIdsCsv: $linkedFeatureIdsCsv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceId,
    textTr,
    textEn,
    evidenceLevel,
    linkedFeatureIdsCsv,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvidenceClaimRow &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.textTr == this.textTr &&
          other.textEn == this.textEn &&
          other.evidenceLevel == this.evidenceLevel &&
          other.linkedFeatureIdsCsv == this.linkedFeatureIdsCsv);
}

class EvidenceClaimCompanion extends UpdateCompanion<EvidenceClaimRow> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<String> textTr;
  final Value<String> textEn;
  final Value<String> evidenceLevel;
  final Value<String?> linkedFeatureIdsCsv;
  final Value<int> rowid;
  const EvidenceClaimCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.textTr = const Value.absent(),
    this.textEn = const Value.absent(),
    this.evidenceLevel = const Value.absent(),
    this.linkedFeatureIdsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EvidenceClaimCompanion.insert({
    required String id,
    required String sourceId,
    required String textTr,
    required String textEn,
    required String evidenceLevel,
    this.linkedFeatureIdsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceId = Value(sourceId),
       textTr = Value(textTr),
       textEn = Value(textEn),
       evidenceLevel = Value(evidenceLevel);
  static Insertable<EvidenceClaimRow> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<String>? textTr,
    Expression<String>? textEn,
    Expression<String>? evidenceLevel,
    Expression<String>? linkedFeatureIdsCsv,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (textTr != null) 'text_tr': textTr,
      if (textEn != null) 'text_en': textEn,
      if (evidenceLevel != null) 'evidence_level': evidenceLevel,
      if (linkedFeatureIdsCsv != null)
        'linked_feature_ids_csv': linkedFeatureIdsCsv,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EvidenceClaimCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceId,
    Value<String>? textTr,
    Value<String>? textEn,
    Value<String>? evidenceLevel,
    Value<String?>? linkedFeatureIdsCsv,
    Value<int>? rowid,
  }) {
    return EvidenceClaimCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      textTr: textTr ?? this.textTr,
      textEn: textEn ?? this.textEn,
      evidenceLevel: evidenceLevel ?? this.evidenceLevel,
      linkedFeatureIdsCsv: linkedFeatureIdsCsv ?? this.linkedFeatureIdsCsv,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (textTr.present) {
      map['text_tr'] = Variable<String>(textTr.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (evidenceLevel.present) {
      map['evidence_level'] = Variable<String>(evidenceLevel.value);
    }
    if (linkedFeatureIdsCsv.present) {
      map['linked_feature_ids_csv'] = Variable<String>(
        linkedFeatureIdsCsv.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceClaimCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('textTr: $textTr, ')
          ..write('textEn: $textEn, ')
          ..write('evidenceLevel: $evidenceLevel, ')
          ..write('linkedFeatureIdsCsv: $linkedFeatureIdsCsv, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentVersionTable extends ContentVersion
    with TableInfo<$ContentVersionTable, ContentVersionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentVersionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releasedAtIsoMeta = const VerificationMeta(
    'releasedAtIso',
  );
  @override
  late final GeneratedColumn<String> releasedAtIso = GeneratedColumn<String>(
    'released_at_iso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeLogTrMeta = const VerificationMeta(
    'changeLogTr',
  );
  @override
  late final GeneratedColumn<String> changeLogTr = GeneratedColumn<String>(
    'change_log_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changeLogEnMeta = const VerificationMeta(
    'changeLogEn',
  );
  @override
  late final GeneratedColumn<String> changeLogEn = GeneratedColumn<String>(
    'change_log_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    version,
    releasedAtIso,
    changeLogTr,
    changeLogEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_version';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentVersionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('released_at_iso')) {
      context.handle(
        _releasedAtIsoMeta,
        releasedAtIso.isAcceptableOrUnknown(
          data['released_at_iso']!,
          _releasedAtIsoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releasedAtIsoMeta);
    }
    if (data.containsKey('change_log_tr')) {
      context.handle(
        _changeLogTrMeta,
        changeLogTr.isAcceptableOrUnknown(
          data['change_log_tr']!,
          _changeLogTrMeta,
        ),
      );
    }
    if (data.containsKey('change_log_en')) {
      context.handle(
        _changeLogEnMeta,
        changeLogEn.isAcceptableOrUnknown(
          data['change_log_en']!,
          _changeLogEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentVersionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentVersionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      releasedAtIso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}released_at_iso'],
      )!,
      changeLogTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_log_tr'],
      ),
      changeLogEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_log_en'],
      ),
    );
  }

  @override
  $ContentVersionTable createAlias(String alias) {
    return $ContentVersionTable(attachedDatabase, alias);
  }
}

class ContentVersionRow extends DataClass
    implements Insertable<ContentVersionRow> {
  final String id;
  final String version;
  final String releasedAtIso;
  final String? changeLogTr;
  final String? changeLogEn;
  const ContentVersionRow({
    required this.id,
    required this.version,
    required this.releasedAtIso,
    this.changeLogTr,
    this.changeLogEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['version'] = Variable<String>(version);
    map['released_at_iso'] = Variable<String>(releasedAtIso);
    if (!nullToAbsent || changeLogTr != null) {
      map['change_log_tr'] = Variable<String>(changeLogTr);
    }
    if (!nullToAbsent || changeLogEn != null) {
      map['change_log_en'] = Variable<String>(changeLogEn);
    }
    return map;
  }

  ContentVersionCompanion toCompanion(bool nullToAbsent) {
    return ContentVersionCompanion(
      id: Value(id),
      version: Value(version),
      releasedAtIso: Value(releasedAtIso),
      changeLogTr: changeLogTr == null && nullToAbsent
          ? const Value.absent()
          : Value(changeLogTr),
      changeLogEn: changeLogEn == null && nullToAbsent
          ? const Value.absent()
          : Value(changeLogEn),
    );
  }

  factory ContentVersionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentVersionRow(
      id: serializer.fromJson<String>(json['id']),
      version: serializer.fromJson<String>(json['version']),
      releasedAtIso: serializer.fromJson<String>(json['releasedAtIso']),
      changeLogTr: serializer.fromJson<String?>(json['changeLogTr']),
      changeLogEn: serializer.fromJson<String?>(json['changeLogEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'version': serializer.toJson<String>(version),
      'releasedAtIso': serializer.toJson<String>(releasedAtIso),
      'changeLogTr': serializer.toJson<String?>(changeLogTr),
      'changeLogEn': serializer.toJson<String?>(changeLogEn),
    };
  }

  ContentVersionRow copyWith({
    String? id,
    String? version,
    String? releasedAtIso,
    Value<String?> changeLogTr = const Value.absent(),
    Value<String?> changeLogEn = const Value.absent(),
  }) => ContentVersionRow(
    id: id ?? this.id,
    version: version ?? this.version,
    releasedAtIso: releasedAtIso ?? this.releasedAtIso,
    changeLogTr: changeLogTr.present ? changeLogTr.value : this.changeLogTr,
    changeLogEn: changeLogEn.present ? changeLogEn.value : this.changeLogEn,
  );
  ContentVersionRow copyWithCompanion(ContentVersionCompanion data) {
    return ContentVersionRow(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      releasedAtIso: data.releasedAtIso.present
          ? data.releasedAtIso.value
          : this.releasedAtIso,
      changeLogTr: data.changeLogTr.present
          ? data.changeLogTr.value
          : this.changeLogTr,
      changeLogEn: data.changeLogEn.present
          ? data.changeLogEn.value
          : this.changeLogEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentVersionRow(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('releasedAtIso: $releasedAtIso, ')
          ..write('changeLogTr: $changeLogTr, ')
          ..write('changeLogEn: $changeLogEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, version, releasedAtIso, changeLogTr, changeLogEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentVersionRow &&
          other.id == this.id &&
          other.version == this.version &&
          other.releasedAtIso == this.releasedAtIso &&
          other.changeLogTr == this.changeLogTr &&
          other.changeLogEn == this.changeLogEn);
}

class ContentVersionCompanion extends UpdateCompanion<ContentVersionRow> {
  final Value<String> id;
  final Value<String> version;
  final Value<String> releasedAtIso;
  final Value<String?> changeLogTr;
  final Value<String?> changeLogEn;
  final Value<int> rowid;
  const ContentVersionCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.releasedAtIso = const Value.absent(),
    this.changeLogTr = const Value.absent(),
    this.changeLogEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentVersionCompanion.insert({
    required String id,
    required String version,
    required String releasedAtIso,
    this.changeLogTr = const Value.absent(),
    this.changeLogEn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       releasedAtIso = Value(releasedAtIso);
  static Insertable<ContentVersionRow> custom({
    Expression<String>? id,
    Expression<String>? version,
    Expression<String>? releasedAtIso,
    Expression<String>? changeLogTr,
    Expression<String>? changeLogEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (releasedAtIso != null) 'released_at_iso': releasedAtIso,
      if (changeLogTr != null) 'change_log_tr': changeLogTr,
      if (changeLogEn != null) 'change_log_en': changeLogEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentVersionCompanion copyWith({
    Value<String>? id,
    Value<String>? version,
    Value<String>? releasedAtIso,
    Value<String?>? changeLogTr,
    Value<String?>? changeLogEn,
    Value<int>? rowid,
  }) {
    return ContentVersionCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      releasedAtIso: releasedAtIso ?? this.releasedAtIso,
      changeLogTr: changeLogTr ?? this.changeLogTr,
      changeLogEn: changeLogEn ?? this.changeLogEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (releasedAtIso.present) {
      map['released_at_iso'] = Variable<String>(releasedAtIso.value);
    }
    if (changeLogTr.present) {
      map['change_log_tr'] = Variable<String>(changeLogTr.value);
    }
    if (changeLogEn.present) {
      map['change_log_en'] = Variable<String>(changeLogEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentVersionCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('releasedAtIso: $releasedAtIso, ')
          ..write('changeLogTr: $changeLogTr, ')
          ..write('changeLogEn: $changeLogEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExportHistoryTable extends ExportHistory
    with TableInfo<$ExportHistoryTable, ExportHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExportHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exportedAtUtcMeta = const VerificationMeta(
    'exportedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> exportedAtUtc =
      GeneratedColumn<DateTime>(
        'exported_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordCountMeta = const VerificationMeta(
    'recordCount',
  );
  @override
  late final GeneratedColumn<int> recordCount = GeneratedColumn<int>(
    'record_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appVersionMeta = const VerificationMeta(
    'appVersion',
  );
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
    'app_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exportedAtUtc,
    format,
    recordCount,
    schemaVersion,
    appVersion,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'export_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExportHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exported_at_utc')) {
      context.handle(
        _exportedAtUtcMeta,
        exportedAtUtc.isAcceptableOrUnknown(
          data['exported_at_utc']!,
          _exportedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exportedAtUtcMeta);
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('record_count')) {
      context.handle(
        _recordCountMeta,
        recordCount.isAcceptableOrUnknown(
          data['record_count']!,
          _recordCountMeta,
        ),
      );
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
        _appVersionMeta,
        appVersion.isAcceptableOrUnknown(data['app_version']!, _appVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_appVersionMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExportHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExportHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exportedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exported_at_utc'],
      )!,
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      recordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_count'],
      ),
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      appVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_version'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ExportHistoryTable createAlias(String alias) {
    return $ExportHistoryTable(attachedDatabase, alias);
  }
}

class ExportHistoryRow extends DataClass
    implements Insertable<ExportHistoryRow> {
  final int id;
  final DateTime exportedAtUtc;
  final String format;
  final int? recordCount;
  final int schemaVersion;
  final String appVersion;
  final String? note;
  const ExportHistoryRow({
    required this.id,
    required this.exportedAtUtc,
    required this.format,
    this.recordCount,
    required this.schemaVersion,
    required this.appVersion,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exported_at_utc'] = Variable<DateTime>(exportedAtUtc);
    map['format'] = Variable<String>(format);
    if (!nullToAbsent || recordCount != null) {
      map['record_count'] = Variable<int>(recordCount);
    }
    map['schema_version'] = Variable<int>(schemaVersion);
    map['app_version'] = Variable<String>(appVersion);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ExportHistoryCompanion toCompanion(bool nullToAbsent) {
    return ExportHistoryCompanion(
      id: Value(id),
      exportedAtUtc: Value(exportedAtUtc),
      format: Value(format),
      recordCount: recordCount == null && nullToAbsent
          ? const Value.absent()
          : Value(recordCount),
      schemaVersion: Value(schemaVersion),
      appVersion: Value(appVersion),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ExportHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExportHistoryRow(
      id: serializer.fromJson<int>(json['id']),
      exportedAtUtc: serializer.fromJson<DateTime>(json['exportedAtUtc']),
      format: serializer.fromJson<String>(json['format']),
      recordCount: serializer.fromJson<int?>(json['recordCount']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      appVersion: serializer.fromJson<String>(json['appVersion']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exportedAtUtc': serializer.toJson<DateTime>(exportedAtUtc),
      'format': serializer.toJson<String>(format),
      'recordCount': serializer.toJson<int?>(recordCount),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'appVersion': serializer.toJson<String>(appVersion),
      'note': serializer.toJson<String?>(note),
    };
  }

  ExportHistoryRow copyWith({
    int? id,
    DateTime? exportedAtUtc,
    String? format,
    Value<int?> recordCount = const Value.absent(),
    int? schemaVersion,
    String? appVersion,
    Value<String?> note = const Value.absent(),
  }) => ExportHistoryRow(
    id: id ?? this.id,
    exportedAtUtc: exportedAtUtc ?? this.exportedAtUtc,
    format: format ?? this.format,
    recordCount: recordCount.present ? recordCount.value : this.recordCount,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    appVersion: appVersion ?? this.appVersion,
    note: note.present ? note.value : this.note,
  );
  ExportHistoryRow copyWithCompanion(ExportHistoryCompanion data) {
    return ExportHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      exportedAtUtc: data.exportedAtUtc.present
          ? data.exportedAtUtc.value
          : this.exportedAtUtc,
      format: data.format.present ? data.format.value : this.format,
      recordCount: data.recordCount.present
          ? data.recordCount.value
          : this.recordCount,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      appVersion: data.appVersion.present
          ? data.appVersion.value
          : this.appVersion,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExportHistoryRow(')
          ..write('id: $id, ')
          ..write('exportedAtUtc: $exportedAtUtc, ')
          ..write('format: $format, ')
          ..write('recordCount: $recordCount, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('appVersion: $appVersion, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exportedAtUtc,
    format,
    recordCount,
    schemaVersion,
    appVersion,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExportHistoryRow &&
          other.id == this.id &&
          other.exportedAtUtc == this.exportedAtUtc &&
          other.format == this.format &&
          other.recordCount == this.recordCount &&
          other.schemaVersion == this.schemaVersion &&
          other.appVersion == this.appVersion &&
          other.note == this.note);
}

class ExportHistoryCompanion extends UpdateCompanion<ExportHistoryRow> {
  final Value<int> id;
  final Value<DateTime> exportedAtUtc;
  final Value<String> format;
  final Value<int?> recordCount;
  final Value<int> schemaVersion;
  final Value<String> appVersion;
  final Value<String?> note;
  const ExportHistoryCompanion({
    this.id = const Value.absent(),
    this.exportedAtUtc = const Value.absent(),
    this.format = const Value.absent(),
    this.recordCount = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.note = const Value.absent(),
  });
  ExportHistoryCompanion.insert({
    this.id = const Value.absent(),
    required DateTime exportedAtUtc,
    required String format,
    this.recordCount = const Value.absent(),
    required int schemaVersion,
    required String appVersion,
    this.note = const Value.absent(),
  }) : exportedAtUtc = Value(exportedAtUtc),
       format = Value(format),
       schemaVersion = Value(schemaVersion),
       appVersion = Value(appVersion);
  static Insertable<ExportHistoryRow> custom({
    Expression<int>? id,
    Expression<DateTime>? exportedAtUtc,
    Expression<String>? format,
    Expression<int>? recordCount,
    Expression<int>? schemaVersion,
    Expression<String>? appVersion,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exportedAtUtc != null) 'exported_at_utc': exportedAtUtc,
      if (format != null) 'format': format,
      if (recordCount != null) 'record_count': recordCount,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (appVersion != null) 'app_version': appVersion,
      if (note != null) 'note': note,
    });
  }

  ExportHistoryCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? exportedAtUtc,
    Value<String>? format,
    Value<int?>? recordCount,
    Value<int>? schemaVersion,
    Value<String>? appVersion,
    Value<String?>? note,
  }) {
    return ExportHistoryCompanion(
      id: id ?? this.id,
      exportedAtUtc: exportedAtUtc ?? this.exportedAtUtc,
      format: format ?? this.format,
      recordCount: recordCount ?? this.recordCount,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      appVersion: appVersion ?? this.appVersion,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exportedAtUtc.present) {
      map['exported_at_utc'] = Variable<DateTime>(exportedAtUtc.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (recordCount.present) {
      map['record_count'] = Variable<int>(recordCount.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExportHistoryCompanion(')
          ..write('id: $id, ')
          ..write('exportedAtUtc: $exportedAtUtc, ')
          ..write('format: $format, ')
          ..write('recordCount: $recordCount, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('appVersion: $appVersion, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $ConsentRecordsTable consentRecords = $ConsentRecordsTable(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $RiskScreeningTable riskScreening = $RiskScreeningTable(this);
  late final $EnergyEstimateTable energyEstimate = $EnergyEstimateTable(this);
  late final $GoalTable goal = $GoalTable(this);
  late final $FoodTable food = $FoodTable(this);
  late final $ServingOptionTable servingOption = $ServingOptionTable(this);
  late final $RecipeTable recipe = $RecipeTable(this);
  late final $RecipeIngredientTable recipeIngredient = $RecipeIngredientTable(
    this,
  );
  late final $MealTable meal = $MealTable(this);
  late final $MealItemTable mealItem = $MealItemTable(this);
  late final $GlucoseMeasurementTable glucoseMeasurement =
      $GlucoseMeasurementTable(this);
  late final $KetoneMeasurementTable ketoneMeasurement =
      $KetoneMeasurementTable(this);
  late final $MeasurementSessionTable measurementSession =
      $MeasurementSessionTable(this);
  late final $WeightEntryTable weightEntry = $WeightEntryTable(this);
  late final $SymptomDefinitionTable symptomDefinition =
      $SymptomDefinitionTable(this);
  late final $SymptomEntryTable symptomEntry = $SymptomEntryTable(this);
  late final $ContextTagTable contextTag = $ContextTagTable(this);
  late final $MealPlanTable mealPlan = $MealPlanTable(this);
  late final $MealPlanEntryTable mealPlanEntry = $MealPlanEntryTable(this);
  late final $ShoppingListTable shoppingList = $ShoppingListTable(this);
  late final $ShoppingListItemTable shoppingListItem = $ShoppingListItemTable(
    this,
  );
  late final $EvidenceSourceTable evidenceSource = $EvidenceSourceTable(this);
  late final $EvidenceClaimTable evidenceClaim = $EvidenceClaimTable(this);
  late final $ContentVersionTable contentVersion = $ContentVersionTable(this);
  late final $ExportHistoryTable exportHistory = $ExportHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettings,
    consentRecords,
    userProfile,
    riskScreening,
    energyEstimate,
    goal,
    food,
    servingOption,
    recipe,
    recipeIngredient,
    meal,
    mealItem,
    glucoseMeasurement,
    ketoneMeasurement,
    measurementSession,
    weightEntry,
    symptomDefinition,
    symptomEntry,
    contextTag,
    mealPlan,
    mealPlanEntry,
    shoppingList,
    shoppingListItem,
    evidenceSource,
    evidenceClaim,
    contentVersion,
    exportHistory,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_profile',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('energy_estimate', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'food',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('serving_option', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipe',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredient', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_item', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'glucose_measurement',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('measurement_session', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ketone_measurement',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('measurement_session', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_plan',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_plan_entry', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shopping_list',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shopping_list_item', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'evidence_source',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('evidence_claim', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> languageCode,
      Value<String?> themeMode,
      Value<String> preferredCarbType,
      Value<int> matchingWindowMinutes,
      Value<bool> onboardingCompleted,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String?> languageCode,
      Value<String?> themeMode,
      Value<String> preferredCarbType,
      Value<int> matchingWindowMinutes,
      Value<bool> onboardingCompleted,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredCarbType => $composableBuilder(
    column: $table.preferredCarbType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchingWindowMinutes => $composableBuilder(
    column: $table.matchingWindowMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredCarbType => $composableBuilder(
    column: $table.preferredCarbType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchingWindowMinutes => $composableBuilder(
    column: $table.matchingWindowMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get preferredCarbType => $composableBuilder(
    column: $table.preferredCarbType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get matchingWindowMinutes => $composableBuilder(
    column: $table.matchingWindowMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingsRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingsRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingsRow>,
          ),
          AppSettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
                Value<String?> themeMode = const Value.absent(),
                Value<String> preferredCarbType = const Value.absent(),
                Value<int> matchingWindowMinutes = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                languageCode: languageCode,
                themeMode: themeMode,
                preferredCarbType: preferredCarbType,
                matchingWindowMinutes: matchingWindowMinutes,
                onboardingCompleted: onboardingCompleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
                Value<String?> themeMode = const Value.absent(),
                Value<String> preferredCarbType = const Value.absent(),
                Value<int> matchingWindowMinutes = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                languageCode: languageCode,
                themeMode: themeMode,
                preferredCarbType: preferredCarbType,
                matchingWindowMinutes: matchingWindowMinutes,
                onboardingCompleted: onboardingCompleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSettingsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTable,
                    AppSettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingsRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingsRow>,
      ),
      AppSettingsRow,
      PrefetchHooks Function()
    >;
typedef $$ConsentRecordsTableCreateCompanionBuilder =
    ConsentRecordsCompanion Function({
      Value<int> id,
      required String consentVersion,
      required String languageCode,
      required DateTime acceptedAtUtc,
      required String textSha256,
    });
typedef $$ConsentRecordsTableUpdateCompanionBuilder =
    ConsentRecordsCompanion Function({
      Value<int> id,
      Value<String> consentVersion,
      Value<String> languageCode,
      Value<DateTime> acceptedAtUtc,
      Value<String> textSha256,
    });

class $$ConsentRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ConsentRecordsTable> {
  $$ConsentRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get consentVersion => $composableBuilder(
    column: $table.consentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acceptedAtUtc => $composableBuilder(
    column: $table.acceptedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textSha256 => $composableBuilder(
    column: $table.textSha256,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConsentRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsentRecordsTable> {
  $$ConsentRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get consentVersion => $composableBuilder(
    column: $table.consentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acceptedAtUtc => $composableBuilder(
    column: $table.acceptedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textSha256 => $composableBuilder(
    column: $table.textSha256,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConsentRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsentRecordsTable> {
  $$ConsentRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get consentVersion => $composableBuilder(
    column: $table.consentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acceptedAtUtc => $composableBuilder(
    column: $table.acceptedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textSha256 => $composableBuilder(
    column: $table.textSha256,
    builder: (column) => column,
  );
}

class $$ConsentRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsentRecordsTable,
          ConsentRecordsRow,
          $$ConsentRecordsTableFilterComposer,
          $$ConsentRecordsTableOrderingComposer,
          $$ConsentRecordsTableAnnotationComposer,
          $$ConsentRecordsTableCreateCompanionBuilder,
          $$ConsentRecordsTableUpdateCompanionBuilder,
          (
            ConsentRecordsRow,
            BaseReferences<
              _$AppDatabase,
              $ConsentRecordsTable,
              ConsentRecordsRow
            >,
          ),
          ConsentRecordsRow,
          PrefetchHooks Function()
        > {
  $$ConsentRecordsTableTableManager(
    _$AppDatabase db,
    $ConsentRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsentRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsentRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsentRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> consentVersion = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<DateTime> acceptedAtUtc = const Value.absent(),
                Value<String> textSha256 = const Value.absent(),
              }) => ConsentRecordsCompanion(
                id: id,
                consentVersion: consentVersion,
                languageCode: languageCode,
                acceptedAtUtc: acceptedAtUtc,
                textSha256: textSha256,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String consentVersion,
                required String languageCode,
                required DateTime acceptedAtUtc,
                required String textSha256,
              }) => ConsentRecordsCompanion.insert(
                id: id,
                consentVersion: consentVersion,
                languageCode: languageCode,
                acceptedAtUtc: acceptedAtUtc,
                textSha256: textSha256,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ConsentRecordsTable, ConsentRecordsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ConsentRecordsTable,
                    ConsentRecordsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConsentRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsentRecordsTable,
      ConsentRecordsRow,
      $$ConsentRecordsTableFilterComposer,
      $$ConsentRecordsTableOrderingComposer,
      $$ConsentRecordsTableAnnotationComposer,
      $$ConsentRecordsTableCreateCompanionBuilder,
      $$ConsentRecordsTableUpdateCompanionBuilder,
      (
        ConsentRecordsRow,
        BaseReferences<_$AppDatabase, $ConsentRecordsTable, ConsentRecordsRow>,
      ),
      ConsentRecordsRow,
      PrefetchHooks Function()
    >;
typedef $$UserProfileTableCreateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      Value<int?> birthYear,
      Value<double?> heightCm,
      Value<double?> currentWeightKg,
      Value<String?> activityLevel,
      Value<String?> energyCoefficient,
      required DateTime createdAtUtc,
      required DateTime updatedAtUtc,
    });
typedef $$UserProfileTableUpdateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      Value<int?> birthYear,
      Value<double?> heightCm,
      Value<double?> currentWeightKg,
      Value<String?> activityLevel,
      Value<String?> energyCoefficient,
      Value<DateTime> createdAtUtc,
      Value<DateTime> updatedAtUtc,
    });

final class $$UserProfileTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileRow> {
  $$UserProfileTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EnergyEstimateTable, List<EnergyEstimateRow>>
  _energyEstimateRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.energyEstimate,
    aliasName: 'user_profile__id__energy_estimate__user_profile_id',
  );

  $$EnergyEstimateTableProcessedTableManager get energyEstimateRefs {
    final manager = $$EnergyEstimateTableTableManager(
      $_db,
      $_db.energyEstimate,
    ).filter((f) => f.userProfileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_energyEstimateRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserProfileTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentWeightKg => $composableBuilder(
    column: $table.currentWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyCoefficient => $composableBuilder(
    column: $table.energyCoefficient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> energyEstimateRefs(
    Expression<bool> Function($$EnergyEstimateTableFilterComposer f) f,
  ) {
    final $$EnergyEstimateTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyEstimate,
      getReferencedColumn: (t) => t.userProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyEstimateTableFilterComposer(
            $db: $db,
            $table: $db.energyEstimate,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthYear => $composableBuilder(
    column: $table.birthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentWeightKg => $composableBuilder(
    column: $table.currentWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyCoefficient => $composableBuilder(
    column: $table.energyCoefficient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get currentWeightKg => $composableBuilder(
    column: $table.currentWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get energyCoefficient => $composableBuilder(
    column: $table.energyCoefficient,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => column,
  );

  Expression<T> energyEstimateRefs<T extends Object>(
    Expression<T> Function($$EnergyEstimateTableAnnotationComposer a) f,
  ) {
    final $$EnergyEstimateTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyEstimate,
      getReferencedColumn: (t) => t.userProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyEstimateTableAnnotationComposer(
            $db: $db,
            $table: $db.energyEstimate,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfileTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTable,
          UserProfileRow,
          $$UserProfileTableFilterComposer,
          $$UserProfileTableOrderingComposer,
          $$UserProfileTableAnnotationComposer,
          $$UserProfileTableCreateCompanionBuilder,
          $$UserProfileTableUpdateCompanionBuilder,
          (UserProfileRow, $$UserProfileTableReferences),
          UserProfileRow,
          PrefetchHooks Function({bool energyEstimateRefs})
        > {
  $$UserProfileTableTableManager(_$AppDatabase db, $UserProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> birthYear = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> currentWeightKg = const Value.absent(),
                Value<String?> activityLevel = const Value.absent(),
                Value<String?> energyCoefficient = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<DateTime> updatedAtUtc = const Value.absent(),
              }) => UserProfileCompanion(
                id: id,
                birthYear: birthYear,
                heightCm: heightCm,
                currentWeightKg: currentWeightKg,
                activityLevel: activityLevel,
                energyCoefficient: energyCoefficient,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> birthYear = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> currentWeightKg = const Value.absent(),
                Value<String?> activityLevel = const Value.absent(),
                Value<String?> energyCoefficient = const Value.absent(),
                required DateTime createdAtUtc,
                required DateTime updatedAtUtc,
              }) => UserProfileCompanion.insert(
                id: id,
                birthYear: birthYear,
                heightCm: heightCm,
                currentWeightKg: currentWeightKg,
                activityLevel: activityLevel,
                energyCoefficient: energyCoefficient,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfileTable, UserProfileRow>(table),
                  $$UserProfileTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({energyEstimateRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (energyEstimateRefs) db.energyEstimate,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (energyEstimateRefs)
                    await $_getPrefetchedData<
                      UserProfileRow,
                      $UserProfileTable,
                      EnergyEstimateRow
                    >(
                      currentTable: table,
                      referencedTable: $$UserProfileTableReferences
                          ._energyEstimateRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UserProfileTableReferences(
                            db,
                            table,
                            p0,
                          ).energyEstimateRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.userProfileId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTable,
      UserProfileRow,
      $$UserProfileTableFilterComposer,
      $$UserProfileTableOrderingComposer,
      $$UserProfileTableAnnotationComposer,
      $$UserProfileTableCreateCompanionBuilder,
      $$UserProfileTableUpdateCompanionBuilder,
      (UserProfileRow, $$UserProfileTableReferences),
      UserProfileRow,
      PrefetchHooks Function({bool energyEstimateRefs})
    >;
typedef $$RiskScreeningTableCreateCompanionBuilder =
    RiskScreeningCompanion Function({
      Value<int> id,
      required DateTime screenedAtUtc,
      required bool hasDiabetes,
      required bool usesGlucoseLoweringMedication,
      required bool pregnantOrBreastfeeding,
      required bool kidneyLiverPancreasDisease,
      required bool eatingDisorderHistory,
      required bool unintentionalWeightLoss,
      required bool under18,
      Value<String?> note,
    });
typedef $$RiskScreeningTableUpdateCompanionBuilder =
    RiskScreeningCompanion Function({
      Value<int> id,
      Value<DateTime> screenedAtUtc,
      Value<bool> hasDiabetes,
      Value<bool> usesGlucoseLoweringMedication,
      Value<bool> pregnantOrBreastfeeding,
      Value<bool> kidneyLiverPancreasDisease,
      Value<bool> eatingDisorderHistory,
      Value<bool> unintentionalWeightLoss,
      Value<bool> under18,
      Value<String?> note,
    });

class $$RiskScreeningTableFilterComposer
    extends Composer<_$AppDatabase, $RiskScreeningTable> {
  $$RiskScreeningTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get screenedAtUtc => $composableBuilder(
    column: $table.screenedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasDiabetes => $composableBuilder(
    column: $table.hasDiabetes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get usesGlucoseLoweringMedication => $composableBuilder(
    column: $table.usesGlucoseLoweringMedication,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pregnantOrBreastfeeding => $composableBuilder(
    column: $table.pregnantOrBreastfeeding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get kidneyLiverPancreasDisease => $composableBuilder(
    column: $table.kidneyLiverPancreasDisease,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get eatingDisorderHistory => $composableBuilder(
    column: $table.eatingDisorderHistory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unintentionalWeightLoss => $composableBuilder(
    column: $table.unintentionalWeightLoss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get under18 => $composableBuilder(
    column: $table.under18,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RiskScreeningTableOrderingComposer
    extends Composer<_$AppDatabase, $RiskScreeningTable> {
  $$RiskScreeningTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get screenedAtUtc => $composableBuilder(
    column: $table.screenedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasDiabetes => $composableBuilder(
    column: $table.hasDiabetes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get usesGlucoseLoweringMedication => $composableBuilder(
    column: $table.usesGlucoseLoweringMedication,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pregnantOrBreastfeeding => $composableBuilder(
    column: $table.pregnantOrBreastfeeding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get kidneyLiverPancreasDisease => $composableBuilder(
    column: $table.kidneyLiverPancreasDisease,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get eatingDisorderHistory => $composableBuilder(
    column: $table.eatingDisorderHistory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unintentionalWeightLoss => $composableBuilder(
    column: $table.unintentionalWeightLoss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get under18 => $composableBuilder(
    column: $table.under18,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RiskScreeningTableAnnotationComposer
    extends Composer<_$AppDatabase, $RiskScreeningTable> {
  $$RiskScreeningTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get screenedAtUtc => $composableBuilder(
    column: $table.screenedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasDiabetes => $composableBuilder(
    column: $table.hasDiabetes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get usesGlucoseLoweringMedication => $composableBuilder(
    column: $table.usesGlucoseLoweringMedication,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pregnantOrBreastfeeding => $composableBuilder(
    column: $table.pregnantOrBreastfeeding,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get kidneyLiverPancreasDisease => $composableBuilder(
    column: $table.kidneyLiverPancreasDisease,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get eatingDisorderHistory => $composableBuilder(
    column: $table.eatingDisorderHistory,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get unintentionalWeightLoss => $composableBuilder(
    column: $table.unintentionalWeightLoss,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get under18 =>
      $composableBuilder(column: $table.under18, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$RiskScreeningTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RiskScreeningTable,
          RiskScreeningRow,
          $$RiskScreeningTableFilterComposer,
          $$RiskScreeningTableOrderingComposer,
          $$RiskScreeningTableAnnotationComposer,
          $$RiskScreeningTableCreateCompanionBuilder,
          $$RiskScreeningTableUpdateCompanionBuilder,
          (
            RiskScreeningRow,
            BaseReferences<
              _$AppDatabase,
              $RiskScreeningTable,
              RiskScreeningRow
            >,
          ),
          RiskScreeningRow,
          PrefetchHooks Function()
        > {
  $$RiskScreeningTableTableManager(_$AppDatabase db, $RiskScreeningTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RiskScreeningTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RiskScreeningTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RiskScreeningTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> screenedAtUtc = const Value.absent(),
                Value<bool> hasDiabetes = const Value.absent(),
                Value<bool> usesGlucoseLoweringMedication =
                    const Value.absent(),
                Value<bool> pregnantOrBreastfeeding = const Value.absent(),
                Value<bool> kidneyLiverPancreasDisease = const Value.absent(),
                Value<bool> eatingDisorderHistory = const Value.absent(),
                Value<bool> unintentionalWeightLoss = const Value.absent(),
                Value<bool> under18 = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => RiskScreeningCompanion(
                id: id,
                screenedAtUtc: screenedAtUtc,
                hasDiabetes: hasDiabetes,
                usesGlucoseLoweringMedication: usesGlucoseLoweringMedication,
                pregnantOrBreastfeeding: pregnantOrBreastfeeding,
                kidneyLiverPancreasDisease: kidneyLiverPancreasDisease,
                eatingDisorderHistory: eatingDisorderHistory,
                unintentionalWeightLoss: unintentionalWeightLoss,
                under18: under18,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime screenedAtUtc,
                required bool hasDiabetes,
                required bool usesGlucoseLoweringMedication,
                required bool pregnantOrBreastfeeding,
                required bool kidneyLiverPancreasDisease,
                required bool eatingDisorderHistory,
                required bool unintentionalWeightLoss,
                required bool under18,
                Value<String?> note = const Value.absent(),
              }) => RiskScreeningCompanion.insert(
                id: id,
                screenedAtUtc: screenedAtUtc,
                hasDiabetes: hasDiabetes,
                usesGlucoseLoweringMedication: usesGlucoseLoweringMedication,
                pregnantOrBreastfeeding: pregnantOrBreastfeeding,
                kidneyLiverPancreasDisease: kidneyLiverPancreasDisease,
                eatingDisorderHistory: eatingDisorderHistory,
                unintentionalWeightLoss: unintentionalWeightLoss,
                under18: under18,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RiskScreeningTable, RiskScreeningRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $RiskScreeningTable,
                    RiskScreeningRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RiskScreeningTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RiskScreeningTable,
      RiskScreeningRow,
      $$RiskScreeningTableFilterComposer,
      $$RiskScreeningTableOrderingComposer,
      $$RiskScreeningTableAnnotationComposer,
      $$RiskScreeningTableCreateCompanionBuilder,
      $$RiskScreeningTableUpdateCompanionBuilder,
      (
        RiskScreeningRow,
        BaseReferences<_$AppDatabase, $RiskScreeningTable, RiskScreeningRow>,
      ),
      RiskScreeningRow,
      PrefetchHooks Function()
    >;
typedef $$EnergyEstimateTableCreateCompanionBuilder =
    EnergyEstimateCompanion Function({
      Value<int> id,
      required int userProfileId,
      required double reeKcal,
      required double tdeeKcal,
      required String formulaVersion,
      required String inputsJson,
      required DateTime computedAtUtc,
    });
typedef $$EnergyEstimateTableUpdateCompanionBuilder =
    EnergyEstimateCompanion Function({
      Value<int> id,
      Value<int> userProfileId,
      Value<double> reeKcal,
      Value<double> tdeeKcal,
      Value<String> formulaVersion,
      Value<String> inputsJson,
      Value<DateTime> computedAtUtc,
    });

final class $$EnergyEstimateTableReferences
    extends
        BaseReferences<_$AppDatabase, $EnergyEstimateTable, EnergyEstimateRow> {
  $$EnergyEstimateTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfileTable _userProfileIdTable(_$AppDatabase db) => db
      .userProfile
      .createAlias('energy_estimate__user_profile_id__user_profile__id');

  $$UserProfileTableProcessedTableManager get userProfileId {
    final $_column = $_itemColumn<int>('user_profile_id')!;

    final manager = $$UserProfileTableTableManager(
      $_db,
      $_db.userProfile,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EnergyEstimateTableFilterComposer
    extends Composer<_$AppDatabase, $EnergyEstimateTable> {
  $$EnergyEstimateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reeKcal => $composableBuilder(
    column: $table.reeKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tdeeKcal => $composableBuilder(
    column: $table.tdeeKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inputsJson => $composableBuilder(
    column: $table.inputsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfileTableFilterComposer get userProfileId {
    final $$UserProfileTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userProfileId,
      referencedTable: $db.userProfile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfileTableFilterComposer(
            $db: $db,
            $table: $db.userProfile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyEstimateTableOrderingComposer
    extends Composer<_$AppDatabase, $EnergyEstimateTable> {
  $$EnergyEstimateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reeKcal => $composableBuilder(
    column: $table.reeKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tdeeKcal => $composableBuilder(
    column: $table.tdeeKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inputsJson => $composableBuilder(
    column: $table.inputsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfileTableOrderingComposer get userProfileId {
    final $$UserProfileTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userProfileId,
      referencedTable: $db.userProfile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfileTableOrderingComposer(
            $db: $db,
            $table: $db.userProfile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyEstimateTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnergyEstimateTable> {
  $$EnergyEstimateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get reeKcal =>
      $composableBuilder(column: $table.reeKcal, builder: (column) => column);

  GeneratedColumn<double> get tdeeKcal =>
      $composableBuilder(column: $table.tdeeKcal, builder: (column) => column);

  GeneratedColumn<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inputsJson => $composableBuilder(
    column: $table.inputsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => column,
  );

  $$UserProfileTableAnnotationComposer get userProfileId {
    final $$UserProfileTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userProfileId,
      referencedTable: $db.userProfile,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfileTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfile,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyEstimateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnergyEstimateTable,
          EnergyEstimateRow,
          $$EnergyEstimateTableFilterComposer,
          $$EnergyEstimateTableOrderingComposer,
          $$EnergyEstimateTableAnnotationComposer,
          $$EnergyEstimateTableCreateCompanionBuilder,
          $$EnergyEstimateTableUpdateCompanionBuilder,
          (EnergyEstimateRow, $$EnergyEstimateTableReferences),
          EnergyEstimateRow,
          PrefetchHooks Function({bool userProfileId})
        > {
  $$EnergyEstimateTableTableManager(
    _$AppDatabase db,
    $EnergyEstimateTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnergyEstimateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnergyEstimateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnergyEstimateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userProfileId = const Value.absent(),
                Value<double> reeKcal = const Value.absent(),
                Value<double> tdeeKcal = const Value.absent(),
                Value<String> formulaVersion = const Value.absent(),
                Value<String> inputsJson = const Value.absent(),
                Value<DateTime> computedAtUtc = const Value.absent(),
              }) => EnergyEstimateCompanion(
                id: id,
                userProfileId: userProfileId,
                reeKcal: reeKcal,
                tdeeKcal: tdeeKcal,
                formulaVersion: formulaVersion,
                inputsJson: inputsJson,
                computedAtUtc: computedAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userProfileId,
                required double reeKcal,
                required double tdeeKcal,
                required String formulaVersion,
                required String inputsJson,
                required DateTime computedAtUtc,
              }) => EnergyEstimateCompanion.insert(
                id: id,
                userProfileId: userProfileId,
                reeKcal: reeKcal,
                tdeeKcal: tdeeKcal,
                formulaVersion: formulaVersion,
                inputsJson: inputsJson,
                computedAtUtc: computedAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EnergyEstimateTable, EnergyEstimateRow>(table),
                  $$EnergyEstimateTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userProfileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userProfileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userProfileId,
                        referencedTable: $$EnergyEstimateTableReferences
                            ._userProfileIdTable(db),
                        referencedColumn: $$EnergyEstimateTableReferences
                            ._userProfileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EnergyEstimateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnergyEstimateTable,
      EnergyEstimateRow,
      $$EnergyEstimateTableFilterComposer,
      $$EnergyEstimateTableOrderingComposer,
      $$EnergyEstimateTableAnnotationComposer,
      $$EnergyEstimateTableCreateCompanionBuilder,
      $$EnergyEstimateTableUpdateCompanionBuilder,
      (EnergyEstimateRow, $$EnergyEstimateTableReferences),
      EnergyEstimateRow,
      PrefetchHooks Function({bool userProfileId})
    >;
typedef $$GoalTableCreateCompanionBuilder = GoalCompanion Function({
  Value<int> id,
  required String goalType,
  required String metric,
  required double targetValue,
  Value<double?> rangeLow,
  Value<double?> rangeHigh,
  Value<String?> sourceEvidenceId,
  Value<String?> clinicianName,
  Value<String?> clinicianGivenAtIso,
  Value<String?> personalNote,
  Value<bool> isActive,
  required DateTime createdAtUtc,
});
typedef $$GoalTableUpdateCompanionBuilder = GoalCompanion Function({
  Value<int> id,
  Value<String> goalType,
  Value<String> metric,
  Value<double> targetValue,
  Value<double?> rangeLow,
  Value<double?> rangeHigh,
  Value<String?> sourceEvidenceId,
  Value<String?> clinicianName,
  Value<String?> clinicianGivenAtIso,
  Value<String?> personalNote,
  Value<bool> isActive,
  Value<DateTime> createdAtUtc,
});

class $$GoalTableFilterComposer extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rangeLow => $composableBuilder(
    column: $table.rangeLow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rangeHigh => $composableBuilder(
    column: $table.rangeHigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceEvidenceId => $composableBuilder(
    column: $table.sourceEvidenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicianName => $composableBuilder(
    column: $table.clinicianName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicianGivenAtIso => $composableBuilder(
    column: $table.clinicianGivenAtIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalTableOrderingComposer extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rangeLow => $composableBuilder(
    column: $table.rangeLow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rangeHigh => $composableBuilder(
    column: $table.rangeHigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceEvidenceId => $composableBuilder(
    column: $table.sourceEvidenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicianName => $composableBuilder(
    column: $table.clinicianName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicianGivenAtIso => $composableBuilder(
    column: $table.clinicianGivenAtIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rangeLow =>
      $composableBuilder(column: $table.rangeLow, builder: (column) => column);

  GeneratedColumn<double> get rangeHigh =>
      $composableBuilder(column: $table.rangeHigh, builder: (column) => column);

  GeneratedColumn<String> get sourceEvidenceId => $composableBuilder(
    column: $table.sourceEvidenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicianName => $composableBuilder(
    column: $table.clinicianName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicianGivenAtIso => $composableBuilder(
    column: $table.clinicianGivenAtIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalNote => $composableBuilder(
    column: $table.personalNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );
}

class $$GoalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalTable,
          GoalRow,
          $$GoalTableFilterComposer,
          $$GoalTableOrderingComposer,
          $$GoalTableAnnotationComposer,
          $$GoalTableCreateCompanionBuilder,
          $$GoalTableUpdateCompanionBuilder,
          (GoalRow, BaseReferences<_$AppDatabase, $GoalTable, GoalRow>),
          GoalRow,
          PrefetchHooks Function()
        > {
  $$GoalTableTableManager(_$AppDatabase db, $GoalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> goalType = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<double?> rangeLow = const Value.absent(),
                Value<double?> rangeHigh = const Value.absent(),
                Value<String?> sourceEvidenceId = const Value.absent(),
                Value<String?> clinicianName = const Value.absent(),
                Value<String?> clinicianGivenAtIso = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
              }) => GoalCompanion(
                id: id,
                goalType: goalType,
                metric: metric,
                targetValue: targetValue,
                rangeLow: rangeLow,
                rangeHigh: rangeHigh,
                sourceEvidenceId: sourceEvidenceId,
                clinicianName: clinicianName,
                clinicianGivenAtIso: clinicianGivenAtIso,
                personalNote: personalNote,
                isActive: isActive,
                createdAtUtc: createdAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String goalType,
                required String metric,
                required double targetValue,
                Value<double?> rangeLow = const Value.absent(),
                Value<double?> rangeHigh = const Value.absent(),
                Value<String?> sourceEvidenceId = const Value.absent(),
                Value<String?> clinicianName = const Value.absent(),
                Value<String?> clinicianGivenAtIso = const Value.absent(),
                Value<String?> personalNote = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAtUtc,
              }) => GoalCompanion.insert(
                id: id,
                goalType: goalType,
                metric: metric,
                targetValue: targetValue,
                rangeLow: rangeLow,
                rangeHigh: rangeHigh,
                sourceEvidenceId: sourceEvidenceId,
                clinicianName: clinicianName,
                clinicianGivenAtIso: clinicianGivenAtIso,
                personalNote: personalNote,
                isActive: isActive,
                createdAtUtc: createdAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalTable, GoalRow>(table),
                  BaseReferences<_$AppDatabase, $GoalTable, GoalRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalTable,
      GoalRow,
      $$GoalTableFilterComposer,
      $$GoalTableOrderingComposer,
      $$GoalTableAnnotationComposer,
      $$GoalTableCreateCompanionBuilder,
      $$GoalTableUpdateCompanionBuilder,
      (GoalRow, BaseReferences<_$AppDatabase, $GoalTable, GoalRow>),
      GoalRow,
      PrefetchHooks Function()
    >;
typedef $$FoodTableCreateCompanionBuilder = FoodCompanion Function({
  required String id,
  required String canonicalName,
  Value<String?> nameTr,
  Value<String?> nameEn,
  required String category,
  required double kcalPer100g,
  required double proteinGPer100g,
  required double fatGPer100g,
  required double carbohydrateTotalGPer100g,
  Value<double> fiberGPer100g,
  required double netCarbGPer100g,
  required String dataSource,
  Value<String?> sourceVersion,
  Value<String?> sourceRecordId,
  Value<String?> license,
  Value<String?> lastReviewedAtIso,
  Value<bool> isUserCreated,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$FoodTableUpdateCompanionBuilder = FoodCompanion Function({
  Value<String> id,
  Value<String> canonicalName,
  Value<String?> nameTr,
  Value<String?> nameEn,
  Value<String> category,
  Value<double> kcalPer100g,
  Value<double> proteinGPer100g,
  Value<double> fatGPer100g,
  Value<double> carbohydrateTotalGPer100g,
  Value<double> fiberGPer100g,
  Value<double> netCarbGPer100g,
  Value<String> dataSource,
  Value<String?> sourceVersion,
  Value<String?> sourceRecordId,
  Value<String?> license,
  Value<String?> lastReviewedAtIso,
  Value<bool> isUserCreated,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$FoodTableReferences
    extends BaseReferences<_$AppDatabase, $FoodTable, FoodRow> {
  $$FoodTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ServingOptionTable, List<ServingOptionRow>>
  _servingOptionRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.servingOption,
    aliasName: 'food__id__serving_option__food_id',
  );

  $$ServingOptionTableProcessedTableManager get servingOptionRefs {
    final manager = $$ServingOptionTableTableManager(
      $_db,
      $_db.servingOption,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_servingOptionRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeIngredientTable, List<RecipeIngredientRow>>
  _recipeIngredientRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeIngredient,
    aliasName: 'food__id__recipe_ingredient__food_id',
  );

  $$RecipeIngredientTableProcessedTableManager get recipeIngredientRefs {
    final manager = $$RecipeIngredientTableTableManager(
      $_db,
      $_db.recipeIngredient,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealItemTable, List<MealItemRow>>
  _mealItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealItem,
    aliasName: 'food__id__meal_item__food_id',
  );

  $$MealItemTableProcessedTableManager get mealItemRefs {
    final manager = $$MealItemTableTableManager(
      $_db,
      $_db.mealItem,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealItemRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShoppingListItemTable, List<ShoppingListItemRow>>
  _shoppingListItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shoppingListItem,
    aliasName: 'food__id__shopping_list_item__food_id',
  );

  $$ShoppingListItemTableProcessedTableManager get shoppingListItemRefs {
    final manager = $$ShoppingListItemTableTableManager(
      $_db,
      $_db.shoppingListItem,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _shoppingListItemRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodTableFilterComposer extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohydrateTotalGPer100g => $composableBuilder(
    column: $table.carbohydrateTotalGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netCarbGPer100g => $composableBuilder(
    column: $table.netCarbGPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceVersion => $composableBuilder(
    column: $table.sourceVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> servingOptionRefs(
    Expression<bool> Function($$ServingOptionTableFilterComposer f) f,
  ) {
    final $$ServingOptionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.servingOption,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServingOptionTableFilterComposer(
            $db: $db,
            $table: $db.servingOption,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeIngredientRefs(
    Expression<bool> Function($$RecipeIngredientTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredient,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredient,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealItemRefs(
    Expression<bool> Function($$MealItemTableFilterComposer f) f,
  ) {
    final $$MealItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableFilterComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shoppingListItemRefs(
    Expression<bool> Function($$ShoppingListItemTableFilterComposer f) f,
  ) {
    final $$ShoppingListItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingListItem,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListItemTableFilterComposer(
            $db: $db,
            $table: $db.shoppingListItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodTableOrderingComposer extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohydrateTotalGPer100g => $composableBuilder(
    column: $table.carbohydrateTotalGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netCarbGPer100g => $composableBuilder(
    column: $table.netCarbGPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceVersion => $composableBuilder(
    column: $table.sourceVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodTable> {
  $$FoodTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get canonicalName => $composableBuilder(
    column: $table.canonicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get kcalPer100g => $composableBuilder(
    column: $table.kcalPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGPer100g => $composableBuilder(
    column: $table.proteinGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGPer100g => $composableBuilder(
    column: $table.fatGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbohydrateTotalGPer100g => $composableBuilder(
    column: $table.carbohydrateTotalGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fiberGPer100g => $composableBuilder(
    column: $table.fiberGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netCarbGPer100g => $composableBuilder(
    column: $table.netCarbGPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dataSource => $composableBuilder(
    column: $table.dataSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceVersion => $composableBuilder(
    column: $table.sourceVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get license =>
      $composableBuilder(column: $table.license, builder: (column) => column);

  GeneratedColumn<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> servingOptionRefs<T extends Object>(
    Expression<T> Function($$ServingOptionTableAnnotationComposer a) f,
  ) {
    final $$ServingOptionTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.servingOption,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServingOptionTableAnnotationComposer(
            $db: $db,
            $table: $db.servingOption,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recipeIngredientRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredient,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeIngredient,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mealItemRefs<T extends Object>(
    Expression<T> Function($$MealItemTableAnnotationComposer a) f,
  ) {
    final $$MealItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableAnnotationComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shoppingListItemRefs<T extends Object>(
    Expression<T> Function($$ShoppingListItemTableAnnotationComposer a) f,
  ) {
    final $$ShoppingListItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingListItem,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListItemTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingListItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodTable,
          FoodRow,
          $$FoodTableFilterComposer,
          $$FoodTableOrderingComposer,
          $$FoodTableAnnotationComposer,
          $$FoodTableCreateCompanionBuilder,
          $$FoodTableUpdateCompanionBuilder,
          (FoodRow, $$FoodTableReferences),
          FoodRow,
          PrefetchHooks Function({
            bool servingOptionRefs,
            bool recipeIngredientRefs,
            bool mealItemRefs,
            bool shoppingListItemRefs,
          })
        > {
  $$FoodTableTableManager(_$AppDatabase db, $FoodTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> canonicalName = const Value.absent(),
                Value<String?> nameTr = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> kcalPer100g = const Value.absent(),
                Value<double> proteinGPer100g = const Value.absent(),
                Value<double> fatGPer100g = const Value.absent(),
                Value<double> carbohydrateTotalGPer100g = const Value.absent(),
                Value<double> fiberGPer100g = const Value.absent(),
                Value<double> netCarbGPer100g = const Value.absent(),
                Value<String> dataSource = const Value.absent(),
                Value<String?> sourceVersion = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                Value<String?> license = const Value.absent(),
                Value<String?> lastReviewedAtIso = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodCompanion(
                id: id,
                canonicalName: canonicalName,
                nameTr: nameTr,
                nameEn: nameEn,
                category: category,
                kcalPer100g: kcalPer100g,
                proteinGPer100g: proteinGPer100g,
                fatGPer100g: fatGPer100g,
                carbohydrateTotalGPer100g: carbohydrateTotalGPer100g,
                fiberGPer100g: fiberGPer100g,
                netCarbGPer100g: netCarbGPer100g,
                dataSource: dataSource,
                sourceVersion: sourceVersion,
                sourceRecordId: sourceRecordId,
                license: license,
                lastReviewedAtIso: lastReviewedAtIso,
                isUserCreated: isUserCreated,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String canonicalName,
                Value<String?> nameTr = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                required String category,
                required double kcalPer100g,
                required double proteinGPer100g,
                required double fatGPer100g,
                required double carbohydrateTotalGPer100g,
                Value<double> fiberGPer100g = const Value.absent(),
                required double netCarbGPer100g,
                required String dataSource,
                Value<String?> sourceVersion = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                Value<String?> license = const Value.absent(),
                Value<String?> lastReviewedAtIso = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodCompanion.insert(
                id: id,
                canonicalName: canonicalName,
                nameTr: nameTr,
                nameEn: nameEn,
                category: category,
                kcalPer100g: kcalPer100g,
                proteinGPer100g: proteinGPer100g,
                fatGPer100g: fatGPer100g,
                carbohydrateTotalGPer100g: carbohydrateTotalGPer100g,
                fiberGPer100g: fiberGPer100g,
                netCarbGPer100g: netCarbGPer100g,
                dataSource: dataSource,
                sourceVersion: sourceVersion,
                sourceRecordId: sourceRecordId,
                license: license,
                lastReviewedAtIso: lastReviewedAtIso,
                isUserCreated: isUserCreated,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FoodTable, FoodRow>(table),
                  $$FoodTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                servingOptionRefs = false,
                recipeIngredientRefs = false,
                mealItemRefs = false,
                shoppingListItemRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (servingOptionRefs) db.servingOption,
                    if (recipeIngredientRefs) db.recipeIngredient,
                    if (mealItemRefs) db.mealItem,
                    if (shoppingListItemRefs) db.shoppingListItem,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (servingOptionRefs)
                        await $_getPrefetchedData<
                          FoodRow,
                          $FoodTable,
                          ServingOptionRow
                        >(
                          currentTable: table,
                          referencedTable: $$FoodTableReferences
                              ._servingOptionRefsTable(db),
                          managerFromTypedResult: (p0) => $$FoodTableReferences(
                            db,
                            table,
                            p0,
                          ).servingOptionRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recipeIngredientRefs)
                        await $_getPrefetchedData<
                          FoodRow,
                          $FoodTable,
                          RecipeIngredientRow
                        >(
                          currentTable: table,
                          referencedTable: $$FoodTableReferences
                              ._recipeIngredientRefsTable(db),
                          managerFromTypedResult: (p0) => $$FoodTableReferences(
                            db,
                            table,
                            p0,
                          ).recipeIngredientRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealItemRefs)
                        await $_getPrefetchedData<
                          FoodRow,
                          $FoodTable,
                          MealItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$FoodTableReferences
                              ._mealItemRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodTableReferences(db, table, p0).mealItemRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shoppingListItemRefs)
                        await $_getPrefetchedData<
                          FoodRow,
                          $FoodTable,
                          ShoppingListItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$FoodTableReferences
                              ._shoppingListItemRefsTable(db),
                          managerFromTypedResult: (p0) => $$FoodTableReferences(
                            db,
                            table,
                            p0,
                          ).shoppingListItemRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FoodTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodTable,
      FoodRow,
      $$FoodTableFilterComposer,
      $$FoodTableOrderingComposer,
      $$FoodTableAnnotationComposer,
      $$FoodTableCreateCompanionBuilder,
      $$FoodTableUpdateCompanionBuilder,
      (FoodRow, $$FoodTableReferences),
      FoodRow,
      PrefetchHooks Function({
        bool servingOptionRefs,
        bool recipeIngredientRefs,
        bool mealItemRefs,
        bool shoppingListItemRefs,
      })
    >;
typedef $$ServingOptionTableCreateCompanionBuilder =
    ServingOptionCompanion Function({
      Value<int> id,
      required String foodId,
      Value<String?> labelTr,
      Value<String?> labelEn,
      required double gramsPerServing,
      Value<bool> isDefault,
    });
typedef $$ServingOptionTableUpdateCompanionBuilder =
    ServingOptionCompanion Function({
      Value<int> id,
      Value<String> foodId,
      Value<String?> labelTr,
      Value<String?> labelEn,
      Value<double> gramsPerServing,
      Value<bool> isDefault,
    });

final class $$ServingOptionTableReferences
    extends
        BaseReferences<_$AppDatabase, $ServingOptionTable, ServingOptionRow> {
  $$ServingOptionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodTable _foodIdTable(_$AppDatabase db) =>
      db.food.createAlias('serving_option__food_id__food__id');

  $$FoodTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodTableTableManager(
      $_db,
      $_db.food,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServingOptionTableFilterComposer
    extends Composer<_$AppDatabase, $ServingOptionTable> {
  $$ServingOptionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelEn => $composableBuilder(
    column: $table.labelEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gramsPerServing => $composableBuilder(
    column: $table.gramsPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodTableFilterComposer get foodId {
    final $$FoodTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableFilterComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServingOptionTableOrderingComposer
    extends Composer<_$AppDatabase, $ServingOptionTable> {
  $$ServingOptionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelEn => $composableBuilder(
    column: $table.labelEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gramsPerServing => $composableBuilder(
    column: $table.gramsPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodTableOrderingComposer get foodId {
    final $$FoodTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableOrderingComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServingOptionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServingOptionTable> {
  $$ServingOptionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get labelTr =>
      $composableBuilder(column: $table.labelTr, builder: (column) => column);

  GeneratedColumn<String> get labelEn =>
      $composableBuilder(column: $table.labelEn, builder: (column) => column);

  GeneratedColumn<double> get gramsPerServing => $composableBuilder(
    column: $table.gramsPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  $$FoodTableAnnotationComposer get foodId {
    final $$FoodTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableAnnotationComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServingOptionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServingOptionTable,
          ServingOptionRow,
          $$ServingOptionTableFilterComposer,
          $$ServingOptionTableOrderingComposer,
          $$ServingOptionTableAnnotationComposer,
          $$ServingOptionTableCreateCompanionBuilder,
          $$ServingOptionTableUpdateCompanionBuilder,
          (ServingOptionRow, $$ServingOptionTableReferences),
          ServingOptionRow,
          PrefetchHooks Function({bool foodId})
        > {
  $$ServingOptionTableTableManager(_$AppDatabase db, $ServingOptionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServingOptionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServingOptionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServingOptionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<String?> labelTr = const Value.absent(),
                Value<String?> labelEn = const Value.absent(),
                Value<double> gramsPerServing = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => ServingOptionCompanion(
                id: id,
                foodId: foodId,
                labelTr: labelTr,
                labelEn: labelEn,
                gramsPerServing: gramsPerServing,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String foodId,
                Value<String?> labelTr = const Value.absent(),
                Value<String?> labelEn = const Value.absent(),
                required double gramsPerServing,
                Value<bool> isDefault = const Value.absent(),
              }) => ServingOptionCompanion.insert(
                id: id,
                foodId: foodId,
                labelTr: labelTr,
                labelEn: labelEn,
                gramsPerServing: gramsPerServing,
                isDefault: isDefault,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServingOptionTable, ServingOptionRow>(table),
                  $$ServingOptionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.foodId,
                        referencedTable: $$ServingOptionTableReferences
                            ._foodIdTable(db),
                        referencedColumn: $$ServingOptionTableReferences
                            ._foodIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ServingOptionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServingOptionTable,
      ServingOptionRow,
      $$ServingOptionTableFilterComposer,
      $$ServingOptionTableOrderingComposer,
      $$ServingOptionTableAnnotationComposer,
      $$ServingOptionTableCreateCompanionBuilder,
      $$ServingOptionTableUpdateCompanionBuilder,
      (ServingOptionRow, $$ServingOptionTableReferences),
      ServingOptionRow,
      PrefetchHooks Function({bool foodId})
    >;
typedef $$RecipeTableCreateCompanionBuilder = RecipeCompanion Function({
  required String id,
  Value<String?> titleTr,
  Value<String?> titleEn,
  required int servings,
  Value<int?> prepMinutes,
  Value<String?> allergensCsv,
  Value<String?> stepsTr,
  Value<String?> stepsEn,
  Value<String?> storageNoteTr,
  Value<String?> storageNoteEn,
  Value<String?> netCarbMethodNote,
  Value<bool> isUserCreated,
  required DateTime createdAtUtc,
  Value<int> rowid,
});
typedef $$RecipeTableUpdateCompanionBuilder = RecipeCompanion Function({
  Value<String> id,
  Value<String?> titleTr,
  Value<String?> titleEn,
  Value<int> servings,
  Value<int?> prepMinutes,
  Value<String?> allergensCsv,
  Value<String?> stepsTr,
  Value<String?> stepsEn,
  Value<String?> storageNoteTr,
  Value<String?> storageNoteEn,
  Value<String?> netCarbMethodNote,
  Value<bool> isUserCreated,
  Value<DateTime> createdAtUtc,
  Value<int> rowid,
});

final class $$RecipeTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeTable, RecipeRow> {
  $$RecipeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientTable, List<RecipeIngredientRow>>
  _recipeIngredientRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeIngredient,
    aliasName: 'recipe__id__recipe_ingredient__recipe_id',
  );

  $$RecipeIngredientTableProcessedTableManager get recipeIngredientRefs {
    final manager = $$RecipeIngredientTableTableManager(
      $_db,
      $_db.recipeIngredient,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealItemTable, List<MealItemRow>>
  _mealItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealItem,
    aliasName: 'recipe__id__meal_item__recipe_id',
  );

  $$MealItemTableProcessedTableManager get mealItemRefs {
    final manager = $$MealItemTableTableManager(
      $_db,
      $_db.mealItem,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealItemRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealPlanEntryTable, List<MealPlanEntryRow>>
  _mealPlanEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealPlanEntry,
    aliasName: 'recipe__id__meal_plan_entry__recipe_id',
  );

  $$MealPlanEntryTableProcessedTableManager get mealPlanEntryRefs {
    final manager = $$MealPlanEntryTableTableManager(
      $_db,
      $_db.mealPlanEntry,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealPlanEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipeTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeTable> {
  $$RecipeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergensCsv => $composableBuilder(
    column: $table.allergensCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepsTr => $composableBuilder(
    column: $table.stepsTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepsEn => $composableBuilder(
    column: $table.stepsEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageNoteTr => $composableBuilder(
    column: $table.storageNoteTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageNoteEn => $composableBuilder(
    column: $table.storageNoteEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get netCarbMethodNote => $composableBuilder(
    column: $table.netCarbMethodNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientRefs(
    Expression<bool> Function($$RecipeIngredientTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredient,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredient,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealItemRefs(
    Expression<bool> Function($$MealItemTableFilterComposer f) f,
  ) {
    final $$MealItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableFilterComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealPlanEntryRefs(
    Expression<bool> Function($$MealPlanEntryTableFilterComposer f) f,
  ) {
    final $$MealPlanEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanEntry,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanEntryTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipeTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeTable> {
  $$RecipeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergensCsv => $composableBuilder(
    column: $table.allergensCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepsTr => $composableBuilder(
    column: $table.stepsTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepsEn => $composableBuilder(
    column: $table.stepsEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageNoteTr => $composableBuilder(
    column: $table.storageNoteTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageNoteEn => $composableBuilder(
    column: $table.storageNoteEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get netCarbMethodNote => $composableBuilder(
    column: $table.netCarbMethodNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeTable> {
  $$RecipeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleTr =>
      $composableBuilder(column: $table.titleTr, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<int> get prepMinutes => $composableBuilder(
    column: $table.prepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergensCsv => $composableBuilder(
    column: $table.allergensCsv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepsTr =>
      $composableBuilder(column: $table.stepsTr, builder: (column) => column);

  GeneratedColumn<String> get stepsEn =>
      $composableBuilder(column: $table.stepsEn, builder: (column) => column);

  GeneratedColumn<String> get storageNoteTr => $composableBuilder(
    column: $table.storageNoteTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storageNoteEn => $composableBuilder(
    column: $table.storageNoteEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get netCarbMethodNote => $composableBuilder(
    column: $table.netCarbMethodNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  Expression<T> recipeIngredientRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredient,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeIngredient,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mealItemRefs<T extends Object>(
    Expression<T> Function($$MealItemTableAnnotationComposer a) f,
  ) {
    final $$MealItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableAnnotationComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mealPlanEntryRefs<T extends Object>(
    Expression<T> Function($$MealPlanEntryTableAnnotationComposer a) f,
  ) {
    final $$MealPlanEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanEntry,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlanEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeTable,
          RecipeRow,
          $$RecipeTableFilterComposer,
          $$RecipeTableOrderingComposer,
          $$RecipeTableAnnotationComposer,
          $$RecipeTableCreateCompanionBuilder,
          $$RecipeTableUpdateCompanionBuilder,
          (RecipeRow, $$RecipeTableReferences),
          RecipeRow,
          PrefetchHooks Function({
            bool recipeIngredientRefs,
            bool mealItemRefs,
            bool mealPlanEntryRefs,
          })
        > {
  $$RecipeTableTableManager(_$AppDatabase db, $RecipeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> titleTr = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<int?> prepMinutes = const Value.absent(),
                Value<String?> allergensCsv = const Value.absent(),
                Value<String?> stepsTr = const Value.absent(),
                Value<String?> stepsEn = const Value.absent(),
                Value<String?> storageNoteTr = const Value.absent(),
                Value<String?> storageNoteEn = const Value.absent(),
                Value<String?> netCarbMethodNote = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeCompanion(
                id: id,
                titleTr: titleTr,
                titleEn: titleEn,
                servings: servings,
                prepMinutes: prepMinutes,
                allergensCsv: allergensCsv,
                stepsTr: stepsTr,
                stepsEn: stepsEn,
                storageNoteTr: storageNoteTr,
                storageNoteEn: storageNoteEn,
                netCarbMethodNote: netCarbMethodNote,
                isUserCreated: isUserCreated,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> titleTr = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                required int servings,
                Value<int?> prepMinutes = const Value.absent(),
                Value<String?> allergensCsv = const Value.absent(),
                Value<String?> stepsTr = const Value.absent(),
                Value<String?> stepsEn = const Value.absent(),
                Value<String?> storageNoteTr = const Value.absent(),
                Value<String?> storageNoteEn = const Value.absent(),
                Value<String?> netCarbMethodNote = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                required DateTime createdAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => RecipeCompanion.insert(
                id: id,
                titleTr: titleTr,
                titleEn: titleEn,
                servings: servings,
                prepMinutes: prepMinutes,
                allergensCsv: allergensCsv,
                stepsTr: stepsTr,
                stepsEn: stepsEn,
                storageNoteTr: storageNoteTr,
                storageNoteEn: storageNoteEn,
                netCarbMethodNote: netCarbMethodNote,
                isUserCreated: isUserCreated,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeTable, RecipeRow>(table),
                  $$RecipeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientRefs = false,
                mealItemRefs = false,
                mealPlanEntryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientRefs) db.recipeIngredient,
                    if (mealItemRefs) db.mealItem,
                    if (mealPlanEntryRefs) db.mealPlanEntry,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipeTable,
                          RecipeIngredientRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipeTableReferences
                              ._recipeIngredientRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipeTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealItemRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipeTable,
                          MealItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipeTableReferences
                              ._mealItemRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipeTableReferences(
                                db,
                                table,
                                p0,
                              ).mealItemRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealPlanEntryRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipeTable,
                          MealPlanEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipeTableReferences
                              ._mealPlanEntryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipeTableReferences(
                                db,
                                table,
                                p0,
                              ).mealPlanEntryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeTable,
      RecipeRow,
      $$RecipeTableFilterComposer,
      $$RecipeTableOrderingComposer,
      $$RecipeTableAnnotationComposer,
      $$RecipeTableCreateCompanionBuilder,
      $$RecipeTableUpdateCompanionBuilder,
      (RecipeRow, $$RecipeTableReferences),
      RecipeRow,
      PrefetchHooks Function({
        bool recipeIngredientRefs,
        bool mealItemRefs,
        bool mealPlanEntryRefs,
      })
    >;
typedef $$RecipeIngredientTableCreateCompanionBuilder =
    RecipeIngredientCompanion Function({
      Value<int> id,
      required String recipeId,
      required String foodId,
      required double grams,
    });
typedef $$RecipeIngredientTableUpdateCompanionBuilder =
    RecipeIngredientCompanion Function({
      Value<int> id,
      Value<String> recipeId,
      Value<String> foodId,
      Value<double> grams,
    });

final class $$RecipeIngredientTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientTable,
          RecipeIngredientRow
        > {
  $$RecipeIngredientTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipeTable _recipeIdTable(_$AppDatabase db) =>
      db.recipe.createAlias('recipe_ingredient__recipe_id__recipe__id');

  $$RecipeTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipeTableTableManager(
      $_db,
      $_db.recipe,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FoodTable _foodIdTable(_$AppDatabase db) =>
      db.food.createAlias('recipe_ingredient__food_id__food__id');

  $$FoodTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodTableTableManager(
      $_db,
      $_db.food,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientTable> {
  $$RecipeIngredientTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipeTableFilterComposer get recipeId {
    final $$RecipeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableFilterComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableFilterComposer get foodId {
    final $$FoodTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableFilterComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientTable> {
  $$RecipeIngredientTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipeTableOrderingComposer get recipeId {
    final $$RecipeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableOrderingComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableOrderingComposer get foodId {
    final $$FoodTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableOrderingComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientTable> {
  $$RecipeIngredientTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  $$RecipeTableAnnotationComposer get recipeId {
    final $$RecipeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableAnnotationComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableAnnotationComposer get foodId {
    final $$FoodTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableAnnotationComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientTable,
          RecipeIngredientRow,
          $$RecipeIngredientTableFilterComposer,
          $$RecipeIngredientTableOrderingComposer,
          $$RecipeIngredientTableAnnotationComposer,
          $$RecipeIngredientTableCreateCompanionBuilder,
          $$RecipeIngredientTableUpdateCompanionBuilder,
          (RecipeIngredientRow, $$RecipeIngredientTableReferences),
          RecipeIngredientRow,
          PrefetchHooks Function({bool recipeId, bool foodId})
        > {
  $$RecipeIngredientTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<double> grams = const Value.absent(),
              }) => RecipeIngredientCompanion(
                id: id,
                recipeId: recipeId,
                foodId: foodId,
                grams: grams,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipeId,
                required String foodId,
                required double grams,
              }) => RecipeIngredientCompanion.insert(
                id: id,
                recipeId: recipeId,
                foodId: foodId,
                grams: grams,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeIngredientTable, RecipeIngredientRow>(
                    table,
                  ),
                  $$RecipeIngredientTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeIngredientTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeIngredientTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (foodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.foodId,
                        referencedTable: $$RecipeIngredientTableReferences
                            ._foodIdTable(db),
                        referencedColumn: $$RecipeIngredientTableReferences
                            ._foodIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientTable,
      RecipeIngredientRow,
      $$RecipeIngredientTableFilterComposer,
      $$RecipeIngredientTableOrderingComposer,
      $$RecipeIngredientTableAnnotationComposer,
      $$RecipeIngredientTableCreateCompanionBuilder,
      $$RecipeIngredientTableUpdateCompanionBuilder,
      (RecipeIngredientRow, $$RecipeIngredientTableReferences),
      RecipeIngredientRow,
      PrefetchHooks Function({bool recipeId, bool foodId})
    >;
typedef $$MealTableCreateCompanionBuilder = MealCompanion Function({
  Value<int> id,
  required String mealType,
  Value<String?> customName,
  required DateTime eatenAtUtc,
  required int localOffsetMinutes,
  Value<String?> note,
});
typedef $$MealTableUpdateCompanionBuilder = MealCompanion Function({
  Value<int> id,
  Value<String> mealType,
  Value<String?> customName,
  Value<DateTime> eatenAtUtc,
  Value<int> localOffsetMinutes,
  Value<String?> note,
});

final class $$MealTableReferences
    extends BaseReferences<_$AppDatabase, $MealTable, MealRow> {
  $$MealTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MealItemTable, List<MealItemRow>>
  _mealItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealItem,
    aliasName: 'meal__id__meal_item__meal_id',
  );

  $$MealItemTableProcessedTableManager get mealItemRefs {
    final manager = $$MealItemTableTableManager(
      $_db,
      $_db.mealItem,
    ).filter((f) => f.mealId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealItemRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealTableFilterComposer extends Composer<_$AppDatabase, $MealTable> {
  $$MealTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eatenAtUtc => $composableBuilder(
    column: $table.eatenAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealItemRefs(
    Expression<bool> Function($$MealItemTableFilterComposer f) f,
  ) {
    final $$MealItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableFilterComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTableOrderingComposer extends Composer<_$AppDatabase, $MealTable> {
  $$MealTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eatenAtUtc => $composableBuilder(
    column: $table.eatenAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealTable> {
  $$MealTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get customName => $composableBuilder(
    column: $table.customName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get eatenAtUtc => $composableBuilder(
    column: $table.eatenAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> mealItemRefs<T extends Object>(
    Expression<T> Function($$MealItemTableAnnotationComposer a) f,
  ) {
    final $$MealItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItem,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableAnnotationComposer(
            $db: $db,
            $table: $db.mealItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealTable,
          MealRow,
          $$MealTableFilterComposer,
          $$MealTableOrderingComposer,
          $$MealTableAnnotationComposer,
          $$MealTableCreateCompanionBuilder,
          $$MealTableUpdateCompanionBuilder,
          (MealRow, $$MealTableReferences),
          MealRow,
          PrefetchHooks Function({bool mealItemRefs})
        > {
  $$MealTableTableManager(_$AppDatabase db, $MealTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String?> customName = const Value.absent(),
                Value<DateTime> eatenAtUtc = const Value.absent(),
                Value<int> localOffsetMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => MealCompanion(
                id: id,
                mealType: mealType,
                customName: customName,
                eatenAtUtc: eatenAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mealType,
                Value<String?> customName = const Value.absent(),
                required DateTime eatenAtUtc,
                required int localOffsetMinutes,
                Value<String?> note = const Value.absent(),
              }) => MealCompanion.insert(
                id: id,
                mealType: mealType,
                customName: customName,
                eatenAtUtc: eatenAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealTable, MealRow>(table),
                  $$MealTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealItemRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mealItemRefs) db.mealItem],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealItemRefs)
                    await $_getPrefetchedData<MealRow, $MealTable, MealItemRow>(
                      currentTable: table,
                      referencedTable: $$MealTableReferences._mealItemRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$MealTableReferences(db, table, p0).mealItemRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mealId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealTable,
      MealRow,
      $$MealTableFilterComposer,
      $$MealTableOrderingComposer,
      $$MealTableAnnotationComposer,
      $$MealTableCreateCompanionBuilder,
      $$MealTableUpdateCompanionBuilder,
      (MealRow, $$MealTableReferences),
      MealRow,
      PrefetchHooks Function({bool mealItemRefs})
    >;
typedef $$MealItemTableCreateCompanionBuilder = MealItemCompanion Function({
  Value<int> id,
  required int mealId,
  required String foodId,
  Value<String?> recipeId,
  required double grams,
  Value<double?> servingsCount,
  Value<double?> userNetCarbOverrideG,
});
typedef $$MealItemTableUpdateCompanionBuilder = MealItemCompanion Function({
  Value<int> id,
  Value<int> mealId,
  Value<String> foodId,
  Value<String?> recipeId,
  Value<double> grams,
  Value<double?> servingsCount,
  Value<double?> userNetCarbOverrideG,
});

final class $$MealItemTableReferences
    extends BaseReferences<_$AppDatabase, $MealItemTable, MealItemRow> {
  $$MealItemTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MealTable _mealIdTable(_$AppDatabase db) =>
      db.meal.createAlias('meal_item__meal_id__meal__id');

  $$MealTableProcessedTableManager get mealId {
    final $_column = $_itemColumn<int>('meal_id')!;

    final manager = $$MealTableTableManager(
      $_db,
      $_db.meal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FoodTable _foodIdTable(_$AppDatabase db) =>
      db.food.createAlias('meal_item__food_id__food__id');

  $$FoodTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodTableTableManager(
      $_db,
      $_db.food,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipeTable _recipeIdTable(_$AppDatabase db) =>
      db.recipe.createAlias('meal_item__recipe_id__recipe__id');

  $$RecipeTableProcessedTableManager? get recipeId {
    final $_column = $_itemColumn<String>('recipe_id');
    if ($_column == null) return null;
    final manager = $$RecipeTableTableManager(
      $_db,
      $_db.recipe,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealItemTableFilterComposer
    extends Composer<_$AppDatabase, $MealItemTable> {
  $$MealItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servingsCount => $composableBuilder(
    column: $table.servingsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get userNetCarbOverrideG => $composableBuilder(
    column: $table.userNetCarbOverrideG,
    builder: (column) => ColumnFilters(column),
  );

  $$MealTableFilterComposer get mealId {
    final $$MealTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableFilterComposer(
            $db: $db,
            $table: $db.meal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableFilterComposer get foodId {
    final $$FoodTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableFilterComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableFilterComposer get recipeId {
    final $$RecipeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableFilterComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableOrderingComposer
    extends Composer<_$AppDatabase, $MealItemTable> {
  $$MealItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servingsCount => $composableBuilder(
    column: $table.servingsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get userNetCarbOverrideG => $composableBuilder(
    column: $table.userNetCarbOverrideG,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealTableOrderingComposer get mealId {
    final $$MealTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableOrderingComposer(
            $db: $db,
            $table: $db.meal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableOrderingComposer get foodId {
    final $$FoodTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableOrderingComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableOrderingComposer get recipeId {
    final $$RecipeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableOrderingComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealItemTable> {
  $$MealItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  GeneratedColumn<double> get servingsCount => $composableBuilder(
    column: $table.servingsCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get userNetCarbOverrideG => $composableBuilder(
    column: $table.userNetCarbOverrideG,
    builder: (column) => column,
  );

  $$MealTableAnnotationComposer get mealId {
    final $$MealTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.meal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableAnnotationComposer(
            $db: $db,
            $table: $db.meal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableAnnotationComposer get foodId {
    final $$FoodTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableAnnotationComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableAnnotationComposer get recipeId {
    final $$RecipeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableAnnotationComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealItemTable,
          MealItemRow,
          $$MealItemTableFilterComposer,
          $$MealItemTableOrderingComposer,
          $$MealItemTableAnnotationComposer,
          $$MealItemTableCreateCompanionBuilder,
          $$MealItemTableUpdateCompanionBuilder,
          (MealItemRow, $$MealItemTableReferences),
          MealItemRow,
          PrefetchHooks Function({bool mealId, bool foodId, bool recipeId})
        > {
  $$MealItemTableTableManager(_$AppDatabase db, $MealItemTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealId = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<String?> recipeId = const Value.absent(),
                Value<double> grams = const Value.absent(),
                Value<double?> servingsCount = const Value.absent(),
                Value<double?> userNetCarbOverrideG = const Value.absent(),
              }) => MealItemCompanion(
                id: id,
                mealId: mealId,
                foodId: foodId,
                recipeId: recipeId,
                grams: grams,
                servingsCount: servingsCount,
                userNetCarbOverrideG: userNetCarbOverrideG,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealId,
                required String foodId,
                Value<String?> recipeId = const Value.absent(),
                required double grams,
                Value<double?> servingsCount = const Value.absent(),
                Value<double?> userNetCarbOverrideG = const Value.absent(),
              }) => MealItemCompanion.insert(
                id: id,
                mealId: mealId,
                foodId: foodId,
                recipeId: recipeId,
                grams: grams,
                servingsCount: servingsCount,
                userNetCarbOverrideG: userNetCarbOverrideG,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealItemTable, MealItemRow>(table),
                  $$MealItemTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mealId = false, foodId = false, recipeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mealId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mealId,
                            referencedTable: $$MealItemTableReferences
                                ._mealIdTable(db),
                            referencedColumn: $$MealItemTableReferences
                                ._mealIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (foodId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.foodId,
                            referencedTable: $$MealItemTableReferences
                                ._foodIdTable(db),
                            referencedColumn: $$MealItemTableReferences
                                ._foodIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (recipeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.recipeId,
                            referencedTable: $$MealItemTableReferences
                                ._recipeIdTable(db),
                            referencedColumn: $$MealItemTableReferences
                                ._recipeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MealItemTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealItemTable,
      MealItemRow,
      $$MealItemTableFilterComposer,
      $$MealItemTableOrderingComposer,
      $$MealItemTableAnnotationComposer,
      $$MealItemTableCreateCompanionBuilder,
      $$MealItemTableUpdateCompanionBuilder,
      (MealItemRow, $$MealItemTableReferences),
      MealItemRow,
      PrefetchHooks Function({bool mealId, bool foodId, bool recipeId})
    >;
typedef $$GlucoseMeasurementTableCreateCompanionBuilder =
    GlucoseMeasurementCompanion Function({
      Value<int> id,
      required double rawValue,
      required String rawUnit,
      required double mmolL,
      required DateTime measuredAtUtc,
      required int localOffsetMinutes,
      required String sourceType,
      Value<String> contextTagIdsJson,
      Value<String?> note,
    });
typedef $$GlucoseMeasurementTableUpdateCompanionBuilder =
    GlucoseMeasurementCompanion Function({
      Value<int> id,
      Value<double> rawValue,
      Value<String> rawUnit,
      Value<double> mmolL,
      Value<DateTime> measuredAtUtc,
      Value<int> localOffsetMinutes,
      Value<String> sourceType,
      Value<String> contextTagIdsJson,
      Value<String?> note,
    });

final class $$GlucoseMeasurementTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GlucoseMeasurementTable,
          GlucoseMeasurementRow
        > {
  $$GlucoseMeasurementTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $MeasurementSessionTable,
    List<MeasurementSessionRow>
  >
  _measurementSessionRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.measurementSession,
        aliasName: 'glucose_measurement__id__measurement_session__glucose_id',
      );

  $$MeasurementSessionTableProcessedTableManager get measurementSessionRefs {
    final manager = $$MeasurementSessionTableTableManager(
      $_db,
      $_db.measurementSession,
    ).filter((f) => f.glucoseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _measurementSessionRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GlucoseMeasurementTableFilterComposer
    extends Composer<_$AppDatabase, $GlucoseMeasurementTable> {
  $$GlucoseMeasurementTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mmolL => $composableBuilder(
    column: $table.mmolL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> measurementSessionRefs(
    Expression<bool> Function($$MeasurementSessionTableFilterComposer f) f,
  ) {
    final $$MeasurementSessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measurementSession,
      getReferencedColumn: (t) => t.glucoseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementSessionTableFilterComposer(
            $db: $db,
            $table: $db.measurementSession,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GlucoseMeasurementTableOrderingComposer
    extends Composer<_$AppDatabase, $GlucoseMeasurementTable> {
  $$GlucoseMeasurementTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mmolL => $composableBuilder(
    column: $table.mmolL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GlucoseMeasurementTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlucoseMeasurementTable> {
  $$GlucoseMeasurementTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get rawUnit =>
      $composableBuilder(column: $table.rawUnit, builder: (column) => column);

  GeneratedColumn<double> get mmolL =>
      $composableBuilder(column: $table.mmolL, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> measurementSessionRefs<T extends Object>(
    Expression<T> Function($$MeasurementSessionTableAnnotationComposer a) f,
  ) {
    final $$MeasurementSessionTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.measurementSession,
          getReferencedColumn: (t) => t.glucoseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MeasurementSessionTableAnnotationComposer(
                $db: $db,
                $table: $db.measurementSession,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GlucoseMeasurementTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlucoseMeasurementTable,
          GlucoseMeasurementRow,
          $$GlucoseMeasurementTableFilterComposer,
          $$GlucoseMeasurementTableOrderingComposer,
          $$GlucoseMeasurementTableAnnotationComposer,
          $$GlucoseMeasurementTableCreateCompanionBuilder,
          $$GlucoseMeasurementTableUpdateCompanionBuilder,
          (GlucoseMeasurementRow, $$GlucoseMeasurementTableReferences),
          GlucoseMeasurementRow,
          PrefetchHooks Function({bool measurementSessionRefs})
        > {
  $$GlucoseMeasurementTableTableManager(
    _$AppDatabase db,
    $GlucoseMeasurementTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlucoseMeasurementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlucoseMeasurementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlucoseMeasurementTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> rawValue = const Value.absent(),
                Value<String> rawUnit = const Value.absent(),
                Value<double> mmolL = const Value.absent(),
                Value<DateTime> measuredAtUtc = const Value.absent(),
                Value<int> localOffsetMinutes = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> contextTagIdsJson = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => GlucoseMeasurementCompanion(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                mmolL: mmolL,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                sourceType: sourceType,
                contextTagIdsJson: contextTagIdsJson,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double rawValue,
                required String rawUnit,
                required double mmolL,
                required DateTime measuredAtUtc,
                required int localOffsetMinutes,
                required String sourceType,
                Value<String> contextTagIdsJson = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => GlucoseMeasurementCompanion.insert(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                mmolL: mmolL,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                sourceType: sourceType,
                contextTagIdsJson: contextTagIdsJson,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GlucoseMeasurementTable, GlucoseMeasurementRow>(
                    table,
                  ),
                  $$GlucoseMeasurementTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({measurementSessionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (measurementSessionRefs) db.measurementSession,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (measurementSessionRefs)
                    await $_getPrefetchedData<
                      GlucoseMeasurementRow,
                      $GlucoseMeasurementTable,
                      MeasurementSessionRow
                    >(
                      currentTable: table,
                      referencedTable: $$GlucoseMeasurementTableReferences
                          ._measurementSessionRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GlucoseMeasurementTableReferences(
                            db,
                            table,
                            p0,
                          ).measurementSessionRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.glucoseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GlucoseMeasurementTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlucoseMeasurementTable,
      GlucoseMeasurementRow,
      $$GlucoseMeasurementTableFilterComposer,
      $$GlucoseMeasurementTableOrderingComposer,
      $$GlucoseMeasurementTableAnnotationComposer,
      $$GlucoseMeasurementTableCreateCompanionBuilder,
      $$GlucoseMeasurementTableUpdateCompanionBuilder,
      (GlucoseMeasurementRow, $$GlucoseMeasurementTableReferences),
      GlucoseMeasurementRow,
      PrefetchHooks Function({bool measurementSessionRefs})
    >;
typedef $$KetoneMeasurementTableCreateCompanionBuilder =
    KetoneMeasurementCompanion Function({
      Value<int> id,
      required double rawValue,
      Value<String> rawUnit,
      required double mmolL,
      Value<String> subtype,
      required DateTime measuredAtUtc,
      required int localOffsetMinutes,
      Value<String?> sourceType,
      Value<String> contextTagIdsJson,
      Value<String?> note,
    });
typedef $$KetoneMeasurementTableUpdateCompanionBuilder =
    KetoneMeasurementCompanion Function({
      Value<int> id,
      Value<double> rawValue,
      Value<String> rawUnit,
      Value<double> mmolL,
      Value<String> subtype,
      Value<DateTime> measuredAtUtc,
      Value<int> localOffsetMinutes,
      Value<String?> sourceType,
      Value<String> contextTagIdsJson,
      Value<String?> note,
    });

final class $$KetoneMeasurementTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $KetoneMeasurementTable,
          KetoneMeasurementRow
        > {
  $$KetoneMeasurementTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $MeasurementSessionTable,
    List<MeasurementSessionRow>
  >
  _measurementSessionRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.measurementSession,
        aliasName: 'ketone_measurement__id__measurement_session__ketone_id',
      );

  $$MeasurementSessionTableProcessedTableManager get measurementSessionRefs {
    final manager = $$MeasurementSessionTableTableManager(
      $_db,
      $_db.measurementSession,
    ).filter((f) => f.ketoneId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _measurementSessionRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KetoneMeasurementTableFilterComposer
    extends Composer<_$AppDatabase, $KetoneMeasurementTable> {
  $$KetoneMeasurementTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mmolL => $composableBuilder(
    column: $table.mmolL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtype => $composableBuilder(
    column: $table.subtype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> measurementSessionRefs(
    Expression<bool> Function($$MeasurementSessionTableFilterComposer f) f,
  ) {
    final $$MeasurementSessionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measurementSession,
      getReferencedColumn: (t) => t.ketoneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementSessionTableFilterComposer(
            $db: $db,
            $table: $db.measurementSession,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KetoneMeasurementTableOrderingComposer
    extends Composer<_$AppDatabase, $KetoneMeasurementTable> {
  $$KetoneMeasurementTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mmolL => $composableBuilder(
    column: $table.mmolL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtype => $composableBuilder(
    column: $table.subtype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KetoneMeasurementTableAnnotationComposer
    extends Composer<_$AppDatabase, $KetoneMeasurementTable> {
  $$KetoneMeasurementTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get rawUnit =>
      $composableBuilder(column: $table.rawUnit, builder: (column) => column);

  GeneratedColumn<double> get mmolL =>
      $composableBuilder(column: $table.mmolL, builder: (column) => column);

  GeneratedColumn<String> get subtype =>
      $composableBuilder(column: $table.subtype, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextTagIdsJson => $composableBuilder(
    column: $table.contextTagIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> measurementSessionRefs<T extends Object>(
    Expression<T> Function($$MeasurementSessionTableAnnotationComposer a) f,
  ) {
    final $$MeasurementSessionTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.measurementSession,
          getReferencedColumn: (t) => t.ketoneId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MeasurementSessionTableAnnotationComposer(
                $db: $db,
                $table: $db.measurementSession,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$KetoneMeasurementTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KetoneMeasurementTable,
          KetoneMeasurementRow,
          $$KetoneMeasurementTableFilterComposer,
          $$KetoneMeasurementTableOrderingComposer,
          $$KetoneMeasurementTableAnnotationComposer,
          $$KetoneMeasurementTableCreateCompanionBuilder,
          $$KetoneMeasurementTableUpdateCompanionBuilder,
          (KetoneMeasurementRow, $$KetoneMeasurementTableReferences),
          KetoneMeasurementRow,
          PrefetchHooks Function({bool measurementSessionRefs})
        > {
  $$KetoneMeasurementTableTableManager(
    _$AppDatabase db,
    $KetoneMeasurementTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KetoneMeasurementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KetoneMeasurementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KetoneMeasurementTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> rawValue = const Value.absent(),
                Value<String> rawUnit = const Value.absent(),
                Value<double> mmolL = const Value.absent(),
                Value<String> subtype = const Value.absent(),
                Value<DateTime> measuredAtUtc = const Value.absent(),
                Value<int> localOffsetMinutes = const Value.absent(),
                Value<String?> sourceType = const Value.absent(),
                Value<String> contextTagIdsJson = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => KetoneMeasurementCompanion(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                mmolL: mmolL,
                subtype: subtype,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                sourceType: sourceType,
                contextTagIdsJson: contextTagIdsJson,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double rawValue,
                Value<String> rawUnit = const Value.absent(),
                required double mmolL,
                Value<String> subtype = const Value.absent(),
                required DateTime measuredAtUtc,
                required int localOffsetMinutes,
                Value<String?> sourceType = const Value.absent(),
                Value<String> contextTagIdsJson = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => KetoneMeasurementCompanion.insert(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                mmolL: mmolL,
                subtype: subtype,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                sourceType: sourceType,
                contextTagIdsJson: contextTagIdsJson,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$KetoneMeasurementTable, KetoneMeasurementRow>(
                    table,
                  ),
                  $$KetoneMeasurementTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({measurementSessionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (measurementSessionRefs) db.measurementSession,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (measurementSessionRefs)
                    await $_getPrefetchedData<
                      KetoneMeasurementRow,
                      $KetoneMeasurementTable,
                      MeasurementSessionRow
                    >(
                      currentTable: table,
                      referencedTable: $$KetoneMeasurementTableReferences
                          ._measurementSessionRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$KetoneMeasurementTableReferences(
                            db,
                            table,
                            p0,
                          ).measurementSessionRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ketoneId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$KetoneMeasurementTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KetoneMeasurementTable,
      KetoneMeasurementRow,
      $$KetoneMeasurementTableFilterComposer,
      $$KetoneMeasurementTableOrderingComposer,
      $$KetoneMeasurementTableAnnotationComposer,
      $$KetoneMeasurementTableCreateCompanionBuilder,
      $$KetoneMeasurementTableUpdateCompanionBuilder,
      (KetoneMeasurementRow, $$KetoneMeasurementTableReferences),
      KetoneMeasurementRow,
      PrefetchHooks Function({bool measurementSessionRefs})
    >;
typedef $$MeasurementSessionTableCreateCompanionBuilder =
    MeasurementSessionCompanion Function({
      Value<int> id,
      Value<int?> glucoseId,
      Value<int?> ketoneId,
      required double gkiValue,
      required String formulaVersion,
      Value<int?> matchDifferenceMinutes,
      required String matchKind,
      required bool confirmedByUser,
      required DateTime computedAtUtc,
      Value<bool> isValid,
    });
typedef $$MeasurementSessionTableUpdateCompanionBuilder =
    MeasurementSessionCompanion Function({
      Value<int> id,
      Value<int?> glucoseId,
      Value<int?> ketoneId,
      Value<double> gkiValue,
      Value<String> formulaVersion,
      Value<int?> matchDifferenceMinutes,
      Value<String> matchKind,
      Value<bool> confirmedByUser,
      Value<DateTime> computedAtUtc,
      Value<bool> isValid,
    });

final class $$MeasurementSessionTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MeasurementSessionTable,
          MeasurementSessionRow
        > {
  $$MeasurementSessionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GlucoseMeasurementTable _glucoseIdTable(_$AppDatabase db) => db
      .glucoseMeasurement
      .createAlias('measurement_session__glucose_id__glucose_measurement__id');

  $$GlucoseMeasurementTableProcessedTableManager? get glucoseId {
    final $_column = $_itemColumn<int>('glucose_id');
    if ($_column == null) return null;
    final manager = $$GlucoseMeasurementTableTableManager(
      $_db,
      $_db.glucoseMeasurement,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_glucoseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KetoneMeasurementTable _ketoneIdTable(_$AppDatabase db) => db
      .ketoneMeasurement
      .createAlias('measurement_session__ketone_id__ketone_measurement__id');

  $$KetoneMeasurementTableProcessedTableManager? get ketoneId {
    final $_column = $_itemColumn<int>('ketone_id');
    if ($_column == null) return null;
    final manager = $$KetoneMeasurementTableTableManager(
      $_db,
      $_db.ketoneMeasurement,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ketoneIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeasurementSessionTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementSessionTable> {
  $$MeasurementSessionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gkiValue => $composableBuilder(
    column: $table.gkiValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get matchDifferenceMinutes => $composableBuilder(
    column: $table.matchDifferenceMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchKind => $composableBuilder(
    column: $table.matchKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get confirmedByUser => $composableBuilder(
    column: $table.confirmedByUser,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isValid => $composableBuilder(
    column: $table.isValid,
    builder: (column) => ColumnFilters(column),
  );

  $$GlucoseMeasurementTableFilterComposer get glucoseId {
    final $$GlucoseMeasurementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.glucoseId,
      referencedTable: $db.glucoseMeasurement,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GlucoseMeasurementTableFilterComposer(
            $db: $db,
            $table: $db.glucoseMeasurement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KetoneMeasurementTableFilterComposer get ketoneId {
    final $$KetoneMeasurementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ketoneId,
      referencedTable: $db.ketoneMeasurement,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KetoneMeasurementTableFilterComposer(
            $db: $db,
            $table: $db.ketoneMeasurement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementSessionTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementSessionTable> {
  $$MeasurementSessionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gkiValue => $composableBuilder(
    column: $table.gkiValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get matchDifferenceMinutes => $composableBuilder(
    column: $table.matchDifferenceMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchKind => $composableBuilder(
    column: $table.matchKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get confirmedByUser => $composableBuilder(
    column: $table.confirmedByUser,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isValid => $composableBuilder(
    column: $table.isValid,
    builder: (column) => ColumnOrderings(column),
  );

  $$GlucoseMeasurementTableOrderingComposer get glucoseId {
    final $$GlucoseMeasurementTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.glucoseId,
      referencedTable: $db.glucoseMeasurement,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GlucoseMeasurementTableOrderingComposer(
            $db: $db,
            $table: $db.glucoseMeasurement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KetoneMeasurementTableOrderingComposer get ketoneId {
    final $$KetoneMeasurementTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ketoneId,
      referencedTable: $db.ketoneMeasurement,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KetoneMeasurementTableOrderingComposer(
            $db: $db,
            $table: $db.ketoneMeasurement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasurementSessionTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementSessionTable> {
  $$MeasurementSessionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get gkiValue =>
      $composableBuilder(column: $table.gkiValue, builder: (column) => column);

  GeneratedColumn<String> get formulaVersion => $composableBuilder(
    column: $table.formulaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get matchDifferenceMinutes => $composableBuilder(
    column: $table.matchDifferenceMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchKind =>
      $composableBuilder(column: $table.matchKind, builder: (column) => column);

  GeneratedColumn<bool> get confirmedByUser => $composableBuilder(
    column: $table.confirmedByUser,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get computedAtUtc => $composableBuilder(
    column: $table.computedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isValid =>
      $composableBuilder(column: $table.isValid, builder: (column) => column);

  $$GlucoseMeasurementTableAnnotationComposer get glucoseId {
    final $$GlucoseMeasurementTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.glucoseId,
          referencedTable: $db.glucoseMeasurement,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GlucoseMeasurementTableAnnotationComposer(
                $db: $db,
                $table: $db.glucoseMeasurement,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$KetoneMeasurementTableAnnotationComposer get ketoneId {
    final $$KetoneMeasurementTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.ketoneId,
          referencedTable: $db.ketoneMeasurement,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$KetoneMeasurementTableAnnotationComposer(
                $db: $db,
                $table: $db.ketoneMeasurement,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MeasurementSessionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasurementSessionTable,
          MeasurementSessionRow,
          $$MeasurementSessionTableFilterComposer,
          $$MeasurementSessionTableOrderingComposer,
          $$MeasurementSessionTableAnnotationComposer,
          $$MeasurementSessionTableCreateCompanionBuilder,
          $$MeasurementSessionTableUpdateCompanionBuilder,
          (MeasurementSessionRow, $$MeasurementSessionTableReferences),
          MeasurementSessionRow,
          PrefetchHooks Function({bool glucoseId, bool ketoneId})
        > {
  $$MeasurementSessionTableTableManager(
    _$AppDatabase db,
    $MeasurementSessionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementSessionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementSessionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementSessionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> glucoseId = const Value.absent(),
                Value<int?> ketoneId = const Value.absent(),
                Value<double> gkiValue = const Value.absent(),
                Value<String> formulaVersion = const Value.absent(),
                Value<int?> matchDifferenceMinutes = const Value.absent(),
                Value<String> matchKind = const Value.absent(),
                Value<bool> confirmedByUser = const Value.absent(),
                Value<DateTime> computedAtUtc = const Value.absent(),
                Value<bool> isValid = const Value.absent(),
              }) => MeasurementSessionCompanion(
                id: id,
                glucoseId: glucoseId,
                ketoneId: ketoneId,
                gkiValue: gkiValue,
                formulaVersion: formulaVersion,
                matchDifferenceMinutes: matchDifferenceMinutes,
                matchKind: matchKind,
                confirmedByUser: confirmedByUser,
                computedAtUtc: computedAtUtc,
                isValid: isValid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> glucoseId = const Value.absent(),
                Value<int?> ketoneId = const Value.absent(),
                required double gkiValue,
                required String formulaVersion,
                Value<int?> matchDifferenceMinutes = const Value.absent(),
                required String matchKind,
                required bool confirmedByUser,
                required DateTime computedAtUtc,
                Value<bool> isValid = const Value.absent(),
              }) => MeasurementSessionCompanion.insert(
                id: id,
                glucoseId: glucoseId,
                ketoneId: ketoneId,
                gkiValue: gkiValue,
                formulaVersion: formulaVersion,
                matchDifferenceMinutes: matchDifferenceMinutes,
                matchKind: matchKind,
                confirmedByUser: confirmedByUser,
                computedAtUtc: computedAtUtc,
                isValid: isValid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MeasurementSessionTable, MeasurementSessionRow>(
                    table,
                  ),
                  $$MeasurementSessionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({glucoseId = false, ketoneId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (glucoseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.glucoseId,
                        referencedTable: $$MeasurementSessionTableReferences
                            ._glucoseIdTable(db),
                        referencedColumn: $$MeasurementSessionTableReferences
                            ._glucoseIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ketoneId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ketoneId,
                        referencedTable: $$MeasurementSessionTableReferences
                            ._ketoneIdTable(db),
                        referencedColumn: $$MeasurementSessionTableReferences
                            ._ketoneIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MeasurementSessionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasurementSessionTable,
      MeasurementSessionRow,
      $$MeasurementSessionTableFilterComposer,
      $$MeasurementSessionTableOrderingComposer,
      $$MeasurementSessionTableAnnotationComposer,
      $$MeasurementSessionTableCreateCompanionBuilder,
      $$MeasurementSessionTableUpdateCompanionBuilder,
      (MeasurementSessionRow, $$MeasurementSessionTableReferences),
      MeasurementSessionRow,
      PrefetchHooks Function({bool glucoseId, bool ketoneId})
    >;
typedef $$WeightEntryTableCreateCompanionBuilder =
    WeightEntryCompanion Function({
      Value<int> id,
      required double rawValue,
      required String rawUnit,
      required double kg,
      required DateTime measuredAtUtc,
      required int localOffsetMinutes,
      Value<String?> conditionNote,
      Value<String?> note,
    });
typedef $$WeightEntryTableUpdateCompanionBuilder =
    WeightEntryCompanion Function({
      Value<int> id,
      Value<double> rawValue,
      Value<String> rawUnit,
      Value<double> kg,
      Value<DateTime> measuredAtUtc,
      Value<int> localOffsetMinutes,
      Value<String?> conditionNote,
      Value<String?> note,
    });

class $$WeightEntryTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntryTable> {
  $$WeightEntryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionNote => $composableBuilder(
    column: $table.conditionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntryTable> {
  $$WeightEntryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawUnit => $composableBuilder(
    column: $table.rawUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kg => $composableBuilder(
    column: $table.kg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionNote => $composableBuilder(
    column: $table.conditionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntryTable> {
  $$WeightEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get rawUnit =>
      $composableBuilder(column: $table.rawUnit, builder: (column) => column);

  GeneratedColumn<double> get kg =>
      $composableBuilder(column: $table.kg, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAtUtc => $composableBuilder(
    column: $table.measuredAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get localOffsetMinutes => $composableBuilder(
    column: $table.localOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditionNote => $composableBuilder(
    column: $table.conditionNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$WeightEntryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightEntryTable,
          WeightEntryRow,
          $$WeightEntryTableFilterComposer,
          $$WeightEntryTableOrderingComposer,
          $$WeightEntryTableAnnotationComposer,
          $$WeightEntryTableCreateCompanionBuilder,
          $$WeightEntryTableUpdateCompanionBuilder,
          (
            WeightEntryRow,
            BaseReferences<_$AppDatabase, $WeightEntryTable, WeightEntryRow>,
          ),
          WeightEntryRow,
          PrefetchHooks Function()
        > {
  $$WeightEntryTableTableManager(_$AppDatabase db, $WeightEntryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> rawValue = const Value.absent(),
                Value<String> rawUnit = const Value.absent(),
                Value<double> kg = const Value.absent(),
                Value<DateTime> measuredAtUtc = const Value.absent(),
                Value<int> localOffsetMinutes = const Value.absent(),
                Value<String?> conditionNote = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WeightEntryCompanion(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                kg: kg,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                conditionNote: conditionNote,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double rawValue,
                required String rawUnit,
                required double kg,
                required DateTime measuredAtUtc,
                required int localOffsetMinutes,
                Value<String?> conditionNote = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WeightEntryCompanion.insert(
                id: id,
                rawValue: rawValue,
                rawUnit: rawUnit,
                kg: kg,
                measuredAtUtc: measuredAtUtc,
                localOffsetMinutes: localOffsetMinutes,
                conditionNote: conditionNote,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeightEntryTable, WeightEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WeightEntryTable,
                    WeightEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightEntryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightEntryTable,
      WeightEntryRow,
      $$WeightEntryTableFilterComposer,
      $$WeightEntryTableOrderingComposer,
      $$WeightEntryTableAnnotationComposer,
      $$WeightEntryTableCreateCompanionBuilder,
      $$WeightEntryTableUpdateCompanionBuilder,
      (
        WeightEntryRow,
        BaseReferences<_$AppDatabase, $WeightEntryTable, WeightEntryRow>,
      ),
      WeightEntryRow,
      PrefetchHooks Function()
    >;
typedef $$SymptomDefinitionTableCreateCompanionBuilder =
    SymptomDefinitionCompanion Function({
      required String id,
      required String nameTr,
      required String nameEn,
      Value<bool> isUserCreated,
      Value<int> rowid,
    });
typedef $$SymptomDefinitionTableUpdateCompanionBuilder =
    SymptomDefinitionCompanion Function({
      Value<String> id,
      Value<String> nameTr,
      Value<String> nameEn,
      Value<bool> isUserCreated,
      Value<int> rowid,
    });

final class $$SymptomDefinitionTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SymptomDefinitionTable,
          SymptomDefinitionRow
        > {
  $$SymptomDefinitionTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SymptomEntryTable, List<SymptomEntryRow>>
  _symptomEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.symptomEntry,
    aliasName: 'symptom_definition__id__symptom_entry__symptom_definition_id',
  );

  $$SymptomEntryTableProcessedTableManager get symptomEntryRefs {
    final manager = $$SymptomEntryTableTableManager($_db, $_db.symptomEntry)
        .filter(
          (f) =>
              f.symptomDefinitionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_symptomEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SymptomDefinitionTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomDefinitionTable> {
  $$SymptomDefinitionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> symptomEntryRefs(
    Expression<bool> Function($$SymptomEntryTableFilterComposer f) f,
  ) {
    final $$SymptomEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.symptomEntry,
      getReferencedColumn: (t) => t.symptomDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomEntryTableFilterComposer(
            $db: $db,
            $table: $db.symptomEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SymptomDefinitionTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomDefinitionTable> {
  $$SymptomDefinitionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SymptomDefinitionTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomDefinitionTable> {
  $$SymptomDefinitionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );

  Expression<T> symptomEntryRefs<T extends Object>(
    Expression<T> Function($$SymptomEntryTableAnnotationComposer a) f,
  ) {
    final $$SymptomEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.symptomEntry,
      getReferencedColumn: (t) => t.symptomDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.symptomEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SymptomDefinitionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomDefinitionTable,
          SymptomDefinitionRow,
          $$SymptomDefinitionTableFilterComposer,
          $$SymptomDefinitionTableOrderingComposer,
          $$SymptomDefinitionTableAnnotationComposer,
          $$SymptomDefinitionTableCreateCompanionBuilder,
          $$SymptomDefinitionTableUpdateCompanionBuilder,
          (SymptomDefinitionRow, $$SymptomDefinitionTableReferences),
          SymptomDefinitionRow,
          PrefetchHooks Function({bool symptomEntryRefs})
        > {
  $$SymptomDefinitionTableTableManager(
    _$AppDatabase db,
    $SymptomDefinitionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomDefinitionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomDefinitionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomDefinitionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameTr = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SymptomDefinitionCompanion(
                id: id,
                nameTr: nameTr,
                nameEn: nameEn,
                isUserCreated: isUserCreated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameTr,
                required String nameEn,
                Value<bool> isUserCreated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SymptomDefinitionCompanion.insert(
                id: id,
                nameTr: nameTr,
                nameEn: nameEn,
                isUserCreated: isUserCreated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SymptomDefinitionTable, SymptomDefinitionRow>(
                    table,
                  ),
                  $$SymptomDefinitionTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({symptomEntryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (symptomEntryRefs) db.symptomEntry],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (symptomEntryRefs)
                    await $_getPrefetchedData<
                      SymptomDefinitionRow,
                      $SymptomDefinitionTable,
                      SymptomEntryRow
                    >(
                      currentTable: table,
                      referencedTable: $$SymptomDefinitionTableReferences
                          ._symptomEntryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SymptomDefinitionTableReferences(
                            db,
                            table,
                            p0,
                          ).symptomEntryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.symptomDefinitionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SymptomDefinitionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomDefinitionTable,
      SymptomDefinitionRow,
      $$SymptomDefinitionTableFilterComposer,
      $$SymptomDefinitionTableOrderingComposer,
      $$SymptomDefinitionTableAnnotationComposer,
      $$SymptomDefinitionTableCreateCompanionBuilder,
      $$SymptomDefinitionTableUpdateCompanionBuilder,
      (SymptomDefinitionRow, $$SymptomDefinitionTableReferences),
      SymptomDefinitionRow,
      PrefetchHooks Function({bool symptomEntryRefs})
    >;
typedef $$SymptomEntryTableCreateCompanionBuilder =
    SymptomEntryCompanion Function({
      Value<int> id,
      required String symptomDefinitionId,
      required int severity,
      Value<DateTime?> startedAtUtc,
      Value<int?> durationMinutes,
      Value<String?> note,
      required DateTime createdAtUtc,
    });
typedef $$SymptomEntryTableUpdateCompanionBuilder =
    SymptomEntryCompanion Function({
      Value<int> id,
      Value<String> symptomDefinitionId,
      Value<int> severity,
      Value<DateTime?> startedAtUtc,
      Value<int?> durationMinutes,
      Value<String?> note,
      Value<DateTime> createdAtUtc,
    });

final class $$SymptomEntryTableReferences
    extends BaseReferences<_$AppDatabase, $SymptomEntryTable, SymptomEntryRow> {
  $$SymptomEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SymptomDefinitionTable _symptomDefinitionIdTable(_$AppDatabase db) =>
      db.symptomDefinition.createAlias(
        'symptom_entry__symptom_definition_id__symptom_definition__id',
      );

  $$SymptomDefinitionTableProcessedTableManager get symptomDefinitionId {
    final $_column = $_itemColumn<String>('symptom_definition_id')!;

    final manager = $$SymptomDefinitionTableTableManager(
      $_db,
      $_db.symptomDefinition,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_symptomDefinitionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SymptomEntryTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomEntryTable> {
  $$SymptomEntryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAtUtc => $composableBuilder(
    column: $table.startedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$SymptomDefinitionTableFilterComposer get symptomDefinitionId {
    final $$SymptomDefinitionTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomDefinitionId,
      referencedTable: $db.symptomDefinition,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomDefinitionTableFilterComposer(
            $db: $db,
            $table: $db.symptomDefinition,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SymptomEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomEntryTable> {
  $$SymptomEntryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAtUtc => $composableBuilder(
    column: $table.startedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$SymptomDefinitionTableOrderingComposer get symptomDefinitionId {
    final $$SymptomDefinitionTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.symptomDefinitionId,
      referencedTable: $db.symptomDefinition,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SymptomDefinitionTableOrderingComposer(
            $db: $db,
            $table: $db.symptomDefinition,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SymptomEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomEntryTable> {
  $$SymptomEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAtUtc => $composableBuilder(
    column: $table.startedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  $$SymptomDefinitionTableAnnotationComposer get symptomDefinitionId {
    final $$SymptomDefinitionTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.symptomDefinitionId,
          referencedTable: $db.symptomDefinition,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SymptomDefinitionTableAnnotationComposer(
                $db: $db,
                $table: $db.symptomDefinition,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SymptomEntryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SymptomEntryTable,
          SymptomEntryRow,
          $$SymptomEntryTableFilterComposer,
          $$SymptomEntryTableOrderingComposer,
          $$SymptomEntryTableAnnotationComposer,
          $$SymptomEntryTableCreateCompanionBuilder,
          $$SymptomEntryTableUpdateCompanionBuilder,
          (SymptomEntryRow, $$SymptomEntryTableReferences),
          SymptomEntryRow,
          PrefetchHooks Function({bool symptomDefinitionId})
        > {
  $$SymptomEntryTableTableManager(_$AppDatabase db, $SymptomEntryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> symptomDefinitionId = const Value.absent(),
                Value<int> severity = const Value.absent(),
                Value<DateTime?> startedAtUtc = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
              }) => SymptomEntryCompanion(
                id: id,
                symptomDefinitionId: symptomDefinitionId,
                severity: severity,
                startedAtUtc: startedAtUtc,
                durationMinutes: durationMinutes,
                note: note,
                createdAtUtc: createdAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String symptomDefinitionId,
                required int severity,
                Value<DateTime?> startedAtUtc = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAtUtc,
              }) => SymptomEntryCompanion.insert(
                id: id,
                symptomDefinitionId: symptomDefinitionId,
                severity: severity,
                startedAtUtc: startedAtUtc,
                durationMinutes: durationMinutes,
                note: note,
                createdAtUtc: createdAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SymptomEntryTable, SymptomEntryRow>(table),
                  $$SymptomEntryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({symptomDefinitionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (symptomDefinitionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.symptomDefinitionId,
                        referencedTable: $$SymptomEntryTableReferences
                            ._symptomDefinitionIdTable(db),
                        referencedColumn: $$SymptomEntryTableReferences
                            ._symptomDefinitionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SymptomEntryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SymptomEntryTable,
      SymptomEntryRow,
      $$SymptomEntryTableFilterComposer,
      $$SymptomEntryTableOrderingComposer,
      $$SymptomEntryTableAnnotationComposer,
      $$SymptomEntryTableCreateCompanionBuilder,
      $$SymptomEntryTableUpdateCompanionBuilder,
      (SymptomEntryRow, $$SymptomEntryTableReferences),
      SymptomEntryRow,
      PrefetchHooks Function({bool symptomDefinitionId})
    >;
typedef $$ContextTagTableCreateCompanionBuilder = ContextTagCompanion Function({
  required String id,
  required String labelTr,
  required String labelEn,
  Value<bool> isUserCreated,
  Value<int> rowid,
});
typedef $$ContextTagTableUpdateCompanionBuilder = ContextTagCompanion Function({
  Value<String> id,
  Value<String> labelTr,
  Value<String> labelEn,
  Value<bool> isUserCreated,
  Value<int> rowid,
});

class $$ContextTagTableFilterComposer
    extends Composer<_$AppDatabase, $ContextTagTable> {
  $$ContextTagTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelEn => $composableBuilder(
    column: $table.labelEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContextTagTableOrderingComposer
    extends Composer<_$AppDatabase, $ContextTagTable> {
  $$ContextTagTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelTr => $composableBuilder(
    column: $table.labelTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelEn => $composableBuilder(
    column: $table.labelEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContextTagTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContextTagTable> {
  $$ContextTagTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get labelTr =>
      $composableBuilder(column: $table.labelTr, builder: (column) => column);

  GeneratedColumn<String> get labelEn =>
      $composableBuilder(column: $table.labelEn, builder: (column) => column);

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );
}

class $$ContextTagTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContextTagTable,
          ContextTagRow,
          $$ContextTagTableFilterComposer,
          $$ContextTagTableOrderingComposer,
          $$ContextTagTableAnnotationComposer,
          $$ContextTagTableCreateCompanionBuilder,
          $$ContextTagTableUpdateCompanionBuilder,
          (
            ContextTagRow,
            BaseReferences<_$AppDatabase, $ContextTagTable, ContextTagRow>,
          ),
          ContextTagRow,
          PrefetchHooks Function()
        > {
  $$ContextTagTableTableManager(_$AppDatabase db, $ContextTagTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContextTagTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContextTagTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContextTagTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> labelTr = const Value.absent(),
                Value<String> labelEn = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContextTagCompanion(
                id: id,
                labelTr: labelTr,
                labelEn: labelEn,
                isUserCreated: isUserCreated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String labelTr,
                required String labelEn,
                Value<bool> isUserCreated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContextTagCompanion.insert(
                id: id,
                labelTr: labelTr,
                labelEn: labelEn,
                isUserCreated: isUserCreated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContextTagTable, ContextTagRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ContextTagTable,
                    ContextTagRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContextTagTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContextTagTable,
      ContextTagRow,
      $$ContextTagTableFilterComposer,
      $$ContextTagTableOrderingComposer,
      $$ContextTagTableAnnotationComposer,
      $$ContextTagTableCreateCompanionBuilder,
      $$ContextTagTableUpdateCompanionBuilder,
      (
        ContextTagRow,
        BaseReferences<_$AppDatabase, $ContextTagTable, ContextTagRow>,
      ),
      ContextTagRow,
      PrefetchHooks Function()
    >;
typedef $$MealPlanTableCreateCompanionBuilder = MealPlanCompanion Function({
  Value<int> id,
  required String startDateIso,
  Value<String?> name,
  required DateTime createdAtUtc,
});
typedef $$MealPlanTableUpdateCompanionBuilder = MealPlanCompanion Function({
  Value<int> id,
  Value<String> startDateIso,
  Value<String?> name,
  Value<DateTime> createdAtUtc,
});

final class $$MealPlanTableReferences
    extends BaseReferences<_$AppDatabase, $MealPlanTable, MealPlanRow> {
  $$MealPlanTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MealPlanEntryTable, List<MealPlanEntryRow>>
  _mealPlanEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealPlanEntry,
    aliasName: 'meal_plan__id__meal_plan_entry__meal_plan_id',
  );

  $$MealPlanEntryTableProcessedTableManager get mealPlanEntryRefs {
    final manager = $$MealPlanEntryTableTableManager(
      $_db,
      $_db.mealPlanEntry,
    ).filter((f) => f.mealPlanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealPlanEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealPlanTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlanTable> {
  $$MealPlanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDateIso => $composableBuilder(
    column: $table.startDateIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealPlanEntryRefs(
    Expression<bool> Function($$MealPlanEntryTableFilterComposer f) f,
  ) {
    final $$MealPlanEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanEntry,
      getReferencedColumn: (t) => t.mealPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanEntryTableFilterComposer(
            $db: $db,
            $table: $db.mealPlanEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlanTable> {
  $$MealPlanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDateIso => $composableBuilder(
    column: $table.startDateIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealPlanTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlanTable> {
  $$MealPlanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startDateIso => $composableBuilder(
    column: $table.startDateIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  Expression<T> mealPlanEntryRefs<T extends Object>(
    Expression<T> Function($$MealPlanEntryTableAnnotationComposer a) f,
  ) {
    final $$MealPlanEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealPlanEntry,
      getReferencedColumn: (t) => t.mealPlanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlanEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealPlanTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlanTable,
          MealPlanRow,
          $$MealPlanTableFilterComposer,
          $$MealPlanTableOrderingComposer,
          $$MealPlanTableAnnotationComposer,
          $$MealPlanTableCreateCompanionBuilder,
          $$MealPlanTableUpdateCompanionBuilder,
          (MealPlanRow, $$MealPlanTableReferences),
          MealPlanRow,
          PrefetchHooks Function({bool mealPlanEntryRefs})
        > {
  $$MealPlanTableTableManager(_$AppDatabase db, $MealPlanTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> startDateIso = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
              }) => MealPlanCompanion(
                id: id,
                startDateIso: startDateIso,
                name: name,
                createdAtUtc: createdAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String startDateIso,
                Value<String?> name = const Value.absent(),
                required DateTime createdAtUtc,
              }) => MealPlanCompanion.insert(
                id: id,
                startDateIso: startDateIso,
                name: name,
                createdAtUtc: createdAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealPlanTable, MealPlanRow>(table),
                  $$MealPlanTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealPlanEntryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealPlanEntryRefs) db.mealPlanEntry,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealPlanEntryRefs)
                    await $_getPrefetchedData<
                      MealPlanRow,
                      $MealPlanTable,
                      MealPlanEntryRow
                    >(
                      currentTable: table,
                      referencedTable: $$MealPlanTableReferences
                          ._mealPlanEntryRefsTable(db),
                      managerFromTypedResult: (p0) => $$MealPlanTableReferences(
                        db,
                        table,
                        p0,
                      ).mealPlanEntryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mealPlanId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealPlanTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlanTable,
      MealPlanRow,
      $$MealPlanTableFilterComposer,
      $$MealPlanTableOrderingComposer,
      $$MealPlanTableAnnotationComposer,
      $$MealPlanTableCreateCompanionBuilder,
      $$MealPlanTableUpdateCompanionBuilder,
      (MealPlanRow, $$MealPlanTableReferences),
      MealPlanRow,
      PrefetchHooks Function({bool mealPlanEntryRefs})
    >;
typedef $$MealPlanEntryTableCreateCompanionBuilder =
    MealPlanEntryCompanion Function({
      Value<int> id,
      required int mealPlanId,
      required int dayOffset,
      required String mealType,
      Value<String?> recipeId,
      required double servings,
      Value<bool> completed,
      Value<String?> note,
    });
typedef $$MealPlanEntryTableUpdateCompanionBuilder =
    MealPlanEntryCompanion Function({
      Value<int> id,
      Value<int> mealPlanId,
      Value<int> dayOffset,
      Value<String> mealType,
      Value<String?> recipeId,
      Value<double> servings,
      Value<bool> completed,
      Value<String?> note,
    });

final class $$MealPlanEntryTableReferences
    extends
        BaseReferences<_$AppDatabase, $MealPlanEntryTable, MealPlanEntryRow> {
  $$MealPlanEntryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealPlanTable _mealPlanIdTable(_$AppDatabase db) =>
      db.mealPlan.createAlias('meal_plan_entry__meal_plan_id__meal_plan__id');

  $$MealPlanTableProcessedTableManager get mealPlanId {
    final $_column = $_itemColumn<int>('meal_plan_id')!;

    final manager = $$MealPlanTableTableManager(
      $_db,
      $_db.mealPlan,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealPlanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipeTable _recipeIdTable(_$AppDatabase db) =>
      db.recipe.createAlias('meal_plan_entry__recipe_id__recipe__id');

  $$RecipeTableProcessedTableManager? get recipeId {
    final $_column = $_itemColumn<String>('recipe_id');
    if ($_column == null) return null;
    final manager = $$RecipeTableTableManager(
      $_db,
      $_db.recipe,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealPlanEntryTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlanEntryTable> {
  $$MealPlanEntryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOffset => $composableBuilder(
    column: $table.dayOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$MealPlanTableFilterComposer get mealPlanId {
    final $$MealPlanTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.mealPlan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanTableFilterComposer(
            $db: $db,
            $table: $db.mealPlan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableFilterComposer get recipeId {
    final $$RecipeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableFilterComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlanEntryTable> {
  $$MealPlanEntryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOffset => $composableBuilder(
    column: $table.dayOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealPlanTableOrderingComposer get mealPlanId {
    final $$MealPlanTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.mealPlan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanTableOrderingComposer(
            $db: $db,
            $table: $db.mealPlan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableOrderingComposer get recipeId {
    final $$RecipeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableOrderingComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlanEntryTable> {
  $$MealPlanEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOffset =>
      $composableBuilder(column: $table.dayOffset, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<double> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$MealPlanTableAnnotationComposer get mealPlanId {
    final $$MealPlanTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealPlanId,
      referencedTable: $db.mealPlan,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealPlanTableAnnotationComposer(
            $db: $db,
            $table: $db.mealPlan,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipeTableAnnotationComposer get recipeId {
    final $$RecipeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipe,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableAnnotationComposer(
            $db: $db,
            $table: $db.recipe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealPlanEntryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlanEntryTable,
          MealPlanEntryRow,
          $$MealPlanEntryTableFilterComposer,
          $$MealPlanEntryTableOrderingComposer,
          $$MealPlanEntryTableAnnotationComposer,
          $$MealPlanEntryTableCreateCompanionBuilder,
          $$MealPlanEntryTableUpdateCompanionBuilder,
          (MealPlanEntryRow, $$MealPlanEntryTableReferences),
          MealPlanEntryRow,
          PrefetchHooks Function({bool mealPlanId, bool recipeId})
        > {
  $$MealPlanEntryTableTableManager(_$AppDatabase db, $MealPlanEntryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlanEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlanEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlanEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealPlanId = const Value.absent(),
                Value<int> dayOffset = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String?> recipeId = const Value.absent(),
                Value<double> servings = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => MealPlanEntryCompanion(
                id: id,
                mealPlanId: mealPlanId,
                dayOffset: dayOffset,
                mealType: mealType,
                recipeId: recipeId,
                servings: servings,
                completed: completed,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealPlanId,
                required int dayOffset,
                required String mealType,
                Value<String?> recipeId = const Value.absent(),
                required double servings,
                Value<bool> completed = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => MealPlanEntryCompanion.insert(
                id: id,
                mealPlanId: mealPlanId,
                dayOffset: dayOffset,
                mealType: mealType,
                recipeId: recipeId,
                servings: servings,
                completed: completed,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealPlanEntryTable, MealPlanEntryRow>(table),
                  $$MealPlanEntryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealPlanId = false, recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mealPlanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mealPlanId,
                        referencedTable: $$MealPlanEntryTableReferences
                            ._mealPlanIdTable(db),
                        referencedColumn: $$MealPlanEntryTableReferences
                            ._mealPlanIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$MealPlanEntryTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$MealPlanEntryTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealPlanEntryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlanEntryTable,
      MealPlanEntryRow,
      $$MealPlanEntryTableFilterComposer,
      $$MealPlanEntryTableOrderingComposer,
      $$MealPlanEntryTableAnnotationComposer,
      $$MealPlanEntryTableCreateCompanionBuilder,
      $$MealPlanEntryTableUpdateCompanionBuilder,
      (MealPlanEntryRow, $$MealPlanEntryTableReferences),
      MealPlanEntryRow,
      PrefetchHooks Function({bool mealPlanId, bool recipeId})
    >;
typedef $$ShoppingListTableCreateCompanionBuilder =
    ShoppingListCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> dateStartIso,
      Value<String?> dateEndIso,
      required DateTime createdAtUtc,
    });
typedef $$ShoppingListTableUpdateCompanionBuilder =
    ShoppingListCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> dateStartIso,
      Value<String?> dateEndIso,
      Value<DateTime> createdAtUtc,
    });

final class $$ShoppingListTableReferences
    extends BaseReferences<_$AppDatabase, $ShoppingListTable, ShoppingListRow> {
  $$ShoppingListTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ShoppingListItemTable, List<ShoppingListItemRow>>
  _shoppingListItemRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shoppingListItem,
    aliasName: 'shopping_list__id__shopping_list_item__shopping_list_id',
  );

  $$ShoppingListItemTableProcessedTableManager get shoppingListItemRefs {
    final manager = $$ShoppingListItemTableTableManager(
      $_db,
      $_db.shoppingListItem,
    ).filter((f) => f.shoppingListId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _shoppingListItemRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShoppingListTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListTable> {
  $$ShoppingListTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateStartIso => $composableBuilder(
    column: $table.dateStartIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateEndIso => $composableBuilder(
    column: $table.dateEndIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> shoppingListItemRefs(
    Expression<bool> Function($$ShoppingListItemTableFilterComposer f) f,
  ) {
    final $$ShoppingListItemTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingListItem,
      getReferencedColumn: (t) => t.shoppingListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListItemTableFilterComposer(
            $db: $db,
            $table: $db.shoppingListItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShoppingListTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListTable> {
  $$ShoppingListTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateStartIso => $composableBuilder(
    column: $table.dateStartIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateEndIso => $composableBuilder(
    column: $table.dateEndIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShoppingListTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListTable> {
  $$ShoppingListTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get dateStartIso => $composableBuilder(
    column: $table.dateStartIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateEndIso => $composableBuilder(
    column: $table.dateEndIso,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  Expression<T> shoppingListItemRefs<T extends Object>(
    Expression<T> Function($$ShoppingListItemTableAnnotationComposer a) f,
  ) {
    final $$ShoppingListItemTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingListItem,
      getReferencedColumn: (t) => t.shoppingListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListItemTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingListItem,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShoppingListTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingListTable,
          ShoppingListRow,
          $$ShoppingListTableFilterComposer,
          $$ShoppingListTableOrderingComposer,
          $$ShoppingListTableAnnotationComposer,
          $$ShoppingListTableCreateCompanionBuilder,
          $$ShoppingListTableUpdateCompanionBuilder,
          (ShoppingListRow, $$ShoppingListTableReferences),
          ShoppingListRow,
          PrefetchHooks Function({bool shoppingListItemRefs})
        > {
  $$ShoppingListTableTableManager(_$AppDatabase db, $ShoppingListTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> dateStartIso = const Value.absent(),
                Value<String?> dateEndIso = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
              }) => ShoppingListCompanion(
                id: id,
                title: title,
                dateStartIso: dateStartIso,
                dateEndIso: dateEndIso,
                createdAtUtc: createdAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> dateStartIso = const Value.absent(),
                Value<String?> dateEndIso = const Value.absent(),
                required DateTime createdAtUtc,
              }) => ShoppingListCompanion.insert(
                id: id,
                title: title,
                dateStartIso: dateStartIso,
                dateEndIso: dateEndIso,
                createdAtUtc: createdAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShoppingListTable, ShoppingListRow>(table),
                  $$ShoppingListTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shoppingListItemRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (shoppingListItemRefs) db.shoppingListItem,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shoppingListItemRefs)
                    await $_getPrefetchedData<
                      ShoppingListRow,
                      $ShoppingListTable,
                      ShoppingListItemRow
                    >(
                      currentTable: table,
                      referencedTable: $$ShoppingListTableReferences
                          ._shoppingListItemRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ShoppingListTableReferences(
                            db,
                            table,
                            p0,
                          ).shoppingListItemRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.shoppingListId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ShoppingListTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingListTable,
      ShoppingListRow,
      $$ShoppingListTableFilterComposer,
      $$ShoppingListTableOrderingComposer,
      $$ShoppingListTableAnnotationComposer,
      $$ShoppingListTableCreateCompanionBuilder,
      $$ShoppingListTableUpdateCompanionBuilder,
      (ShoppingListRow, $$ShoppingListTableReferences),
      ShoppingListRow,
      PrefetchHooks Function({bool shoppingListItemRefs})
    >;
typedef $$ShoppingListItemTableCreateCompanionBuilder =
    ShoppingListItemCompanion Function({
      Value<int> id,
      required int shoppingListId,
      Value<String?> foodId,
      Value<String?> label,
      Value<double?> quantityGrams,
      Value<String?> quantityDisplay,
      Value<String?> category,
      Value<bool> isChecked,
    });
typedef $$ShoppingListItemTableUpdateCompanionBuilder =
    ShoppingListItemCompanion Function({
      Value<int> id,
      Value<int> shoppingListId,
      Value<String?> foodId,
      Value<String?> label,
      Value<double?> quantityGrams,
      Value<String?> quantityDisplay,
      Value<String?> category,
      Value<bool> isChecked,
    });

final class $$ShoppingListItemTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ShoppingListItemTable,
          ShoppingListItemRow
        > {
  $$ShoppingListItemTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShoppingListTable _shoppingListIdTable(_$AppDatabase db) => db
      .shoppingList
      .createAlias('shopping_list_item__shopping_list_id__shopping_list__id');

  $$ShoppingListTableProcessedTableManager get shoppingListId {
    final $_column = $_itemColumn<int>('shopping_list_id')!;

    final manager = $$ShoppingListTableTableManager(
      $_db,
      $_db.shoppingList,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shoppingListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FoodTable _foodIdTable(_$AppDatabase db) =>
      db.food.createAlias('shopping_list_item__food_id__food__id');

  $$FoodTableProcessedTableManager? get foodId {
    final $_column = $_itemColumn<String>('food_id');
    if ($_column == null) return null;
    final manager = $$FoodTableTableManager(
      $_db,
      $_db.food,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShoppingListItemTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTable> {
  $$ShoppingListItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityGrams => $composableBuilder(
    column: $table.quantityGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantityDisplay => $composableBuilder(
    column: $table.quantityDisplay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  $$ShoppingListTableFilterComposer get shoppingListId {
    final $$ShoppingListTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoppingListId,
      referencedTable: $db.shoppingList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListTableFilterComposer(
            $db: $db,
            $table: $db.shoppingList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableFilterComposer get foodId {
    final $$FoodTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableFilterComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingListItemTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTable> {
  $$ShoppingListItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityGrams => $composableBuilder(
    column: $table.quantityGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantityDisplay => $composableBuilder(
    column: $table.quantityDisplay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShoppingListTableOrderingComposer get shoppingListId {
    final $$ShoppingListTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoppingListId,
      referencedTable: $db.shoppingList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListTableOrderingComposer(
            $db: $db,
            $table: $db.shoppingList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableOrderingComposer get foodId {
    final $$FoodTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableOrderingComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingListItemTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListItemTable> {
  $$ShoppingListItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get quantityGrams => $composableBuilder(
    column: $table.quantityGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantityDisplay => $composableBuilder(
    column: $table.quantityDisplay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  $$ShoppingListTableAnnotationComposer get shoppingListId {
    final $$ShoppingListTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shoppingListId,
      referencedTable: $db.shoppingList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingListTableAnnotationComposer(
            $db: $db,
            $table: $db.shoppingList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodTableAnnotationComposer get foodId {
    final $$FoodTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.food,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodTableAnnotationComposer(
            $db: $db,
            $table: $db.food,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingListItemTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingListItemTable,
          ShoppingListItemRow,
          $$ShoppingListItemTableFilterComposer,
          $$ShoppingListItemTableOrderingComposer,
          $$ShoppingListItemTableAnnotationComposer,
          $$ShoppingListItemTableCreateCompanionBuilder,
          $$ShoppingListItemTableUpdateCompanionBuilder,
          (ShoppingListItemRow, $$ShoppingListItemTableReferences),
          ShoppingListItemRow,
          PrefetchHooks Function({bool shoppingListId, bool foodId})
        > {
  $$ShoppingListItemTableTableManager(
    _$AppDatabase db,
    $ShoppingListItemTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> shoppingListId = const Value.absent(),
                Value<String?> foodId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<double?> quantityGrams = const Value.absent(),
                Value<String?> quantityDisplay = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
              }) => ShoppingListItemCompanion(
                id: id,
                shoppingListId: shoppingListId,
                foodId: foodId,
                label: label,
                quantityGrams: quantityGrams,
                quantityDisplay: quantityDisplay,
                category: category,
                isChecked: isChecked,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int shoppingListId,
                Value<String?> foodId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<double?> quantityGrams = const Value.absent(),
                Value<String?> quantityDisplay = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
              }) => ShoppingListItemCompanion.insert(
                id: id,
                shoppingListId: shoppingListId,
                foodId: foodId,
                label: label,
                quantityGrams: quantityGrams,
                quantityDisplay: quantityDisplay,
                category: category,
                isChecked: isChecked,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShoppingListItemTable, ShoppingListItemRow>(
                    table,
                  ),
                  $$ShoppingListItemTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shoppingListId = false, foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shoppingListId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.shoppingListId,
                        referencedTable: $$ShoppingListItemTableReferences
                            ._shoppingListIdTable(db),
                        referencedColumn: $$ShoppingListItemTableReferences
                            ._shoppingListIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (foodId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.foodId,
                        referencedTable: $$ShoppingListItemTableReferences
                            ._foodIdTable(db),
                        referencedColumn: $$ShoppingListItemTableReferences
                            ._foodIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShoppingListItemTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingListItemTable,
      ShoppingListItemRow,
      $$ShoppingListItemTableFilterComposer,
      $$ShoppingListItemTableOrderingComposer,
      $$ShoppingListItemTableAnnotationComposer,
      $$ShoppingListItemTableCreateCompanionBuilder,
      $$ShoppingListItemTableUpdateCompanionBuilder,
      (ShoppingListItemRow, $$ShoppingListItemTableReferences),
      ShoppingListItemRow,
      PrefetchHooks Function({bool shoppingListId, bool foodId})
    >;
typedef $$EvidenceSourceTableCreateCompanionBuilder =
    EvidenceSourceCompanion Function({
      required String id,
      required String titleTr,
      required String titleEn,
      required String plainSummaryTr,
      required String plainSummaryEn,
      required String evidenceLevel,
      required String studyType,
      required String population,
      Value<int?> sampleSize,
      required int year,
      required String authorsCsv,
      required String journal,
      Value<String?> doi,
      Value<int?> pmid,
      Value<String?> pmcid,
      required String canonicalUrl,
      required String accessedAtIso,
      required String contentVersion,
      required String lastReviewedAtIso,
      required String reviewedByRole,
      required String limitationsTr,
      required String limitationsEn,
      Value<String?> conflictsOrFundingNoteTr,
      Value<String?> conflictsOrFundingNoteEn,
      Value<int> rowid,
    });
typedef $$EvidenceSourceTableUpdateCompanionBuilder =
    EvidenceSourceCompanion Function({
      Value<String> id,
      Value<String> titleTr,
      Value<String> titleEn,
      Value<String> plainSummaryTr,
      Value<String> plainSummaryEn,
      Value<String> evidenceLevel,
      Value<String> studyType,
      Value<String> population,
      Value<int?> sampleSize,
      Value<int> year,
      Value<String> authorsCsv,
      Value<String> journal,
      Value<String?> doi,
      Value<int?> pmid,
      Value<String?> pmcid,
      Value<String> canonicalUrl,
      Value<String> accessedAtIso,
      Value<String> contentVersion,
      Value<String> lastReviewedAtIso,
      Value<String> reviewedByRole,
      Value<String> limitationsTr,
      Value<String> limitationsEn,
      Value<String?> conflictsOrFundingNoteTr,
      Value<String?> conflictsOrFundingNoteEn,
      Value<int> rowid,
    });

final class $$EvidenceSourceTableReferences
    extends
        BaseReferences<_$AppDatabase, $EvidenceSourceTable, EvidenceSourceRow> {
  $$EvidenceSourceTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$EvidenceClaimTable, List<EvidenceClaimRow>>
  _evidenceClaimRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.evidenceClaim,
    aliasName: 'evidence_source__id__evidence_claim__source_id',
  );

  $$EvidenceClaimTableProcessedTableManager get evidenceClaimRefs {
    final manager = $$EvidenceClaimTableTableManager(
      $_db,
      $_db.evidenceClaim,
    ).filter((f) => f.sourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_evidenceClaimRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EvidenceSourceTableFilterComposer
    extends Composer<_$AppDatabase, $EvidenceSourceTable> {
  $$EvidenceSourceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plainSummaryTr => $composableBuilder(
    column: $table.plainSummaryTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plainSummaryEn => $composableBuilder(
    column: $table.plainSummaryEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studyType => $composableBuilder(
    column: $table.studyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleSize => $composableBuilder(
    column: $table.sampleSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorsCsv => $composableBuilder(
    column: $table.authorsCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get journal => $composableBuilder(
    column: $table.journal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doi => $composableBuilder(
    column: $table.doi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pmid => $composableBuilder(
    column: $table.pmid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pmcid => $composableBuilder(
    column: $table.pmcid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalUrl => $composableBuilder(
    column: $table.canonicalUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accessedAtIso => $composableBuilder(
    column: $table.accessedAtIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewedByRole => $composableBuilder(
    column: $table.reviewedByRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get limitationsTr => $composableBuilder(
    column: $table.limitationsTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get limitationsEn => $composableBuilder(
    column: $table.limitationsEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conflictsOrFundingNoteTr => $composableBuilder(
    column: $table.conflictsOrFundingNoteTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conflictsOrFundingNoteEn => $composableBuilder(
    column: $table.conflictsOrFundingNoteEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> evidenceClaimRefs(
    Expression<bool> Function($$EvidenceClaimTableFilterComposer f) f,
  ) {
    final $$EvidenceClaimTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evidenceClaim,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceClaimTableFilterComposer(
            $db: $db,
            $table: $db.evidenceClaim,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EvidenceSourceTableOrderingComposer
    extends Composer<_$AppDatabase, $EvidenceSourceTable> {
  $$EvidenceSourceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plainSummaryTr => $composableBuilder(
    column: $table.plainSummaryTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plainSummaryEn => $composableBuilder(
    column: $table.plainSummaryEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studyType => $composableBuilder(
    column: $table.studyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleSize => $composableBuilder(
    column: $table.sampleSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorsCsv => $composableBuilder(
    column: $table.authorsCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get journal => $composableBuilder(
    column: $table.journal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doi => $composableBuilder(
    column: $table.doi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pmid => $composableBuilder(
    column: $table.pmid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pmcid => $composableBuilder(
    column: $table.pmcid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalUrl => $composableBuilder(
    column: $table.canonicalUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accessedAtIso => $composableBuilder(
    column: $table.accessedAtIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewedByRole => $composableBuilder(
    column: $table.reviewedByRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get limitationsTr => $composableBuilder(
    column: $table.limitationsTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get limitationsEn => $composableBuilder(
    column: $table.limitationsEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conflictsOrFundingNoteTr => $composableBuilder(
    column: $table.conflictsOrFundingNoteTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conflictsOrFundingNoteEn => $composableBuilder(
    column: $table.conflictsOrFundingNoteEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EvidenceSourceTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvidenceSourceTable> {
  $$EvidenceSourceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleTr =>
      $composableBuilder(column: $table.titleTr, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get plainSummaryTr => $composableBuilder(
    column: $table.plainSummaryTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plainSummaryEn => $composableBuilder(
    column: $table.plainSummaryEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get studyType =>
      $composableBuilder(column: $table.studyType, builder: (column) => column);

  GeneratedColumn<String> get population => $composableBuilder(
    column: $table.population,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sampleSize => $composableBuilder(
    column: $table.sampleSize,
    builder: (column) => column,
  );

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get authorsCsv => $composableBuilder(
    column: $table.authorsCsv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get journal =>
      $composableBuilder(column: $table.journal, builder: (column) => column);

  GeneratedColumn<String> get doi =>
      $composableBuilder(column: $table.doi, builder: (column) => column);

  GeneratedColumn<int> get pmid =>
      $composableBuilder(column: $table.pmid, builder: (column) => column);

  GeneratedColumn<String> get pmcid =>
      $composableBuilder(column: $table.pmcid, builder: (column) => column);

  GeneratedColumn<String> get canonicalUrl => $composableBuilder(
    column: $table.canonicalUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accessedAtIso => $composableBuilder(
    column: $table.accessedAtIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastReviewedAtIso => $composableBuilder(
    column: $table.lastReviewedAtIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewedByRole => $composableBuilder(
    column: $table.reviewedByRole,
    builder: (column) => column,
  );

  GeneratedColumn<String> get limitationsTr => $composableBuilder(
    column: $table.limitationsTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get limitationsEn => $composableBuilder(
    column: $table.limitationsEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conflictsOrFundingNoteTr => $composableBuilder(
    column: $table.conflictsOrFundingNoteTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conflictsOrFundingNoteEn => $composableBuilder(
    column: $table.conflictsOrFundingNoteEn,
    builder: (column) => column,
  );

  Expression<T> evidenceClaimRefs<T extends Object>(
    Expression<T> Function($$EvidenceClaimTableAnnotationComposer a) f,
  ) {
    final $$EvidenceClaimTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.evidenceClaim,
      getReferencedColumn: (t) => t.sourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceClaimTableAnnotationComposer(
            $db: $db,
            $table: $db.evidenceClaim,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EvidenceSourceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvidenceSourceTable,
          EvidenceSourceRow,
          $$EvidenceSourceTableFilterComposer,
          $$EvidenceSourceTableOrderingComposer,
          $$EvidenceSourceTableAnnotationComposer,
          $$EvidenceSourceTableCreateCompanionBuilder,
          $$EvidenceSourceTableUpdateCompanionBuilder,
          (EvidenceSourceRow, $$EvidenceSourceTableReferences),
          EvidenceSourceRow,
          PrefetchHooks Function({bool evidenceClaimRefs})
        > {
  $$EvidenceSourceTableTableManager(
    _$AppDatabase db,
    $EvidenceSourceTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvidenceSourceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvidenceSourceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvidenceSourceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titleTr = const Value.absent(),
                Value<String> titleEn = const Value.absent(),
                Value<String> plainSummaryTr = const Value.absent(),
                Value<String> plainSummaryEn = const Value.absent(),
                Value<String> evidenceLevel = const Value.absent(),
                Value<String> studyType = const Value.absent(),
                Value<String> population = const Value.absent(),
                Value<int?> sampleSize = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String> authorsCsv = const Value.absent(),
                Value<String> journal = const Value.absent(),
                Value<String?> doi = const Value.absent(),
                Value<int?> pmid = const Value.absent(),
                Value<String?> pmcid = const Value.absent(),
                Value<String> canonicalUrl = const Value.absent(),
                Value<String> accessedAtIso = const Value.absent(),
                Value<String> contentVersion = const Value.absent(),
                Value<String> lastReviewedAtIso = const Value.absent(),
                Value<String> reviewedByRole = const Value.absent(),
                Value<String> limitationsTr = const Value.absent(),
                Value<String> limitationsEn = const Value.absent(),
                Value<String?> conflictsOrFundingNoteTr = const Value.absent(),
                Value<String?> conflictsOrFundingNoteEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EvidenceSourceCompanion(
                id: id,
                titleTr: titleTr,
                titleEn: titleEn,
                plainSummaryTr: plainSummaryTr,
                plainSummaryEn: plainSummaryEn,
                evidenceLevel: evidenceLevel,
                studyType: studyType,
                population: population,
                sampleSize: sampleSize,
                year: year,
                authorsCsv: authorsCsv,
                journal: journal,
                doi: doi,
                pmid: pmid,
                pmcid: pmcid,
                canonicalUrl: canonicalUrl,
                accessedAtIso: accessedAtIso,
                contentVersion: contentVersion,
                lastReviewedAtIso: lastReviewedAtIso,
                reviewedByRole: reviewedByRole,
                limitationsTr: limitationsTr,
                limitationsEn: limitationsEn,
                conflictsOrFundingNoteTr: conflictsOrFundingNoteTr,
                conflictsOrFundingNoteEn: conflictsOrFundingNoteEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titleTr,
                required String titleEn,
                required String plainSummaryTr,
                required String plainSummaryEn,
                required String evidenceLevel,
                required String studyType,
                required String population,
                Value<int?> sampleSize = const Value.absent(),
                required int year,
                required String authorsCsv,
                required String journal,
                Value<String?> doi = const Value.absent(),
                Value<int?> pmid = const Value.absent(),
                Value<String?> pmcid = const Value.absent(),
                required String canonicalUrl,
                required String accessedAtIso,
                required String contentVersion,
                required String lastReviewedAtIso,
                required String reviewedByRole,
                required String limitationsTr,
                required String limitationsEn,
                Value<String?> conflictsOrFundingNoteTr = const Value.absent(),
                Value<String?> conflictsOrFundingNoteEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EvidenceSourceCompanion.insert(
                id: id,
                titleTr: titleTr,
                titleEn: titleEn,
                plainSummaryTr: plainSummaryTr,
                plainSummaryEn: plainSummaryEn,
                evidenceLevel: evidenceLevel,
                studyType: studyType,
                population: population,
                sampleSize: sampleSize,
                year: year,
                authorsCsv: authorsCsv,
                journal: journal,
                doi: doi,
                pmid: pmid,
                pmcid: pmcid,
                canonicalUrl: canonicalUrl,
                accessedAtIso: accessedAtIso,
                contentVersion: contentVersion,
                lastReviewedAtIso: lastReviewedAtIso,
                reviewedByRole: reviewedByRole,
                limitationsTr: limitationsTr,
                limitationsEn: limitationsEn,
                conflictsOrFundingNoteTr: conflictsOrFundingNoteTr,
                conflictsOrFundingNoteEn: conflictsOrFundingNoteEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvidenceSourceTable, EvidenceSourceRow>(table),
                  $$EvidenceSourceTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({evidenceClaimRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (evidenceClaimRefs) db.evidenceClaim,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (evidenceClaimRefs)
                    await $_getPrefetchedData<
                      EvidenceSourceRow,
                      $EvidenceSourceTable,
                      EvidenceClaimRow
                    >(
                      currentTable: table,
                      referencedTable: $$EvidenceSourceTableReferences
                          ._evidenceClaimRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EvidenceSourceTableReferences(
                            db,
                            table,
                            p0,
                          ).evidenceClaimRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sourceId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EvidenceSourceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvidenceSourceTable,
      EvidenceSourceRow,
      $$EvidenceSourceTableFilterComposer,
      $$EvidenceSourceTableOrderingComposer,
      $$EvidenceSourceTableAnnotationComposer,
      $$EvidenceSourceTableCreateCompanionBuilder,
      $$EvidenceSourceTableUpdateCompanionBuilder,
      (EvidenceSourceRow, $$EvidenceSourceTableReferences),
      EvidenceSourceRow,
      PrefetchHooks Function({bool evidenceClaimRefs})
    >;
typedef $$EvidenceClaimTableCreateCompanionBuilder =
    EvidenceClaimCompanion Function({
      required String id,
      required String sourceId,
      required String textTr,
      required String textEn,
      required String evidenceLevel,
      Value<String?> linkedFeatureIdsCsv,
      Value<int> rowid,
    });
typedef $$EvidenceClaimTableUpdateCompanionBuilder =
    EvidenceClaimCompanion Function({
      Value<String> id,
      Value<String> sourceId,
      Value<String> textTr,
      Value<String> textEn,
      Value<String> evidenceLevel,
      Value<String?> linkedFeatureIdsCsv,
      Value<int> rowid,
    });

final class $$EvidenceClaimTableReferences
    extends
        BaseReferences<_$AppDatabase, $EvidenceClaimTable, EvidenceClaimRow> {
  $$EvidenceClaimTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EvidenceSourceTable _sourceIdTable(_$AppDatabase db) => db
      .evidenceSource
      .createAlias('evidence_claim__source_id__evidence_source__id');

  $$EvidenceSourceTableProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $$EvidenceSourceTableTableManager(
      $_db,
      $_db.evidenceSource,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EvidenceClaimTableFilterComposer
    extends Composer<_$AppDatabase, $EvidenceClaimTable> {
  $$EvidenceClaimTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textTr => $composableBuilder(
    column: $table.textTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedFeatureIdsCsv => $composableBuilder(
    column: $table.linkedFeatureIdsCsv,
    builder: (column) => ColumnFilters(column),
  );

  $$EvidenceSourceTableFilterComposer get sourceId {
    final $$EvidenceSourceTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.evidenceSource,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceSourceTableFilterComposer(
            $db: $db,
            $table: $db.evidenceSource,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceClaimTableOrderingComposer
    extends Composer<_$AppDatabase, $EvidenceClaimTable> {
  $$EvidenceClaimTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textTr => $composableBuilder(
    column: $table.textTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedFeatureIdsCsv => $composableBuilder(
    column: $table.linkedFeatureIdsCsv,
    builder: (column) => ColumnOrderings(column),
  );

  $$EvidenceSourceTableOrderingComposer get sourceId {
    final $$EvidenceSourceTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.evidenceSource,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceSourceTableOrderingComposer(
            $db: $db,
            $table: $db.evidenceSource,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceClaimTableAnnotationComposer
    extends Composer<_$AppDatabase, $EvidenceClaimTable> {
  $$EvidenceClaimTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textTr =>
      $composableBuilder(column: $table.textTr, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get evidenceLevel => $composableBuilder(
    column: $table.evidenceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedFeatureIdsCsv => $composableBuilder(
    column: $table.linkedFeatureIdsCsv,
    builder: (column) => column,
  );

  $$EvidenceSourceTableAnnotationComposer get sourceId {
    final $$EvidenceSourceTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceId,
      referencedTable: $db.evidenceSource,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EvidenceSourceTableAnnotationComposer(
            $db: $db,
            $table: $db.evidenceSource,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EvidenceClaimTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EvidenceClaimTable,
          EvidenceClaimRow,
          $$EvidenceClaimTableFilterComposer,
          $$EvidenceClaimTableOrderingComposer,
          $$EvidenceClaimTableAnnotationComposer,
          $$EvidenceClaimTableCreateCompanionBuilder,
          $$EvidenceClaimTableUpdateCompanionBuilder,
          (EvidenceClaimRow, $$EvidenceClaimTableReferences),
          EvidenceClaimRow,
          PrefetchHooks Function({bool sourceId})
        > {
  $$EvidenceClaimTableTableManager(_$AppDatabase db, $EvidenceClaimTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvidenceClaimTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvidenceClaimTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvidenceClaimTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> textTr = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String> evidenceLevel = const Value.absent(),
                Value<String?> linkedFeatureIdsCsv = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EvidenceClaimCompanion(
                id: id,
                sourceId: sourceId,
                textTr: textTr,
                textEn: textEn,
                evidenceLevel: evidenceLevel,
                linkedFeatureIdsCsv: linkedFeatureIdsCsv,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceId,
                required String textTr,
                required String textEn,
                required String evidenceLevel,
                Value<String?> linkedFeatureIdsCsv = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EvidenceClaimCompanion.insert(
                id: id,
                sourceId: sourceId,
                textTr: textTr,
                textEn: textEn,
                evidenceLevel: evidenceLevel,
                linkedFeatureIdsCsv: linkedFeatureIdsCsv,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EvidenceClaimTable, EvidenceClaimRow>(table),
                  $$EvidenceClaimTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sourceId,
                        referencedTable: $$EvidenceClaimTableReferences
                            ._sourceIdTable(db),
                        referencedColumn: $$EvidenceClaimTableReferences
                            ._sourceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EvidenceClaimTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EvidenceClaimTable,
      EvidenceClaimRow,
      $$EvidenceClaimTableFilterComposer,
      $$EvidenceClaimTableOrderingComposer,
      $$EvidenceClaimTableAnnotationComposer,
      $$EvidenceClaimTableCreateCompanionBuilder,
      $$EvidenceClaimTableUpdateCompanionBuilder,
      (EvidenceClaimRow, $$EvidenceClaimTableReferences),
      EvidenceClaimRow,
      PrefetchHooks Function({bool sourceId})
    >;
typedef $$ContentVersionTableCreateCompanionBuilder =
    ContentVersionCompanion Function({
      required String id,
      required String version,
      required String releasedAtIso,
      Value<String?> changeLogTr,
      Value<String?> changeLogEn,
      Value<int> rowid,
    });
typedef $$ContentVersionTableUpdateCompanionBuilder =
    ContentVersionCompanion Function({
      Value<String> id,
      Value<String> version,
      Value<String> releasedAtIso,
      Value<String?> changeLogTr,
      Value<String?> changeLogEn,
      Value<int> rowid,
    });

class $$ContentVersionTableFilterComposer
    extends Composer<_$AppDatabase, $ContentVersionTable> {
  $$ContentVersionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releasedAtIso => $composableBuilder(
    column: $table.releasedAtIso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeLogTr => $composableBuilder(
    column: $table.changeLogTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeLogEn => $composableBuilder(
    column: $table.changeLogEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContentVersionTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentVersionTable> {
  $$ContentVersionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releasedAtIso => $composableBuilder(
    column: $table.releasedAtIso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeLogTr => $composableBuilder(
    column: $table.changeLogTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeLogEn => $composableBuilder(
    column: $table.changeLogEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentVersionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentVersionTable> {
  $$ContentVersionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get releasedAtIso => $composableBuilder(
    column: $table.releasedAtIso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeLogTr => $composableBuilder(
    column: $table.changeLogTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeLogEn => $composableBuilder(
    column: $table.changeLogEn,
    builder: (column) => column,
  );
}

class $$ContentVersionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentVersionTable,
          ContentVersionRow,
          $$ContentVersionTableFilterComposer,
          $$ContentVersionTableOrderingComposer,
          $$ContentVersionTableAnnotationComposer,
          $$ContentVersionTableCreateCompanionBuilder,
          $$ContentVersionTableUpdateCompanionBuilder,
          (
            ContentVersionRow,
            BaseReferences<
              _$AppDatabase,
              $ContentVersionTable,
              ContentVersionRow
            >,
          ),
          ContentVersionRow,
          PrefetchHooks Function()
        > {
  $$ContentVersionTableTableManager(
    _$AppDatabase db,
    $ContentVersionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentVersionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentVersionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentVersionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<String> releasedAtIso = const Value.absent(),
                Value<String?> changeLogTr = const Value.absent(),
                Value<String?> changeLogEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentVersionCompanion(
                id: id,
                version: version,
                releasedAtIso: releasedAtIso,
                changeLogTr: changeLogTr,
                changeLogEn: changeLogEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String version,
                required String releasedAtIso,
                Value<String?> changeLogTr = const Value.absent(),
                Value<String?> changeLogEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentVersionCompanion.insert(
                id: id,
                version: version,
                releasedAtIso: releasedAtIso,
                changeLogTr: changeLogTr,
                changeLogEn: changeLogEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContentVersionTable, ContentVersionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ContentVersionTable,
                    ContentVersionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContentVersionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentVersionTable,
      ContentVersionRow,
      $$ContentVersionTableFilterComposer,
      $$ContentVersionTableOrderingComposer,
      $$ContentVersionTableAnnotationComposer,
      $$ContentVersionTableCreateCompanionBuilder,
      $$ContentVersionTableUpdateCompanionBuilder,
      (
        ContentVersionRow,
        BaseReferences<_$AppDatabase, $ContentVersionTable, ContentVersionRow>,
      ),
      ContentVersionRow,
      PrefetchHooks Function()
    >;
typedef $$ExportHistoryTableCreateCompanionBuilder =
    ExportHistoryCompanion Function({
      Value<int> id,
      required DateTime exportedAtUtc,
      required String format,
      Value<int?> recordCount,
      required int schemaVersion,
      required String appVersion,
      Value<String?> note,
    });
typedef $$ExportHistoryTableUpdateCompanionBuilder =
    ExportHistoryCompanion Function({
      Value<int> id,
      Value<DateTime> exportedAtUtc,
      Value<String> format,
      Value<int?> recordCount,
      Value<int> schemaVersion,
      Value<String> appVersion,
      Value<String?> note,
    });

class $$ExportHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ExportHistoryTable> {
  $$ExportHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get exportedAtUtc => $composableBuilder(
    column: $table.exportedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordCount => $composableBuilder(
    column: $table.recordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExportHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ExportHistoryTable> {
  $$ExportHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get exportedAtUtc => $composableBuilder(
    column: $table.exportedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordCount => $composableBuilder(
    column: $table.recordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExportHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExportHistoryTable> {
  $$ExportHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get exportedAtUtc => $composableBuilder(
    column: $table.exportedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get recordCount => $composableBuilder(
    column: $table.recordCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$ExportHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExportHistoryTable,
          ExportHistoryRow,
          $$ExportHistoryTableFilterComposer,
          $$ExportHistoryTableOrderingComposer,
          $$ExportHistoryTableAnnotationComposer,
          $$ExportHistoryTableCreateCompanionBuilder,
          $$ExportHistoryTableUpdateCompanionBuilder,
          (
            ExportHistoryRow,
            BaseReferences<
              _$AppDatabase,
              $ExportHistoryTable,
              ExportHistoryRow
            >,
          ),
          ExportHistoryRow,
          PrefetchHooks Function()
        > {
  $$ExportHistoryTableTableManager(_$AppDatabase db, $ExportHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExportHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExportHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExportHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> exportedAtUtc = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<int?> recordCount = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<String> appVersion = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => ExportHistoryCompanion(
                id: id,
                exportedAtUtc: exportedAtUtc,
                format: format,
                recordCount: recordCount,
                schemaVersion: schemaVersion,
                appVersion: appVersion,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime exportedAtUtc,
                required String format,
                Value<int?> recordCount = const Value.absent(),
                required int schemaVersion,
                required String appVersion,
                Value<String?> note = const Value.absent(),
              }) => ExportHistoryCompanion.insert(
                id: id,
                exportedAtUtc: exportedAtUtc,
                format: format,
                recordCount: recordCount,
                schemaVersion: schemaVersion,
                appVersion: appVersion,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExportHistoryTable, ExportHistoryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExportHistoryTable,
                    ExportHistoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExportHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExportHistoryTable,
      ExportHistoryRow,
      $$ExportHistoryTableFilterComposer,
      $$ExportHistoryTableOrderingComposer,
      $$ExportHistoryTableAnnotationComposer,
      $$ExportHistoryTableCreateCompanionBuilder,
      $$ExportHistoryTableUpdateCompanionBuilder,
      (
        ExportHistoryRow,
        BaseReferences<_$AppDatabase, $ExportHistoryTable, ExportHistoryRow>,
      ),
      ExportHistoryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$ConsentRecordsTableTableManager get consentRecords =>
      $$ConsentRecordsTableTableManager(_db, _db.consentRecords);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
  $$RiskScreeningTableTableManager get riskScreening =>
      $$RiskScreeningTableTableManager(_db, _db.riskScreening);
  $$EnergyEstimateTableTableManager get energyEstimate =>
      $$EnergyEstimateTableTableManager(_db, _db.energyEstimate);
  $$GoalTableTableManager get goal => $$GoalTableTableManager(_db, _db.goal);
  $$FoodTableTableManager get food => $$FoodTableTableManager(_db, _db.food);
  $$ServingOptionTableTableManager get servingOption =>
      $$ServingOptionTableTableManager(_db, _db.servingOption);
  $$RecipeTableTableManager get recipe =>
      $$RecipeTableTableManager(_db, _db.recipe);
  $$RecipeIngredientTableTableManager get recipeIngredient =>
      $$RecipeIngredientTableTableManager(_db, _db.recipeIngredient);
  $$MealTableTableManager get meal => $$MealTableTableManager(_db, _db.meal);
  $$MealItemTableTableManager get mealItem =>
      $$MealItemTableTableManager(_db, _db.mealItem);
  $$GlucoseMeasurementTableTableManager get glucoseMeasurement =>
      $$GlucoseMeasurementTableTableManager(_db, _db.glucoseMeasurement);
  $$KetoneMeasurementTableTableManager get ketoneMeasurement =>
      $$KetoneMeasurementTableTableManager(_db, _db.ketoneMeasurement);
  $$MeasurementSessionTableTableManager get measurementSession =>
      $$MeasurementSessionTableTableManager(_db, _db.measurementSession);
  $$WeightEntryTableTableManager get weightEntry =>
      $$WeightEntryTableTableManager(_db, _db.weightEntry);
  $$SymptomDefinitionTableTableManager get symptomDefinition =>
      $$SymptomDefinitionTableTableManager(_db, _db.symptomDefinition);
  $$SymptomEntryTableTableManager get symptomEntry =>
      $$SymptomEntryTableTableManager(_db, _db.symptomEntry);
  $$ContextTagTableTableManager get contextTag =>
      $$ContextTagTableTableManager(_db, _db.contextTag);
  $$MealPlanTableTableManager get mealPlan =>
      $$MealPlanTableTableManager(_db, _db.mealPlan);
  $$MealPlanEntryTableTableManager get mealPlanEntry =>
      $$MealPlanEntryTableTableManager(_db, _db.mealPlanEntry);
  $$ShoppingListTableTableManager get shoppingList =>
      $$ShoppingListTableTableManager(_db, _db.shoppingList);
  $$ShoppingListItemTableTableManager get shoppingListItem =>
      $$ShoppingListItemTableTableManager(_db, _db.shoppingListItem);
  $$EvidenceSourceTableTableManager get evidenceSource =>
      $$EvidenceSourceTableTableManager(_db, _db.evidenceSource);
  $$EvidenceClaimTableTableManager get evidenceClaim =>
      $$EvidenceClaimTableTableManager(_db, _db.evidenceClaim);
  $$ContentVersionTableTableManager get contentVersion =>
      $$ContentVersionTableTableManager(_db, _db.contentVersion);
  $$ExportHistoryTableTableManager get exportHistory =>
      $$ExportHistoryTableTableManager(_db, _db.exportHistory);
}
