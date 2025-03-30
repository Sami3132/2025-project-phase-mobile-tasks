import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/core/error/failures.dart';

void main() {
  group('Failure', () {
    test('ServerFailure should have correct message', () {
      const message = 'Server error occurred';
      const failure = ServerFailure(message);
      expect(failure.message, message);
    });

    test('CacheFailure should have correct message', () {
      const message = 'Cache error occurred';
      const failure = CacheFailure(message);
      expect(failure.message, message);
    });

    test('ValidationFailure should have correct message', () {
      const message = 'Validation error occurred';
      const failure = ValidationFailure(message);
      expect(failure.message, message);
    });

    test('should create a Failure with correct message', () {
      const failure = ServerFailure('Test error message');

      expect(failure.message, 'Test error message');
    });

    test('should be equal when messages are the same', () {
      const failure1 = ServerFailure('Test error message');
      const failure2 = ServerFailure('Test error message');

      expect(failure1, equals(failure2));
    });

    test('should not be equal when messages are different', () {
      const failure1 = ServerFailure('Test error message 1');
      const failure2 = ServerFailure('Test error message 2');

      expect(failure1, isNot(equals(failure2)));
    });

    test('should not be equal when types are different', () {
      const failure1 = ServerFailure('Test error message');
      const failure2 = CacheFailure('Test error message');

      expect(failure1, isNot(equals(failure2)));
    });
  });
} 