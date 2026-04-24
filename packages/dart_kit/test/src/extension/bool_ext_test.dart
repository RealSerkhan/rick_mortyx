import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  test('is false working', () async {
    // Arrange
    const bool isFalse = false;
    const bool isTrue = true;

    // Assert
    expect(isFalse.isFalse, isTrue);
    expect(isTrue.isFalse, isFalse);
  });

  test('is null or false working', () async {
    // Arrange
    const bool isFalse = false;
    const bool? isNull = null;
    const bool isTrue = true;

    // Assert
    expect(isFalse.isNullOrFalse, isTrue);
    expect(isNull.isNullOrFalse, isTrue);
    expect(isTrue.isNullOrFalse, isFalse);
  });
}
