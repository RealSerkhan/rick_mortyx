import 'package:dart_kit/src/models/result.dart';

/// [Future] helper extension
extension FutureExt<T> on Future<T> {
  /// map [Future] data into [Result].
  Future<Result<T>> mapToResult({
    ResultOrigin origin = ResultOrigin.other,
  }) async {
    try {
      return Result<T>.data(origin, await this);
    } catch (error, stacktrace) {
      return Result<T>.error(origin, error, stacktrace);
    }
  }

  /// Filter error events by swallow [Future] error to prevent propagate error to Parent Future.
  Future<T?> filterSuccess([Function(Object?)? errorHandler]) async {
    try {
      return await this;
    } catch (error, _) {
      errorHandler?.call(error);
      return null;
    }
  }
}
