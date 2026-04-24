import 'package:dart_kit/src/exceptions/result_exception.dart';
import 'package:dart_kit/src/extension/result_stream_ext.dart';
import 'package:dart_kit/src/models/result.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../base_mocks.mocks.dart';
import '../helpers/result_helper.dart';

void main() {
  test('takeDataResult filter out Error and Loading events', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.other, ResultException('error')),
      const Result<String>.data(ResultOrigin.other, 'string'),
    ]);

    // Act
    final filteredStream = stream.takeDataResult();

    // Assert
    expect(filteredStream, emitsInOrder([const Result<String>.data(ResultOrigin.other, 'string'), emitsDone]));
  });

  test('takeLoadingResult filter out Error and Data events', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.other, ResultException('error')),
      const Result<String>.data(ResultOrigin.other, 'string'),
    ]);

    // Act
    final filteredStream = stream.takeLoadingResult();

    // Assert
    expect(filteredStream, emitsInOrder([const Result<String>.loading(ResultOrigin.other), emitsDone]));
  });

  test('takeErrorResult filter out Loading and Data events', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.other, ResultException('error')),
      const Result<String>.data(ResultOrigin.other, 'string'),
    ]);

    // Act
    final filteredStream = stream.takeErrorResult();

    // Assert
    expect(
      filteredStream,
      emitsInOrder([
        Result<String>.error(ResultOrigin.other, ResultException('error')),
        emitsDone,
      ]),
    );
  });

  test('takeDataOrErrorResults filter out Loading events', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.other, ResultException('error')),
      const Result<String>.data(ResultOrigin.other, 'string'),
    ]);

    // Act
    final filteredStream = stream.takeDataOrErrorResults();

    // Assert
    expect(
      filteredStream,
      emitsInOrder([
        Result<String>.error(ResultOrigin.other, ResultException('error')),
        const Result<String>.data(ResultOrigin.other, 'string'),
        emitsDone,
      ]),
    );
  });

  test('takeDataOrLoadingResults filter out Error events', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.other, ResultException('error')),
      const Result<String>.data(ResultOrigin.other, 'string'),
    ]);

    // Act
    final filteredStream = stream.takeDataOrLoadingResults();

    // Assert
    expect(
      filteredStream,
      emitsInOrder([
        const Result<String>.loading(ResultOrigin.other),
        const Result<String>.data(ResultOrigin.other, 'string'),
        emitsDone,
      ]),
    );
  });

  test('takeOrigins filter out origins', () {
    // Arrange
    final stream = Stream.fromIterable([
      const Result<String>.loading(ResultOrigin.other),
      Result<String>.error(ResultOrigin.network, ResultException('error')),
      const Result<String>.data(ResultOrigin.local, 'string'),
    ]);

    // Act
    final networkStream = stream.takeOrigins([ResultOrigin.network]);
    final localStream = stream.takeOrigins([ResultOrigin.local]);
    final otherStream = stream.takeOrigins([ResultOrigin.other]);
    final allOriginsStream = stream.takeOrigins(ResultOrigin.values);

    // Assert
    expect(
      networkStream,
      emitsInOrder([Result<String>.error(ResultOrigin.network, ResultException('error')), emitsDone]),
    );

    expect(localStream, emitsInOrder([const Result<String>.data(ResultOrigin.local, 'string'), emitsDone]));

    expect(otherStream, emitsInOrder([const Result<String>.loading(ResultOrigin.other), emitsDone]));

    expect(
      allOriginsStream,
      emitsInOrder(
        [
          const Result<String>.loading(ResultOrigin.other),
          Result<String>.error(ResultOrigin.network, ResultException('error')),
          const Result<String>.data(ResultOrigin.local, 'string'),
          emitsDone,
        ],
      ),
    );
  });

  test('doOnDataResult calls callback', () async {
    // Arrange
    final streamData = generateResultList<String>(
      dataLength: 1,
      errorLength: 2,
      loadingLength: 3,
      dataGenerator: (index) => 'string',
      errorGenerator: (index) => ResultException('error'),
    );
    final stream = Stream.fromIterable(streamData);

    final MockCallbackVoid mockCallback = MockCallbackVoid();
    when(mockCallback.call()).thenReturn(null);

    // Act
    final mappedStream = stream.doOnDataResult((data) {
      mockCallback.call();
    });

    // Assert
    await expectLater(mappedStream, emitsInOrder([...streamData, emitsDone]));
    verify(mockCallback.call()).called(1);
  });

  test('doOnErrorResult calls callback', () async {
    // Arrange
    final streamData = generateResultList<String>(
      dataLength: 1,
      errorLength: 2,
      loadingLength: 3,
      dataGenerator: (index) => 'string',
      errorGenerator: (index) => ResultException('error'),
    );
    final stream = Stream.fromIterable(streamData);

    final MockCallbackVoid mockCallback = MockCallbackVoid();
    when(mockCallback.call()).thenReturn(null);

    // Act
    final mappedStream = stream.doOnErrorResult((data) {
      mockCallback.call();
    });

    // Assert
    await expectLater(mappedStream, emitsInOrder([...streamData, emitsDone]));
    verify(mockCallback.call()).called(2);
  });

  test('doOnLoadingResult calls callback', () async {
    // Arrange
    final streamData = generateResultList<String>(
      dataLength: 1,
      errorLength: 2,
      loadingLength: 3,
      dataGenerator: (index) => 'string',
      errorGenerator: (index) => ResultException('error'),
    );
    final stream = Stream.fromIterable(streamData);

    final MockCallbackVoid mockCallback = MockCallbackVoid();
    when(mockCallback.call()).thenReturn(null);

    // Act
    final mappedStream = stream.doOnLoadingResult((data) {
      mockCallback.call();
    });

    // Assert
    await expectLater(mappedStream, emitsInOrder([...streamData, emitsDone]));
    verify(mockCallback.call()).called(3);
  });

  test('distinctUntilDataChanged filter out same stream events', () async {
    // Arrange
    final stream = generateResultStream<String>(
      dataLength: 3,
      errorLength: 3,
      loadingLength: 3,
      dataGenerator: (index) => 'string',
      errorGenerator: (index) => ResultException('error'),
    );

    // Act
    final mappedStream = stream.distinctUntilDataChanged();

    // Assert
    await expectLater(
      mappedStream,
      emitsInOrder(
        [
          ...generateResultList<String>(
            dataLength: 1,
            errorLength: 1,
            loadingLength: 1,
            dataGenerator: (index) => 'string',
            errorGenerator: (index) => ResultException('error'),
          ),
          emitsDone,
        ],
      ),
    );
  });
}
