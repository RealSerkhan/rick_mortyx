import 'package:mockito/annotations.dart';

abstract class Callback<T> {
  T call();
}

abstract class ValueCallback<P, T> {
  T call(P param);
}

abstract class CallbackVoid implements Callback<void> {}

abstract class CallbackInt implements Callback<int> {}

abstract class CallbackString implements Callback<String> {}

abstract class ValueCallbackStringInt implements ValueCallback<String, int> {}

@GenerateMocks([
  CallbackVoid,
  CallbackInt,
  CallbackString,
  ValueCallbackStringInt,
])
void main() {}
