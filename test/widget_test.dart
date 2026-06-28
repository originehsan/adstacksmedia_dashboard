import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adstacksmedia_dashboard/app.dart';

void main() {
  testWidgets('Dashboard app launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AdstacksApp(),
      ),
    );
    await tester.pump();
    expect(find.byType(AdstacksApp), findsOneWidget);
  });
}