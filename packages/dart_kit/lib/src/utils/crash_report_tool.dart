import 'package:logger/logger.dart';

/// base class for reporting any error happen inside [Logger].
abstract class CrashReportTool {
  Future init();

  Future logNonFatal(LogEvent event);

  Future logFatal(dynamic error, StackTrace? stackTrace);
}

/// implementer for [CrashReportTool] will ignore any error, useful for test purpose.
class NoOpsCrashReportTool extends CrashReportTool {
  @override
  Future init() async {}

  @override
  // ignore: type_annotate_public_apis
  Future logFatal(error, StackTrace? stackTrace) async {}

  @override
  Future logNonFatal(LogEvent event) async {}
}
