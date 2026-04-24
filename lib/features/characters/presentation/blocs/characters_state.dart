part of 'characters_cubit.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading() = _Loading;
  const factory CharactersState.loaded({
    required List<Character> characters,
    required int currentPage,
    required bool hasNextPage,
    @Default(false) bool isLoadingMore,
  }) = _Loaded;
  const factory CharactersState.error(Failure failure) = _Error;
}
