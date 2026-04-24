/// Used to notify unexpected errors for Result class.
class ResultException extends Error {
  /// Constructor
  ResultException(this.message);

  /// The error message
  final String message;

  @override
  String toString() => 'ResultException: $message';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType && other is ResultException && other.message == message);

  @override
  int get hashCode => Object.hash(runtimeType, message);
}
