// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_reminder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

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
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'minutesBefore': PropertySchema(
      id: 3,
      name: r'minutesBefore',
      type: IsarType.long,
    ),
    r'notificationId': PropertySchema(
      id: 4,
      name: r'notificationId',
      type: IsarType.long,
    ),
    r'scheduledAt': PropertySchema(
      id: 5,
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
  writer.writeBool(offsets[2], object.isActive);
  writer.writeLong(offsets[3], object.minutesBefore);
  writer.writeLong(offsets[4], object.notificationId);
  writer.writeDateTime(offsets[5], object.scheduledAt);
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
  object.id = id;
  object.isActive = reader.readBool(offsets[2]);
  object.minutesBefore = reader.readLong(offsets[3]);
  object.notificationId = reader.readLong(offsets[4]);
  object.scheduledAt = reader.readDateTime(offsets[5]);
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
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
