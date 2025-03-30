import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/products/presentation/pages/edit_product_page.dart';

@GenerateNiceMocks([MockSpec<ProductBloc>()])
import 'edit_product_page_test.mocks.dart';

void main() {
  late MockProductBloc mockProductBloc;
  late Product testProduct;

  setUp(() {
    mockProductBloc = MockProductBloc();
    when(mockProductBloc.state).thenReturn(ProductInitial());
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductInitial()));

    testProduct = const Product(
      id: 1,
      name: 'Test Product',
      price: 99.99,
      description: 'Test Description',
    );
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: child,
      ),
    );
  }

  testWidgets('should show form fields with product data',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(EditProductPage(product: testProduct)));
    await tester.pump();

    // Assert
    expect(find.text('Edit Product'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    
    // Find TextFormFields by their labels
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    
    // Verify the initial values
    final nameField = tester.widget<TextFormField>(
      find.ancestor(
        of: find.text('Name'),
        matching: find.byType(TextFormField),
      ),
    );
    expect(nameField.controller?.text, 'Test Product');
    
    final priceField = tester.widget<TextFormField>(
      find.ancestor(
        of: find.text('Price'),
        matching: find.byType(TextFormField),
      ),
    );
    expect(priceField.controller?.text, '99.99');
    
    final descriptionField = tester.widget<TextFormField>(
      find.ancestor(
        of: find.text('Description'),
        matching: find.byType(TextFormField),
      ),
    );
    expect(descriptionField.controller?.text, 'Test Description');
  });

  testWidgets('should add UpdateProductEvent when form is submitted',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(EditProductPage(product: testProduct)));
    await tester.pump();

    // Update form fields
    await tester.enterText(
      find.ancestor(
        of: find.text('Name'),
        matching: find.byType(TextFormField),
      ),
      'Updated Product'
    );
    await tester.enterText(
      find.ancestor(
        of: find.text('Price'),
        matching: find.byType(TextFormField),
      ),
      '149.99'
    );
    await tester.enterText(
      find.ancestor(
        of: find.text('Description'),
        matching: find.byType(TextFormField),
      ),
      'Updated Description'
    );

    // Submit the form
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    // Assert
    verify(mockProductBloc.add(any)).called(1);
  });

  testWidgets('should show validation errors when form is empty',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(EditProductPage(product: testProduct)));
    await tester.pump();

    // Clear form fields
    await tester.enterText(
      find.ancestor(
        of: find.text('Name'),
        matching: find.byType(TextFormField),
      ),
      ''
    );
    await tester.enterText(
      find.ancestor(
        of: find.text('Price'),
        matching: find.byType(TextFormField),
      ),
      ''
    );
    await tester.enterText(
      find.ancestor(
        of: find.text('Description'),
        matching: find.byType(TextFormField),
      ),
      ''
    );

    // Submit empty form
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Price is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
  });
} 