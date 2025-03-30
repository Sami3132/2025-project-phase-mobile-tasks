import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';

@GenerateMocks([ProductRepository])
import 'update_product_test.mocks.dart';

void main() {
  late UpdateProduct useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = UpdateProduct(mockRepository);
  });

  const tProduct = Product(
    id: 1,
    name: 'Updated Product',
    price: 20.0,
    description: 'Updated Description',
  );

  test('should update product in the repository', () async {
    // arrange
    when(mockRepository.updateProduct(any)).thenAnswer((_) async => {});

    // act
    await useCase(tProduct);

    // assert
    verify(mockRepository.updateProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate repository errors', () async {
    // arrange
    when(mockRepository.updateProduct(any)).thenThrow(Exception('Test error'));

    // act
    final call = useCase(tProduct);

    // assert
    expect(() => call, throwsException);
    verify(mockRepository.updateProduct(tProduct));
    verifyNoMoreInteractions(mockRepository);
  });
} 