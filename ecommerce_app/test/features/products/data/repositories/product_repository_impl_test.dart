import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:ecommerce_app/features/products/data/repositories/product_repository_impl.dart';

@GenerateMocks([SharedPreferences])
import 'product_repository_impl_test.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    repository = ProductRepositoryImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getProducts', () {
    test('should return cached products when available', () async {
      final products = [
        ProductModel(id: 1, name: 'Test 1', price: 10.0, description: 'Desc 1'),
        ProductModel(id: 2, name: 'Test 2', price: 20.0, description: 'Desc 2'),
      ];
      final jsonList = products.map((p) => jsonEncode(p.toJson())).toList();
      
      when(mockSharedPreferences.getStringList('products'))
          .thenReturn(jsonList);

      final result = await repository.getProducts();

      expect(result.length, products.length);
      final resultProduct1 = result.firstWhere((p) => p.id == 1);
      final resultProduct2 = result.firstWhere((p) => p.id == 2);
      expect(resultProduct1.name, products[0].name);
      expect(resultProduct1.price, products[0].price);
      expect(resultProduct1.description, products[0].description);
      expect(resultProduct2.name, products[1].name);
      expect(resultProduct2.price, products[1].price);
      expect(resultProduct2.description, products[1].description);
      verify(mockSharedPreferences.getStringList('products')).called(1);
    });

    test('should return empty list when no cached products', () async {
      when(mockSharedPreferences.getStringList('products')).thenReturn([]);

      final result = await repository.getProducts();

      expect(result, isEmpty);
      verify(mockSharedPreferences.getStringList('products')).called(1);
    });
  });

  group('addProduct', () {
    test('should add product and save to cache', () async {
      final product = ProductModel(
        id: 1,
        name: 'Test Product',
        price: 10.0,
        description: 'Test Description',
      );

      when(mockSharedPreferences.getStringList('products')).thenReturn([]);
      when(mockSharedPreferences.setStringList(any, any)).thenAnswer((_) async => true);

      await repository.addProduct(product);

      verify(mockSharedPreferences.getStringList('products')).called(1);
      verify(mockSharedPreferences.setStringList('products', any)).called(1);
    });
  });

  group('updateProduct', () {
    test('should update existing product and save to cache', () async {
      final existingProducts = [
        ProductModel(id: 1, name: 'Old', price: 10.0, description: 'Old'),
        ProductModel(id: 2, name: 'Test 2', price: 20.0, description: 'Desc 2'),
      ];
      final updatedProduct = ProductModel(
        id: 1,
        name: 'Updated',
        price: 15.0,
        description: 'Updated',
      );

      when(mockSharedPreferences.getStringList('products'))
          .thenReturn(existingProducts.map((p) => jsonEncode(p.toJson())).toList());
      when(mockSharedPreferences.setStringList(any, any)).thenAnswer((_) async => true);

      await repository.updateProduct(updatedProduct);

      verify(mockSharedPreferences.getStringList('products')).called(1);
      verify(mockSharedPreferences.setStringList('products', any)).called(1);
    });
  });

  group('deleteProduct', () {
    test('should delete product and save updated list to cache', () async {
      final existingProducts = [
        ProductModel(id: 1, name: 'Test 1', price: 10.0, description: 'Desc 1'),
        ProductModel(id: 2, name: 'Test 2', price: 20.0, description: 'Desc 2'),
      ];

      when(mockSharedPreferences.getStringList('products'))
          .thenReturn(existingProducts.map((p) => jsonEncode(p.toJson())).toList());
      when(mockSharedPreferences.setStringList(any, any)).thenAnswer((_) async => true);

      await repository.deleteProduct(1);

      verify(mockSharedPreferences.getStringList('products')).called(1);
      verify(mockSharedPreferences.setStringList('products', any)).called(1);
    });
  });
} 