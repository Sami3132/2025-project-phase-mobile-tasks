import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/get_products.dart';

@GenerateMocks([ProductRepository])
import 'get_products_test.mocks.dart';

void main() {
  late GetProducts useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProducts(mockRepository);
  });

  final tProducts = [
    const Product(id: 1, name: 'Test 1', price: 10.0, description: 'Desc 1'),
    const Product(id: 2, name: 'Test 2', price: 20.0, description: 'Desc 2'),
  ];

  test('should get products from the repository', () async {
    // arrange
    when(mockRepository.getProducts()).thenAnswer((_) async => tProducts);

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, tProducts);
    verify(mockRepository.getProducts());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty list when repository returns empty list', () async {
    // arrange
    when(mockRepository.getProducts()).thenAnswer((_) async => []);

    // act
    final result = await useCase(const NoParams());

    // assert
    expect(result, isEmpty);
    verify(mockRepository.getProducts());
    verifyNoMoreInteractions(mockRepository);
  });
} 