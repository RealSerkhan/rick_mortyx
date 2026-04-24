import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  test('map to result works when future is success', () async {
    // Arrange
    final successFuture = Future.value('string');

    // Act
    final result = successFuture.mapToResult();

    // Assert
    expect(result, completion(const Result<String>.data(ResultOrigin.other, 'string')));
  });

  test('map to result works when future is error', () async {
    // Arrange
    final errorFuture = Future<String>.error(ResultException('test_ex'));

    // Act
    final result = await errorFuture.mapToResult();

    // Assert
    expect(result.isError, isTrue);
    expect(result.getErrorOrNull(), equals(ResultException('test_ex')));
  });

  test('filter success works when future is success', () async {
    // Arrange
    final successFuture = Future.value('string');

    // Act
    final result = successFuture.filterSuccess();

    // Assert
    expect(result, completion('string'));
  });

  test('filter success works when future is error', () async {
    // Arrange
    final errorFuture = Future<String>.error(ResultException('test_ex'));

    // Act
    final result = errorFuture.filterSuccess();

    // Assert
    expect(result, completion(null));
  });
}
