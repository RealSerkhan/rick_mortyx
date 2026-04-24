import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  test('isZero works', () async {
    // Arrange
    const int isZero = 0;
    const int isNotZero = 1;

    // Assert
    expect(isZero.isZero, isTrue);
    expect(isNotZero.isZero, isFalse);
  });

  test('isNullOrZero works', () async {
    // Arrange
    const int isZero = 0;
    const int? isNull = null;
    const int isNotZero = 1;

    // Assert
    expect(isZero.isNullOrZero, isTrue);
    expect(isNull.isNullOrZero, isTrue);
    expect(isNotZero.isNullOrZero, isFalse);
  });

  test('isNotNullNorZero works', () async {
    // Arrange
    const int isZero = 0;
    const int? isNull = null;
    const int isNotZero = 1;

    // Assert
    expect(isZero.isNotNullNorZero, isFalse);
    expect(isNull.isNotNullNorZero, isFalse);
    expect(isNotZero.isNotNullNorZero, isTrue);
  });

  test('isBetween works', () async {
    // Arrange
    const int number = 1;

    // Assert
    expect(number.isBetween(0, 2), isTrue);
    expect(number.isBetween(1, 2), isFalse);
    expect(number.isBetween(0, 1), isFalse);
    expect(number.isBetween(1, 1), isFalse);
    expect(number.isBetween(2, 3), isFalse);
  });

  test('inRange works', () async {
    // Arrange
    const int number = 1;

    // Assert
    expect(number.inRange(0, 2), isTrue);
    expect(number.inRange(1, 2), isTrue);
    expect(number.inRange(0, 1), isTrue);
    expect(number.inRange(2, 3), isFalse);
  });
}
