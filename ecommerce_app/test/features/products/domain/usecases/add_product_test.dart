import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/add_product.dart';

@GenerateMocks([ProductRepository])
import 'add_product_test.mocks.dart';

void main() {
  late AddProduct useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = AddProduct(mockRepository);
  });

  const tProduct = Product(
    id: 1,
    name: 'Test Product',
    price: 10.0,
    description: 'Test Description',
  );

  test('should add product to the repository', () async {
    // arrange
    when(mockRepository.addProduct(any)).thenAnswer((_) async => {});

    // act
    await useCase(tProduct);

    // assert
    verify(mockRepository.addProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate repository errors', () async {
    // arrange
    when(mockRepository.addProduct(any)).thenThrow(Exception('Test error'));

    // act
    final call = useCase(tProduct);

    // assert
    expect(() => call, throwsException);
    verify(mockRepository.addProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });
} 