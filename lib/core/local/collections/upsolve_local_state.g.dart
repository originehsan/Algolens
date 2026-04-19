// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsolve_local_state.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUpsolveLocalStateCollection on Isar {
  IsarCollection<UpsolveLocalState> get upsolveLocalStates => this.collection();
}

const UpsolveLocalStateSchema = CollectionSchema(
  name: r'UpsolveLocalState',
  id: -7225040204552677600,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 1,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'problemKey': PropertySchema(
      id: 2,
      name: r'problemKey',
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
  bytesCount += 3 + object.problemKey.length * 3;
  return bytesCount;
}

void _upsolveLocalStateSerialize(
  UpsolveLocalState object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeBool(offsets[1], object.isCompleted);
  writer.writeString(offsets[2], object.problemKey);
}

UpsolveLocalState _upsolveLocalStateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UpsolveLocalState();
  object.completedAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[1]);
  object.problemKey = reader.readString(offsets[2]);
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
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
}

extension UpsolveLocalStateQueryObject
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QFilterCondition> {}

extension UpsolveLocalStateQueryLinks
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QFilterCondition> {}

extension UpsolveLocalStateQuerySortBy
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QSortBy> {
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
}

extension UpsolveLocalStateQuerySortThenBy
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QSortThenBy> {
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
}

extension UpsolveLocalStateQueryWhereDistinct
    on QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct> {
  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<UpsolveLocalState, UpsolveLocalState, QDistinct>
      distinctByProblemKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemKey', caseSensitive: caseSensitive);
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

  QueryBuilder<UpsolveLocalState, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<UpsolveLocalState, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<UpsolveLocalState, String, QQueryOperations>
      problemKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemKey');
    });
  }
}
