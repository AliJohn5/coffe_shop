import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<User> signIn({required String email, required String password});

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<User?> getCurrentUser();

  Future<void> signOut();

  Future<void> refreshToken();
}
