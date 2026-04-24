import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_favourites_use_case.dart';
import 'package:rick_morty/features/characters/presentation/blocs/favourites_cubit.dart';

import '../../../fixtures.dart';

class MockGetFavouritesUseCase extends Mock implements GetFavouritesUseCase {}

void main() {
  late MockGetFavouritesUseCase getFavourites;

  setUp(() => getFavourites = MockGetFavouritesUseCase());

  FavouritesCubit buildCubit() => FavouritesCubit(getFavourites);

  // ─── loadFavourites ──────────────────────────────────────────────────────────

  group('loadFavourites', () {
    blocTest<FavouritesCubit, FavouritesState>(
      'emits [loading, loaded] with characters on success',
      build: buildCubit,
      setUp: () {
        when(() => getFavourites()).thenAnswer((_) async => const Right([tCharacterFavourited]));
      },
      act: (cubit) => cubit.loadFavourites(),
      expect:
          () => [
            const FavouritesState.loading(),
            const FavouritesState.loaded([tCharacterFavourited]),
          ],
    );

    blocTest<FavouritesCubit, FavouritesState>(
      'emits [loading, loaded] with empty list when no favourites',
      build: buildCubit,
      setUp: () {
        when(() => getFavourites()).thenAnswer((_) async => const Right([]));
      },
      act: (cubit) => cubit.loadFavourites(),
      expect: () => [const FavouritesState.loading(), const FavouritesState.loaded([])],
    );

    blocTest<FavouritesCubit, FavouritesState>(
      'emits [loading, error] on failure',
      build: buildCubit,
      setUp: () {
        when(() => getFavourites()).thenAnswer((_) async => const Left(ServerFailure(errorMessage: 'db error')));
      },
      act: (cubit) => cubit.loadFavourites(),
      expect:
          () => [const FavouritesState.loading(), const FavouritesState.error(ServerFailure(errorMessage: 'db error'))],
    );

    blocTest<FavouritesCubit, FavouritesState>(
      'calls use case exactly once per invocation',
      build: buildCubit,
      setUp: () {
        when(() => getFavourites()).thenAnswer((_) async => const Right([tCharacterFavourited]));
      },
      act: (cubit) => cubit.loadFavourites(),
      verify: (_) => verify(() => getFavourites()).called(1),
    );
  });
}
