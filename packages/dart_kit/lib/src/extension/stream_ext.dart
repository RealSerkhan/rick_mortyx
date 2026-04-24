import 'package:dart_kit/src/models/result.dart';
import 'package:dart_kit/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

/// [Stream] helper extension
extension StreamExt<T> on Stream<T> {
  /// map [Stream] data into [Result].
  Stream<Result<T>> mapToResult({ResultOrigin origin = ResultOrigin.other}) =>
      map((data) => Result<T>.data(origin, data)).onErrorReturnWith((Object error, StackTrace stacktrace) {
        Logger.w('Stream error', error, stacktrace);
        return Result<T>.error(origin, error, stacktrace);
      });

  /// Filter error events by swallow [Stream] error to prevent propagate error to listeners.
  Stream<T> filterSuccess([Function(Object?)? errorHandler]) => handleError((Object error, StackTrace stacktrace) {
        Logger.w('Stream error', error, stacktrace);
        errorHandler?.call(error);
      });
}

extension StreamNullableExt<T> on Stream<T?> {
  /// convert the nullable stream to non nullable stream by map each null event
  /// to value by applying [transform].
  Stream<T> mapNullTo(T Function() transform) => map((it) => it ?? transform());
}
