// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_setup/main.dart';
import 'package:flutter_setup/widgets/product_card.dart';
import 'package:flutter_setup/widgets/price_filter.dart';

void main() {
  testWidgets('App should render home screen with product list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Available Products'), findsOneWidget);
    
    // Verify that the user greeting is displayed
    expect(find.text('Hello, Yohannes'), findsOneWidget);
    
    // Verify that product cards are rendered
    expect(find.byType(ProductCard), findsWidgets);
  });

  testWidgets('Search functionality should work', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find and tap the search button
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Verify that the search field is visible
    expect(find.byType(TextField), findsOneWidget);
    
    // Verify that the price filter is visible
    expect(find.byType(PriceFilter), findsOneWidget);
  });

  testWidgets('Add product button should be visible', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the add product button is visible
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
