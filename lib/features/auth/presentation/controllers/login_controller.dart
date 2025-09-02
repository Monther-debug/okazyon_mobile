import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Form State
class LoginFormState {
  final String email;
  final String password;
  final bool obscurePassword;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

// Login Form Controller
class LoginFormController extends StateNotifier<LoginFormState> {
  LoginFormController() : super(const LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void reset() {
    state = const LoginFormState();
  }

  bool isFormValid() {
    return state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.password.length >= 6;
  }
}

// Login Form Provider
final loginFormControllerProvider =
    StateNotifierProvider<LoginFormController, LoginFormState>(
      (ref) => LoginFormController(),
    );

// Text Controllers Provider
final loginTextControllersProvider = Provider((ref) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ref.onDispose(() {
    emailController.dispose();
    passwordController.dispose();
  });

  return {'email': emailController, 'password': passwordController};
});
