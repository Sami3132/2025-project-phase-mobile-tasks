import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';

@GenerateMocks([ProductRepository])
import 'delete_product_test.mocks.dart';

void main() {
  late DeleteProduct useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = DeleteProduct(mockRepository);
  });

  const tProductId = 1;

  test('should delete product from the repository', () async {
    // arrange
    when(mockRepository.deleteProduct(any)).thenAnswer((_) async => {});
    when(mockRepository.getProducts()).thenAnswer((_) async => []);

    // act
    await useCase(tProductId);

    // assert
    verify(mockRepository.deleteProduct(tProductId));
    verify(mockRepository.getProducts());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should propagate repository errors', () async {
    // arrange
    final exception = Exception('Test error');
    when(mockRepository.deleteProduct(any)).thenThrow(exception);

    // act
    final call = useCase(tProductId);

    // assert
    expect(() => call, throwsA(exception));
    verify(mockRepository.deleteProduct(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });
} 