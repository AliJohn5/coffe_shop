import 'package:coffe_shop/features/auth/domain/usecases/get_current_user.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_in.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_out.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this._signIn,
    required this._signUp,
    required this._signOut,
    required this._getCurrentUser,
  }) : super(const AuthState());

  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  Future<void> restoreSession() async {
    emit(state.copyWith(status: AuthStatus.checking, clearError: true));

    try {
      final user = await _getCurrentUser();

      if (isClosed) return;

      emit(
        AuthState(
          status: user == null
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          user: user,
        ),
      );
    } catch (_) {
      if (isClosed) return;

      emit(const AuthState(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    if (state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final user = await _signIn(email: email.trim(), password: password);

      if (isClosed) return;

      emit(AuthState(status: AuthStatus.authenticated, user: user));
    } catch (error) {
      if (isClosed) return;

      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Unable to sign in. Please try again.',
        ),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final user = await _signUp(
        name: name.trim(),
        email: email.trim(),
        password: password,
      );

      if (isClosed) return;

      emit(AuthState(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      if (isClosed) return;
      debugPrint('Sign up error: $e'); // Log the error for debugging
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Unable to create your account. Please try again.',
        ),
      );
    }
  }

  Future<void> signOut() async {
    
    await _signOut();

    if (isClosed) return;

    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
