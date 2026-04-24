import 'package:collection/collection.dart';
import 'package:dart_kit/src/exceptions/result_exception.dart';
import 'package:meta/meta.dart';

/// Holder for responses from multiple origins.
///
/// Instead of using regular error channels (a.k.a. throwing exceptions), we'll
/// use this holder class to represent each result.
class Result<T> {
  const Result._(this.origin);

  /// Loading event dispatched for currently running process.
  const factory Result.loading(ResultOrigin origin) = LoadingResult<T>;

  /// Data event dispatched for successfully finished process.
  const factory Result.data(ResultOrigin origin, T value) = DataResult<T>;

  /// Error Event dispatched for unsuccessfully finished process.
  const factory Result.error(
    ResultOrigin origin,
    Object error, [
    StackTrace? stackTrace,
  ]) = ErrorResult<T>;

  /// The origin of the result.
  final ResultOrigin origin;

  Result<R> _swapType<R>() => when(
        onData: (origin, data) => Result.data(origin, data as R),
        onLoading: (origin) => Result.loading(origin),
        onError: (origin, error, stacktrace) => Result.error(origin, error, stacktrace),
      );

  Result<E> mapData<E>(
    E Function(DataResult<T> value) onData,
  ) =>
      this is DataResult<T> ? Result.data(origin, onData(this as DataResult<T>)) : _swapType<E>();

  /// Returns the available data or throws error if there is no data.
  T requireData() => when(
        onData: (_, data) => data,
        onLoading: (_) => throw ResultException('There is no data in loading'),
        // ignore: only_throw_errors
        onError: (_, error, __) => throw error,
      );

  /// If there is data available, returns it; otherwise returns null.
  T? getDataOrNull() => this is DataResult<T> ? (this as DataResult<T>).value : null;

  Object? getErrorOrNull() => this is ErrorResult<T> ? (this as ErrorResult<T>).error : null;

  /// Returns the Error or throws error if there is no error.
  Object requireError() => maybeMap(
        onError: (response) => response.error,
        orElse: () => throw ResultException(
          'Response is not an ErrorResult. Response: $this',
        ),
      );

  /// If this [Result] is of type [ErrorResult], throws the
  /// exception. Otherwise, does nothing.
  void throwIfError() {
    if (this is ErrorResult) {
      // ignore: only_throw_errors
      throw (this as ErrorResult).error;
    }
  }

  /// Returns if the response is a [LoadingResult]
  bool get isLoading => this is LoadingResult;

  /// Returns if the response is a [ErrorResult]
  bool get isError => this is ErrorResult;

  /// Returns if the response is a [DataResult]
  bool get isData => this is DataResult;

  /// Invoke [onData] if the response is successful, [onLoading] if the response
  /// is loading, and [onError] if the response is an error.
  E map<E>({
    required E Function(LoadingResult<T> value) onLoading,
    required E Function(DataResult<T> value) onData,
    required E Function(ErrorResult<T> value) onError,
  }) {
    if (this is LoadingResult<T>) {
      return onLoading(this as LoadingResult<T>);
    } else if (this is DataResult<T>) {
      return onData(this as DataResult<T>);
    } else if (this is ErrorResult<T>) {
      return onError(this as ErrorResult<T>);
    } else {
      throw ResultException('Unknown Result type: $this');
    }
  }

  /// Invoke [onData] or [orElse] as fallback if the response is successful,
  /// [onLoading] or [orElse] as fallback if the response is loading, and
  /// [onError] or [orElse] as fallback if the response is an error.
  E maybeMap<E>({
    required E Function() orElse,
    E Function(LoadingResult<T> value)? onLoading,
    E Function(DataResult<T> value)? onData,
    E Function(ErrorResult<T> value)? onError,
  }) =>
      map(
        onLoading: onLoading ?? (_) => orElse(),
        onData: onData ?? (_) => orElse(),
        onError: onError ?? (_) => orElse(),
      );

  /// Invoke [onData] if the response is successful,
  /// [onLoading] if the response is loading, and
  /// [onError] if the response is an error.
  /// If the callback is not provided, null is returned.
  E? mapOrNull<E>({
    E Function(LoadingResult<T> value)? onLoading,
    E Function(DataResult<T> value)? onData,
    E Function(ErrorResult<T> value)? onError,
  }) =>
      maybeMap(
        onLoading: onLoading,
        onData: onData,
        onError: onError,
        orElse: () => null,
      );

  /// Invoke [onData] if the response is successful, [onLoading] if the response
  /// is loading, and [onError] if the response is an error.
  E when<E>({
    required E Function(ResultOrigin origin) onLoading,
    required E Function(ResultOrigin origin, T data) onData,
    required E Function(
      ResultOrigin origin,
      Object error,
      StackTrace? stackTrace,
    )
        onError,
  }) =>
      map(
        onLoading: (value) => onLoading(value.origin),
        onData: (value) => onData(value.origin, value.value),
        onError: (value) => onError(
          value.origin,
          value.error,
          value.stackTrace,
        ),
      );

  /// Invoke [onData] if the response is successful,
  /// [onLoading] if the response is loading, and
  /// [onError] if the response is an error.
  /// If the callback is not provided, null is returned.
  E? whenOrNull<E>({
    E Function(ResultOrigin origin)? onLoading,
    E Function(ResultOrigin origin, T data)? onData,
    E Function(ResultOrigin origin, Object error, StackTrace? stackTrace)? onError,
  }) =>
      maybeWhen(
        onLoading: onLoading,
        onData: onData,
        onError: onError,
        orElse: (origin) => null,
      );

  /// Invoke [onData] or [orElse] as fallback if the response is successful,
  /// [onLoading] or [orElse] as fallback if the response is loading, and
  /// [onError] or [orElse] as fallback if the response is an error.
  E maybeWhen<E>({
    required E Function(ResultOrigin origin) orElse,
    E Function(ResultOrigin origin)? onLoading,
    E Function(ResultOrigin origin, T data)? onData,
    E Function(ResultOrigin origin, Object error, StackTrace? stackTrace)? onError,
  }) =>
      when(
        onLoading: onLoading ?? (origin) => orElse(origin),
        onData: onData ?? (origin, _) => orElse(origin),
        onError: onError ?? (origin, _, __) => orElse(origin),
      );
}

/// Loading event dispatched for currently running process.
@immutable
class LoadingResult<T> extends Result<T> {
  /// LoadingResult constructor
  const LoadingResult(super.origin) : super._();

  @override
  String toString() => 'LoadingResult<$T>.loading(origin: $origin)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType && other is LoadingResult<T> && origin == other.origin);

  @override
  int get hashCode => Object.hash(runtimeType, origin.hashCode);
}

/// Data event dispatched for successfully finished process.
@immutable
class DataResult<T> extends Result<T> {
  /// DataResult constructor
  const DataResult(super.origin, this.value) : super._();

  /// The data value
  final T value;

  @override
  String toString() => 'DataResult<$T>.data(origin: $origin, value: $value)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is DataResult<T> &&
          other.origin == origin &&
          (identical(other.value, value) ||
              (other.value is List && value is List
                  ? const DeepCollectionEquality().equals(other.value, value)
                  : other.value == value)));

  @override
  int get hashCode => Object.hash(runtimeType, origin.hashCode, value.hashCode);
}

/// Error Event dispatched for unsuccessfully finished process.
@immutable
class ErrorResult<T> extends Result<T> {
  /// ErrorResult constructor
  const ErrorResult(super.origin, this.error, [this.stackTrace]) : super._();

  /// The error
  final Object error;

  /// The error stacktrace
  final StackTrace? stackTrace;

  @override
  String toString() => 'ErrorResult<$T>.error(origin: $origin, error: $error, '
      'stackTrace: $stackTrace)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is ErrorResult<T> &&
          other.origin == origin &&
          other.error == error &&
          other.stackTrace == stackTrace);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        origin.hashCode,
        error.hashCode,
        stackTrace.hashCode,
      );
}

/// Represents the origin for a [Result].
enum ResultOrigin {
  /// [Result] is sent from the local storage.
  local,

  /// [Result] is sent from a network.
  network,

  /// [Result] is sent from unknown origin.
  other,
}
