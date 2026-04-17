// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dismissed_contest.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

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
