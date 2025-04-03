import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSourceBase {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSource implements AuthRemoteDataSourceBase {
  final DioClient dioClient;

  AuthRemoteDataSource(this.dioClient);

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await dioClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final user = UserModel.fromJson(response.data);
      // Add token to future requests
      if (user.token != null) {
        await dioClient.addAuthToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      }
      throw Exception(e.message ?? 'Failed to sign in');
    }
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    try {
      final response = await dioClient.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final user = UserModel.fromJson(response.data);
      // Add token to future requests if it's included in the response
      if (user.token != null) {
        await dioClient.addAuthToken(user.token!);
      } else {
        // If token is not included, sign in to get it
        return await signIn(email, password);
      }
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Email already exists');
      }
      throw Exception(e.message ?? 'Failed to sign up');
    }
  }

  @override
  Future<void> signOut() async {
    await dioClient.removeAuthToken();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await dioClient.get('/users/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return null;
      }
      throw Exception(e.message ?? 'Failed to get user profile');
    }
  }
} 