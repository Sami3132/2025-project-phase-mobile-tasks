import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';

@GenerateMocks([SharedPreferences])
import 'product_local_data_source_test.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
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

    test('should return empty list when no cached data exists', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final result = await dataSource.getProducts();

      // assert
      expect(result, []);
      verify(mockSharedPreferences.getString(CACHED_PRODUCTS_KEY));
    });

    test('should return list of products when cached data exists', () async {
      // arrange
      final jsonList = tProducts.map((product) => product.toJson()).toList();
      final jsonString = json.encode(jsonList);
      when(mockSharedPreferences.getString(any)).thenReturn(jsonString);

      // act
      final result = await dataSource.getProducts();

      // assert
      expect(result.length, equals(tProducts.length));
      expect(result[0].id, equals(tProducts[0].id));
      expect(result[0].name, equals(tProducts[0].name));
      expect(result[0].price, equals(tProducts[0].price));
      expect(result[0].description, equals(tProducts[0].description));
      verify(mockSharedPreferences.getString(CACHED_PRODUCTS_KEY));
    });
  });

  group('cacheProducts', () {
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

    test('should cache products successfully', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      // act
      await dataSource.cacheProducts(tProducts);

      // assert
      final jsonList = tProducts.map((product) => product.toJson()).toList();
      final jsonString = json.encode(jsonList);
      verify(mockSharedPreferences.setString(CACHED_PRODUCTS_KEY, jsonString));
    });

    test('should throw CacheException when caching fails', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);

      // act
      final call = dataSource.cacheProducts;

      // assert
      expect(() => call(tProducts), throwsA(isA<CacheException>()));
    });
  });
} 