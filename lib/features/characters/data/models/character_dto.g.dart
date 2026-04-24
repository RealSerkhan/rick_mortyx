// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharactersPageDtoImpl _$$CharactersPageDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CharactersPageDtoImpl(
  info: CharacterInfoDto.fromJson(json['info'] as Map<String, dynamic>),
  results:
      (json['results'] as List<dynamic>)
          .map((e) => CharacterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$CharactersPageDtoImplToJson(
  _$CharactersPageDtoImpl instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};

_$CharacterInfoDtoImpl _$$CharacterInfoDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterInfoDtoImpl(
  count: (json['count'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
  next: json['next'] as String?,
  prev: json['prev'] as String?,
);

Map<String, dynamic> _$$CharacterInfoDtoImplToJson(
  _$CharacterInfoDtoImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'pages': instance.pages,
  'next': instance.next,
  'prev': instance.prev,
};

_$CharacterDtoImpl _$$CharacterDtoImplFromJson(Map<String, dynamic> json) =>
    _$CharacterDtoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: CharacterLocationDto.fromJson(
        json['origin'] as Map<String, dynamic>,
      ),
      location: CharacterLocationDto.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      image: json['image'] as String,
      url: json['url'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$$CharacterDtoImplToJson(_$CharacterDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'url': instance.url,
      'created': instance.created,
    };

_$CharacterLocationDtoImpl _$$CharacterLocationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CharacterLocationDtoImpl(
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$$CharacterLocationDtoImplToJson(
  _$CharacterLocationDtoImpl instance,
) => <String, dynamic>{'name': instance.name, 'url': instance.url};
