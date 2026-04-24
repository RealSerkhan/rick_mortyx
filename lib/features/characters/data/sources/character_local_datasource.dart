import 'dart:convert';
import 'package:rick_morty/features/characters/data/models/character_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CharacterLocalDataSource {
  List<CharacterDto> getFavouriteCharacters();
  bool isFavourite(int characterId);
  Future<void> saveFavourite(CharacterDto dto);
  Future<void> removeFavourite(int characterId);
}

@LazySingleton(as: CharacterLocalDataSource)
class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const _key = 'favourite_characters';

  CharacterLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  List<CharacterDto> getFavouriteCharacters() {
    final jsonStr = _prefs.getString(_key);
    if (jsonStr == null) return [];
    final list = jsonDecode(jsonStr) as List;
    return list.map((e) => CharacterDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  bool isFavourite(int characterId) {
    return getFavouriteCharacters().any((c) => c.id == characterId);
  }

  @override
  Future<void> saveFavourite(CharacterDto dto) async {
    final favourites = getFavouriteCharacters();
    if (!favourites.any((c) => c.id == dto.id)) {
      favourites.add(dto);
      await _prefs.setString(_key, jsonEncode(favourites.map((c) => c.toJson()).toList()));
    }
  }

  @override
  Future<void> removeFavourite(int characterId) async {
    final favourites = getFavouriteCharacters()..removeWhere((c) => c.id == characterId);
    await _prefs.setString(_key, jsonEncode(favourites.map((c) => c.toJson()).toList()));
  }
}
