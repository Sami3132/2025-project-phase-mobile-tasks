import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/products/presentation/pages/home_page.dart';
import 'package:ecommerce_app/features/products/presentation/pages/add_product_page.dart';

@GenerateMocks([ProductBloc, NavigatorObserver])
import 'home_page_test.mocks.dart';

void main() {
  late MockProductBloc mockProductBloc;
  late MockNavigatorObserver mockNavigatorObserver;
  late List<Product> testProducts;

  setUp(() {
    mockProductBloc = MockProductBloc();
    mockNavigatorObserver = MockNavigatorObserver();
    when(mockNavigatorObserver.navigator).thenReturn(null);
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductInitial()));

    testProducts = [
      const Product(id: 1, name: 'Test Product 1', price: 99.99, description: 'Description 1'),
      const Product(id: 2, name: 'Test Product 2', price: 149.99, description: 'Description 2'),
    ];
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: child,
      ),
      navigatorObservers: [mockNavigatorObserver],
      onGenerateRoute: (settings) {
        if (settings.name == '/add-product') {
          return MaterialPageRoute(
            builder: (context) => const AddProductPage(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }

  testWidgets('should show loading indicator when state is ProductLoading',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductLoading());
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductLoading()));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show products when state is ProductsLoaded',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductsLoaded(testProducts));
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductsLoaded(testProducts)));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('\$99.99'), findsOneWidget);
    expect(find.text('\$149.99'), findsOneWidget);
  });

  testWidgets('should show error message when state is ProductError',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Error loading products';
    when(mockProductBloc.state).thenReturn(const ProductError(errorMessage));
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(const ProductError(errorMessage)));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('should show "No products found" when state is ProductInitial',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductInitial());
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductInitial()));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    // Assert
    expect(find.text('No products found'), findsOneWidget);
  });

  testWidgets('should add DeleteProductEvent when delete is called',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductsLoaded(testProducts));
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductsLoaded(testProducts)));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Assert
    verify(mockProductBloc.add(const DeleteProductEvent(1))).called(1);
  });

  testWidgets('should navigate to AddProductPage when FAB is tapped',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductsLoaded(testProducts));
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductsLoaded(testProducts)));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Assert
    verify(mockNavigatorObserver.didPush(any, any));
  });

  testWidgets('should add GetProductsEvent when returning from AddProductPage with true',
      (WidgetTester tester) async {
    // Arrange
    when(mockProductBloc.state).thenReturn(ProductsLoaded(testProducts));
    when(mockProductBloc.stream).thenAnswer((_) => Stream.value(ProductsLoaded(testProducts)));

    // Act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));
    await tester.pump();

    // Find and tap the FAB
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Simulate returning from AddProductPage with true
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop(true);
    await tester.pumpAndSettle();

    // Assert
    verify(mockProductBloc.add(any)).called(1);
  });
} 