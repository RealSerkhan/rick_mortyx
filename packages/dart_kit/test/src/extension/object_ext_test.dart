import 'package:dart_kit/dart_kit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../base_mocks.mocks.dart';

void main() {
  group('non nullable Object ', () {
    test('let call the callback and returns mapped result', () {
      const object = 'string';

      final mockValueCallback = MockValueCallbackStringInt();
      when(mockValueCallback.call(any)).thenReturn(1);

      expect(object.let(mockValueCallback), isA<int>());
      verify(mockValueCallback.call('string')).called(1);
    });

    test('also calls the callback and returns same value', () {
      const object = 'string';

      final mockValueCallback = MockValueCallbackStringInt();
      when(mockValueCallback.call(any)).thenReturn(1);

      expect(object.also(mockValueCallback.call), equals('string'));
      verify(mockValueCallback.call('string')).called(1);
    });

    test('apply calls the callback and returns same value', () {
      const object = 'string';

      final mockCallback = MockCallbackVoid();
      when(mockCallback.call()).thenReturn(null);

      expect(object.apply(mockCallback.call), equals('string'));
      verify(mockCallback.call()).called(1);
    });
  });

  group('nullable Object ', () {
    test('isNull works', () {
      const string = 'string';
      const String? nullString = null;

      expect(string.isNull, isFalse);
      expect(nullString.isNull, isTrue);
    });

    test('isNotNull works', () {
      const string = 'string';
      const String? nullString = null;

      expect(string.isNotNull, isTrue);
      expect(nullString.isNotNull, isFalse);
    });
  });
}
