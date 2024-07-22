class ApiException implements Exception {
  final dynamic message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}