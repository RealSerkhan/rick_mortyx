import 'package:collection/collection.dart';
import 'package:dart_kit/src/exceptions/result_exception.dart';
import 'package:dart_kit/src/models/result.dart';
import 'package:rxdart/transformers.dart';

extension ResultStreamExt<T> on Stream<Result<T>> {
  /// only allow of [DataResult] event.
  Stream<Result<T>> takeDataResult() => where((it) => it.isData);

  /// only allow of [LoadingResult] event.
  Stream<Result<T>> takeLoadingResult() => where((it) => it.isLoading);

  /// only allow of [ErrorResult] event.
  Stream<Result<T>> takeErrorResult() => where((it) => it.isError);

  /// only allow of [DataResult] and [ErrorResult]  event.
  Stream<Result<T>> takeDataOrErrorResults() => where((it) => it.isData || it.isError);

  /// only allow of [DataResult] and [ErrorResult]  event.
  Stream<Result<T>> takeDataOrLoadingResults() => where((it) => it.isData || it.isLoading);

  /// only allow [Result] with origin in [origins].
  Stream<Result<T>> takeOrigins(List<ResultOrigin> origins) => where((it) => origins.contains(it.origin));

  /// only allow [Result] with origin equal to [origin].
  Stream<Result<T>> takeOrigin(ResultOrigin origin) => takeOrigins([origin]);

  /// only allow [Result] with [ResultOrigin.network].
  Stream<Result<T>> takeNetworkOrigin() => takeOrigin(ResultOrigin.network);

  /// only allow [Result] with [ResultOrigin.local].
  Stream<Result<T>> takeLocaLOrigin() => takeOrigin(ResultOrigin.local);

  /// apply [onData] when stream emit [DataResult].
  Stream<Result<T>> doOnDataResult(
    Function(DataResult<T> value) onData,
  ) =>
      doOnData((it) => it is DataResult<T> ? onData(it) : null);

  /// apply [onError] when stream emit [ErrorResult].
  Stream<Result<T>> doOnErrorResult(
    Function(ErrorResult<T> value) onError,
  ) =>
      doOnData((it) => it is ErrorResult<T> ? onError(it) : null);

  /// apply [onLoading] when stream emit [LoadingResult].
  Stream<Result<T>> doOnLoadingResult(
    Function(LoadingResult<T> value) onLoading,
  ) =>
      doOnData((it) => it is LoadingResult<T> ? onLoading(it) : null);

  Stream<Result<E>> mapData<E>(E Function(DataResult<T> value) onData) => map((it) => it.mapData(onData));

  /// Stream version of [Result] map function.
  /// Invoke [onData] if the response is successful, [onLoading] if the response
  /// is loading, and [onError] if the response is an error.
  Stream<E> unwrap<E>({
    required E Function(LoadingResult<T> value) onLoading,
    required E Function(DataResult<T> value) onData,
    required E Function(ErrorResult<T> value) onError,
  }) =>
      map(
        (it) => it.map(onLoading: onLoading, onData: onData, onError: onError),
      );

  Stream<E> maybeUnwrap<E>({
    required E Function() orElse,
    E Function(LoadingResult<T> value)? onLoading,
    E Function(DataResult<T> value)? onData,
    E Function(ErrorResult<T> value)? onError,
  }) =>
      map(
        (it) => it.maybeMap(
          orElse: orElse,
          onLoading: onLoading,
          onData: onData,
          onError: onError,
        ),
      );

  Stream<E> unwrapOrThrow<E>({
    E Function(LoadingResult<T> value)? onLoading,
    E Function(DataResult<T> value)? onData,
    E Function(ErrorResult<T> value)? onError,
  }) =>
      map(
        (it) => it.maybeMap(
          orElse: () => throw ResultException('unwrapOrThrow error'),
          onLoading: onLoading,
          onData: onData,
          onError: onError,
        ),
      );

  /// Invokes [onData] if the response is successful, [onLoading] if the
  /// response is loading, and [onError] if the response is an error.
  Stream<E> when<E>({
    required E Function(ResultOrigin origin) onLoading,
    required E Function(ResultOrigin origin, T data) onData,
    required E Function(
      ResultOrigin origin,
      Object error,
      StackTrace? stackTrace,
    )
        onError,
  }) =>
      unwrap(
        onLoading: (value) => onLoading(value.origin),
        onData: (value) => onData(value.origin, value.value),
        onError: (value) => onError(
          value.origin,
          value.error,
          value.stackTrace,
        ),
      );

  /// Invokes [onData] if the response is successful,
  /// [onLoading] if the response is loading, and
  /// [onError] if the response is an error.
  /// If the callback is not provided, null is returned.
  Stream<E?> whenOrNull<E>({
    E Function(ResultOrigin origin)? onLoading,
    E Function(ResultOrigin origin, T data)? onData,
    E Function(
      ResultOrigin origin,
      Object error,
      StackTrace? stackTrace,
    )?
        onError,
  }) =>
      maybeWhen(
        onLoading: onLoading,
        onData: onData,
        onError: onError,
        orElse: (origin) => null,
      );

  /// Invokes [onData] or [orElse] as fallback if the response is successful,
  /// [onLoading] or [orElse] as fallback if the response is loading, and
  /// [onError] or [orElse] as fallback if the response is an error.
  Stream<E> maybeWhen<E>({
    E Function(ResultOrigin origin)? onLoading,
    E Function(ResultOrigin origin, T data)? onData,
    E Function(
      ResultOrigin origin,
      Object error,
      StackTrace? stackTrace,
    )?
        onError,
    required E Function(ResultOrigin origin) orElse,
  }) =>
      when(
        onLoading: onLoading ?? (origin) => orElse(origin),
        onData: onData ?? (origin, _) => orElse(origin),
        onError: onError ?? (origin, _, __) => orElse(origin),
      );

  /// Returns stream where all subsequent repetitions of the same [ResultData]
  /// are filtered out.
  Stream<Result<T>> distinctUntilDataChanged() => distinctUnique(
        hashCode: (it) => it.isData && it.requireData() is List
            ? const DeepCollectionEquality().hash(it.requireData())
            : it.isData
                ? it.requireData().hashCode
                : it.hashCode,
        equals: (it1, it2) => it1.isData && it2.isData && it1.requireData() is List && it2.requireData() is List
            ? const DeepCollectionEquality().equals(
                it1.requireData(),
                it2.requireData(),
              )
            : it1.isData && it2.isData
                ? it1.requireData() == it2.requireData()
                : it1 == it2,
      );
}
