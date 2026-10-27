import 'package:flutter_test/flutter_test.dart';
import 'package:posmbg_mobile/app/app.dart';

void main() {
  testWidgets('SPPGApp initial smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SppgApp());
    await tester.pumpAndSettle();

    // Verifikasi branding SPPGIndonesia dan navigasi onboarding tampil
    expect(find.text('SPPGIndonesia'), findsWidgets);
    expect(find.text('Lewati'), findsOneWidget);
    expect(find.text('Lanjut'), findsOneWidget);

    // Tap tombol Lewati untuk langsung ke form login (slide ke-3)
    await tester.tap(find.text('Lewati'));
    await tester.pumpAndSettle();

    // Verifikasi form login dan tombol daftar tampil di slide ke-3
    expect(find.text('Masuk ke Akun Anda'), findsOneWidget);
    expect(find.text('Daftar Sekarang'), findsOneWidget);
  });
}
