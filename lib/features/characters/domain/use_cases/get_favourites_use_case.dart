import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/repos/character_repo.dart';

@lazySingleton
class GetFavouritesUseCase {
  final CharacterRepository _repository;

  GetFavouritesUseCase(this._repository);

  Future<Either<Failure, List<Character>>> call() async {
    return _repository.getFavourites();
  }
}
