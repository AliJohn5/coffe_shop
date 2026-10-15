import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../../../core/storage/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._tokenStorage,
  });

  @override
  Future<User> signIn({required String email, required String password}) async {
    final response = await _remoteDataSource.signIn(
      email: email,
      password: password,
    );

    await _saveTokens(response);

    final userJson = response['user'] as Map<String, dynamic>;
    return UserModel.fromJson(userJson).toEntity();
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );

    await _saveTokens(response);

    final userJson = response['user'] as Map<String, dynamic>;
    return UserModel.fromJson(userJson).toEntity();
  }

  @override
  Future<User?> getCurrentUser() async {
    final accessToken = await _tokenStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }

    try {
      final response = await _remoteDataSource.getCurrentUser();
      return UserModel.fromJson(response).toEntity();
    } catch (_) {
      // Don't clear tokens for every error: a network failure
      // doesn't necessarily mean the session is invalid.
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
    await _tokenStorage.clear();
  }

  Future<void> _saveTokens(Map<String, dynamic> response) async {
    final accessToken = response['access'] as String?;
    final refreshToken = response['refresh'] as String?;

    if (accessToken == null || accessToken.isEmpty) {
      throw const FormatException(
        'Authentication response did not contain an access token.',
      );
    }

    await _tokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> refreshToken() async {
    final res = await _remoteDataSource.refreshToken();
    final accessToken = res['access'] as String?;
    final refreshToken = res['refresh'] as String?;
    await _tokenStorage.saveTokens(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken,
    );
  }
}
