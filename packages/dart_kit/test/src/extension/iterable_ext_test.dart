import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  group('super join ', () {
    test('returns joined array when list is not empty', () async {
      // Arrange
      final list = [1, 2, 3];

      // Assert
      expect(list.superJoin(0), equals([1, 0, 2, 0, 3]));
    });

    test('returns same list when have one item', () async {
      // Arrange
      final list = [1];

      // Assert
      expect(list.superJoin(0), equals([1]));
    });

    test('returns empty list when list is empty', () async {
      // Arrange
      final list = [];

      // Assert
      expect(list.superJoin(0), equals([]));
    });
  });
}
