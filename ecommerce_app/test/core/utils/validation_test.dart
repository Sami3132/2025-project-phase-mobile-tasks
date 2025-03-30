import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/core/utils/validation.dart';

void main() {
  group('Validation', () {
    group('validateName', () {
      test('should return null for valid name', () {
        expect(Validation.validateName('Valid Product Name'), isNull);
      });

      test('should return error message for empty name', () {
        expect(Validation.validateName(''), 'Name is required');
      });

      test('should return error message for null name', () {
        expect(Validation.validateName(null), 'Name is required');
      });

      test('should return error message for too short name', () {
        expect(Validation.validateName('ab'), 'Name must be at least 3 characters');
      });
    });

    group('validatePrice', () {
      test('should return null for valid price', () {
        expect(Validation.validatePrice('10.99'), isNull);
        expect(Validation.validatePrice('0.99'), isNull);
        expect(Validation.validatePrice('1000'), isNull);
      });

      test('should return error message for empty price', () {
        expect(Validation.validatePrice(''), 'Price is required');
      });

      test('should return error message for null price', () {
        expect(Validation.validatePrice(null), 'Price is required');
      });

      test('should return error message for invalid price format', () {
        expect(Validation.validatePrice('abc'), 'Please enter a valid number');
        expect(Validation.validatePrice('10.99.99'), 'Please enter a valid number');
      });

      test('should return error message for zero or negative price', () {
        expect(Validation.validatePrice('0'), 'Price must be greater than 0');
        expect(Validation.validatePrice('-10.99'), 'Price must be greater than 0');
      });
    });

    group('validateDescription', () {
      test('should return null for valid description', () {
        expect(Validation.validateDescription('Valid product description'), isNull);
      });

      test('should return error message for empty description', () {
        expect(Validation.validateDescription(''), 'Description is required');
      });

      test('should return error message for null description', () {
        expect(Validation.validateDescription(null), 'Description is required');
      });

      test('should return error message for too short description', () {
        expect(Validation.validateDescription('ab'), 'Description must be at least 10 characters');
      });
    });
  });
}
