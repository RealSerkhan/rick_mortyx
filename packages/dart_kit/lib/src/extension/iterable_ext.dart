extension IterableExt<T> on Iterable<T> {
  /// same as `String.join()` but will work for any list of type [T].
  Iterable<T> superJoin(T separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return [];
    }

    final l = [iterator.current];
    while (iterator.moveNext()) {
      l
        ..add(separator)
        ..add(iterator.current);
    }
    return l;
  }
}

extension NullableIterableExt<T> on Iterable<T>? {}
