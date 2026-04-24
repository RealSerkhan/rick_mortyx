import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/repos/character_repo.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_characters_use_case.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_favourites_use_case.dart';
import 'package:rick_morty/features/characters/domain/use_cases/toggle_favourite_use_case.dart';

import '../../../fixtures.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late MockCharacterRepository repo;

  setUp(() {
    repo = MockCharacterRepository();
    registerFallbackValue(tCharacter);
  });

  // ─── GetCharactersUseCase ────────────────────────────────────────────────────

  group('GetCharactersUseCase', () {
    late GetCharactersUseCase useCase;

    setUp(() => useCase = GetCharactersUseCase(repo));

    test('returns CharactersPage on success', () async {
      when(
        () => repo.getCharacters(page: any(named: 'page'), name: any(named: 'name')),
      ).thenAnswer((_) async => Right(tCharactersPage));

      final result = await useCase(page: 1);

      expect(result, Right(tCharactersPage));
      verify(() => repo.getCharacters(page: 1, name: null)).called(1);
    });

    test('returns Failure on error', () async {
      const failure = ServerFailure(errorMessage: 'Not found');
      when(
        () => repo.getCharacters(page: any(named: 'page'), name: any(named: 'name')),
      ).thenAnswer((_) async => const Left(failure));

      final result = await useCase(page: 1);

      expect(result, const Left(failure));
    });

    test('passes name filter through to repository', () async {
      when(
        () => repo.getCharacters(page: any(named: 'page'), name: any(named: 'name')),
      ).thenAnswer((_) async => Right(tCharactersPage));

      await useCase(page: 1, name: 'Rick');

      verify(() => repo.getCharacters(page: 1, name: 'Rick')).called(1);
    });
  });

  // ─── ToggleFavouriteUseCase ──────────────────────────────────────────────────

  group('ToggleFavouriteUseCase', () {
    late ToggleFavouriteUseCase useCase;

    setUp(() => useCase = ToggleFavouriteUseCase(repo));

    test('returns unit on success', () async {
      when(() => repo.toggleFavourite(any())).thenAnswer((_) async => const Right(unit));

      final result = await useCase(tCharacter);

      expect(result, const Right(unit));
      verify(() => repo.toggleFavourite(tCharacter)).called(1);
    });

    test('returns Failure on error', () async {
      const failure = NoInternetFailure(errorMessage: 'No internet');
      when(() => repo.toggleFavourite(any())).thenAnswer((_) async => const Left(failure));

      final result = await useCase(tCharacter);

      expect(result, const Left(failure));
    });
  });

  // ─── GetFavouritesUseCase ────────────────────────────────────────────────────

  group('GetFavouritesUseCase', () {
    late GetFavouritesUseCase useCase;

    setUp(() => useCase = GetFavouritesUseCase(repo));

    test('returns list of favourites on success', () async {
      when(() => repo.getFavourites()).thenAnswer((_) async => const Right([tCharacterFavourited]));

      final result = await useCase();

      expect(result, const Right([tCharacterFavourited]));
    });

    test('returns Failure on error', () async {
      const failure = ServerFailure(errorMessage: 'Server error');
      when(() => repo.getFavourites()).thenAnswer((_) async => const Left(failure));

      final result = await useCase();

      expect(result, const Left(failure));
    });
  });
}
