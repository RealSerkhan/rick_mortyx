import 'package:dart_kit/src/extension/object_ext.dart';

extension BoolExt on bool {
  /// syntactic sugar for object == false.
  bool get isFalse => this == false;
  bool get isTrue => this == true;
}

extension NullableBoolExt on bool? {
  /// syntactic sugar for object == null || object == false.
  bool get isNullOrFalse => isNull || this!.isFalse;

  bool get isNotNullOrFalse => isNotNull || this!.isTrue;
}
