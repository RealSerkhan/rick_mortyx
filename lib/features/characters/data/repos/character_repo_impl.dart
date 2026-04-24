import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rick_morty/base/data/repos/base_repo_impl.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/data/models/character_dto.dart';
import 'package:rick_morty/features/characters/data/sources/character_local_datasource.dart';
import 'package:rick_morty/features/characters/data/sources/character_remote_datasource.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/entities/characters_page.dart';
import 'package:rick_morty/features/characters/domain/repos/character_repo.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl extends BaseRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;
  final CharacterLocalDataSource _localDataSource;

  CharacterRepositoryImpl(this._remoteDataSource, this._localDataSource, Logger logger) : super(logger);

  @override
  Future<Either<Failure, CharactersPage>> getCharacters({int page = 1, String? name}) async {
    return request(() async {
      final dto = await _remoteDataSource.getCharacters(page: page, name: name);
      final favouriteIds = _localDataSource.getFavouriteCharacters().map((c) => c.id).toSet();
      final characters = dto.results.map((d) => d.toDomain(isFavourite: favouriteIds.contains(d.id))).toList();
      return CharactersPage(
        characters: characters,
        currentPage: page,
        totalPages: dto.info.pages,
        hasNext: dto.info.next != null,
      );
    });
  }

  @override
  Future<Either<Failure, List<Character>>> getFavourites() async {
    return request(() async {
      final dtos = _localDataSource.getFavouriteCharacters();
      return dtos.map((d) => d.toDomain(isFavourite: true)).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> toggleFavourite(Character character) async {
    return request(() async {
      if (_localDataSource.isFavourite(character.id)) {
        await _localDataSource.removeFavourite(character.id);
      } else {
        await _localDataSource.saveFavourite(character.toDto());
      }
      return unit;
    });
  }
}
