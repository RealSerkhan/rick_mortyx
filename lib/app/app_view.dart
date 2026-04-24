import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/app/theme/locale_cubit.dart';
import 'package:rick_morty/app/theme/theme_cubit.dart';
import 'package:rick_morty/base/di/di_entry_point.dart';
import 'package:rick_morty/features/home/presentation/pages/home_screen.dart';
import 'package:rick_morty/features/settings/domain/use_cases/get_locale_use_case.dart';
import 'package:rick_morty/features/settings/domain/use_cases/get_theme_mode_use_case.dart';
import 'package:rick_morty/features/settings/domain/use_cases/save_locale_use_case.dart';
import 'package:rick_morty/features/settings/domain/use_cases/save_theme_mode_use_case.dart';
import 'package:rick_morty/l10n/app_localizations.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(getIt<GetThemeModeUseCase>(), getIt<SaveThemeModeUseCase>())),
        BlocProvider(create: (_) => LocaleCubit(getIt<GetLocaleUseCase>(), getIt<SaveLocaleUseCase>())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return ScreenUtilInit(
                designSize: const Size(430, 876),
                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Rick & Morty',
                    locale: locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    theme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: const Color(0xFF0F0F0F),
                        brightness: Brightness.light,
                      ),
                      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
                      extensions: const [AppColors.light],
                    ),
                    darkTheme: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: const Color(0xFF0F0F0F),
                        brightness: Brightness.dark,
                      ),
                      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
                      extensions: const [AppColors.dark],
                    ),
                    themeMode: themeMode,
                    home: const HomeScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
