import 'package:http/http.dart' as http;
import '../../features/products/data/datasources/product_remote_data_source.dart';

final sl = ServiceLocator();

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<String, dynamic> _singletons = {};

  Future<void> init() async {
    // External
    _singletons['httpClient'] = http.Client();

    // Data sources
    _singletons['productRemoteDataSource'] = ProductRemoteDataSourceImpl(
      client: _singletons['httpClient'],
    );
  }

  T registerLazySingleton<T extends Object>(T Function() factory) {
    final key = T.toString();
    if (!_singletons.containsKey(key)) {
      _singletons[key] = factory();
    }
    return _singletons[key] as T;
  }

  T get<T extends Object>() {
    final key = T.toString();
    if (!_singletons.containsKey(key)) {
      throw Exception('No singleton registered for type $T');
    }
    return _singletons[key] as T;
  }
} 