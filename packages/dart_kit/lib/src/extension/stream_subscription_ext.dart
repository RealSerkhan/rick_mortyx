import 'dart:async';

extension StreamSubscriptionExt on StreamSubscription<dynamic> {
  /// add this subscription to [subscriptionList].
  void register(List<StreamSubscription<dynamic>> subscriptionList) => subscriptionList.add(this);
}

extension ListOfStreamSubscriptionExt on List<StreamSubscription<dynamic>> {
  /// cancel all subscription inside this list
  Future<void> cancel() async {
    for (final StreamSubscription<dynamic> sub in this) {
      await sub.cancel();
    }
    clear();
  }
}
