// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

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
    r'lastActiveDate': PropertySchema(
      id: 5,
      name: r'lastActiveDate',
      type: IsarType.string,
    ),
    r'maxRating': PropertySchema(
      id: 6,
      name: r'maxRating',
      type: IsarType.long,
    ),
    r'problemsSolved': PropertySchema(
      id: 7,
      name: r'problemsSolved',
      type: IsarType.long,
    ),
    r'rank': PropertySchema(
      id: 8,
      name: r'rank',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 9,
      name: r'rating',
      type: IsarType.long,
    ),
    r'streakDays': PropertySchema(
      id: 10,
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
  writer.writeString(offsets[5], object.lastActiveDate);
  writer.writeLong(offsets[6], object.maxRating);
  writer.writeLong(offsets[7], object.problemsSolved);
  writer.writeString(offsets[8], object.rank);
  writer.writeLong(offsets[9], object.rating);
  writer.writeLong(offsets[10], object.streakDays);
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
  object.lastActiveDate = reader.readString(offsets[5]);
  object.maxRating = reader.readLong(offsets[6]);
  object.problemsSolved = reader.readLong(offsets[7]);
  object.rank = reader.readString(offsets[8]);
  object.rating = reader.readLong(offsets[9]);
  object.streakDays = reader.readLong(offsets[10]);
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
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
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
