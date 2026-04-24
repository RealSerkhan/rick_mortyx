import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/repos/character_repo.dart';

@lazySingleton
class ToggleFavouriteUseCase {
  final CharacterRepository _repository;

  ToggleFavouriteUseCase(this._repository);

  Future<Either<Failure, Unit>> call(Character character) async {
    return _repository.toggleFavourite(character);
  }
}
