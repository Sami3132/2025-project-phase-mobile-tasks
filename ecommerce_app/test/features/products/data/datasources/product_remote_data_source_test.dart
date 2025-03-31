import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';

@GenerateMocks([http.Client])
import 'product_remote_data_source_test.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProducts', () {
    final tProducts = [
      {
        'id': 1,
        'name': 'Test Product 1',
        'price': 10.0,
        'description': 'Test Description 1',
        'lastModified': DateTime.now().toIso8601String(),
      },
      {
        'id': 2,
        'name': 'Test Product 2',
        'price': 20.0,
        'description': 'Test Description 2',
        'lastModified': DateTime.now().toIso8601String(),
      },
    ];

    test(
      'should return ProductModel list when the response is successful',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products')))
            .thenAnswer((_) async => http.Response(
                  json.encode(tProducts),
                  200,
                ));

        // act
        final result = await dataSource.getProducts();

        // assert
        expect(result, isA<List<ProductModel>>());
        expect(result.length, 2);
        expect(result[0].id, tProducts[0]['id']);
        expect(result[0].name, tProducts[0]['name']);
        expect(result[0].price, tProducts[0]['price']);
        expect(result[0].description, tProducts[0]['description']);
        verify(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products')));
      },
    );

    test(
      'should throw Exception when the response is not successful',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products')))
            .thenAnswer((_) async => http.Response('Error', 404));

        // act
        final call = dataSource.getProducts;

        // assert
        expect(() => call(), throwsException);
        verify(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products')));
      },
    );
  });

  group('getProductById', () {
    final tProduct = {
      'id': 1,
      'name': 'Test Product',
      'price': 10.0,
      'description': 'Test Description',
      'lastModified': DateTime.now().toIso8601String(),
    };

    test(
      'should return ProductModel when the response is successful',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products/1')))
            .thenAnswer((_) async => http.Response(
                  json.encode(tProduct),
                  200,
                ));

        // act
        final result = await dataSource.getProductById('1');

        // assert
        expect(result, isA<ProductModel>());
        expect(result.id, tProduct['id']);
        expect(result.name, tProduct['name']);
        expect(result.price, tProduct['price']);
        expect(result.description, tProduct['description']);
        verify(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products/1')));
      },
    );

    test(
      'should throw Exception when the response is not successful',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products/1')))
            .thenAnswer((_) async => http.Response('Error', 404));

        // act
        final call = dataSource.getProductById;

        // assert
        expect(() => call('1'), throwsException);
        verify(mockHttpClient.get(Uri.parse('${dataSource.baseUrl}/api/v1/products/1')));
      },
    );
  });
} 