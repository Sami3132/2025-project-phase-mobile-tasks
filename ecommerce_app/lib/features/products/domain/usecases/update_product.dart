import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct implements UseCase<void, Product> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<void> call(Product product) async {
    return await repository.updateProduct(product);
  }
} 