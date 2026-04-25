import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/domain/entities/characters_page.dart';

const tCharacter = Character(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  gender: 'Male',
  originName: 'Earth (C-137)',
  locationName: 'Citadel of Ricks',
  image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
);

const tCharacterFavourited = Character(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  gender: 'Male',
  originName: 'Earth (C-137)',
  locationName: 'Citadel of Ricks',
  image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
  isFavourite: true,
);

final tCharactersPage = const CharactersPage(characters: [tCharacter], currentPage: 1, totalPages: 3, hasNext: true);

final tCharactersPageLast = const CharactersPage(characters: [tCharacter], currentPage: 3, totalPages: 3, hasNext: false);
