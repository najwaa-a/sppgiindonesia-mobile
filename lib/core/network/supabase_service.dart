import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_tables.dart';

/// Service terpusat untuk interaksi dengan Supabase (Auth, Database, Storage)
class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  // --- AUTHENTICATION ---
  static User? get currentUser => client.auth.currentUser;
  static bool get isAuthenticated => currentUser != null;

  /// Registrasi pengguna baru dengan metadata role ('kitchen' / 'supplier')
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
    String? phone,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role,
        'phone': phone,
      },
    );

    // Otomatis simpan profil di tabel profiles jika user berhasil dibuat
    if (response.user != null) {
      await client.from(SupabaseTables.profiles).upsert({
        'id': response.user!.id,
        'full_name': fullName,
        'role': role,
        'phone': phone,
        'created_at': DateTime.now().toIso8601String(),
      });
    }

    return response;
  }

  /// Login email dan password
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Logout sesi
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Ambil role user dari tabel profiles
  static Future<String?> getUserRole(String userId) async {
    try {
      final data = await client
          .from(SupabaseTables.profiles)
          .select('role')
          .eq('id', userId)
          .maybeSingle();
      return data?['role'] as String?;
    } catch (_) {
      return null;
    }
  }

  // --- DATABASE HELPERS ---
  static PostgrestQueryBuilder from(String table) => client.from(table);

  // --- STORAGE HELPERS ---
  /// Upload file bukti serah terima (PoD) ke Supabase Storage bucket
  static Future<String?> uploadProofPhoto({
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    try {
      final path = 'proofs/$fileName';
      await client.storage.from(SupabaseTables.bucketProofOfDelivery).uploadBinary(
            path,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );
      return client.storage.from(SupabaseTables.bucketProofOfDelivery).getPublicUrl(path);
    } catch (_) {
      return null;
    }
  }
}
