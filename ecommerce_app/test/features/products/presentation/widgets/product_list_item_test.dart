import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/widgets/product_list_item.dart';

@GenerateMocks([NavigatorObserver])
import 'product_list_item_test.mocks.dart';

void main() {
  late MockNavigatorObserver mockNavigatorObserver;
  late Product testProduct;

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
    when(mockNavigatorObserver.navigator).thenReturn(null);
    
    testProduct = const Product(
      id: 1,
      name: 'Test Product',
      price: 99.99,
      description: 'Test Description',
    );
  });

  Widget makeTestableWidget(Widget widget) {
    return MaterialApp(
      home: Scaffold(
        body: Material(
          child: widget,
        ),
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('should display product information correctly',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      makeTestableWidget(
        ProductListItem(
          product: testProduct,
          index: 0,
          onDelete: () {},
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$99.99'), findsOneWidget);
    expect(find.text('1)'), findsOneWidget);
  });

  testWidgets('should show delete confirmation dialog when delete button is tapped',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      makeTestableWidget(
        ProductListItem(
          product: testProduct,
          index: 0,
          onDelete: () {},
        ),
      ),
    );

    // Act
    await tester.pump();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Delete Product'), findsOneWidget);
    expect(find.text('Are you sure you want to delete this product?'), findsOneWidget);
  });

  testWidgets('should navigate to edit page when edit button is tapped',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      makeTestableWidget(
        ProductListItem(
          product: testProduct,
          index: 0,
          onDelete: () {},
        ),
      ),
    );

    // Act
    await tester.pump();
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Assert
    verify(mockNavigatorObserver.didPush(any, any));
  });

  testWidgets('should navigate to details page when item is tapped',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      makeTestableWidget(
        ProductListItem(
          product: testProduct,
          index: 0,
          onDelete: () {},
        ),
      ),
    );

    // Act
    await tester.pump();
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Assert
    verify(mockNavigatorObserver.didPush(any, any));
  });

  testWidgets('should call onDelete when delete is confirmed',
      (WidgetTester tester) async {
    // Arrange
    bool deleteCalled = false;
    await tester.pumpWidget(
      makeTestableWidget(
        ProductListItem(
          product: testProduct,
          index: 0,
          onDelete: () => deleteCalled = true,
        ),
      ),
    );

    // Act
    await tester.pump();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Assert
    expect(deleteCalled, true);
  });
} 