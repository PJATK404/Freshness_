import 'package:flutter_test/flutter_test.dart';
import 'package:freshness/ui/freshness_app.dart';

void main() {
  testWidgets('shows app name on start screen', (tester) async {
    await tester.pumpWidget(const FreshnessApp());

    expect(find.text('Freshness'), findsOneWidget);
  });
}
