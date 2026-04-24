import 'dart:async';

/// Debounce Strategy.
///
/// Debouncing is needed when there is a possibility of multiple calls
/// to a method being made within a short duration of each other,
/// and it's desireable that only the last of those calls actually invoke the target method.
class Debouncer<T> {
  Debouncer({
    required this.duration,
    this.onValue,
  });

  final Duration duration;
  void Function(T)? onValue;

  T? _value;
  Timer? _timer;

  T get value => _value!;
  bool get isActive => _timer?.isActive ?? false;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value as T));
  }

  void dispose() {
    _timer?.cancel();
  }
}
