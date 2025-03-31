import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final SharedPreferences sharedPreferences;
  final ProductRemoteDataSource remoteDataSource;
  static const String _productsKey = 'products';

  ProductRepositoryImpl({
    required this.sharedPreferences,
    required this.remoteDataSource,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      // Try to get products from remote source first
      final remoteProducts = await remoteDataSource.getProducts();
      
      // Cache the products locally
      await _cacheProducts(remoteProducts);
      
      return remoteProducts;
    } catch (e) {
      // If remote fetch fails, try to get from local cache
      final productsJson = sharedPreferences.getStringList(_productsKey) ?? [];
      if (productsJson.isEmpty) return [];

      final products = productsJson.map((json) {
        try {
          final Map<String, dynamic> decodedJson = jsonDecode(json) as Map<String, dynamic>;
          return ProductModel.fromJson(decodedJson);
        } catch (e) {
          return null;
        }
      }).whereType<Product>().toList();

      // Sort products by lastModified timestamp
      products.sort((a, b) {
        final aModel = a as ProductModel;
        final bModel = b as ProductModel;
        return bModel.lastModified.compareTo(aModel.lastModified);
      });

      return products;
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    try {
      // Try to get product from remote source first
      final remoteProduct = await remoteDataSource.getProductById(id.toString());
      return remoteProduct;
    } catch (e) {
      // If remote fetch fails, try to get from local cache
      final products = await getProducts();
      return products.firstWhere((product) => product.id == id);
    }
  }

  Future<void> _cacheProducts(List<Product> products) async {
    final productsJson = products.map((product) {
      final model = product as ProductModel;
      return jsonEncode(model.toJson());
    }).toList();
    await sharedPreferences.setStringList(_productsKey, productsJson);
  }

  @override
  Future<void> addProduct(Product product) async {
    try {
      final products = await getProducts();
      final productModel = ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        description: product.description,
      );
      products.add(productModel);
      await _saveProducts(products);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      final products = await getProducts();
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = ProductModel(
          id: product.id,
          name: product.name,
          price: product.price,
          description: product.description,
        );
        await _saveProducts(products);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      final products = await getProducts();
      products.removeWhere((product) => product.id == id);
      await _saveProducts(products);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveProducts(List<Product> products) async {
    try {
      final productsJson = products
          .map((product) => jsonEncode((product as ProductModel).toJson()))
          .toList();
      await sharedPreferences.setStringList(_productsKey, productsJson);
    } catch (e) {
      rethrow;
    }
  }
} 