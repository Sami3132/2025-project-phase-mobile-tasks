import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

// ignore: constant_identifier_names
const CACHED_PRODUCTS_KEY = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getProducts() async {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS_KEY);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonList = products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(jsonList);
    final success = await sharedPreferences.setString(CACHED_PRODUCTS_KEY, jsonString);
    if (!success) {
      throw CacheException();
    }
  }
} 