import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/features/settings/domain/repos/settings_repo.dart';

@lazySingleton
class GetLocaleUseCase {
  GetLocaleUseCase(this._repository);

  final SettingsRepository _repository;

  Either<Failure, String?> call() => _repository.getLocale();
}
