/// Exception dasar untuk layer data / network
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({this.message = 'Sesi telah berakhir atau tidak sah. Silakan login kembali.'});

  @override
  String toString() => 'UnauthorizedException: $message';
}
