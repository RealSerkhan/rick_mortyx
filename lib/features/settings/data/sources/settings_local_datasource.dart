import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  String? getThemeMode();
  Future<void> saveThemeMode(String value);

  String? getLocale();
  Future<void> saveLocale(String value);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale';

  SettingsLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  String? getThemeMode() => _prefs.getString(_themeKey);

  @override
  Future<void> saveThemeMode(String value) => _prefs.setString(_themeKey, value);

  @override
  String? getLocale() => _prefs.getString(_localeKey);

  @override
  Future<void> saveLocale(String value) => _prefs.setString(_localeKey, value);
}
