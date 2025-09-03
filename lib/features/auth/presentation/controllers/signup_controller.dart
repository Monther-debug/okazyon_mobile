import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupFormState {
  final String username;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToTerms;

  const SignupFormState({
    this.username = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.agreeToTerms = false,
  });

  SignupFormState copyWith({
    String? username,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeToTerms,
  }) {
    return SignupFormState(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
    );
  }
}

class SignupFormController extends StateNotifier<SignupFormState> {
  SignupFormController() : super(const SignupFormState());

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }

  void toggleAgreeToTerms(bool? value) {
    state = state.copyWith(agreeToTerms: value ?? false);
  }

  void reset() {
    state = const SignupFormState();
  }

  bool isFormValid() {
    return state.username.isNotEmpty &&
        state.phone.isNotEmpty &&
        state.password.isNotEmpty &&
        state.confirmPassword.isNotEmpty &&
        state.password == state.confirmPassword &&
        state.password.length >= 6 &&
        state.agreeToTerms;
  }
}

// Signup Form Provider
final signupFormControllerProvider =
    StateNotifierProvider<SignupFormController, SignupFormState>(
      (ref) => SignupFormController(),
    );

// Text Controllers Provider
final signupTextControllersProvider = Provider((ref) {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ref.onDispose(() {
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  });

  return {
    'username': usernameController,
    'phone': phoneController,
    'password': passwordController,
    'confirmPassword': confirmPasswordController,
  };
});
