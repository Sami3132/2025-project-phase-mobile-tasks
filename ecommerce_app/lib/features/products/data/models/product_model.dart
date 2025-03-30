import '../../domain/entities/product.dart';

class ProductModel extends Product {
  final DateTime lastModified;

  ProductModel({
    required int id,
    required String name,
    required double price,
    required String description,
    DateTime? lastModified,
  }) : lastModified = lastModified ?? DateTime.now(),
       super(
          id: id,
          name: name,
          price: price,
          description: description,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      lastModified: json['lastModified'] != null 
          ? DateTime.parse(json['lastModified'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'lastModified': lastModified.toIso8601String(),
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      lastModified: DateTime.now(),
    );
  }
} 