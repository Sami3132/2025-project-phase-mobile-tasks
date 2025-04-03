import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final dioClient = DioClient(baseUrl: 'https://g5-flutter-learning-path-be.onrender.com/api/v2');
    final authRemoteDataSource = AuthRemoteDataSource(dioClient);
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final signInUseCase = SignIn(authRepository);
    final signUpUseCase = SignUp(authRepository);

    return BlocProvider(
      create: (context) => AuthBloc(
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
        authRepository: authRepository,
      )..add(CheckAuthStatusEvent()),
      child: MaterialApp(
        title: 'ECOM',
        theme: ThemeData(
          primaryColor: const Color(0xFF3F51F3),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3F51F3),
            primary: const Color(0xFF3F51F3),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
