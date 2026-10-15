import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository _repository;

  const SignUp(this._repository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(name: name, email: email, password: password);
  }
}
