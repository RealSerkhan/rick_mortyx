// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rick & Morty';

  @override
  String get charactersTitle => 'Characters';

  @override
  String get rickAndMortyUniverse => 'Rick & Morty Universe';

  @override
  String get switchToLightMode => 'Switch to light mode';

  @override
  String get switchToDarkMode => 'Switch to dark mode';

  @override
  String get searchCharacters => 'Search characters...';

  @override
  String get noCharactersFound => 'No characters found';

  @override
  String get favouritesTitle => 'Favourites';

  @override
  String get noFavouritesYet =>
      'No favourites yet.\nTap ♥ on a character to save it.';

  @override
  String get oops => 'Oops!';

  @override
  String get unexpectedError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get species => 'Species';

  @override
  String get type => 'Type';

  @override
  String get gender => 'Gender';

  @override
  String get origin => 'Origin';

  @override
  String get lastLocation => 'Last Location';

  @override
  String get addToFavourites => 'Add to Favourites';

  @override
  String get removeFromFavourites => 'Remove from Favourites';

  @override
  String get addedToFavourites => 'Added to Favourites';

  @override
  String get removedFromFavourites => 'Removed from Favourites';

  @override
  String get yourSavedCharacters => 'Your saved characters';
}
