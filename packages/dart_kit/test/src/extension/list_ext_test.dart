import 'package:dart_kit/dart_kit.dart';
import 'package:test/test.dart';

void main() {
  test('getFromLast return item when index in range or throw RangeError', () {
    final list = List.generate(2, (index) => index);

    expect(list.getFromLast(0), equals(1));
    expect(list.getFromLast(1), equals(0));
    expect(() => list.getFromLast(2), throwsRangeError);
  });

  test('beforeLast return item that before last item when index in range or throw RangeError', () {
    final list = List.generate(2, (index) => index);
    final emptyList = [];
    final oneItemList = [0];

    expect(list.beforeLast, equals(0));
    expect(() => oneItemList.beforeLast, throwsRangeError);
    expect(() => emptyList.beforeLast, throwsRangeError);
  });

  test('elementAtOrNull return item when index in range or return null', () {
    final list = List.generate(2, (index) => index);

    expect(list.elementAtOrNull(0), equals(0));
    expect(list.elementAtOrNull(1), equals(1));
    expect(list.elementAtOrNull(2), isNull);
  });

  test('second return second item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.second, equals(1));
    expect(emptyList.second, isNull);
  });

  test('third return third item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.third, equals(2));
    expect(emptyList.third, isNull);
  });

  test('fourth return fourth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.fourth, equals(3));
    expect(emptyList.fourth, isNull);
  });

  test('fifth return fifth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.fifth, equals(4));
    expect(emptyList.fifth, isNull);
  });

  test('sixth return sixth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.sixth, equals(5));
    expect(emptyList.sixth, isNull);
  });

  test('seventh return seventh item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.seventh, equals(6));
    expect(emptyList.seventh, isNull);
  });

  test('eighth return eighth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.eighth, equals(7));
    expect(emptyList.eighth, isNull);
  });

  test('ninth return ninth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.ninth, equals(8));
    expect(emptyList.ninth, isNull);
  });

  test('tenth return tenth item or null', () {
    final list = List.generate(10, (index) => index);
    final emptyList = [];

    expect(list.tenth, equals(9));
    expect(emptyList.tenth, isNull);
  });

  test('map where returns mapped array', () {
    final list = List.generate(10, (index) => index);
    final emptyList = <int>[];

    expect(
      list.mapWhere((it) => it.isEven, (it) => it + 1),
      equals(list.where((it) => it.isEven).map((it) => it + 1).toList()),
    );
    expect(emptyList.mapWhere((it) => it == 0, (it) => it + 1), equals([]));
  });

  test('isNullOrEmpty works', () {
    final list = List.generate(10, (index) => index);
    final emptyList = <int>[];
    const List<int>? nullList = null;

    expect(list.isNullOrEmpty, isFalse);
    expect(emptyList.isNullOrEmpty, isTrue);
    expect(nullList.isNullOrEmpty, isTrue);
  });

  test('isNotNullNorEmpty works', () {
    final list = List.generate(10, (index) => index);
    final emptyList = <int>[];
    const List<int>? nullList = null;

    expect(list.isNotNullNorEmpty, isTrue);
    expect(emptyList.isNotNullNorEmpty, isFalse);
    expect(nullList.isNotNullNorEmpty, isFalse);
  });
}
