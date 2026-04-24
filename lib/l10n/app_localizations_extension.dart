import 'package:flutter/widgets.dart';
import 'package:rick_morty/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
