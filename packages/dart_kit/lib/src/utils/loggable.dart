import 'package:dart_kit/dart_kit.dart';

/// provide logging functionality for any class with prefixing [loggerTag] to error message.
mixin Loggable {
  String get loggerTag;
  String _message(dynamic message) => '$loggerTag: $message';

  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) => Logger.v(_message(message), error, stackTrace);

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) => Logger.d(_message(message), error, stackTrace);

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) => Logger.i(_message(message), error, stackTrace);

  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) => Logger.w(_message(message), error, stackTrace);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) => Logger.e(_message(message), error, stackTrace);

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      Logger.wtf(_message(message), error, stackTrace);

  Future<void> fatal({dynamic error, StackTrace? stackTrace}) => Logger.fatal(error: error, stackTrace: stackTrace);
}
