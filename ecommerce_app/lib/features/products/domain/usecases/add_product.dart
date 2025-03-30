import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct implements UseCase<void, Product> {
  final ProductRepository repository;

  AddProduct(this.repository);

  @override
  Future<void> call(Product product) async {
    return await repository.addProduct(product);
  }
} 