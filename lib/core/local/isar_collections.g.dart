// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingsCollection on Isar {
  IsarCollection<UserSettings> get userSettings => this.collection();
}

const UserSettingsSchema = CollectionSchema(
  name: r'UserSettings',
  id: 4939698790990493221,
  properties: {
    r'bannerLastShownAt': PropertySchema(
      id: 0,
      name: r'bannerLastShownAt',
      type: IsarType.dateTime,
    ),
    r'contestAlertsEnabled': PropertySchema(
      id: 1,
      name: r'contestAlertsEnabled',
      type: IsarType.bool,
    ),
    r'isPhoneVerified': PropertySchema(
      id: 2,
      name: r'isPhoneVerified',
      type: IsarType.bool,
    ),
    r'notificationPermissionAsked': PropertySchema(
      id: 3,
      name: r'notificationPermissionAsked',
      type: IsarType.bool,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 4,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'phoneNumber': PropertySchema(
      id: 5,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'reminderMinutesBefore': PropertySchema(
      id: 6,
      name: r'reminderMinutesBefore',
      type: IsarType.long,
    ),
    r'smsAlertsEnabled': PropertySchema(
      id: 7,
      name: r'smsAlertsEnabled',
      type: IsarType.bool,
    ),
    r'streakReminderEnabled': PropertySchema(
      id: 8,
      name: r'streakReminderEnabled',
      type: IsarType.bool,
    ),
    r'ttsLanguage': PropertySchema(
      id: 9,
      name: r'ttsLanguage',
      type: IsarType.string,
    ),
    r'ttsVoiceEnabled': PropertySchema(
      id: 10,
      name: r'ttsVoiceEnabled',
      type: IsarType.bool,
    ),
    r'ttsVolume': PropertySchema(
      id: 11,
      name: r'ttsVolume',
      type: IsarType.double,
    ),
    r'upsolveReminderEnabled': PropertySchema(
      id: 12,
      name: r'upsolveReminderEnabled',
      type: IsarType.bool,
    ),
    r'voiceCallEnabled': PropertySchema(
      id: 13,
      name: r'voiceCallEnabled',
      type: IsarType.bool,
    ),
    r'widgetEnabled': PropertySchema(
      id: 14,
      name: r'widgetEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _userSettingsEstimateSize,
  serialize: _userSettingsSerialize,
  deserialize: _userSettingsDeserialize,
  deserializeProp: _userSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userSettingsGetId,
  getLinks: _userSettingsGetLinks,
  attach: _userSettingsAttach,
  version: '3.1.0+1',
);

int _userSettingsEstimateSize(
  UserSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.phoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ttsLanguage.length * 3;
  return bytesCount;
}

void _userSettingsSerialize(
  UserSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.bannerLastShownAt);
  writer.writeBool(offsets[1], object.contestAlertsEnabled);
  writer.writeBool(offsets[2], object.isPhoneVerified);
  writer.writeBool(offsets[3], object.notificationPermissionAsked);
  writer.writeBool(offsets[4], object.onboardingCompleted);
  writer.writeString(offsets[5], object.phoneNumber);
  writer.writeLong(offsets[6], object.reminderMinutesBefore);
  writer.writeBool(offsets[7], object.smsAlertsEnabled);
  writer.writeBool(offsets[8], object.streakReminderEnabled);
  writer.writeString(offsets[9], object.ttsLanguage);
  writer.writeBool(offsets[10], object.ttsVoiceEnabled);
  writer.writeDouble(offsets[11], object.ttsVolume);
  writer.writeBool(offsets[12], object.upsolveReminderEnabled);
  writer.writeBool(offsets[13], object.voiceCallEnabled);
  writer.writeBool(offsets[14], object.widgetEnabled);
}

UserSettings _userSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettings();
  object.bannerLastShownAt = reader.readDateTimeOrNull(offsets[0]);
  object.contestAlertsEnabled = reader.readBool(offsets[1]);
  object.id = id;
  object.isPhoneVerified = reader.readBool(offsets[2]);
  object.notificationPermissionAsked = reader.readBool(offsets[3]);
  object.onboardingCompleted = reader.readBool(offsets[4]);
  object.phoneNumber = reader.readStringOrNull(offsets[5]);
  object.reminderMinutesBefore = reader.readLong(offsets[6]);
  object.smsAlertsEnabled = reader.readBool(offsets[7]);
  object.streakReminderEnabled = reader.readBool(offsets[8]);
  object.ttsLanguage = reader.readString(offsets[9]);
  object.ttsVoiceEnabled = reader.readBool(offsets[10]);
  object.ttsVolume = reader.readDouble(offsets[11]);
  object.upsolveReminderEnabled = reader.readBool(offsets[12]);
  object.voiceCallEnabled = reader.readBool(offsets[13]);
  object.widgetEnabled = reader.readBool(offsets[14]);
  return object;
}

P _userSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userSettingsGetId(UserSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSettingsGetLinks(UserSettings object) {
  return [];
}

void _userSettingsAttach(
    IsarCollection<dynamic> col, Id id, UserSettings object) {
  object.id = id;
}

extension UserSettingsQueryWhereSort
    on QueryBuilder<UserSettings, UserSettings, QWhere> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSettingsQueryWhere
    on QueryBuilder<UserSettings, UserSettings, QWhereClause> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserSettingsQueryFilter
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {
  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bannerLastShownAt',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bannerLastShownAt',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bannerLastShownAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bannerLastShownAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bannerLastShownAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      bannerLastShownAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bannerLastShownAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      contestAlertsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestAlertsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      isPhoneVerifiedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPhoneVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationPermissionAskedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationPermissionAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      reminderMinutesBeforeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderMinutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      reminderMinutesBeforeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderMinutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      reminderMinutesBeforeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderMinutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      reminderMinutesBeforeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderMinutesBefore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      smsAlertsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsAlertsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      streakReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ttsLanguage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ttsLanguage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ttsLanguage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttsLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ttsLanguage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsVoiceEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttsVoiceEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsVolumeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttsVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsVolumeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ttsVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsVolumeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ttsVolume',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      ttsVolumeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ttsVolume',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      upsolveReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'upsolveReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      voiceCallEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voiceCallEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      widgetEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widgetEnabled',
        value: value,
      ));
    });
  }
}

extension UserSettingsQueryObject
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQueryLinks
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQuerySortBy
    on QueryBuilder<UserSettings, UserSettings, QSortBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByBannerLastShownAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bannerLastShownAt', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByBannerLastShownAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bannerLastShownAt', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByContestAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestAlertsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByContestAlertsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestAlertsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByIsPhoneVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhoneVerified', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByIsPhoneVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhoneVerified', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByNotificationPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationPermissionAsked', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByNotificationPermissionAskedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationPermissionAsked', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByReminderMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinutesBefore', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByReminderMinutesBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinutesBefore', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortBySmsAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsAlertsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortBySmsAlertsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsAlertsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByStreakReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByStreakReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByTtsLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsLanguage', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByTtsLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsLanguage', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByTtsVoiceEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVoiceEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByTtsVoiceEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVoiceEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByTtsVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVolume', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByTtsVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVolume', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByUpsolveReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upsolveReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByUpsolveReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upsolveReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByVoiceCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceCallEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByVoiceCallEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceCallEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByWidgetEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByWidgetEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetEnabled', Sort.desc);
    });
  }
}

extension UserSettingsQuerySortThenBy
    on QueryBuilder<UserSettings, UserSettings, QSortThenBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByBannerLastShownAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bannerLastShownAt', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByBannerLastShownAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bannerLastShownAt', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByContestAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestAlertsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByContestAlertsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestAlertsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByIsPhoneVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhoneVerified', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByIsPhoneVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPhoneVerified', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByNotificationPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationPermissionAsked', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByNotificationPermissionAskedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationPermissionAsked', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByReminderMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinutesBefore', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByReminderMinutesBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderMinutesBefore', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenBySmsAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsAlertsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenBySmsAlertsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsAlertsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByStreakReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByStreakReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByTtsLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsLanguage', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByTtsLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsLanguage', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByTtsVoiceEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVoiceEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByTtsVoiceEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVoiceEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByTtsVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVolume', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByTtsVolumeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttsVolume', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByUpsolveReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upsolveReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByUpsolveReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upsolveReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByVoiceCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceCallEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByVoiceCallEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voiceCallEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByWidgetEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByWidgetEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widgetEnabled', Sort.desc);
    });
  }
}

extension UserSettingsQueryWhereDistinct
    on QueryBuilder<UserSettings, UserSettings, QDistinct> {
  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByBannerLastShownAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bannerLastShownAt');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByContestAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestAlertsEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByIsPhoneVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPhoneVerified');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByNotificationPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationPermissionAsked');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByPhoneNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByReminderMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderMinutesBefore');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctBySmsAlertsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smsAlertsEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByStreakReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakReminderEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByTtsLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ttsLanguage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByTtsVoiceEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ttsVoiceEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByTtsVolume() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ttsVolume');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByUpsolveReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'upsolveReminderEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByVoiceCallEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voiceCallEnabled');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByWidgetEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widgetEnabled');
    });
  }
}

extension UserSettingsQueryProperty
    on QueryBuilder<UserSettings, UserSettings, QQueryProperty> {
  QueryBuilder<UserSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
      bannerLastShownAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bannerLastShownAt');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      contestAlertsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestAlertsEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isPhoneVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPhoneVerified');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      notificationPermissionAskedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationPermissionAsked');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations>
      reminderMinutesBeforeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderMinutesBefore');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      smsAlertsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smsAlertsEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      streakReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakReminderEnabled');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations> ttsLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ttsLanguage');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> ttsVoiceEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ttsVoiceEnabled');
    });
  }

  QueryBuilder<UserSettings, double, QQueryOperations> ttsVolumeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ttsVolume');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      upsolveReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'upsolveReminderEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      voiceCallEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voiceCallEnabled');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> widgetEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widgetEnabled');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContestReminderCollection on Isar {
  IsarCollection<ContestReminder> get contestReminders => this.collection();
}

const ContestReminderSchema = CollectionSchema(
  name: r'ContestReminder',
  id: 6177793721843008235,
  properties: {
    r'contestId': PropertySchema(
      id: 0,
      name: r'contestId',
      type: IsarType.long,
    ),
    r'contestName': PropertySchema(
      id: 1,
      name: r'contestName',
      type: IsarType.string,
    ),
    r'contestStartTimeSeconds': PropertySchema(
      id: 2,
      name: r'contestStartTimeSeconds',
      type: IsarType.long,
    ),
    r'firesAt': PropertySchema(
      id: 3,
      name: r'firesAt',
      type: IsarType.dateTime,
    ),
    r'hasFired': PropertySchema(
      id: 4,
      name: r'hasFired',
      type: IsarType.bool,
    ),
    r'isActive': PropertySchema(
      id: 5,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'minutesBefore': PropertySchema(
      id: 6,
      name: r'minutesBefore',
      type: IsarType.long,
    ),
    r'notificationId': PropertySchema(
      id: 7,
      name: r'notificationId',
      type: IsarType.long,
    ),
    r'scheduledAt': PropertySchema(
      id: 8,
      name: r'scheduledAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _contestReminderEstimateSize,
  serialize: _contestReminderSerialize,
  deserialize: _contestReminderDeserialize,
  deserializeProp: _contestReminderDeserializeProp,
  idName: r'id',
  indexes: {
    r'contestId': IndexSchema(
      id: -5609394854807372884,
      name: r'contestId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'contestId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _contestReminderGetId,
  getLinks: _contestReminderGetLinks,
  attach: _contestReminderAttach,
  version: '3.1.0+1',
);

int _contestReminderEstimateSize(
  ContestReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contestName.length * 3;
  return bytesCount;
}

void _contestReminderSerialize(
  ContestReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contestId);
  writer.writeString(offsets[1], object.contestName);
  writer.writeLong(offsets[2], object.contestStartTimeSeconds);
  writer.writeDateTime(offsets[3], object.firesAt);
  writer.writeBool(offsets[4], object.hasFired);
  writer.writeBool(offsets[5], object.isActive);
  writer.writeLong(offsets[6], object.minutesBefore);
  writer.writeLong(offsets[7], object.notificationId);
  writer.writeDateTime(offsets[8], object.scheduledAt);
}

ContestReminder _contestReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContestReminder();
  object.contestId = reader.readLong(offsets[0]);
  object.contestName = reader.readString(offsets[1]);
  object.contestStartTimeSeconds = reader.readLong(offsets[2]);
  object.id = id;
  object.isActive = reader.readBool(offsets[5]);
  object.minutesBefore = reader.readLong(offsets[6]);
  object.notificationId = reader.readLong(offsets[7]);
  object.scheduledAt = reader.readDateTime(offsets[8]);
  return object;
}

P _contestReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contestReminderGetId(ContestReminder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contestReminderGetLinks(ContestReminder object) {
  return [];
}

void _contestReminderAttach(
    IsarCollection<dynamic> col, Id id, ContestReminder object) {
  object.id = id;
}

extension ContestReminderQueryWhereSort
    on QueryBuilder<ContestReminder, ContestReminder, QWhere> {
  QueryBuilder<ContestReminder, ContestReminder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhere> anyContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'contestId'),
      );
    });
  }
}

extension ContestReminderQueryWhere
    on QueryBuilder<ContestReminder, ContestReminder, QWhereClause> {
  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      contestIdEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contestId',
        value: [contestId],
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      contestIdNotEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      contestIdGreaterThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [contestId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      contestIdLessThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [],
        upper: [contestId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterWhereClause>
      contestIdBetween(
    int lowerContestId,
    int upperContestId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [lowerContestId],
        includeLower: includeLower,
        upper: [upperContestId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContestReminderQueryFilter
    on QueryBuilder<ContestReminder, ContestReminder, QFilterCondition> {
  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contestName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contestName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contestName',
        value: '',
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestStartTimeSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestStartTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestStartTimeSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestStartTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestStartTimeSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestStartTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      contestStartTimeSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestStartTimeSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      firesAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firesAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      firesAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firesAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      firesAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firesAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      firesAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firesAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      hasFiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasFired',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      minutesBeforeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      minutesBeforeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      minutesBeforeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minutesBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      minutesBeforeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minutesBefore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      notificationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      notificationIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      notificationIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      notificationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      scheduledAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      scheduledAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      scheduledAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterFilterCondition>
      scheduledAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContestReminderQueryObject
    on QueryBuilder<ContestReminder, ContestReminder, QFilterCondition> {}

extension ContestReminderQueryLinks
    on QueryBuilder<ContestReminder, ContestReminder, QFilterCondition> {}

extension ContestReminderQuerySortBy
    on QueryBuilder<ContestReminder, ContestReminder, QSortBy> {
  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestName', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestName', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestStartTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByContestStartTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestStartTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy> sortByFiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firesAt', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByFiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firesAt', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByHasFired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFired', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByHasFiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFired', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesBefore', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByMinutesBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesBefore', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      sortByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }
}

extension ContestReminderQuerySortThenBy
    on QueryBuilder<ContestReminder, ContestReminder, QSortThenBy> {
  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestName', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestName', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestStartTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByContestStartTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestStartTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy> thenByFiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firesAt', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByFiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firesAt', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByHasFired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFired', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByHasFiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasFired', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesBefore', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByMinutesBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minutesBefore', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QAfterSortBy>
      thenByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }
}

extension ContestReminderQueryWhereDistinct
    on QueryBuilder<ContestReminder, ContestReminder, QDistinct> {
  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestId');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByContestName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByContestStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestStartTimeSeconds');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByFiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firesAt');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByHasFired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasFired');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByMinutesBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minutesBefore');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationId');
    });
  }

  QueryBuilder<ContestReminder, ContestReminder, QDistinct>
      distinctByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAt');
    });
  }
}

extension ContestReminderQueryProperty
    on QueryBuilder<ContestReminder, ContestReminder, QQueryProperty> {
  QueryBuilder<ContestReminder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ContestReminder, int, QQueryOperations> contestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestId');
    });
  }

  QueryBuilder<ContestReminder, String, QQueryOperations>
      contestNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestName');
    });
  }

  QueryBuilder<ContestReminder, int, QQueryOperations>
      contestStartTimeSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestStartTimeSeconds');
    });
  }

  QueryBuilder<ContestReminder, DateTime, QQueryOperations> firesAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firesAt');
    });
  }

  QueryBuilder<ContestReminder, bool, QQueryOperations> hasFiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasFired');
    });
  }

  QueryBuilder<ContestReminder, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<ContestReminder, int, QQueryOperations> minutesBeforeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minutesBefore');
    });
  }

  QueryBuilder<ContestReminder, int, QQueryOperations>
      notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationId');
    });
  }

  QueryBuilder<ContestReminder, DateTime, QQueryOperations>
      scheduledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUpsolveLocalStateCollection on Isar {
  IsarCollection<UpsolveLocalState> get upsolveLocalStates => this.collection();
}

const UpsolveLocalStateSchema = CollectionSchema(
  name: r'UpsolveLocalState',
  id: -7225040204552677600,
  properties: {
    r'bestVerdict': PropertySchema(
      id: 0,
      name: r'bestVerdict',
      type: IsarType.string,
    ),
    r'completedAt': PropertySchema(
      id: 1,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'contestId': PropertySchema(
      id: 2,
      name: r'contestId',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 3,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isWeakTopic': PropertySchema(
      id: 4,
      name: r'isWeakTopic',
      type: IsarType.bool,
    ),
    r'problemIndex': PropertySchema(
      id: 5,
      name: r'problemIndex',
      type: IsarType.string,
    ),
    r'problemKey': PropertySchema(
      id: 6,
      name: r'problemKey',
      type: IsarType.string,
    ),
    r'problemName': PropertySchema(
      id: 7,
      name: r'problemName',
      type: IsarType.string,
    ),
    r'problemRating': PropertySchema(
      id: 8,
      name: r'problemRating',
      type: IsarType.long,
    ),
    r'problemUrl': PropertySchema(
      id: 9,
      name: r'problemUrl',
      type: IsarType.string,
    ),
    r'tagsJson': PropertySchema(
      id: 10,
      name: r'tagsJson',
      type: IsarType.string,
    )
  },
  estimateSize: _upsolveLocalStateEstimateSize,
  serialize: _upsolveLocalStateSerialize,
  deserialize: _upsolveLocalStateDeserialize,
  deserializeProp: _upsolveLocalStateDeserializeProp,
  idName: r'id',
  indexes: {
    r'problemKey': IndexSchema(
      id: 7278337527727463828,
      name: r'problemKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'problemKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _upsolveLocalStateGetId,
  getLinks: _upsolveLocalStateGetLinks,
  attach: _upsolveLocalStateAttach,
  version: '3.1.0+1',
);

int _upsolveLocalStateEstimateSize(
  UpsolveLocalState object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bestVerdict.length * 3;
  bytesCount += 3 + object.problemIndex.length * 3;
  bytesCount += 3 + object.problemKey.length * 3;
  bytesCount += 3 + object.problemName.length * 3;
  bytesCount += 3 + object.problemUrl.length * 3;
  bytesCount += 3 + object.tagsJson.length * 3;
  return bytesCount;
}

void _upsolveLocalStateSerialize(
  UpsolveLocalState object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bestVerdict);
  writer.writeDateTime(offsets[1], object.completedAt);
  writer.writeLong(offsets[2], object.contestId);
  writer.writeBool(offsets[3], object.isCompleted);
  writer.writeBool(offsets[4], object.isWeakTopic);
  writer.writeString(offsets[5], object.problemIndex);
  writer.writeString(offsets[6], object.problemKey);
  writer.writeString(offsets[7], object.problemName);
  writer.writeLong(offsets[8], object.problemRating);
  writer.writeString(offsets[9], object.problemUrl);
  writer.writeString(offsets[10], object.tagsJson);
}

UpsolveLocalState _upsolveLocalStateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UpsolveLocalState();
  object.bestVerdict = reader.readString(offsets[0]);
  object.completedAt = reader.readDateTimeOrNull(offsets[1]);
  object.contestId = reader.readLong(offsets[2]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[3]);
  object.isWeakTopic = reader.readBool(offsets[4]);
  object.problemIndex = reader.readString(offsets[5]);
  object.problemKey = reader.readString(offsets[6]);
  object.problemName = reader.readString(offsets[7]);
  object.problemRating = reader.readLong(offsets[8]);
  object.problemUrl = reader.readString(offsets[9]);
  object.tagsJson = reader.readString(offsets[10]);
  return object;
}

P _upsolveLocalStateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _upsolveLocalStateGetId(UpsolveLocalState object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _upsolveLocalStateGetLinks(
    UpsolveLocalState object) {
  return [];
}

void _upsolveLocalStateAttach(
    IsarCollection<dynamic> col, Id id, UpsolveLocalState object) {
  object.id = id;
}

extension UpsolveLocalStateByIndex on IsarCollection<UpsolveLocalState> {
  Future<UpsolveLocalState?> getByProblemKey(String problemKey) {
    return getByIndex(r'problemKey', [problemKey]);
  }

  UpsolveLocalState? getByProblemKeySync(String problemKey) {
    return getByIndexSync(r'problemKey', [problemKey]);
  }

  Future<bool> deleteByProblemKey(String problemKey) {
    return deleteByIndex(r'problemKey', [problemKey]);
  }

  bool deleteByProblemKeySync(String problemKey) {
    return deleteByIndexSync(r'problemKey', [problemKey]);
  }

  Future<List<UpsolveLocalState?>> getAllByProblemKey(
      List<String> problemKeyValues) {
    final values = problemKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'problemKey', values);
  }

  List<UpsolveLocalState?> getAllByProblemKeySync(
      List<String> problemKeyValues) {
    final values = problemKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'problemKey', values);
  }

  Future<int> deleteAllByProblemKey(List<String> problemKeyValues) {
    final values = problemKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'problemKey', values);
  }

  int deleteAllByProblemKeySync(List<String> problemKeyValues) {
    final values = problemKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'problemKey', values);
  }

  Future<Id> putByProblemKey(UpsolveLocalState object) {
    return putByIndex(r'problemKey', object);
  }

  Id putByProblemKeySync(UpsolveLocalState object, {bool saveLinks = true}) {
    return putByIndexSync(r'problemKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProblemKey(List<UpsolveLocalState> objects) {
    return putAllByIndex(r'problemKey', objects);
  }

  List<Id> putAllByProblemKeySync(List<UpsolveLocalState> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'problemKey', objects, saveLinks: saveLinks);
  }
}

extension UpsolveLocalStateQueryWhereSort
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QWhere> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UpsolveLocalStateQueryWhere
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QWhereClause> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      problemKeyEqualTo(String problemKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'problemKey',
        value: [problemKey],
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterWhereClause>
      problemKeyNotEqualTo(String problemKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'problemKey',
              lower: [],
              upper: [problemKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'problemKey',
              lower: [problemKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'problemKey',
              lower: [problemKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'problemKey',
              lower: [],
              upper: [problemKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UpsolveLocalStateQueryFilter
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QFilterCondition> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bestVerdict',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bestVerdict',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bestVerdict',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bestVerdict',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      bestVerdictIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bestVerdict',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      contestIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      contestIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      contestIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      contestIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      isWeakTopicEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isWeakTopic',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'problemIndex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'problemIndex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'problemIndex',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'problemKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'problemKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'problemKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'problemName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'problemName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemName',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'problemName',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemRating',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemRating',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemRating',
        value: value,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'problemUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'problemUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      problemUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'problemUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterFilterCondition>
      tagsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagsJson',
        value: '',
      ));
    });
  }
}

extension UpsolveLocalStateQueryObject
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QFilterCondition> {}

extension UpsolveLocalStateQueryLinks
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QFilterCondition> {}

extension UpsolveLocalStateQuerySortBy
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QSortBy> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByBestVerdict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestVerdict', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByBestVerdictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestVerdict', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByIsWeakTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeakTopic', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByIsWeakTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeakTopic', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemIndex', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemIndex', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemKey', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemKey', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemName', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemName', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemRating', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemRating', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemUrl', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByProblemUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemUrl', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByTagsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      sortByTagsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.desc);
    });
  }
}

extension UpsolveLocalStateQuerySortThenBy
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QSortThenBy> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByBestVerdict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestVerdict', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByBestVerdictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestVerdict', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByIsWeakTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeakTopic', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByIsWeakTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWeakTopic', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemIndex', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemIndex', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemKey', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemKey', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemName', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemName', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemRating', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemRating', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemUrl', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByProblemUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemUrl', Sort.desc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByTagsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.asc);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QAfterSortBy>
      thenByTagsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagsJson', Sort.desc);
    });
  }
}

extension UpsolveLocalStateQueryWhereDistinct
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByBestVerdict({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bestVerdict', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestId');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByIsWeakTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isWeakTopic');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemRating');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByTagsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagsJson', caseSensitive: caseSensitive);
    });
  }
}

extension UpsolveLocalStateQueryProperty
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QQueryProperty> {
  QueryBuilder<UpsolveLocalState, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      bestVerdictProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bestVerdict');
    });
  }

  QueryBuilder<UpsolveLocalState, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<UpsolveLocalState, int, QQueryOperations> contestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestId');
    });
  }

  QueryBuilder<UpsolveLocalState, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<UpsolveLocalState, bool, QQueryOperations>
      isWeakTopicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isWeakTopic');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      problemIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemIndex');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      problemKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemKey');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      problemNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemName');
    });
  }

  QueryBuilder<UpsolveLocalState, int, QQueryOperations>
      problemRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemRating');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      problemUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemUrl');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations> tagsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagsJson');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDismissedContestCollection on Isar {
  IsarCollection<DismissedContest> get dismissedContests => this.collection();
}

const DismissedContestSchema = CollectionSchema(
  name: r'DismissedContest',
  id: -8723572165671748607,
  properties: {
    r'contestId': PropertySchema(
      id: 0,
      name: r'contestId',
      type: IsarType.long,
    ),
    r'dismissedAt': PropertySchema(
      id: 1,
      name: r'dismissedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _dismissedContestEstimateSize,
  serialize: _dismissedContestSerialize,
  deserialize: _dismissedContestDeserialize,
  deserializeProp: _dismissedContestDeserializeProp,
  idName: r'id',
  indexes: {
    r'contestId': IndexSchema(
      id: -5609394854807372884,
      name: r'contestId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'contestId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dismissedContestGetId,
  getLinks: _dismissedContestGetLinks,
  attach: _dismissedContestAttach,
  version: '3.1.0+1',
);

int _dismissedContestEstimateSize(
  DismissedContest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dismissedContestSerialize(
  DismissedContest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contestId);
  writer.writeDateTime(offsets[1], object.dismissedAt);
}

DismissedContest _dismissedContestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DismissedContest();
  object.contestId = reader.readLong(offsets[0]);
  object.dismissedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _dismissedContestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dismissedContestGetId(DismissedContest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dismissedContestGetLinks(DismissedContest object) {
  return [];
}

void _dismissedContestAttach(
    IsarCollection<dynamic> col, Id id, DismissedContest object) {
  object.id = id;
}

extension DismissedContestByIndex on IsarCollection<DismissedContest> {
  Future<DismissedContest?> getByContestId(int contestId) {
    return getByIndex(r'contestId', [contestId]);
  }

  DismissedContest? getByContestIdSync(int contestId) {
    return getByIndexSync(r'contestId', [contestId]);
  }

  Future<bool> deleteByContestId(int contestId) {
    return deleteByIndex(r'contestId', [contestId]);
  }

  bool deleteByContestIdSync(int contestId) {
    return deleteByIndexSync(r'contestId', [contestId]);
  }

  Future<List<DismissedContest?>> getAllByContestId(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'contestId', values);
  }

  List<DismissedContest?> getAllByContestIdSync(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'contestId', values);
  }

  Future<int> deleteAllByContestId(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'contestId', values);
  }

  int deleteAllByContestIdSync(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'contestId', values);
  }

  Future<Id> putByContestId(DismissedContest object) {
    return putByIndex(r'contestId', object);
  }

  Id putByContestIdSync(DismissedContest object, {bool saveLinks = true}) {
    return putByIndexSync(r'contestId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContestId(List<DismissedContest> objects) {
    return putAllByIndex(r'contestId', objects);
  }

  List<Id> putAllByContestIdSync(List<DismissedContest> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'contestId', objects, saveLinks: saveLinks);
  }
}

extension DismissedContestQueryWhereSort
    on QueryBuilder<DismissedContest, DismissedContest, QWhere> {
  QueryBuilder<DismissedContest, DismissedContest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhere> anyContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'contestId'),
      );
    });
  }
}

extension DismissedContestQueryWhere
    on QueryBuilder<DismissedContest, DismissedContest, QWhereClause> {
  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      contestIdEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contestId',
        value: [contestId],
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      contestIdNotEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      contestIdGreaterThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [contestId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      contestIdLessThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [],
        upper: [contestId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterWhereClause>
      contestIdBetween(
    int lowerContestId,
    int upperContestId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [lowerContestId],
        includeLower: includeLower,
        upper: [upperContestId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DismissedContestQueryFilter
    on QueryBuilder<DismissedContest, DismissedContest, QFilterCondition> {
  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      contestIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      contestIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      contestIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      contestIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      dismissedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dismissedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      dismissedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dismissedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      dismissedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dismissedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      dismissedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dismissedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DismissedContestQueryObject
    on QueryBuilder<DismissedContest, DismissedContest, QFilterCondition> {}

extension DismissedContestQueryLinks
    on QueryBuilder<DismissedContest, DismissedContest, QFilterCondition> {}

extension DismissedContestQuerySortBy
    on QueryBuilder<DismissedContest, DismissedContest, QSortBy> {
  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      sortByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      sortByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      sortByDismissedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissedAt', Sort.asc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      sortByDismissedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissedAt', Sort.desc);
    });
  }
}

extension DismissedContestQuerySortThenBy
    on QueryBuilder<DismissedContest, DismissedContest, QSortThenBy> {
  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      thenByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      thenByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      thenByDismissedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissedAt', Sort.asc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      thenByDismissedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissedAt', Sort.desc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DismissedContestQueryWhereDistinct
    on QueryBuilder<DismissedContest, DismissedContest, QDistinct> {
  QueryBuilder<DismissedContest, DismissedContest, QDistinct>
      distinctByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestId');
    });
  }

  QueryBuilder<DismissedContest, DismissedContest, QDistinct>
      distinctByDismissedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dismissedAt');
    });
  }
}

extension DismissedContestQueryProperty
    on QueryBuilder<DismissedContest, DismissedContest, QQueryProperty> {
  QueryBuilder<DismissedContest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DismissedContest, int, QQueryOperations> contestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestId');
    });
  }

  QueryBuilder<DismissedContest, DateTime, QQueryOperations>
      dismissedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dismissedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedProfileCollection on Isar {
  IsarCollection<CachedProfile> get cachedProfiles => this.collection();
}

const CachedProfileSchema = CollectionSchema(
  name: r'CachedProfile',
  id: -3272954809300854847,
  properties: {
    r'avatar': PropertySchema(
      id: 0,
      name: r'avatar',
      type: IsarType.string,
    ),
    r'cachedAt': PropertySchema(
      id: 1,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'contestsParticipated': PropertySchema(
      id: 2,
      name: r'contestsParticipated',
      type: IsarType.long,
    ),
    r'handle': PropertySchema(
      id: 3,
      name: r'handle',
      type: IsarType.string,
    ),
    r'isValid': PropertySchema(
      id: 4,
      name: r'isValid',
      type: IsarType.bool,
    ),
    r'isValidOffline': PropertySchema(
      id: 5,
      name: r'isValidOffline',
      type: IsarType.bool,
    ),
    r'lastActiveDate': PropertySchema(
      id: 6,
      name: r'lastActiveDate',
      type: IsarType.string,
    ),
    r'maxRating': PropertySchema(
      id: 7,
      name: r'maxRating',
      type: IsarType.long,
    ),
    r'problemsSolved': PropertySchema(
      id: 8,
      name: r'problemsSolved',
      type: IsarType.long,
    ),
    r'rank': PropertySchema(
      id: 9,
      name: r'rank',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 10,
      name: r'rating',
      type: IsarType.long,
    ),
    r'streakDays': PropertySchema(
      id: 11,
      name: r'streakDays',
      type: IsarType.long,
    )
  },
  estimateSize: _cachedProfileEstimateSize,
  serialize: _cachedProfileSerialize,
  deserialize: _cachedProfileDeserialize,
  deserializeProp: _cachedProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'handle': IndexSchema(
      id: -5563962949089040958,
      name: r'handle',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'handle',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedProfileGetId,
  getLinks: _cachedProfileGetLinks,
  attach: _cachedProfileAttach,
  version: '3.1.0+1',
);

int _cachedProfileEstimateSize(
  CachedProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avatar.length * 3;
  bytesCount += 3 + object.handle.length * 3;
  bytesCount += 3 + object.lastActiveDate.length * 3;
  bytesCount += 3 + object.rank.length * 3;
  return bytesCount;
}

void _cachedProfileSerialize(
  CachedProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatar);
  writer.writeDateTime(offsets[1], object.cachedAt);
  writer.writeLong(offsets[2], object.contestsParticipated);
  writer.writeString(offsets[3], object.handle);
  writer.writeBool(offsets[4], object.isValid);
  writer.writeBool(offsets[5], object.isValidOffline);
  writer.writeString(offsets[6], object.lastActiveDate);
  writer.writeLong(offsets[7], object.maxRating);
  writer.writeLong(offsets[8], object.problemsSolved);
  writer.writeString(offsets[9], object.rank);
  writer.writeLong(offsets[10], object.rating);
  writer.writeLong(offsets[11], object.streakDays);
}

CachedProfile _cachedProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedProfile();
  object.avatar = reader.readString(offsets[0]);
  object.cachedAt = reader.readDateTime(offsets[1]);
  object.contestsParticipated = reader.readLong(offsets[2]);
  object.handle = reader.readString(offsets[3]);
  object.id = id;
  object.lastActiveDate = reader.readString(offsets[6]);
  object.maxRating = reader.readLong(offsets[7]);
  object.problemsSolved = reader.readLong(offsets[8]);
  object.rank = reader.readString(offsets[9]);
  object.rating = reader.readLong(offsets[10]);
  object.streakDays = reader.readLong(offsets[11]);
  return object;
}

P _cachedProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedProfileGetId(CachedProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedProfileGetLinks(CachedProfile object) {
  return [];
}

void _cachedProfileAttach(
    IsarCollection<dynamic> col, Id id, CachedProfile object) {
  object.id = id;
}

extension CachedProfileByIndex on IsarCollection<CachedProfile> {
  Future<CachedProfile?> getByHandle(String handle) {
    return getByIndex(r'handle', [handle]);
  }

  CachedProfile? getByHandleSync(String handle) {
    return getByIndexSync(r'handle', [handle]);
  }

  Future<bool> deleteByHandle(String handle) {
    return deleteByIndex(r'handle', [handle]);
  }

  bool deleteByHandleSync(String handle) {
    return deleteByIndexSync(r'handle', [handle]);
  }

  Future<List<CachedProfile?>> getAllByHandle(List<String> handleValues) {
    final values = handleValues.map((e) => [e]).toList();
    return getAllByIndex(r'handle', values);
  }

  List<CachedProfile?> getAllByHandleSync(List<String> handleValues) {
    final values = handleValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'handle', values);
  }

  Future<int> deleteAllByHandle(List<String> handleValues) {
    final values = handleValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'handle', values);
  }

  int deleteAllByHandleSync(List<String> handleValues) {
    final values = handleValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'handle', values);
  }

  Future<Id> putByHandle(CachedProfile object) {
    return putByIndex(r'handle', object);
  }

  Id putByHandleSync(CachedProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'handle', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHandle(List<CachedProfile> objects) {
    return putAllByIndex(r'handle', objects);
  }

  List<Id> putAllByHandleSync(List<CachedProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'handle', objects, saveLinks: saveLinks);
  }
}

extension CachedProfileQueryWhereSort
    on QueryBuilder<CachedProfile, CachedProfile, QWhere> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedProfileQueryWhere
    on QueryBuilder<CachedProfile, CachedProfile, QWhereClause> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> handleEqualTo(
      String handle) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'handle',
        value: [handle],
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause>
      handleNotEqualTo(String handle) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'handle',
              lower: [],
              upper: [handle],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'handle',
              lower: [handle],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'handle',
              lower: [handle],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'handle',
              lower: [],
              upper: [handle],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CachedProfileQueryFilter
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      avatarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      cachedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      cachedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      contestsParticipatedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestsParticipated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      contestsParticipatedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestsParticipated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      contestsParticipatedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestsParticipated',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      contestsParticipatedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestsParticipated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'handle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'handle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'handle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'handle',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      handleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'handle',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      isValidEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isValid',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      isValidOfflineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isValidOffline',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastActiveDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastActiveDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastActiveDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastActiveDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      lastActiveDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastActiveDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      maxRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      maxRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      maxRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxRating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      maxRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      problemsSolvedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      problemsSolvedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      problemsSolvedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemsSolved',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      problemsSolvedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemsSolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> rankEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> rankBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rank',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> rankMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rank',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rank',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      rankIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rank',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      ratingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      ratingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      ratingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      ratingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      streakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      streakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      streakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
      streakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedProfileQueryObject
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {}

extension CachedProfileQueryLinks
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {}

extension CachedProfileQuerySortBy
    on QueryBuilder<CachedProfile, CachedProfile, QSortBy> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByContestsParticipated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestsParticipated', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByContestsParticipatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestsParticipated', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByHandle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handle', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByHandleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handle', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByIsValidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByIsValidOfflineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByMaxRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByMaxRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByProblemsSolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemsSolved', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByProblemsSolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemsSolved', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      sortByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }
}

extension CachedProfileQuerySortThenBy
    on QueryBuilder<CachedProfile, CachedProfile, QSortThenBy> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByContestsParticipated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestsParticipated', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByContestsParticipatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestsParticipated', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByHandle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handle', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByHandleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handle', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIsValidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByIsValidOfflineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByMaxRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByMaxRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxRating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByProblemsSolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemsSolved', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByProblemsSolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemsSolved', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
      thenByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }
}

extension CachedProfileQueryWhereDistinct
    on QueryBuilder<CachedProfile, CachedProfile, QDistinct> {
  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByAvatar(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
      distinctByContestsParticipated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestsParticipated');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByHandle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'handle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isValid');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
      distinctByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isValidOffline');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
      distinctByLastActiveDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastActiveDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByMaxRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxRating');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
      distinctByProblemsSolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemsSolved');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByRank(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rank', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakDays');
    });
  }
}

extension CachedProfileQueryProperty
    on QueryBuilder<CachedProfile, CachedProfile, QQueryProperty> {
  QueryBuilder<CachedProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> avatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatar');
    });
  }

  QueryBuilder<CachedProfile, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations>
      contestsParticipatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestsParticipated');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> handleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'handle');
    });
  }

  QueryBuilder<CachedProfile, bool, QQueryOperations> isValidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isValid');
    });
  }

  QueryBuilder<CachedProfile, bool, QQueryOperations> isValidOfflineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isValidOffline');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations>
      lastActiveDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastActiveDate');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations> maxRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxRating');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations> problemsSolvedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemsSolved');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> rankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rank');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations> streakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakDays');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedContestCollection on Isar {
  IsarCollection<CachedContest> get cachedContests => this.collection();
}

const CachedContestSchema = CollectionSchema(
  name: r'CachedContest',
  id: 8301394856471991335,
  properties: {
    r'cachedAt': PropertySchema(
      id: 0,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'contestId': PropertySchema(
      id: 1,
      name: r'contestId',
      type: IsarType.long,
    ),
    r'durationFormatted': PropertySchema(
      id: 2,
      name: r'durationFormatted',
      type: IsarType.string,
    ),
    r'durationSeconds': PropertySchema(
      id: 3,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'isLive': PropertySchema(
      id: 4,
      name: r'isLive',
      type: IsarType.bool,
    ),
    r'isUpcoming': PropertySchema(
      id: 5,
      name: r'isUpcoming',
      type: IsarType.bool,
    ),
    r'isValid': PropertySchema(
      id: 6,
      name: r'isValid',
      type: IsarType.bool,
    ),
    r'isValidOffline': PropertySchema(
      id: 7,
      name: r'isValidOffline',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'relativeTimeSeconds': PropertySchema(
      id: 9,
      name: r'relativeTimeSeconds',
      type: IsarType.long,
    ),
    r'startDateTime': PropertySchema(
      id: 10,
      name: r'startDateTime',
      type: IsarType.dateTime,
    ),
    r'startTimeSeconds': PropertySchema(
      id: 11,
      name: r'startTimeSeconds',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 12,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedContestEstimateSize,
  serialize: _cachedContestSerialize,
  deserialize: _cachedContestDeserialize,
  deserializeProp: _cachedContestDeserializeProp,
  idName: r'id',
  indexes: {
    r'contestId': IndexSchema(
      id: -5609394854807372884,
      name: r'contestId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'contestId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedContestGetId,
  getLinks: _cachedContestGetLinks,
  attach: _cachedContestAttach,
  version: '3.1.0+1',
);

int _cachedContestEstimateSize(
  CachedContest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.durationFormatted.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _cachedContestSerialize(
  CachedContest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cachedAt);
  writer.writeLong(offsets[1], object.contestId);
  writer.writeString(offsets[2], object.durationFormatted);
  writer.writeLong(offsets[3], object.durationSeconds);
  writer.writeBool(offsets[4], object.isLive);
  writer.writeBool(offsets[5], object.isUpcoming);
  writer.writeBool(offsets[6], object.isValid);
  writer.writeBool(offsets[7], object.isValidOffline);
  writer.writeString(offsets[8], object.name);
  writer.writeLong(offsets[9], object.relativeTimeSeconds);
  writer.writeDateTime(offsets[10], object.startDateTime);
  writer.writeLong(offsets[11], object.startTimeSeconds);
  writer.writeString(offsets[12], object.type);
}

CachedContest _cachedContestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedContest();
  object.cachedAt = reader.readDateTime(offsets[0]);
  object.contestId = reader.readLong(offsets[1]);
  object.durationSeconds = reader.readLong(offsets[3]);
  object.id = id;
  object.name = reader.readString(offsets[8]);
  object.relativeTimeSeconds = reader.readLong(offsets[9]);
  object.startTimeSeconds = reader.readLong(offsets[11]);
  object.type = reader.readString(offsets[12]);
  return object;
}

P _cachedContestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedContestGetId(CachedContest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedContestGetLinks(CachedContest object) {
  return [];
}

void _cachedContestAttach(
    IsarCollection<dynamic> col, Id id, CachedContest object) {
  object.id = id;
}

extension CachedContestByIndex on IsarCollection<CachedContest> {
  Future<CachedContest?> getByContestId(int contestId) {
    return getByIndex(r'contestId', [contestId]);
  }

  CachedContest? getByContestIdSync(int contestId) {
    return getByIndexSync(r'contestId', [contestId]);
  }

  Future<bool> deleteByContestId(int contestId) {
    return deleteByIndex(r'contestId', [contestId]);
  }

  bool deleteByContestIdSync(int contestId) {
    return deleteByIndexSync(r'contestId', [contestId]);
  }

  Future<List<CachedContest?>> getAllByContestId(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'contestId', values);
  }

  List<CachedContest?> getAllByContestIdSync(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'contestId', values);
  }

  Future<int> deleteAllByContestId(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'contestId', values);
  }

  int deleteAllByContestIdSync(List<int> contestIdValues) {
    final values = contestIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'contestId', values);
  }

  Future<Id> putByContestId(CachedContest object) {
    return putByIndex(r'contestId', object);
  }

  Id putByContestIdSync(CachedContest object, {bool saveLinks = true}) {
    return putByIndexSync(r'contestId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContestId(List<CachedContest> objects) {
    return putAllByIndex(r'contestId', objects);
  }

  List<Id> putAllByContestIdSync(List<CachedContest> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'contestId', objects, saveLinks: saveLinks);
  }
}

extension CachedContestQueryWhereSort
    on QueryBuilder<CachedContest, CachedContest, QWhere> {
  QueryBuilder<CachedContest, CachedContest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhere> anyContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'contestId'),
      );
    });
  }
}

extension CachedContestQueryWhere
    on QueryBuilder<CachedContest, CachedContest, QWhereClause> {
  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause>
      contestIdEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contestId',
        value: [contestId],
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause>
      contestIdNotEqualTo(int contestId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [contestId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contestId',
              lower: [],
              upper: [contestId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause>
      contestIdGreaterThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [contestId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause>
      contestIdLessThan(
    int contestId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [],
        upper: [contestId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterWhereClause>
      contestIdBetween(
    int lowerContestId,
    int upperContestId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'contestId',
        lower: [lowerContestId],
        includeLower: includeLower,
        upper: [upperContestId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CachedContestQueryFilter
    on QueryBuilder<CachedContest, CachedContest, QFilterCondition> {
  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      cachedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      cachedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      contestIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      contestIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      contestIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contestId',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      contestIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contestId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationFormatted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'durationFormatted',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'durationFormatted',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationFormatted',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationFormattedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'durationFormatted',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      isLiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLive',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      isUpcomingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUpcoming',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      isValidEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isValid',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      isValidOfflineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isValidOffline',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      relativeTimeSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relativeTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      relativeTimeSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relativeTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      relativeTimeSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relativeTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      relativeTimeSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relativeTimeSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startDateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startTimeSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startTimeSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startTimeSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimeSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      startTimeSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimeSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension CachedContestQueryObject
    on QueryBuilder<CachedContest, CachedContest, QFilterCondition> {}

extension CachedContestQueryLinks
    on QueryBuilder<CachedContest, CachedContest, QFilterCondition> {}

extension CachedContestQuerySortBy
    on QueryBuilder<CachedContest, CachedContest, QSortBy> {
  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByDurationFormatted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationFormatted', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByDurationFormattedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationFormatted', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByIsUpcoming() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUpcoming', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByIsUpcomingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUpcoming', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByIsValidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByIsValidOfflineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByRelativeTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relativeTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByRelativeTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relativeTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      sortByStartTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CachedContestQuerySortThenBy
    on QueryBuilder<CachedContest, CachedContest, QSortThenBy> {
  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByContestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contestId', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByDurationFormatted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationFormatted', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByDurationFormattedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationFormatted', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIsUpcoming() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUpcoming', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByIsUpcomingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUpcoming', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByIsValidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValid', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByIsValidOfflineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidOffline', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByRelativeTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relativeTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByRelativeTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relativeTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeSeconds', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy>
      thenByStartTimeSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeSeconds', Sort.desc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CachedContestQueryWhereDistinct
    on QueryBuilder<CachedContest, CachedContest, QDistinct> {
  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByContestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contestId');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByDurationFormatted({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationFormatted',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLive');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByIsUpcoming() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUpcoming');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByIsValid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isValid');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByIsValidOffline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isValidOffline');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByRelativeTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relativeTimeSeconds');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDateTime');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct>
      distinctByStartTimeSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeSeconds');
    });
  }

  QueryBuilder<CachedContest, CachedContest, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension CachedContestQueryProperty
    on QueryBuilder<CachedContest, CachedContest, QQueryProperty> {
  QueryBuilder<CachedContest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedContest, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedContest, int, QQueryOperations> contestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contestId');
    });
  }

  QueryBuilder<CachedContest, String, QQueryOperations>
      durationFormattedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationFormatted');
    });
  }

  QueryBuilder<CachedContest, int, QQueryOperations> durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<CachedContest, bool, QQueryOperations> isLiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLive');
    });
  }

  QueryBuilder<CachedContest, bool, QQueryOperations> isUpcomingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUpcoming');
    });
  }

  QueryBuilder<CachedContest, bool, QQueryOperations> isValidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isValid');
    });
  }

  QueryBuilder<CachedContest, bool, QQueryOperations> isValidOfflineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isValidOffline');
    });
  }

  QueryBuilder<CachedContest, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CachedContest, int, QQueryOperations>
      relativeTimeSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relativeTimeSeconds');
    });
  }

  QueryBuilder<CachedContest, DateTime, QQueryOperations>
      startDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDateTime');
    });
  }

  QueryBuilder<CachedContest, int, QQueryOperations>
      startTimeSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeSeconds');
    });
  }

  QueryBuilder<CachedContest, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
