import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  test('mapToResult returns data result when stream have data', () async {
    // Arrange
    final stream = Stream.value('string');

    // Act
    final mappedStream = stream.mapToResult();

    // Assert
    expect(mappedStream, emitsInOrder([const Result.data(ResultOrigin.other, 'string'), emitsDone]));
  });

  test('mapToResult returns error result when stream throw error', () async {
    // Arrange
    final stream = Stream<String>.error(ResultException('test_ex'));
    final mappedStream = stream.mapToResult();

    // Act
    final result = await mappedStream.first;

    // Assert
    expect(result.isError, isTrue);
    expect(result.getErrorOrNull(), equals(ResultException('test_ex')));
  });

  test('filterSuccess returns stream with no error', () async {
    // Arrange
    final dataStream = Stream<String>.value('string');
    final errorStream = Stream<String>.error(ResultException('test_ex'));

    // Assert
    expect(dataStream.filterSuccess(), emitsInOrder(['string', emitsDone]));
    expect(errorStream.filterSuccess(), emitsInOrder([emitsDone]));
  });

  test('mapNullTo returns mapped Stream', () async {
    // Arrange
    final dataStream = Stream<String?>.fromIterable([null, 'string', null]);

    // Act
    final mappedStream = dataStream.mapNullTo(() => '');

    // Assert
    expect(mappedStream, emitsInOrder(['', 'string', '', emitsDone]));
  });
}
