import 'package:dart_kit/src/exceptions/result_exception.dart';
import 'package:dart_kit/src/models/result.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../base_mocks.mocks.dart';

void main() {
  group('Require data extensions', () {
    test('requireData of an error throws the exception', () async {
      final customEx = Exception('Custom ex');
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, customEx).requireData,
        throwsA((dynamic e) => e == customEx),
      );
    });
    test('requireData of a loading response throws a exception', () async {
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).requireData,
        throwsA(
          (dynamic e) => e is ResultException && e.toString() == 'ResultException: There is no data in loading',
        ),
      );
    });
    test('requireData of a data returns the data', () async {
      expect(
        const Result.data(ResultOrigin.network, 1).requireData(),
        equals(1),
      );
    });
  });

  group('Require error extensions', () {
    test('requireError of an error throws the exception', () async {
      final customEx = Exception('Custom ex');
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, customEx).requireError(),
        equals(customEx),
      );
    });
    test('requireError of a loading response throws a exception', () async {
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).requireError,
        throwsA(
          (dynamic e) => e is ResultException && e.toString().contains('Response is not an ErrorResult'),
        ),
      );
    });
    test('requireError of a data response throws a exception', () async {
      expect(
        const DataResult<dynamic>(ResultOrigin.network, 1).requireError,
        throwsA(
          (dynamic e) => e is ResultException && e.toString().contains('Response is not an ErrorResult'),
        ),
      );
    });
  });

  group('throwIfError extension', () {
    test('throwIfError of an error throws the exception', () async {
      final customEx = Exception('Custom ex');
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, customEx).throwIfError,
        throwsA((dynamic e) => e == customEx),
      );
    });
    test('throwIfError of a loading response does not do anything', () async {
      const LoadingResult<dynamic>(ResultOrigin.network).throwIfError();
    });
    test('throwIfError of a data returns the data', () async {
      const Result.data(ResultOrigin.network, 1).throwIfError();
    });
  });

  group('Get data extensions', () {
    test('getData of an error returns null', () async {
      final customEx = Exception('Custom ex');
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, customEx).getDataOrNull(),
        equals(null),
      );
    });
    test('getData of a loading response returns null', () async {
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).getDataOrNull(),
        equals(null),
      );
    });
    test('getData of a data response returns the data', () async {
      expect(
        const Result.data(ResultOrigin.network, 1).getDataOrNull(),
        equals(1),
      );
    });
  });

  group('Property extensions', () {
    test('Loading returns true if loading', () async {
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, Error()).isLoading,
        equals(false),
      );
      expect(
        const Result.data(ResultOrigin.network, 1).isLoading,
        equals(false),
      );
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).isLoading,
        equals(true),
      );
    });
    test('Data returns true if it is a data event', () async {
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, Error()).isData,
        equals(false),
      );
      expect(
        const Result.data(ResultOrigin.network, 1).isData,
        equals(true),
      );
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).isData,
        equals(false),
      );
    });
    test('Error returns true if the response is an error', () async {
      expect(
        ErrorResult<dynamic>(ResultOrigin.network, Error()).isError,
        equals(true),
      );
      expect(
        const Result.data(ResultOrigin.network, 1).isError,
        equals(false),
      );
      expect(
        const LoadingResult<dynamic>(ResultOrigin.network).isError,
        equals(false),
      );
    });
  });

  group('Map', () {
    test('Map for loading', () {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).map(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('Map for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).map(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('Map for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).map(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });
  });

  group('MaybeMap', () {
    test('MaybeMap for loading', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).maybeMap(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
        orElse: () => throw Exception('Should not be called'),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MaybeMap for loading with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).maybeMap(
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
        orElse: mockLoadingCallback,
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MaybeMap for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).maybeMap(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
        orElse: () => throw Exception('Should not be called'),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('MaybeMap for data with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).maybeMap(
        onLoading: (_) => mockLoadingCallback(),
        onError: (_) => mockErrorCallback(),
        orElse: mockDataCallback,
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('MaybeMap for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).maybeMap(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
        orElse: () => throw Exception('Should not be called'),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });

    test('MaybeMap for error with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).maybeMap(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        orElse: mockErrorCallback,
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });
  });

  group('When', () {
    test('When for loading', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).when(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('When for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).when(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('When for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).when(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });
  });

  group('MaybeWhen', () {
    test('MaybeWhen for loading', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).maybeWhen(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
        orElse: (_) => throw Exception('Should not be called'),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MaybeWhen for loading with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const LoadingResult<dynamic>(ResultOrigin.network).maybeWhen(
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
        orElse: (_) => mockLoadingCallback(),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MaybeWhen for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).maybeWhen(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
        orElse: (_) => throw Exception('Should not be called'),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('MaybeWhen for data with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).maybeWhen(
        onLoading: (_) => mockLoadingCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
        orElse: (_) => mockDataCallback(),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('MaybeWhen for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).maybeWhen(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
        orElse: (_) => throw Exception('Should not be called'),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });

    test('MaybeWhen for error with else', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).maybeWhen(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        orElse: (_) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });
  });

  group('WhenOrNull', () {
    test('WhenOrNull for loading', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      when(mockLoadingCallback.call()).thenAnswer((_) => 1);

      const LoadingResult<dynamic>(ResultOrigin.network).whenOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('WhenOrNull for loading without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      final value = const LoadingResult<dynamic>(ResultOrigin.network).whenOrNull(
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('WhenOrNull for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).whenOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('WhenOrNull for data without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      final value = const Result.data(ResultOrigin.network, 1).whenOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockLoadingCallback());
      verifyNever(mockErrorCallback());
    });

    test('WhenOrNull for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).whenOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
        onError: (_, __, ___) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });

    test('WhenOrNull for error without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final value = ErrorResult<dynamic>(ResultOrigin.network, Error()).whenOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_, __) => mockDataCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
    });
  });

  group('MapOrNull', () {
    test('MapOrNull for loading', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      when(mockLoadingCallback.call()).thenAnswer((_) => 1);

      const LoadingResult<dynamic>(ResultOrigin.network).mapOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verify(mockLoadingCallback()).called(1);
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MapOrNull for loading without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      final value = const LoadingResult<dynamic>(ResultOrigin.network).mapOrNull(
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verifyNever(mockErrorCallback());
    });

    test('MapOrNull for data', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      const Result.data(ResultOrigin.network, 1).mapOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verify(mockDataCallback()).called(1);
      verifyNever(mockErrorCallback());
    });

    test('MapOrNull for data without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockErrorCallback = MockCallbackInt();
      final value = const Result.data(ResultOrigin.network, 1).mapOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onError: (_) => mockErrorCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockLoadingCallback());
      verifyNever(mockErrorCallback());
    });

    test('MapOrNull for error', () async {
      final mockLoadingCallback = MockCallbackVoid();
      final mockDataCallback = MockCallbackVoid();
      final mockErrorCallback = MockCallbackVoid();
      ErrorResult<dynamic>(ResultOrigin.network, Error()).mapOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
        onError: (_) => mockErrorCallback(),
      );
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
      verify(mockErrorCallback()).called(1);
    });

    test('MapOrNull for error without callback', () async {
      final mockLoadingCallback = MockCallbackInt();
      final mockDataCallback = MockCallbackInt();
      final value = ErrorResult<dynamic>(ResultOrigin.network, Error()).mapOrNull(
        onLoading: (_) => mockLoadingCallback(),
        onData: (_) => mockDataCallback(),
      );
      expect(value, equals(null));
      verifyNever(mockLoadingCallback());
      verifyNever(mockLoadingCallback());
      verifyNever(mockDataCallback());
    });
  });
}
