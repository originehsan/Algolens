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
