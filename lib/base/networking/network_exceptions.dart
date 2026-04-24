class NoInternetException implements Exception {}

class TimeoutException implements Exception {}

class CancelledException implements Exception {}

class ServerNotWorkingException implements Exception {
  final String callId;
  ServerNotWorkingException({required this.callId});
}

class WrongDataException implements Exception {
  final int? statusCode;
  final String? cause;
  final String callId;
  final String sourceClass;

  WrongDataException({required this.statusCode, this.cause, required this.callId, required this.sourceClass});
}

class CacheException implements Exception {}

class UnKnownException implements Exception {
  final String callId;
  final String sourceClass;
  final dynamic error;

  UnKnownException({required this.callId, required this.sourceClass, required this.error});
}
