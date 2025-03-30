import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final SharedPreferences sharedPreferences;
  static const String _productsKey = 'products';

  ProductRepositoryImpl({required this.sharedPreferences});

  @override
  Future<List<Product>> getProducts() async {
    try {
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
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    final products = await getProducts();
    return products.firstWhere((product) => product.id == id);
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