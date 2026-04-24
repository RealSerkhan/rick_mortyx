import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/entities/characters_page.dart';
import 'package:rick_morty/features/characters/domain/repos/character_repo.dart';

@lazySingleton
class GetCharactersUseCase {
  final CharacterRepository _repository;

  GetCharactersUseCase(this._repository);

  Future<Either<Failure, CharactersPage>> call({int page = 1, String? name}) async {
    return _repository.getCharacters(page: page, name: name);
  }
}
