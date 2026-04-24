import 'package:rick_morty/base/data/sources/base_remote_source.dart';
import 'package:rick_morty/base/networking/http_client.dart';
import 'package:rick_morty/features/characters/data/models/character_dto.dart';
import 'package:injectable/injectable.dart';

abstract class CharacterRemoteDataSource {
  Future<CharactersPageDto> getCharacters({int page = 1, String? name});
}

@LazySingleton(as: CharacterRemoteDataSource)
class CharacterRemoteDataSourceImpl extends BaseRemoteSource implements CharacterRemoteDataSource {
  CharacterRemoteDataSourceImpl(super._client);

  @override
  Future<CharactersPageDto> getCharacters({int page = 1, String? name}) async {
    return request<CharactersPageDto>(
      method: HttpMethod.GET,
      endpoint: '/character',
      callId: '/character',
      serializer: (data) => CharactersPageDto.fromJson(data as Map<String, dynamic>),
      queryParameters: {'page': page, if (name != null && name.isNotEmpty) 'name': name},
    );
  }

  @override
  String get loggerTag => 'CharacterRemoteDataSourceImpl';
}
