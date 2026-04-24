import 'package:bloc/bloc.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_favourites_use_case.dart';

part 'favourites_state.dart';
part 'favourites_cubit.freezed.dart';

@lazySingleton
class FavouritesCubit extends Cubit<FavouritesState> {
  final GetFavouritesUseCase _getFavouritesUseCase;

  FavouritesCubit(this._getFavouritesUseCase) : super(const FavouritesState.initial());

  Future<void> loadFavourites() async {
    emit(const FavouritesState.loading());

    final result = await _getFavouritesUseCase();

    result.fold(
      (failure) => emit(FavouritesState.error(failure)),
      (characters) => emit(FavouritesState.loaded(characters)),
    );
  }
}
