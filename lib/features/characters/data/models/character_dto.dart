import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';

part 'character_dto.freezed.dart';
part 'character_dto.g.dart';

@freezed
class CharactersPageDto with _$CharactersPageDto {
  const factory CharactersPageDto({required CharacterInfoDto info, required List<CharacterDto> results}) =
      _CharactersPageDto;

  factory CharactersPageDto.fromJson(Map<String, dynamic> json) => _$CharactersPageDtoFromJson(json);
}

@freezed
class CharacterInfoDto with _$CharacterInfoDto {
  const factory CharacterInfoDto({required int count, required int pages, String? next, String? prev}) =
      _CharacterInfoDto;

  factory CharacterInfoDto.fromJson(Map<String, dynamic> json) => _$CharacterInfoDtoFromJson(json);
}

@freezed
class CharacterDto with _$CharacterDto {
  const factory CharacterDto({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required CharacterLocationDto origin,
    required CharacterLocationDto location,
    required String image,
    required String url,
    required String created,
  }) = _CharacterDto;

  factory CharacterDto.fromJson(Map<String, dynamic> json) => _$CharacterDtoFromJson(json);
}

@freezed
class CharacterLocationDto with _$CharacterLocationDto {
  const factory CharacterLocationDto({required String name, required String url}) = _CharacterLocationDto;

  factory CharacterLocationDto.fromJson(Map<String, dynamic> json) => _$CharacterLocationDtoFromJson(json);
}

extension CharacterDtoX on CharacterDto {
  Character toDomain({bool isFavourite = false}) {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type.isEmpty ? null : type,
      gender: gender,
      originName: origin.name,
      locationName: location.name,
      image: image,
      isFavourite: isFavourite,
    );
  }
}

extension CharacterX on Character {
  CharacterDto toDto() {
    return CharacterDto(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type ?? '',
      gender: gender,
      origin: CharacterLocationDto(name: originName, url: ''),
      location: CharacterLocationDto(name: locationName, url: ''),
      image: image,
      url: '',
      created: '',
    );
  }
}
