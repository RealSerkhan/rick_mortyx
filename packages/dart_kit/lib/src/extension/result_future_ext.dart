import 'dart:async';

import 'package:dart_kit/src/models/result.dart';

extension ResultFutureExt<T> on Future<Result<T>> {
  /// apply [onData] when future is [DataResult].
  Future<Result<T>> doOnDataResult(
    Function(DataResult<T> value) onData,
  ) =>
      then((it) {
        if (it is DataResult<T>) {
          onData(it);
        }
        return it;
      });

  /// apply [onError] when future is [ErrorResult].
  Future<Result<T>> doOnErrorResult(
    Function(ErrorResult<T> value) onError,
  ) =>
      then((it) {
        if (it is ErrorResult<T>) {
          onError(it);
        }
        return it;
      });

  /// apply [onLoading] when future is [LoadingResult].
  Future<Result<T>> doOnLoadingResult(
    Function(LoadingResult<T> value) onLoading,
  ) =>
      then((it) {
        if (it is LoadingResult<T>) {
          onLoading(it);
        }
        return it;
      });

  /// apply [onError] when future is [ErrorResult].
  Future<Result<T>> mapErrorResult(
    Result<T> Function(ErrorResult<T> value) onError,
  ) =>
      then((it) {
        if (it is ErrorResult<T>) {
          return onError(it);
        }
        return it;
      });

  Future<R> requireData<R>(FutureOr<R> Function(T value) onData) => then((it) => onData(it.requireData()));

  /// apply [onError] when future is [ErrorResult].
  // Future<Result<R>> map(
  //   Result<T> Function(ErrorResult<T> value) onError,
  // ) =>
  //     then((it) {
  //       if (it is ErrorResult<T>) {
  //         return onError(it);
  //       }
  //       return it;
  //     });

  // Future<Result<R>> swapType<R>() => then(
  //       (it) => it.when(
  //         onLoading: onLoading,
  //         onData: onData,
  //         onError: onError,
  //       ),
  //     );
}
