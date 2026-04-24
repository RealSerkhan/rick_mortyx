import 'package:dartz/dartz.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/entities/characters_page.dart';

abstract class CharacterRepository {
  Future<Either<Failure, CharactersPage>> getCharacters({int page = 1, String? name});
  Future<Either<Failure, List<Character>>> getFavourites();
  Future<Either<Failure, Unit>> toggleFavourite(Character character);
}
