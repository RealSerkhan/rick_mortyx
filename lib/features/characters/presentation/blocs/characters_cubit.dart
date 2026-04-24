import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/entities/characters_page.dart';
import 'package:rick_morty/features/characters/domain/use_cases/get_characters_use_case.dart';
import 'package:rick_morty/features/characters/domain/use_cases/toggle_favourite_use_case.dart';

part 'characters_state.dart';
part 'characters_cubit.freezed.dart';

@lazySingleton
class CharactersCubit extends Cubit<CharactersState> {
  final GetCharactersUseCase _getCharactersUseCase;
  final ToggleFavouriteUseCase _toggleFavouriteUseCase;

  Timer? _debounce;
  String _searchQuery = '';
  List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  CharactersCubit(this._getCharactersUseCase, this._toggleFavouriteUseCase) : super(const CharactersState.initial());

  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _characters = [];
    }

    emit(const CharactersState.loading());
    final result = await _fetch(page: 1);
    result.fold((failure) => emit(CharactersState.error(failure)), (page) => _applyPage(page));
  }

  Future<void> loadMoreCharacters() async {
    if (_isLoadingMore) return;

    final currentState = state;
    if (currentState is! _Loaded || !currentState.hasNextPage) return;

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _fetch(page: _currentPage + 1);
    _isLoadingMore = false;
    result.fold((_) {
      if (state is _Loaded) emit((state as _Loaded).copyWith(isLoadingMore: false));
    }, (page) => _applyPage(page, append: true));
  }

  Future<Either<Failure, CharactersPage>> _fetch({required int page}) {
    return _getCharactersUseCase(page: page, name: _searchQuery.isEmpty ? null : _searchQuery);
  }

  void _applyPage(CharactersPage page, {bool append = false}) {
    _characters = append ? [..._characters, ...page.characters] : page.characters;
    _currentPage = page.currentPage;
    emit(CharactersState.loaded(characters: _characters, currentPage: _currentPage, hasNextPage: page.hasNext));
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchQuery != query) {
        _searchQuery = query;
        loadCharacters(refresh: true);
      }
    });
  }

  Future<void> toggleFavourite(Character character) async {
    final result = await _toggleFavouriteUseCase(character);
    result.fold((_) {}, (_) {
      final updatedCharacter = character.copyWith(isFavourite: !character.isFavourite);
      final index = _characters.indexWhere((c) => c.id == character.id);
      if (index != -1) {
        _characters = List.from(_characters)..[index] = updatedCharacter;
        final currentState = state;
        if (currentState is _Loaded) {
          emit(currentState.copyWith(characters: _characters));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
