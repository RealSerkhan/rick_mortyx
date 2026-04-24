import 'package:dartz/dartz.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> request<T>(Function data, {Either<Failure, T>? Function(dynamic e)? exceptionHandler});
}
