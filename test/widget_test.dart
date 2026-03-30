// This is a basic Flutter widget test for Colordary app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:colordary/main.dart';

void main() {
  testWidgets('Colordary app smoke test - verify app launches', 
    (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: CozyDiaryApp(),
      ),
    );

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app has launched successfully
    // The app should have Material widget structure
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Colordary app - verify basic navigation', 
    (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: CozyDiaryApp(),
      ),
    );

    // Wait for initial navigation to complete
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that the app has at least one scaffold
    expect(find.byType(Scaffold), findsWidgets);
  });
}
