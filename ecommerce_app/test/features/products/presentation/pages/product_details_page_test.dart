import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/pages/product_details_page.dart';

void main() {
  late Product testProduct;

  setUp(() {
    testProduct = const Product(
      id: 1,
      name: 'Test Product',
      price: 99.99,
      description: 'Test Description',
    );
  });

  testWidgets('should display product details', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailsPage(product: testProduct),
      ),
    );
    await tester.pump();

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Price: \$99.99'), findsOneWidget);
    expect(find.text('Description:'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('should be able to navigate back', (WidgetTester tester) async {
    bool didPop = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [
          MockNavigatorObserver((route, previousRoute) {
            if (route == null) {
              didPop = true;
            }
          }),
        ],
        home: Builder(
          builder: (context) => ProductDetailsPage(product: testProduct),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Navigate back
    Navigator.of(tester.element(find.byType(ProductDetailsPage))).pop();
    await tester.pumpAndSettle();

    // Assert
    expect(didPop, true);
  });
}

class MockNavigatorObserver extends NavigatorObserver {
  final void Function(Route<dynamic>?, Route<dynamic>?) onPushCall;

  MockNavigatorObserver(this.onPushCall);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPushCall(null, previousRoute);
  }
} 