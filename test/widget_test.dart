import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fca_news_app/main.dart';

void main() {
  testWidgets('DailyNews page loads and displays content',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the DailyNews page is loaded by checking for specific content
    // Replace 'Daily News' with the actual title or key widget text if it's different.
    expect(find.text('Daily News'), findsOneWidget);

    // Check if there's a list or grid of articles
    // Replace `ListView` or `GridView` with the actual widget used if different.
    expect(find.byType(ListView), findsWidgets);
  });
}
