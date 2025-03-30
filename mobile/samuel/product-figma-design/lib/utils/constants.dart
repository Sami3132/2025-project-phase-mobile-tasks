import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  static const String appName = 'Shoe Store';
  static const String dateFormat = 'MMMM d, yyyy';
  
  /// Colors
  static const Color primaryColor = Color(0xFF3F51F3);
  static const Color secondaryColor = Color(0xFF636363);
  static const Color tertiaryColor = Color(0xFFAAAAAA);
  static const Color backgroundColor = Colors.white;
  static const Color shadowColor = Color(0xFFCCCCCC);
  static const Color starColor = Color(0xFFFFD700);
  
  /// Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Syne',
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: secondaryColor,
    fontFamily: 'Sora',
  );
  
  static const TextStyle priceStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontFamily: 'Poppins',
  );

  static const TextStyle headerStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'Syne',
  );

  static const TextStyle dateStyle = TextStyle(
    fontSize: 10,
    fontFamily: 'Sora',
  );

  static const TextStyle descriptionStyle = TextStyle(
    fontSize: 13,
    color: Color(0xFF3E3E3E),
    fontFamily: 'Poppins',
  );
  
  /// Dimensions
  static const double defaultPadding = 20.0;
  static const double defaultRadius = 10.0;
  static const double defaultIconSize = 25.0;
  
  /// Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  /// API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String productsEndpoint = '/products';
  
  /// Error Messages
  static const String errorLoadingProducts = 'Failed to load products';
  static const String errorAddingProduct = 'Failed to add product';
  static const String errorUpdatingProduct = 'Failed to update product';
  static const String errorDeletingProduct = 'Failed to delete product';
  
  /// Success Messages
  static const String successAddingProduct = 'Product added successfully';
  static const String successUpdatingProduct = 'Product updated successfully';
  static const String successDeletingProduct = 'Product deleted successfully';
} 