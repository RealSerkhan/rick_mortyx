import 'package:stack_trace/stack_trace.dart';

class PrintableTrace extends Trace {
  PrintableTrace(super.frames, {super.original});

  // It's equal to VMTrace.toString() Method.
  // Firebase use it to generate the stacktrace
  @override
  String toString() {
    var i = 1;
    return frames.map((frame) {
      final number = '#${i++}'.padRight(8);
      final member = frame.member!
          .replaceAllMapped(
            RegExp(r'[^.]+\.<async>'),
            (match) => '${match[1]}.<${match[1]}_async_body>',
          )
          .replaceAll('<fn>', '<anonymous closure>');
      final line = frame.line ?? 0;
      final column = frame.column ?? 0;
      return '$number$member (${frame.uri}:$line:$column)\n';
    }).join();
  }
}
