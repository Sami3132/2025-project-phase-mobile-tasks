import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';

void main() {
  group('Product', () {
    test('should create a Product with correct values', () {
      const product = Product(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      expect(product.id, 1);
      expect(product.name, 'Test Product');
      expect(product.price, 10.99);
      expect(product.description, 'Test Description');
    });

    test('should be equal when all properties are the same', () {
      const product1 = Product(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      const product2 = Product(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      expect(product1, equals(product2));
    });

    test('should not be equal when properties are different', () {
      const product1 = Product(
        id: 1,
        name: 'Test Product 1',
        price: 10.99,
        description: 'Test Description 1',
      );

      const product2 = Product(
        id: 2,
        name: 'Test Product 2',
        price: 20.99,
        description: 'Test Description 2',
      );

      expect(product1, isNot(equals(product2)));
    });
  });
} 