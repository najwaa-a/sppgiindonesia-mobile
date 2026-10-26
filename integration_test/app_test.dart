import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:posmbg_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Aplikasi dapat dibuka dan merender tampilan awal', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('SPPGIndonesia'), findsWidgets);
  });
}
