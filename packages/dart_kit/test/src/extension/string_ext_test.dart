import 'package:dart_kit/src/extension/string_ext.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../base_mocks.mocks.dart';

void main() {
  group('Is Null Or Empty String extensions', () {
    test('isNullOrEmpty returns true if null', () async {
      const String? string = null;
      expect(string.isNullOrEmpty, equals(true));
    });

    test('isNullOrEmpty returns true if empty', () async {
      const String string = '';
      expect(string.isNullOrEmpty, equals(true));
    });

    test('isNullOrEmpty returns false if not null nor empty', () async {
      const String string = '1';
      expect(string.isNullOrEmpty, equals(false));
    });
  });

  group('If Null Or Blank String extensions', () {
    test('ifNullOrBlank called  if null', () async {
      const String? string = null;
      final mockNullCallback = MockCallbackString();
      when(mockNullCallback.call()).thenReturn('string');
      final result = string.ifNullOrBlank(() => mockNullCallback.call());
      verify(mockNullCallback()).called(1);
      expect(result, equals('string'));
    });

    test('ifNullOrBlank called if blank', () async {
      const String string = '';
      final mockNullCallback = MockCallbackString();
      when(mockNullCallback.call()).thenReturn('string');
      final result = string.ifNullOrBlank(() => mockNullCallback.call());
      verify(mockNullCallback()).called(1);
      expect(result, equals('string'));
    });

    test('ifNullOrBlank called if not null nor blank', () async {
      const String string = 'value';
      final mockNullCallback = MockCallbackString();
      when(mockNullCallback.call()).thenReturn('string');
      final result = string.ifNullOrBlank(() => mockNullCallback.call());
      verifyNever(mockNullCallback());
      expect(result, equals('value'));
    });
  });

  group('Is Upper Case String extensions', () {
    test('isUpperCase returns false', () async {
      final samples = ['notUpperCase', 'NOT_UPPER_CASE', 'NotUpperCase', 'not_upper_case'];
      for (final sample in samples) {
        expect(sample.isUpperCase, equals(false));
      }
    });

    test('isUpperCase returns true', () async {
      final samples = ['UPPERCASE'];
      for (final sample in samples) {
        expect(sample.isUpperCase, equals(true));
      }
    });
  });

  group('Is Number String extensions', () {
    test('isNumber returns false', () async {
      final samples = ['123A', 'a123', '123a123', ' 123', ' 123', '123 '];
      for (final sample in samples) {
        expect(sample.isNumber, equals(false));
      }
    });

    test('isNumber returns true', () async {
      final samples = ['123', '000'];
      for (final sample in samples) {
        expect(sample.isNumber, equals(true));
      }
    });
  });
}
