import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/products/presentation/pages/add_product_page.dart';

@GenerateNiceMocks([MockSpec<ProductBloc>()])
import 'add_product_page_test.mocks.dart';

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    when(mockProductBloc.state).thenReturn(ProductInitial());
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductInitial()));
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: child,
      ),
    );
  }

  testWidgets('should show form fields', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(const AddProductPage()));
    await tester.pump();

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Add Product', skipOffstage: false), findsNWidgets(2)); // One in AppBar, one in button
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });

  testWidgets('should add AddProductEvent when form is submitted',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(const AddProductPage()));
    await tester.pump();

    // Fill in the form
    await tester.enterText(find.byType(TextFormField).first, 'Test Product');
    await tester.enterText(find.byType(TextFormField).at(1), '99.99');
    await tester.enterText(find.byType(TextFormField).last, 'Test Description');

    // Submit the form
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert
    verify(mockProductBloc.add(any)).called(1);
  });

  testWidgets('should show validation errors when form is empty',
      (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(makeTestableWidget(const AddProductPage()));
    await tester.pump();

    // Submit empty form
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Price is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
  });
} 