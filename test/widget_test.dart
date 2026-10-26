import 'package:flutter_test/flutter_test.dart';
import 'package:posmbg_mobile/app/app.dart';

void main() {
  testWidgets('SPPGApp initial smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SppgApp());
    await tester.pumpAndSettle();

    // Verifikasi branding SPPGIndonesia tampil
    expect(find.text('SPPGIndonesia'), findsWidgets);
    expect(find.text('Masuk'), findsOneWidget);
  });
}
