import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/features/settings/domain/use_cases/get_theme_mode_use_case.dart';
import 'package:rick_morty/features/settings/domain/use_cases/save_theme_mode_use_case.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(GetThemeModeUseCase getThemeMode, this._saveThemeMode)
    : super(
        getThemeMode().fold((_) => ThemeMode.system, (value) {
          switch (value) {
            case 'light':
              return ThemeMode.light;
            case 'dark':
              return ThemeMode.dark;
            default:
              return ThemeMode.system;
          }
        }),
      );

  final SaveThemeModeUseCase _saveThemeMode;

  void toggle() {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _saveThemeMode(next == ThemeMode.dark ? 'dark' : 'light');
    emit(next);
  }
}
