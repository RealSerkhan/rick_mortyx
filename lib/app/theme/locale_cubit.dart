import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/features/settings/domain/use_cases/get_locale_use_case.dart';
import 'package:rick_morty/features/settings/domain/use_cases/save_locale_use_case.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(GetLocaleUseCase getLocale, this._saveLocale)
    : super(getLocale().fold((_) => const Locale('en'), (value) => Locale(value ?? 'en')));

  final SaveLocaleUseCase _saveLocale;
  //for only 2 languages, we can toggle between them. For more languages, we would need to pass the next locale as a parameter
  void toggle() {
    final next = state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    _saveLocale(next.languageCode);
    emit(next);
  }
}
