import 'package:coffe_shop/core/network/api_client.dart';

//TODO: Remove this flag when the backend is ready
const bool isTestingWithoutBackend = true;

abstract interface class AuthRemoteDataSource {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> getCurrentUser();

  Future<Map<String, dynamic>> signOut();

  Future<Map<String, dynamic>> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    if (isTestingWithoutBackend) {
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      return {
        'access': 'dummy_access_token',
        'refresh': 'dummy_refresh_token',
        'user': {"name": "John Doe", "id": 1, "email": email},
      };
    }

    final response = await apiClient.instance.post(
      '/auth/login/',
      data: {'email': email, 'password': password},
    );

    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (isTestingWithoutBackend) {
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      return {
        'access': 'dummy_access_token',
        'refresh': 'dummy_refresh_token',
        'user': {"name": "John Doe", "id": 1, "email": email},
      };
    }

    final response = await apiClient.instance.post(
      '/auth/register/',
      data: {'name': name, 'email': email, 'password': password},
    );

    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    if (isTestingWithoutBackend) {
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      return {"name": "John Doe", "id": 1, "email": "example@gmail.com"};
    }

    final response = await apiClient.instance.get('/auth/me/');

    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> signOut() async {
    if (isTestingWithoutBackend) {
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      return {"message": "Successfully signed out"};
    }

    final response = await apiClient.instance.get('/auth/sign-out/');

    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> refreshToken() async {
    if (isTestingWithoutBackend) {
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      return {
        'access': 'dummy_access_token',
        'refresh': 'dummy_refresh_token',
        "name": "John Doe",
        "id": 1,
        "email": "example@gmail.com",
      };
    }
    final response = await apiClient.instance.get('/auth/refresh-token/');

    return Map<String, dynamic>.from(response.data as Map);
  }
}
