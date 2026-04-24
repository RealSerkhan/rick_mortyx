import 'package:dartz/dartz.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';

abstract class SettingsRepository {
  Either<Failure, String?> getThemeMode();
  Future<Either<Failure, Unit>> saveThemeMode(String value);

  Either<Failure, String?> getLocale();
  Future<Either<Failure, Unit>> saveLocale(String value);
}
