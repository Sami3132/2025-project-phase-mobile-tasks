import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_state.dart';

void main() {
  group('ProductState', () {
    final testProducts = [
      const Product(id: 1, name: 'Test Product 1', price: 99.99, description: 'Description 1'),
      const Product(id: 2, name: 'Test Product 2', price: 149.99, description: 'Description 2'),
    ];

    test('ProductInitial props should be empty', () {
      final state = ProductInitial();
      expect(state.props, []);
    });

    test('ProductLoading props should be empty', () {
      final state = ProductLoading();
      expect(state.props, []);
    });

    test('ProductsLoaded props should contain products', () {
      final state = ProductsLoaded(testProducts);
      expect(state.props, [testProducts]);
    });

    test('ProductError props should contain message', () {
      const message = 'Error message';
      const state = ProductError(message);
      expect(state.props, [message]);
    });

    test('ProductsLoaded states with same products should be equal', () {
      final state1 = ProductsLoaded(testProducts);
      final state2 = ProductsLoaded(testProducts);
      expect(state1, state2);
    });

    test('ProductError states with same message should be equal', () {
      const message = 'Error message';
      const state1 = ProductError(message);
      const state2 = ProductError(message);
      expect(state1, state2);
    });
  });
} 