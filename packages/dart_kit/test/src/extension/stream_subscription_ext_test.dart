import 'dart:async';

import 'package:dart_kit/dart_kit.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

import '../base_mocks.mocks.dart';

void main() {
  test('register stream subscription inside array of subscription when call subscription.register()', () async {
    // Arrange
    final listOfSub = <StreamSubscription>[];
    final stream = Stream.fromIterable([1, 2, 3]);
    final StreamSubscription<int> sub = stream.listen((event) {});

    // Act
    sub.register(listOfSub);

    // Assert
    expect(listOfSub.length, equals(1));
    sub.cancel();
  });

  test('cancel all stream subscriptions when call list.cancel', () async {
    // Arrange
    final listOfSub = <StreamSubscription>[];

    final MockCallbackVoid mockCallback = MockCallbackVoid();
    when(mockCallback.call()).thenReturn(null);

    // Act
    Stream.fromIterable([1, 2, 3]).doOnCancel(mockCallback.call).listen((event) {}).register(listOfSub);
    Stream.fromIterable([1, 2, 3]).doOnCancel(mockCallback.call).listen((event) {}).register(listOfSub);
    await listOfSub.cancel();

    // Assert
    expect(listOfSub, isEmpty);
    verify(mockCallback.call()).called(2);
  });
}
