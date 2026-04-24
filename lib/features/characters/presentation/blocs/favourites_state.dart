part of 'favourites_cubit.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState.initial() = _FavInitial;
  const factory FavouritesState.loading() = _FavLoading;
  const factory FavouritesState.loaded(List<Character> characters) = _FavLoaded;
  const factory FavouritesState.error(Failure failure) = _FavError;
}
