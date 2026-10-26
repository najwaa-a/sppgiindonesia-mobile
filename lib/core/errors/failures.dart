/// Failure dasar untuk domain layer
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Terjadi kesalahan pada server.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Koneksi internet bermasalah. Periksa jaringan Anda.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Akses ditolak atau autentikasi gagal.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Gagal membaca atau menyimpan data lokal.']);
}
