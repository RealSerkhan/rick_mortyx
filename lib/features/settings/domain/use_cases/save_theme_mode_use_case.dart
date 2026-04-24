import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/settings/domain/repos/settings_repo.dart';

@lazySingleton
class SaveThemeModeUseCase {
  SaveThemeModeUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, Unit>> call(String value) => _repository.saveThemeMode(value);
}
