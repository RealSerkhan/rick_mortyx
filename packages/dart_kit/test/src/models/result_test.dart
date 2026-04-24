import 'package:dart_kit/src/models/result.dart';
import 'package:test/test.dart';

void main() {
  group('Result Class Test ', () {
    group('LoadingResult', () {
      test('toString()', () async {
        expect(
          const LoadingResult<int>(ResultOrigin.network).toString(),
          equals(
            'LoadingResult<int>.loading(origin: ResultOrigin.network)',
          ),
        );
      });
      test('equal', () async {
        const result1 = LoadingResult<int>(ResultOrigin.network);
        const result2 = LoadingResult<int>(ResultOrigin.network);
        const result3 = LoadingResult<int>(ResultOrigin.local);
        expect(result1 == result3, equals(false));
        expect(result1 == result2, equals(true));
      });
      test('hashcode', () async {
        const result1 = LoadingResult<int>(ResultOrigin.network);
        const result2 = LoadingResult<int>(ResultOrigin.network);
        const result3 = LoadingResult<int>(ResultOrigin.local);
        expect(result1.hashCode == result3.hashCode, equals(false));
        expect(result1.hashCode == result2.hashCode, equals(true));
      });
    });

    group('DataResult', () {
      test('toString()', () async {
        expect(
          const DataResult(ResultOrigin.network, '1').toString(),
          equals(
            'DataResult<String>.data(origin: ResultOrigin.network, '
            'value: 1)',
          ),
        );
      });
      test('equal', () async {
        const result1 = DataResult(ResultOrigin.network, 1);
        const result1Copy = DataResult(ResultOrigin.network, 1);
        const result2 = DataResult(ResultOrigin.network, 2);
        const result3 = DataResult(ResultOrigin.local, 1);
        expect(result1 == result3, equals(false));
        expect(result1 == result1Copy, equals(true));
        expect(result1 == result2, equals(false));
      });
      test('hashcode', () async {
        const result1 = DataResult(ResultOrigin.network, 1);
        const result1Copy = DataResult(ResultOrigin.network, 1);
        const result2 = DataResult(ResultOrigin.network, 2);
        const result3 = DataResult(ResultOrigin.local, 1);
        expect(result1.hashCode == result3.hashCode, equals(false));
        expect(result1.hashCode == result1Copy.hashCode, equals(true));
        expect(result1.hashCode == result2.hashCode, equals(false));
      });
    });

    group('ErrorResult', () {
      test('toString()', () async {
        expect(
          const ErrorResult<String>(ResultOrigin.network, 'error').toString(),
          equals(
            'ErrorResult<String>.error(origin: ResultOrigin.network, '
            'error: error, stackTrace: null)',
          ),
        );
      });
      test('equal', () async {
        const result1 = ErrorResult<String>(ResultOrigin.network, 1);
        const result1Tmp = ErrorResult<String>(ResultOrigin.network, 1);
        const result2 = ErrorResult<String>(ResultOrigin.network, 2);
        const result3 = ErrorResult<String>(ResultOrigin.local, 1);
        expect(result1 == result3, equals(false));
        expect(result1 == result1Tmp, equals(true));
        expect(result1 == result2, equals(false));
      });
      test('hashcode', () async {
        const result1 = ErrorResult<String>(ResultOrigin.network, 1);
        const result1Tmp = ErrorResult<String>(ResultOrigin.network, 1);
        const result2 = ErrorResult<String>(ResultOrigin.network, 2);
        const result3 = ErrorResult<String>(ResultOrigin.local, 1);
        expect(result1.hashCode == result3.hashCode, equals(false));
        expect(result1.hashCode == result1Tmp.hashCode, equals(true));
        expect(result1.hashCode == result2.hashCode, equals(false));
      });
    });
  });
}
