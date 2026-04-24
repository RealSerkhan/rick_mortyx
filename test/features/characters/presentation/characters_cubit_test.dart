import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_characters_use_case.dart';
import 'package:rick_morty/features/characters/domain/use_cases/toggle_favourite_use_case.dart';
import 'package:rick_morty/features/characters/presentation/blocs/characters_cubit.dart';

import '../../../fixtures.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

class MockToggleFavouriteUseCase extends Mock implements ToggleFavouriteUseCase {}

void main() {
  late MockGetCharactersUseCase getCharacters;
  late MockToggleFavouriteUseCase toggleFavourite;

  setUp(() {
    getCharacters = MockGetCharactersUseCase();
    toggleFavourite = MockToggleFavouriteUseCase();
    registerFallbackValue(tCharacter);
  });

  CharactersCubit buildCubit() => CharactersCubit(getCharacters, toggleFavourite);

  // ─── loadCharacters ──────────────────────────────────────────────────────────

  group('loadCharacters', () {
    blocTest<CharactersCubit, CharactersState>(
      'emits [loading, loaded] on success',
      build: buildCubit,
      setUp: () {
        when(
          () => getCharacters(page: any(named: 'page'), name: any(named: 'name')),
        ).thenAnswer((_) async => Right(tCharactersPage));
      },
      act: (cubit) => cubit.loadCharacters(),
      expect:
          () => [
            const CharactersState.loading(),
            CharactersState.loaded(characters: tCharactersPage.characters, currentPage: 1, hasNextPage: true),
          ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'emits [loading, error] on failure',
      build: buildCubit,
      setUp: () {
        when(
          () => getCharacters(page: any(named: 'page'), name: any(named: 'name')),
        ).thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'error')));
      },
      act: (cubit) => cubit.loadCharacters(),
      expect:
          () => [const CharactersState.loading(), const CharactersState.error(ServerFailure(errorMessage: 'error'))],
    );

    blocTest<CharactersCubit, CharactersState>(
      'resets page and list when refresh is true',
      build: buildCubit,
      setUp: () {
        when(
          () => getCharacters(page: any(named: 'page'), name: any(named: 'name')),
        ).thenAnswer((_) async => Right(tCharactersPage));
      },
      act: (cubit) => cubit.loadCharacters(refresh: true),
      expect:
          () => [
            const CharactersState.loading(),
            CharactersState.loaded(characters: tCharactersPage.characters, currentPage: 1, hasNextPage: true),
          ],
      verify: (_) => verify(() => getCharacters(page: 1, name: null)).called(1),
    );
  });

  // ─── loadMoreCharacters ──────────────────────────────────────────────────────

  group('loadMoreCharacters', () {
    blocTest<CharactersCubit, CharactersState>(
      'appends next page to existing list',
      build: buildCubit,
      setUp: () {
        when(
          () => getCharacters(page: any(named: 'page'), name: any(named: 'name')),
        ).thenAnswer((_) async => Right(tCharactersPage));
      },
      // seed: is intentionally omitted — _characters must be populated via loadCharacters
      // because seed() only sets the emitted state, not the cubit's private _characters field.
      act: (cubit) async {
        await cubit.loadCharacters();
        await cubit.loadMoreCharacters();
      },
      expect:
          () => [
            const CharactersState.loading(),
            CharactersState.loaded(characters: tCharactersPage.characters, currentPage: 1, hasNextPage: true),
            CharactersState.loaded(
              characters: tCharactersPage.characters,
              currentPage: 1,
              hasNextPage: true,
              isLoadingMore: true,
            ),
            CharactersState.loaded(
              characters: [...tCharactersPage.characters, ...tCharactersPage.characters],
              currentPage: 1,
              hasNextPage: true,
            ),
          ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'does nothing when hasNextPage is false',
      build: buildCubit,
      seed: () => CharactersState.loaded(characters: tCharactersPage.characters, currentPage: 3, hasNextPage: false),
      act: (cubit) => cubit.loadMoreCharacters(),
      expect: () => <CharactersState>[],
    );

    blocTest<CharactersCubit, CharactersState>(
      'does nothing when state is not loaded',
      build: buildCubit,
      act: (cubit) => cubit.loadMoreCharacters(),
      expect: () => <CharactersState>[],
    );
  });

  // ─── toggleFavourite ─────────────────────────────────────────────────────────

  group('toggleFavourite', () {
    blocTest<CharactersCubit, CharactersState>(
      'flips isFavourite to true in loaded list',
      build: buildCubit,
      setUp: () {
        when(
          () => getCharacters(page: any(named: 'page'), name: any(named: 'name')),
        ).thenAnswer((_) async => Right(tCharactersPage));
        when(() => toggleFavourite(any())).thenAnswer((_) async => const Right(unit));
      },
      // seed: is intentionally omitted — _characters must be populated via loadCharacters
      // because seed() only sets the emitted state, not the cubit's private _characters field.
      act: (cubit) async {
        await cubit.loadCharacters();
        await cubit.toggleFavourite(tCharacter);
      },
      expect:
          () => [
            const CharactersState.loading(),
            CharactersState.loaded(characters: tCharactersPage.characters, currentPage: 1, hasNextPage: true),
            CharactersState.loaded(characters: const [tCharacterFavourited], currentPage: 1, hasNextPage: true),
          ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'emits nothing on toggle failure',
      build: buildCubit,
      setUp: () {
        when(() => toggleFavourite(any())).thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'error')));
      },
      seed: () => CharactersState.loaded(characters: const [tCharacter], currentPage: 1, hasNextPage: false),
      act: (cubit) => cubit.toggleFavourite(tCharacter),
      expect: () => <CharactersState>[],
    );
  });
}
