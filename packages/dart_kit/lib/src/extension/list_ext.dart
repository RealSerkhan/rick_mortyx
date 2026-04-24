import 'package:dart_kit/dart_kit.dart';

extension ListExt<T> on List<T> {
  /// get item from array start counting index from the last item by [steps].
  T getFromLast(int steps) => this[length - 1 - steps];

  /// same as `elementAt` but will return null instead of throwing exception if index is not exist.
  T? elementAtOrNull(int index) => index >= length ? null : elementAt(index);

  /// return the second item in array or null if not exist.
  T? get second => elementAtOrNull(1);

  /// return the third item in array or null if not exist.
  T? get third => elementAtOrNull(2);

  /// return the fourth item in array or null if not exist.
  T? get fourth => elementAtOrNull(3);

  /// return the fifth item in array or null if not exist.
  T? get fifth => elementAtOrNull(4);

  /// return the sixth item in array or null if not exist.
  T? get sixth => elementAtOrNull(5);

  /// return the seventh item in array or null if not exist.
  T? get seventh => elementAtOrNull(6);

  /// return the eighth item in array or null if not exist.
  T? get eighth => elementAtOrNull(7);

  /// return the ninth item in array or null if not exist.
  T? get ninth => elementAtOrNull(8);

  /// return the tenth item in array or null if not exist.
  T? get tenth => elementAtOrNull(9);

  /// return the the item that exist before last item in array.
  T? get beforeLast => getFromLast(1);

  /// apply where by [test] function then apply map to remaining items by [toElement] function.
  List<E> mapWhere<E>(bool Function(T) test, E Function(T e) toElement) =>
      where(test).map(toElement).toList();
}

extension NullableListExt<T> on List<T>? {
  /// syntactic sugar for list == null || list.isEmpty.
  bool get isNullOrEmpty => isNull || this!.isEmpty;

  /// syntactic sugar for list != null && list.isNotEmpty.
  bool get isNotNullNorEmpty => !isNullOrEmpty;

  List<T>? get ifEmptyThenNull => this!.isEmpty ? null : this;
}
