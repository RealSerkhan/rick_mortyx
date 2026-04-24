// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dart_kit/src/utils/crash_report_tool.dart';
import 'package:dart_kit/src/utils/printable_trace.dart';
import 'package:logger/logger.dart' as dart_log;
import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

/// base logger class that wrap reporting tool strategy and logging strategy.
abstract class Logger {
  static CrashReportTool _crashReportTool = NoOpsCrashReportTool();

  static final dart_log.Logger _instance = dart_log.Logger(
    printer: _CrashReportWrappedPrinter(PrettyPrinter(), _crashReportTool),
    filter: _DisplayAllLogFilter(),
    output: MultiOutput([ConsoleOutput()]),
  );

  static Future init({required CrashReportTool crashReportTool}) {
    _crashReportTool = crashReportTool;
    return _crashReportTool.init();
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.verbose, message, error, stackTrace);

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.debug, message, error, stackTrace);

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.info, message, error, stackTrace);

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.warning, message, error, stackTrace);

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.error, message, error, stackTrace);

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _instance.log(Level.wtf, message, error, stackTrace);

  static Future<void> fatal({dynamic error, StackTrace? stackTrace}) async {
    d('Fatal', error, stackTrace);
    await _crashReportTool.logFatal(error, stackTrace);
  }
}

class _CrashReportWrappedPrinter extends LogPrinter {
  _CrashReportWrappedPrinter(this._printer, this._crashReportTool);

  final LogPrinter _printer;
  final CrashReportTool _crashReportTool;

  @override
  void init() => _printer.init();

  @override
  List<String> log(LogEvent event) {
    late final dart_log.LogEvent sanitizedEvent = dart_log.LogEvent(
      event.level,
      event.message,
      event.error,
      event.stackTrace ?? _currentStacktrace(),
    );

    switch (event.level) {
      case Level.verbose:
      case Level.debug:
      case Level.nothing:
      case Level.info:
        break;
      case Level.warning:
      case Level.error:
      case Level.wtf:
        _crashReportTool.logNonFatal(sanitizedEvent);
        break;
    }
    return _printer.log(sanitizedEvent);
  }

  StackTrace _currentStacktrace() {
    final trace = Trace.current(4);
    final frames = trace.frames;
    final newFrames = frames.map(
      (frame) => Frame(
        frame.uri,
        frame.line,
        frame.column,
        frame.member,
      ),
    );
    return PrintableTrace(newFrames);
  }

  @override
  void destroy() => _printer.destroy();
}

class _DisplayAllLogFilter extends LogFilter {
  // TODO(abd): In the future it should be filtered based on the env
  @override
  bool shouldLog(LogEvent event) => true;
}
