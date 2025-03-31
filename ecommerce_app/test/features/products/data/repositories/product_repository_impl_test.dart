import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:ecommerce_app/features/products/data/repositories/product_repository_impl.dart';

@GenerateMocks([ProductRemoteDataSource, SharedPreferences])
import 'product_repository_impl_test.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockSharedPreferences = MockSharedPreferences();
    repository = ProductRepositoryImpl(
      sharedPreferences: mockSharedPreferences,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('getProducts', () {
    final tProducts = [
      ProductModel(
        id: 1,
        name: 'Test Product 1',
        price: 10.0,
        description: 'Test Description 1',
      ),
      ProductModel(
        id: 2,
        name: 'Test Product 2',
        price: 20.0,
        description: 'Test Description 2',
      ),
    ];

    final tProductsJson = tProducts.map((product) {
      final model = product as ProductModel;
      return jsonEncode(model.toJson());
    }).toList();

    test(
      'should return remote data when remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => tProducts);
        when(mockSharedPreferences.setStringList(any, any))
            .thenAnswer((_) async => true);
        when(mockSharedPreferences.getStringList('products'))
            .thenReturn([]);

        // act
        final result = await repository.getProducts();

        // assert
        verify(mockRemoteDataSource.getProducts());
        verify(mockSharedPreferences.setStringList('products', any));
        expect(result, equals(tProducts));
      },
    );

    test(
      'should cache data locally when remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => tProducts);
        when(mockSharedPreferences.setStringList(any, any))
            .thenAnswer((_) async => true);
        when(mockSharedPreferences.getStringList('products'))
            .thenReturn([]);

        // act
        await repository.getProducts();

        // assert
        verify(mockRemoteDataSource.getProducts());
        verify(mockSharedPreferences.setStringList('products', any));
      },
    );

    test(
      'should return cached data when remote data source fails',
      () async {
        // arrange
        when(mockRemoteDataSource.getProducts())
            .thenThrow(Exception());
        when(mockSharedPreferences.getStringList('products'))
            .thenReturn(tProductsJson);

        // act
        final result = await repository.getProducts();

        // assert
        verify(mockRemoteDataSource.getProducts());
        verify(mockSharedPreferences.getStringList('products'));
        expect(result.length, equals(tProducts.length));
        expect(result[0].id, equals(tProducts[0].id));
        expect(result[0].name, equals(tProducts[0].name));
      },
    );
  });

  group('getProduct', () {
    final tProduct = ProductModel(
      id: 1,
      name: 'Test Product',
      price: 10.0,
      description: 'Test Description',
    );

    test(
      'should return remote product when remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById('1'))
            .thenAnswer((_) async => tProduct);
        when(mockSharedPreferences.getStringList('products'))
            .thenReturn([]);

        // act
        final result = await repository.getProduct(1);

        // assert
        verify(mockRemoteDataSource.getProductById('1'));
        expect(result, equals(tProduct));
      },
    );

    test(
      'should return cached product when remote data source fails',
      () async {
        // arrange
        when(mockRemoteDataSource.getProductById('1'))
            .thenThrow(Exception());
        when(mockSharedPreferences.getStringList('products'))
            .thenReturn([jsonEncode(tProduct.toJson())]);

        // act
        final result = await repository.getProduct(1);

        // assert
        verify(mockRemoteDataSource.getProductById('1'));
        verify(mockSharedPreferences.getStringList('products'));
        expect(result.id, equals(tProduct.id));
        expect(result.name, equals(tProduct.name));
      },
    );
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