import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:wasteagram/main.dart' as app;
import 'package:wasteagram/widgets/post_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify image selector floating action button', (tester) async {
    app.main();

    await tester.pumpAndSettle();

    final Finder fab = find.byIcon(Icons.photo);

    expect(fab, findsOneWidget);
  });

  testWidgets('select an entry in the list, verify details are populated',
      (tester) async {
    app.main();

    await tester.pumpAndSettle();

    final Finder tile =
        find.widgetWithText(PostCard, 'Thursday, March 9, 2023');

    await tester.tap(tile);

    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Food wasted: 3'), findsOneWidget);
    expect(find.text('Location: (37.3374267, -121.9473567)'), findsOneWidget);
  });
}
