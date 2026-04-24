import 'package:dart_kit/dart_kit.dart';

const undefined = Object();

extension ObjectExt<T extends Object> on T {
  /// Calls the specified function [block] with [this] value as its argument and returns its result.
  R let<R>(R Function(T) block) => block(this);

  /// Calls the specified function [block] with [this] value as its argument and returns [this] value.
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Calls the specified function [block] with [this] value as its receiver and returns [this] value.
  T apply(void Function() block) {
    block();
    return this;
  }

  Result<T> asDataResult({ResultOrigin origin = ResultOrigin.other}) => Result.data(origin, this);
}

extension NullableObjectExt<T extends Object> on T? {
  /// general nullable checker
  bool get isNull => this == null;
  bool get isNotNull => !isNull;

  

  /// Calls the specified function [block] with [this] value as its argument and returns its result.
  R let<R>(R Function(T?) block) => block(this);

  /// Calls the specified function [block] with [this] value as its argument and returns [this] value.
  T? also(void Function(T?) block) {
    block(this);
    return this;
  }

  /// Calls the specified function [block] with [this] value as its receiver and returns [this] value.
  T? apply(void Function() block) {
    block();
    return this;
  }
}
