import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rick_morty/base/data/repos/base_repo_impl.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/settings/data/sources/settings_local_datasource.dart';
import 'package:rick_morty/features/settings/domain/repos/settings_repo.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends BaseRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._localDataSource, Logger logger) : super(logger);

  final SettingsLocalDataSource _localDataSource;

  @override
  Either<Failure, String?> getThemeMode() {
    try {
      return Right(_localDataSource.getThemeMode());
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveThemeMode(String value) => request(() async {
    await _localDataSource.saveThemeMode(value);
    return unit;
  });

  @override
  Either<Failure, String?> getLocale() {
    try {
      return Right(_localDataSource.getLocale());
    } catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLocale(String value) => request(() async {
    await _localDataSource.saveLocale(value);
    return unit;
  });
}
