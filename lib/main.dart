import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Memuat konfigurasi environment .env jika tersedia
  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    // Gunakan fallback default jika .env belum dibuat
  }

  // Inisialisasi Supabase SDK jika kredensial telah dikonfigurasi
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl != null &&
      supabaseAnonKey != null &&
      supabaseUrl.startsWith('http') &&
      !supabaseUrl.contains('your-project-id')) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: supabaseAnonKey,
      );
    } catch (e) {
      debugPrint('Supabase initialization note: $e');
    }
  }

  runApp(const SppgApp());
}