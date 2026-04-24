import 'package:dart_kit/src/extension/object_ext.dart';

extension IntExt on int {
  /// syntactic sugar for object == 0
  bool get isZero => this == 0;
}

extension NullableIntExt on int? {
  /// syntactic sugar for object == null || object == 0.
  bool get isNullOrZero => isNull || this!.isZero;

  /// syntactic sugar for object != null && object != 0.
  bool get isNotNullNorZero => !isNullOrZero;

  /// check if value is between [from] and [to], also if value == [from] or value == [to] will return false.
  bool isBetween(int from, int to) => this != null && from < this! && this! < to;

  /// check if value in range [from -> to], also if value == [from] or value == [to] will return true.
  bool inRange(int from, int? to) => this != null && from <= this! && (to == null || this! <= to);
}
