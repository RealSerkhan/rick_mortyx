import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;
  final String? callId;

  const Failure({this.errorMessage, this.callId});

  @override
  List<Object?> get props => [errorMessage, callId];
}

class ServerFailure extends Failure {
  final String? sourceClass;
  final int? statusCode;

  const ServerFailure({super.errorMessage, super.callId, this.sourceClass, this.statusCode});

  @override
  List<Object?> get props => [errorMessage, callId, sourceClass, statusCode];
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({super.errorMessage, super.callId});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.errorMessage, super.callId});
}

class CacheFailure extends Failure {
  const CacheFailure({super.errorMessage, super.callId});
}

class UnknownFailure extends Failure {
  final String? sourceClass;

  const UnknownFailure({super.errorMessage, super.callId, this.sourceClass});

  @override
  List<Object?> get props => [errorMessage, callId, sourceClass];
}

class RequestFailure extends Failure {
  const RequestFailure({super.errorMessage, super.callId});
}
