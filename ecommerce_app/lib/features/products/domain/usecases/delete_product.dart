import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProduct implements UseCase<void, int> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<void> call(int id) async {
    await repository.deleteProduct(id);
    // After deletion, reorder all products
    final products = await repository.getProducts();
    for (var i = 0; i < products.length; i++) {
      final product = products[i];
      if (product.id != i + 1) {
        final updatedProduct = Product(
          id: i + 1,
          name: product.name,
          price: product.price,
          description: product.description,
        );
        await repository.updateProduct(updatedProduct);
      }
    }
  }
} 