import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/add_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/products/domain/usecases/get_products.dart';
import 'package:ecommerce_app/features/products/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_state.dart';

@GenerateNiceMocks([
  MockSpec<GetProducts>(),
  MockSpec<AddProduct>(),
  MockSpec<UpdateProduct>(),
  MockSpec<DeleteProduct>(),
])
import 'product_bloc_test.mocks.dart';

void main() {
  late ProductBloc bloc;
  late MockGetProducts mockGetProducts;
  late MockAddProduct mockAddProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late List<Product> testProducts;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockAddProduct = MockAddProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    bloc = ProductBloc(
      getProducts: mockGetProducts,
      addProduct: mockAddProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
    );
    testProducts = [
      const Product(id: 1, name: 'Test Product 1', price: 99.99, description: 'Description 1'),
      const Product(id: 2, name: 'Test Product 2', price: 149.99, description: 'Description 2'),
    ];

    // Default stub for mockGetProducts
    when(mockGetProducts(any)).thenAnswer((_) async => testProducts);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be ProductInitial', () {
    expect(bloc.state, equals(ProductInitial()));
  });

  group('GetProductsEvent', () {
    test('should emit [ProductLoading, ProductsLoaded] when data is gotten successfully',
        () async {
      // Assert later
      final expected = [
        ProductLoading(),
        ProductsLoaded(testProducts),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetProductsEvent());
    });

    test('should emit [ProductLoading, ProductError] when getting data fails',
        () async {
      // Arrange
      when(mockGetProducts(any)).thenThrow(Exception('Failed to get products'));

      // Assert later
      final expected = [
        ProductLoading(),
        const ProductError('Exception: Failed to get products'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(GetProductsEvent());
    });
  });

  group('AddProductEvent', () {
    const newProduct = Product(
      id: 3,
      name: 'New Product',
      price: 199.99,
      description: 'New Description',
    );

    test('should emit [ProductLoading, ProductsLoaded] when adding product succeeds',
        () async {
      // Arrange
      when(mockAddProduct(any)).thenAnswer((_) async => true);
      when(mockGetProducts(any)).thenAnswer((_) async => [...testProducts, newProduct]);

      // Assert later
      final expected = [
        ProductLoading(),
        ProductsLoaded([...testProducts, newProduct]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const AddProductEvent(newProduct));
    });
  });

  group('UpdateProductEvent', () {
    const updatedProduct = Product(
      id: 1,
      name: 'Updated Product',
      price: 299.99,
      description: 'Updated Description',
    );

    test('should emit [ProductLoading, ProductsLoaded] when updating product succeeds',
        () async {
      // Arrange
      when(mockUpdateProduct(any)).thenAnswer((_) async => true);
      when(mockGetProducts(any)).thenAnswer((_) async => [updatedProduct, testProducts[1]]);

      // Assert later
      final expected = [
        ProductLoading(),
        ProductsLoaded([updatedProduct, testProducts[1]]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const UpdateProductEvent(updatedProduct));
    });
  });

  group('DeleteProductEvent', () {
    test('should emit [ProductLoading, ProductsLoaded] when deleting product succeeds',
        () async {
      // Arrange
      when(mockDeleteProduct(any)).thenAnswer((_) async => true);
      when(mockGetProducts(any)).thenAnswer((_) async => [testProducts[1]]);

      // Assert later
      final expected = [
        ProductLoading(),
        ProductsLoaded([testProducts[1]]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const DeleteProductEvent(1));
    });
  });
} 