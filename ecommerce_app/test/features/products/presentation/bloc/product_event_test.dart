import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_event.dart';

void main() {
  group('ProductEvent', () {
    const testProduct = Product(
      id: 1,
      name: 'Test Product',
      price: 99.99,
      description: 'Test Description',
    );

    test('GetProductsEvent props should be empty', () {
      final event = GetProductsEvent();
      expect(event.props, []);
    });

    test('AddProductEvent props should contain product', () {
      const event = AddProductEvent(testProduct);
      expect(event.props, [testProduct]);
    });

    test('UpdateProductEvent props should contain product', () {
      const event = UpdateProductEvent(testProduct);
      expect(event.props, [testProduct]);
    });

    test('DeleteProductEvent props should contain id', () {
      const event = DeleteProductEvent(1);
      expect(event.props, [1]);
    });

    test('GetProductsEvent instances should be equal', () {
      final event1 = GetProductsEvent();
      final event2 = GetProductsEvent();
      expect(event1, event2);
    });

    test('AddProductEvent instances with same product should be equal', () {
      const event1 = AddProductEvent(testProduct);
      const event2 = AddProductEvent(testProduct);
      expect(event1, event2);
    });

    test('UpdateProductEvent instances with same product should be equal', () {
      const event1 = UpdateProductEvent(testProduct);
      const event2 = UpdateProductEvent(testProduct);
      expect(event1, event2);
    });

    test('DeleteProductEvent instances with same id should be equal', () {
      const event1 = DeleteProductEvent(1);
      const event2 = DeleteProductEvent(1);
      expect(event1, event2);
    });
  });
} 