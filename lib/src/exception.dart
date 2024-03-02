class StapeException extends Error {
  final dynamic details;
  StapeException(this.details);

  @override
  String toString() => 'Something went wrong while sending the event: $details';
}
