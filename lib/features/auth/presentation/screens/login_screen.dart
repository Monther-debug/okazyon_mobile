import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/utils/validators.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/core/widgets/google_button.dart';
import 'package:okazyon_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:okazyon_mobile/features/auth/presentation/controllers/login_controller.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final loginFormState = ref.watch(loginFormControllerProvider);
    final controllers = ref.watch(loginTextControllersProvider);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
        ref.read(authControllerProvider.notifier).clearError();
      }

      if (next.isAuthenticated) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful!')));
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.pagePadding,
            right: AppSizes.pagePadding,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSizes.screenHeight(context) * 0.1),
                const Text(
                  'Okazyon',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(width: 40, height: 4, color: Colors.red),
                SizedBox(height: AppSizes.screenHeight(context) * 0.1),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: controllers['phone']!,
                  validator: CustomValidator.phone,
                  suffixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: controllers['password']!,
                  validator: CustomValidator.password,
                  obscureText: loginFormState.obscurePassword,
                  suffixIcon:
                      loginFormState.obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  onSuffixIconPressed: () {
                    ref
                        .read(loginFormControllerProvider.notifier)
                        .togglePasswordVisibility();
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text: authState.isLoading ? 'Logging in...' : 'Login',
                  onPressed:
                      authState.isLoading
                          ? () {}
                          : () async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .login(
                                    controllers['phone']!.text,
                                    controllers['password']!.text,
                                  );
                            }
                          },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                const Text('Or continue with'),
                const SizedBox(height: AppSizes.widgetSpacing),
                GoogleButton(
                  onPressed:
                      authState.isLoading
                          ? () {}
                          : () async {
                            await ref
                                .read(authControllerProvider.notifier)
                                .loginWithGoogle();
                          },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
