// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ريك ومورتي';

  @override
  String get charactersTitle => 'الشخصيات';

  @override
  String get rickAndMortyUniverse => 'عالم ريك ومورتي';

  @override
  String get switchToLightMode => 'التبديل إلى الوضع الفاتح';

  @override
  String get switchToDarkMode => 'التبديل إلى الوضع الداكن';

  @override
  String get searchCharacters => 'بحث عن الشخصيات...';

  @override
  String get noCharactersFound => 'لا توجد شخصيات';

  @override
  String get favouritesTitle => 'المفضلة';

  @override
  String get noFavouritesYet => 'لا توجد مفضلة بعد.\nاضغط ♥ على شخصية لحفظها.';

  @override
  String get oops => 'عذراً!';

  @override
  String get unexpectedError =>
      'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً.';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get species => 'النوع';

  @override
  String get type => 'الصنف';

  @override
  String get gender => 'الجنس';

  @override
  String get origin => 'الأصل';

  @override
  String get lastLocation => 'آخر موقع';

  @override
  String get addToFavourites => 'إضافة إلى المفضلة';

  @override
  String get removeFromFavourites => 'إزالة من المفضلة';

  @override
  String get addedToFavourites => 'تمت الإضافة إلى المفضلة';

  @override
  String get removedFromFavourites => 'تمت الإزالة من المفضلة';

  @override
  String get yourSavedCharacters => 'شخصياتك المحفوظة';
}
