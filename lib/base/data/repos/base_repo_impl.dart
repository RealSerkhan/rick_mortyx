import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/base/domain/repos/base_repo.dart';
import 'package:rick_morty/base/networking/network_exceptions.dart';

class BaseRepositoryImpl implements BaseRepository {
  const BaseRepositoryImpl(this._logger);

  final Logger _logger;

  @override
  Future<Either<Failure, T>> request<T>(
    Function data, {
    Either<Failure, T>? Function(dynamic e)? exceptionHandler,
  }) async {
    try {
      final result = await data.call();
      return Right(result);
    } on WrongDataException catch (e) {
      _logger.e('Wrong data exception: ${e.toString()}');
      return _handleWrongDataException(e, exceptionHandler: exceptionHandler);
    } on ServerNotWorkingException catch (error) {
      _logger.e('Server not working: ${error.callId}');
      return Left(ServerFailure(callId: error.callId));
    } on NoInternetException {
      _logger.e('No internet connection');
      return const Left(NoInternetFailure());
    } on CacheException {
      return const Left(CacheFailure());
    } on TimeoutException {
      _logger.e('Timeout exception');
      return const Left(TimeoutFailure());
    } on UnKnownException catch (error) {
      _logger.e('Unknown error: ${error.error} ${error.sourceClass}');
      return Left(
        UnknownFailure(callId: error.callId, sourceClass: error.sourceClass, errorMessage: error.error.toString()),
      );
    } catch (e, stackTrace) {
      _logger.e('Error in request: $e $stackTrace');
      return const Left(UnknownFailure());
    }
  }

  Either<Failure, T> _handleWrongDataException<T>(
    WrongDataException e, {
    Either<Failure, T>? Function(dynamic e)? exceptionHandler,
  }) {
    final customException = exceptionHandler?.call(e);
    if (customException != null) {
      return customException;
    }
    return Left(
      ServerFailure(errorMessage: e.cause, callId: e.callId, sourceClass: e.sourceClass, statusCode: e.statusCode),
    );
  }
}
