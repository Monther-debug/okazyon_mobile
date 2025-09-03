import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Login Form State
class LoginFormState {
  final String phone;
  final String password;
  final bool obscurePassword;

  const LoginFormState({
    this.phone = '',
    this.password = '',
    this.obscurePassword = true,
  });

  LoginFormState copyWith({
    String? phone,
    String? password,
    bool? obscurePassword,
  }) {
    return LoginFormState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

// Login Form Controller
class LoginFormController extends StateNotifier<LoginFormState> {
  LoginFormController() : super(const LoginFormState());

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
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
    return state.phone.isNotEmpty &&
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
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  ref.onDispose(() {
    phoneController.dispose();
    passwordController.dispose();
  });

  return {'phone': phoneController, 'password': passwordController};
});
