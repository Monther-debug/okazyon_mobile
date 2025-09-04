import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
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
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(next.error!)));
        ref.read(authControllerProvider.notifier).clearError();
      }

      if (next.isAuthenticated && !(previous?.isAuthenticated ?? false)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)?.loginSuccessful ??
                    'Login Successful',
              ),
              backgroundColor: Colors.green,
            ),
          );
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
                Text(
                  AppLocalizations.of(context)?.appTitle ?? 'Okazyon',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(width: 40, height: 4, color: Colors.red),
                SizedBox(height: AppSizes.screenHeight(context) * 0.1),
                CustomTextField(
                  labelText:
                      AppLocalizations.of(context)?.phoneNumber ?? 'Phone',
                  hintText:
                      AppLocalizations.of(context)?.enterPhone ?? 'Enter phone',
                  controller: controllers['phone']!,
                  validator: (value) => CustomValidator.phone(value, context),
                  suffixIcon: Iconsax.mobile,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText:
                      AppLocalizations.of(context)?.password ?? 'Password',
                  hintText:
                      AppLocalizations.of(context)?.enterPassword ??
                      'Enter password',
                  controller: controllers['password']!,
                  validator: (value) => CustomValidator.password(value, context),
                  suffixIcon: Iconsax.lock,
                  obscureText: loginFormState.obscurePassword,
                  prefixIcon:
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
                    onPressed:
                        authState.isLoading
                            ? null
                            : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                    child: Text(
                      AppLocalizations.of(context)?.forgotPassword ??
                          'Forgot Password?',
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text:
                      authState.isLoading
                          ? AppLocalizations.of(context)?.loggingIn ??
                              'Logging In...'
                          : AppLocalizations.of(context)?.login ?? 'Login',
                  onPressed:
                      authState.isLoading
                          ? null
                          : () {
                            if (formKey.currentState?.validate() ?? false) {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .login(
                                    phone: controllers['phone']!.text,
                                    password: controllers['password']!.text,
                                  );
                            }
                          },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.dontHaveAccount ??
                          "Don't have an account?",
                    ),
                    TextButton(
                      onPressed:
                          authState.isLoading
                              ? null
                              : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                      child: Text(
                        AppLocalizations.of(context)?.signUp ?? 'Sign Up',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Text(
                  AppLocalizations.of(context)?.orContinueWith ??
                      'Or continue with',
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                GoogleButton(
                  onPressed:
                      authState.isLoading
                          ? null
                          : () {
                            ref
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
