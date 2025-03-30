import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/presentation/widgets/loading_overlay.dart';

void main() {
  testWidgets('should show loading indicator when isLoading is true',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: LoadingOverlay(
          isLoading: true,
          child: Text('Content'),
        ),
      ),
    );
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
  });

  testWidgets('should not show loading indicator when isLoading is false',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: LoadingOverlay(
          isLoading: false,
          child: Text('Content'),
        ),
      ),
    );
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Content'), findsOneWidget);
  });
} 