// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CharactersPageDto _$CharactersPageDtoFromJson(Map<String, dynamic> json) {
  return _CharactersPageDto.fromJson(json);
}

/// @nodoc
mixin _$CharactersPageDto {
  CharacterInfoDto get info => throw _privateConstructorUsedError;
  List<CharacterDto> get results => throw _privateConstructorUsedError;

  /// Serializes this CharactersPageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharactersPageDtoCopyWith<CharactersPageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharactersPageDtoCopyWith<$Res> {
  factory $CharactersPageDtoCopyWith(
    CharactersPageDto value,
    $Res Function(CharactersPageDto) then,
  ) = _$CharactersPageDtoCopyWithImpl<$Res, CharactersPageDto>;
  @useResult
  $Res call({CharacterInfoDto info, List<CharacterDto> results});

  $CharacterInfoDtoCopyWith<$Res> get info;
}

/// @nodoc
class _$CharactersPageDtoCopyWithImpl<$Res, $Val extends CharactersPageDto>
    implements $CharactersPageDtoCopyWith<$Res> {
  _$CharactersPageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? info = null, Object? results = null}) {
    return _then(
      _value.copyWith(
            info:
                null == info
                    ? _value.info
                    : info // ignore: cast_nullable_to_non_nullable
                        as CharacterInfoDto,
            results:
                null == results
                    ? _value.results
                    : results // ignore: cast_nullable_to_non_nullable
                        as List<CharacterDto>,
          )
          as $Val,
    );
  }

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterInfoDtoCopyWith<$Res> get info {
    return $CharacterInfoDtoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharactersPageDtoImplCopyWith<$Res>
    implements $CharactersPageDtoCopyWith<$Res> {
  factory _$$CharactersPageDtoImplCopyWith(
    _$CharactersPageDtoImpl value,
    $Res Function(_$CharactersPageDtoImpl) then,
  ) = __$$CharactersPageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CharacterInfoDto info, List<CharacterDto> results});

  @override
  $CharacterInfoDtoCopyWith<$Res> get info;
}

/// @nodoc
class __$$CharactersPageDtoImplCopyWithImpl<$Res>
    extends _$CharactersPageDtoCopyWithImpl<$Res, _$CharactersPageDtoImpl>
    implements _$$CharactersPageDtoImplCopyWith<$Res> {
  __$$CharactersPageDtoImplCopyWithImpl(
    _$CharactersPageDtoImpl _value,
    $Res Function(_$CharactersPageDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? info = null, Object? results = null}) {
    return _then(
      _$CharactersPageDtoImpl(
        info:
            null == info
                ? _value.info
                : info // ignore: cast_nullable_to_non_nullable
                    as CharacterInfoDto,
        results:
            null == results
                ? _value._results
                : results // ignore: cast_nullable_to_non_nullable
                    as List<CharacterDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharactersPageDtoImpl implements _CharactersPageDto {
  const _$CharactersPageDtoImpl({
    required this.info,
    required final List<CharacterDto> results,
  }) : _results = results;

  factory _$CharactersPageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharactersPageDtoImplFromJson(json);

  @override
  final CharacterInfoDto info;
  final List<CharacterDto> _results;
  @override
  List<CharacterDto> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CharactersPageDto(info: $info, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharactersPageDtoImpl &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    info,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharactersPageDtoImplCopyWith<_$CharactersPageDtoImpl> get copyWith =>
      __$$CharactersPageDtoImplCopyWithImpl<_$CharactersPageDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharactersPageDtoImplToJson(this);
  }
}

abstract class _CharactersPageDto implements CharactersPageDto {
  const factory _CharactersPageDto({
    required final CharacterInfoDto info,
    required final List<CharacterDto> results,
  }) = _$CharactersPageDtoImpl;

  factory _CharactersPageDto.fromJson(Map<String, dynamic> json) =
      _$CharactersPageDtoImpl.fromJson;

  @override
  CharacterInfoDto get info;
  @override
  List<CharacterDto> get results;

  /// Create a copy of CharactersPageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharactersPageDtoImplCopyWith<_$CharactersPageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterInfoDto _$CharacterInfoDtoFromJson(Map<String, dynamic> json) {
  return _CharacterInfoDto.fromJson(json);
}

/// @nodoc
mixin _$CharacterInfoDto {
  int get count => throw _privateConstructorUsedError;
  int get pages => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get prev => throw _privateConstructorUsedError;

  /// Serializes this CharacterInfoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterInfoDtoCopyWith<CharacterInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterInfoDtoCopyWith<$Res> {
  factory $CharacterInfoDtoCopyWith(
    CharacterInfoDto value,
    $Res Function(CharacterInfoDto) then,
  ) = _$CharacterInfoDtoCopyWithImpl<$Res, CharacterInfoDto>;
  @useResult
  $Res call({int count, int pages, String? next, String? prev});
}

/// @nodoc
class _$CharacterInfoDtoCopyWithImpl<$Res, $Val extends CharacterInfoDto>
    implements $CharacterInfoDtoCopyWith<$Res> {
  _$CharacterInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? pages = null,
    Object? next = freezed,
    Object? prev = freezed,
  }) {
    return _then(
      _value.copyWith(
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
            pages:
                null == pages
                    ? _value.pages
                    : pages // ignore: cast_nullable_to_non_nullable
                        as int,
            next:
                freezed == next
                    ? _value.next
                    : next // ignore: cast_nullable_to_non_nullable
                        as String?,
            prev:
                freezed == prev
                    ? _value.prev
                    : prev // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterInfoDtoImplCopyWith<$Res>
    implements $CharacterInfoDtoCopyWith<$Res> {
  factory _$$CharacterInfoDtoImplCopyWith(
    _$CharacterInfoDtoImpl value,
    $Res Function(_$CharacterInfoDtoImpl) then,
  ) = __$$CharacterInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int count, int pages, String? next, String? prev});
}

/// @nodoc
class __$$CharacterInfoDtoImplCopyWithImpl<$Res>
    extends _$CharacterInfoDtoCopyWithImpl<$Res, _$CharacterInfoDtoImpl>
    implements _$$CharacterInfoDtoImplCopyWith<$Res> {
  __$$CharacterInfoDtoImplCopyWithImpl(
    _$CharacterInfoDtoImpl _value,
    $Res Function(_$CharacterInfoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? pages = null,
    Object? next = freezed,
    Object? prev = freezed,
  }) {
    return _then(
      _$CharacterInfoDtoImpl(
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
        pages:
            null == pages
                ? _value.pages
                : pages // ignore: cast_nullable_to_non_nullable
                    as int,
        next:
            freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                    as String?,
        prev:
            freezed == prev
                ? _value.prev
                : prev // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterInfoDtoImpl implements _CharacterInfoDto {
  const _$CharacterInfoDtoImpl({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory _$CharacterInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterInfoDtoImplFromJson(json);

  @override
  final int count;
  @override
  final int pages;
  @override
  final String? next;
  @override
  final String? prev;

  @override
  String toString() {
    return 'CharacterInfoDto(count: $count, pages: $pages, next: $next, prev: $prev)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterInfoDtoImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.prev, prev) || other.prev == prev));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, pages, next, prev);

  /// Create a copy of CharacterInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterInfoDtoImplCopyWith<_$CharacterInfoDtoImpl> get copyWith =>
      __$$CharacterInfoDtoImplCopyWithImpl<_$CharacterInfoDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterInfoDtoImplToJson(this);
  }
}

abstract class _CharacterInfoDto implements CharacterInfoDto {
  const factory _CharacterInfoDto({
    required final int count,
    required final int pages,
    final String? next,
    final String? prev,
  }) = _$CharacterInfoDtoImpl;

  factory _CharacterInfoDto.fromJson(Map<String, dynamic> json) =
      _$CharacterInfoDtoImpl.fromJson;

  @override
  int get count;
  @override
  int get pages;
  @override
  String? get next;
  @override
  String? get prev;

  /// Create a copy of CharacterInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterInfoDtoImplCopyWith<_$CharacterInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterDto _$CharacterDtoFromJson(Map<String, dynamic> json) {
  return _CharacterDto.fromJson(json);
}

/// @nodoc
mixin _$CharacterDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get species => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  CharacterLocationDto get origin => throw _privateConstructorUsedError;
  CharacterLocationDto get location => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;

  /// Serializes this CharacterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterDtoCopyWith<CharacterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterDtoCopyWith<$Res> {
  factory $CharacterDtoCopyWith(
    CharacterDto value,
    $Res Function(CharacterDto) then,
  ) = _$CharacterDtoCopyWithImpl<$Res, CharacterDto>;
  @useResult
  $Res call({
    int id,
    String name,
    String status,
    String species,
    String type,
    String gender,
    CharacterLocationDto origin,
    CharacterLocationDto location,
    String image,
    String url,
    String created,
  });

  $CharacterLocationDtoCopyWith<$Res> get origin;
  $CharacterLocationDtoCopyWith<$Res> get location;
}

/// @nodoc
class _$CharacterDtoCopyWithImpl<$Res, $Val extends CharacterDto>
    implements $CharacterDtoCopyWith<$Res> {
  _$CharacterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? type = null,
    Object? gender = null,
    Object? origin = null,
    Object? location = null,
    Object? image = null,
    Object? url = null,
    Object? created = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            species:
                null == species
                    ? _value.species
                    : species // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            gender:
                null == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String,
            origin:
                null == origin
                    ? _value.origin
                    : origin // ignore: cast_nullable_to_non_nullable
                        as CharacterLocationDto,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as CharacterLocationDto,
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            created:
                null == created
                    ? _value.created
                    : created // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterLocationDtoCopyWith<$Res> get origin {
    return $CharacterLocationDtoCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharacterLocationDtoCopyWith<$Res> get location {
    return $CharacterLocationDtoCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharacterDtoImplCopyWith<$Res>
    implements $CharacterDtoCopyWith<$Res> {
  factory _$$CharacterDtoImplCopyWith(
    _$CharacterDtoImpl value,
    $Res Function(_$CharacterDtoImpl) then,
  ) = __$$CharacterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String status,
    String species,
    String type,
    String gender,
    CharacterLocationDto origin,
    CharacterLocationDto location,
    String image,
    String url,
    String created,
  });

  @override
  $CharacterLocationDtoCopyWith<$Res> get origin;
  @override
  $CharacterLocationDtoCopyWith<$Res> get location;
}

/// @nodoc
class __$$CharacterDtoImplCopyWithImpl<$Res>
    extends _$CharacterDtoCopyWithImpl<$Res, _$CharacterDtoImpl>
    implements _$$CharacterDtoImplCopyWith<$Res> {
  __$$CharacterDtoImplCopyWithImpl(
    _$CharacterDtoImpl _value,
    $Res Function(_$CharacterDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? type = null,
    Object? gender = null,
    Object? origin = null,
    Object? location = null,
    Object? image = null,
    Object? url = null,
    Object? created = null,
  }) {
    return _then(
      _$CharacterDtoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        species:
            null == species
                ? _value.species
                : species // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        gender:
            null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String,
        origin:
            null == origin
                ? _value.origin
                : origin // ignore: cast_nullable_to_non_nullable
                    as CharacterLocationDto,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as CharacterLocationDto,
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        created:
            null == created
                ? _value.created
                : created // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterDtoImpl implements _CharacterDto {
  const _$CharacterDtoImpl({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.url,
    required this.created,
  });

  factory _$CharacterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String status;
  @override
  final String species;
  @override
  final String type;
  @override
  final String gender;
  @override
  final CharacterLocationDto origin;
  @override
  final CharacterLocationDto location;
  @override
  final String image;
  @override
  final String url;
  @override
  final String created;

  @override
  String toString() {
    return 'CharacterDto(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, url: $url, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    url,
    created,
  );

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterDtoImplCopyWith<_$CharacterDtoImpl> get copyWith =>
      __$$CharacterDtoImplCopyWithImpl<_$CharacterDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterDtoImplToJson(this);
  }
}

abstract class _CharacterDto implements CharacterDto {
  const factory _CharacterDto({
    required final int id,
    required final String name,
    required final String status,
    required final String species,
    required final String type,
    required final String gender,
    required final CharacterLocationDto origin,
    required final CharacterLocationDto location,
    required final String image,
    required final String url,
    required final String created,
  }) = _$CharacterDtoImpl;

  factory _CharacterDto.fromJson(Map<String, dynamic> json) =
      _$CharacterDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get status;
  @override
  String get species;
  @override
  String get type;
  @override
  String get gender;
  @override
  CharacterLocationDto get origin;
  @override
  CharacterLocationDto get location;
  @override
  String get image;
  @override
  String get url;
  @override
  String get created;

  /// Create a copy of CharacterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterDtoImplCopyWith<_$CharacterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterLocationDto _$CharacterLocationDtoFromJson(Map<String, dynamic> json) {
  return _CharacterLocationDto.fromJson(json);
}

/// @nodoc
mixin _$CharacterLocationDto {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this CharacterLocationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterLocationDtoCopyWith<CharacterLocationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterLocationDtoCopyWith<$Res> {
  factory $CharacterLocationDtoCopyWith(
    CharacterLocationDto value,
    $Res Function(CharacterLocationDto) then,
  ) = _$CharacterLocationDtoCopyWithImpl<$Res, CharacterLocationDto>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$CharacterLocationDtoCopyWithImpl<
  $Res,
  $Val extends CharacterLocationDto
>
    implements $CharacterLocationDtoCopyWith<$Res> {
  _$CharacterLocationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CharacterLocationDtoImplCopyWith<$Res>
    implements $CharacterLocationDtoCopyWith<$Res> {
  factory _$$CharacterLocationDtoImplCopyWith(
    _$CharacterLocationDtoImpl value,
    $Res Function(_$CharacterLocationDtoImpl) then,
  ) = __$$CharacterLocationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$CharacterLocationDtoImplCopyWithImpl<$Res>
    extends _$CharacterLocationDtoCopyWithImpl<$Res, _$CharacterLocationDtoImpl>
    implements _$$CharacterLocationDtoImplCopyWith<$Res> {
  __$$CharacterLocationDtoImplCopyWithImpl(
    _$CharacterLocationDtoImpl _value,
    $Res Function(_$CharacterLocationDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CharacterLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? url = null}) {
    return _then(
      _$CharacterLocationDtoImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterLocationDtoImpl implements _CharacterLocationDto {
  const _$CharacterLocationDtoImpl({required this.name, required this.url});

  factory _$CharacterLocationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterLocationDtoImplFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'CharacterLocationDto(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterLocationDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  /// Create a copy of CharacterLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterLocationDtoImplCopyWith<_$CharacterLocationDtoImpl>
  get copyWith =>
      __$$CharacterLocationDtoImplCopyWithImpl<_$CharacterLocationDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterLocationDtoImplToJson(this);
  }
}

abstract class _CharacterLocationDto implements CharacterLocationDto {
  const factory _CharacterLocationDto({
    required final String name,
    required final String url,
  }) = _$CharacterLocationDtoImpl;

  factory _CharacterLocationDto.fromJson(Map<String, dynamic> json) =
      _$CharacterLocationDtoImpl.fromJson;

  @override
  String get name;
  @override
  String get url;

  /// Create a copy of CharacterLocationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterLocationDtoImplCopyWith<_$CharacterLocationDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
