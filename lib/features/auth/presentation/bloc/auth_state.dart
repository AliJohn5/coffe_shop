import '../../domain/entities/user.dart';

enum AuthStatus { initial, checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final bool isSubmitting;

  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.isSubmitting = false,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    bool clearUser = false,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
