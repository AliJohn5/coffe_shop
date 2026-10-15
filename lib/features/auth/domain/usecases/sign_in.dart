import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _repository;

  const SignIn(this._repository);

  Future<User> call({required String email, required String password}) {
    return _repository.signIn(email: email, password: password);
  }
}
