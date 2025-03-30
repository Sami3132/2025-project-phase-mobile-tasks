/// A model class representing a product in the application.
class Product {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String category;
  final double rating;
  final String description;

  const Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.rating,
    required this.description,
  });

  /// Creates a Product from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
    );
  }

  /// Converts the Product to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'rating': rating,
      'description': description,
    };
  }

  /// Creates a copy of the Product with optional parameter updates.
  Product copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
    String? category,
    double? rating,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      description: description ?? this.description,
    );
  }
} 