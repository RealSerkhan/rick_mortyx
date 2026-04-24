// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/characters/data/repos/character_repo_impl.dart' as _i746;
import '../../features/characters/data/sources/character_local_datasource.dart'
    as _i1062;
import '../../features/characters/data/sources/character_remote_datasource.dart'
    as _i947;
import '../../features/characters/domain/repos/character_repo.dart' as _i132;
import '../../features/characters/domain/use_cases/get_characters_use_case.dart'
    as _i941;
import '../../features/characters/domain/use_cases/get_favourites_use_case.dart'
    as _i1070;
import '../../features/characters/domain/use_cases/toggle_favourite_use_case.dart'
    as _i572;
import '../../features/characters/presentation/blocs/characters_cubit.dart'
    as _i789;
import '../../features/characters/presentation/blocs/favourites_cubit.dart'
    as _i948;
import '../../features/settings/data/repos/settings_repo_impl.dart' as _i181;
import '../../features/settings/data/sources/settings_local_datasource.dart'
    as _i846;
import '../../features/settings/domain/repos/settings_repo.dart' as _i433;
import '../../features/settings/domain/use_cases/get_locale_use_case.dart'
    as _i633;
import '../../features/settings/domain/use_cases/get_theme_mode_use_case.dart'
    as _i861;
import '../../features/settings/domain/use_cases/save_locale_use_case.dart'
    as _i1020;
import '../../features/settings/domain/use_cases/save_theme_mode_use_case.dart'
    as _i989;
import '../networking/http_client.dart' as _i757;
import 'app_module.dart' as _i460;
import 'network_module.dart' as _i567;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initDependencyInjection(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appModule = _$AppModule();
  final networkModule = _$NetworkModule();
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => appModule.sharedPreferences(),
    preResolve: true,
  );
  gh.lazySingleton<_i974.Logger>(() => appModule.logger());
  gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
  gh.lazySingleton<_i846.SettingsLocalDataSource>(
    () => _i846.SettingsLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i757.HttpClient>(
    () => networkModule.httpClient(gh<_i361.Dio>()),
  );
  gh.lazySingleton<_i1062.CharacterLocalDataSource>(
    () => _i1062.CharacterLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i433.SettingsRepository>(
    () => _i181.SettingsRepositoryImpl(
      gh<_i846.SettingsLocalDataSource>(),
      gh<_i974.Logger>(),
    ),
  );
  gh.lazySingleton<_i989.SaveThemeModeUseCase>(
    () => _i989.SaveThemeModeUseCase(gh<_i433.SettingsRepository>()),
  );
  gh.lazySingleton<_i861.GetThemeModeUseCase>(
    () => _i861.GetThemeModeUseCase(gh<_i433.SettingsRepository>()),
  );
  gh.lazySingleton<_i633.GetLocaleUseCase>(
    () => _i633.GetLocaleUseCase(gh<_i433.SettingsRepository>()),
  );
  gh.lazySingleton<_i1020.SaveLocaleUseCase>(
    () => _i1020.SaveLocaleUseCase(gh<_i433.SettingsRepository>()),
  );
  gh.lazySingleton<_i947.CharacterRemoteDataSource>(
    () => _i947.CharacterRemoteDataSourceImpl(gh<_i757.HttpClient>()),
  );
  gh.lazySingleton<_i132.CharacterRepository>(
    () => _i746.CharacterRepositoryImpl(
      gh<_i947.CharacterRemoteDataSource>(),
      gh<_i1062.CharacterLocalDataSource>(),
      gh<_i974.Logger>(),
    ),
  );
  gh.lazySingleton<_i572.ToggleFavouriteUseCase>(
    () => _i572.ToggleFavouriteUseCase(gh<_i132.CharacterRepository>()),
  );
  gh.lazySingleton<_i1070.GetFavouritesUseCase>(
    () => _i1070.GetFavouritesUseCase(gh<_i132.CharacterRepository>()),
  );
  gh.lazySingleton<_i941.GetCharactersUseCase>(
    () => _i941.GetCharactersUseCase(gh<_i132.CharacterRepository>()),
  );
  gh.lazySingleton<_i789.CharactersCubit>(
    () => _i789.CharactersCubit(
      gh<_i941.GetCharactersUseCase>(),
      gh<_i572.ToggleFavouriteUseCase>(),
    ),
  );
  gh.lazySingleton<_i948.FavouritesCubit>(
    () => _i948.FavouritesCubit(gh<_i1070.GetFavouritesUseCase>()),
  );
  return getIt;
}

class _$AppModule extends _i460.AppModule {}

class _$NetworkModule extends _i567.NetworkModule {}
