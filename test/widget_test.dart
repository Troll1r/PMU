import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmu/main.dart';

void main() {
  testWidgets('Лайк показывает SnackBar, карточка открывает детали', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter is gorgeous'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(3));

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.text('Лайк поставлен'), findsOneWidget);

    // Ждём, пока SnackBar исчезнет.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dart в действии').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('Практическое руководство'), findsOneWidget);
  });
}
