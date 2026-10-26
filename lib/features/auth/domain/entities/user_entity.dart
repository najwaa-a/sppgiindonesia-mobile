/// Entity user untuk autentikasi dan role detection
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String role; // 'kitchen' atau 'supplier'
  final String? token;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
  });

  bool get isKitchen => role.toLowerCase() == 'kitchen';
  bool get isSupplier => role.toLowerCase() == 'supplier';
}
