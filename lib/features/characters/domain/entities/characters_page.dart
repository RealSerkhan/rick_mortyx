import 'package:rick_morty/features/characters/domain/entities/character.dart';

class CharactersPage {
  final List<Character> characters;
  final int currentPage;
  final int totalPages;
  final bool hasNext;

  const CharactersPage({
    required this.characters,
    required this.currentPage,
    required this.totalPages,
    required this.hasNext,
  });
}
