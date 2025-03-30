import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    test('should create a ProductModel with correct values', () {
      final product = ProductModel(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      expect(product.id, 1);
      expect(product.name, 'Test Product');
      expect(product.price, 10.99);
      expect(product.description, 'Test Description');
      expect(product.lastModified, isNotNull);
    });

    test('should create from JSON correctly', () {
      final json = {
        'id': 1,
        'name': 'Test Product',
        'price': 10.99,
        'description': 'Test Description',
        'lastModified': '2024-03-30T10:00:00.000Z',
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.name, 'Test Product');
      expect(product.price, 10.99);
      expect(product.description, 'Test Description');
      expect(product.lastModified, DateTime.parse('2024-03-30T10:00:00.000Z'));
    });

    test('should convert to JSON correctly', () {
      final product = ProductModel(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      final json = product.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Test Product');
      expect(json['price'], 10.99);
      expect(json['description'], 'Test Description');
      expect(json['lastModified'], isA<String>());
      expect(DateTime.parse(json['lastModified'] as String), isA<DateTime>());
    });

    test('should create copy with updated values', () async {
      final product = ProductModel(
        id: 1,
        name: 'Test Product',
        price: 10.99,
        description: 'Test Description',
      );

      // Add a small delay to ensure lastModified timestamps are different
      await Future.delayed(const Duration(milliseconds: 1));

      final updatedProduct = product.copyWith(
        name: 'Updated Product',
        price: 20.99,
      );

      expect(updatedProduct.id, 1);
      expect(updatedProduct.name, 'Updated Product');
      expect(updatedProduct.price, 20.99);
      expect(updatedProduct.description, 'Test Description');
      expect(updatedProduct.lastModified, isNotNull);
      expect(updatedProduct.lastModified.isAfter(product.lastModified), isTrue);
    });
  });
} 