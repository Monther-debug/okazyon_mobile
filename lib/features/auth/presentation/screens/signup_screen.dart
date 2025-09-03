import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/utils/validators.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:okazyon_mobile/features/auth/presentation/controllers/signup_controller.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final signupFormState = ref.watch(signupFormControllerProvider);
    final controllers = ref.watch(signupTextControllersProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
        ref.read(authControllerProvider.notifier).clearError();
      }

      if (next.isAuthenticated) {
        // Navigate to home screen or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.screenHeight(context) * 0.05),
                const Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join Okazyon and discover amazing deals',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.05),
                CustomTextField(
                  labelText: 'Username',
                  hintText: 'Choose a username',
                  controller: controllers['username']!,
                  validator: CustomValidator.username,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: controllers['phone']!,
                  validator: CustomValidator.phone,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Create a strong password',
                  controller: controllers['password']!,
                  validator: CustomValidator.password,
                  obscureText: signupFormState.obscurePassword,
                  suffixIcon:
                      signupFormState.obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  onSuffixIconPressed: () {
                    ref
                        .read(signupFormControllerProvider.notifier)
                        .togglePasswordVisibility();
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your password again',
                  controller: controllers['confirmPassword']!,
                  validator:
                      (value) => CustomValidator.confirmPassword(
                        value,
                        controllers['password']!.text,
                      ),
                  obscureText: signupFormState.obscureConfirmPassword,
                  suffixIcon:
                      signupFormState.obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  onSuffixIconPressed: () {
                    ref
                        .read(signupFormControllerProvider.notifier)
                        .toggleConfirmPasswordVisibility();
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  children: [
                    Checkbox(
                      value: signupFormState.agreeToTerms,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        ref
                            .read(signupFormControllerProvider.notifier)
                            .toggleAgreeToTerms(value);
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text: authState.isLoading ? 'Creating Account...' : 'Sign up',
                  onPressed:
                      authState.isLoading
                          ? () {}
                          : () async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .signup(
                                    username: controllers['username']!.text,
                                    phone: controllers['phone']!.text,
                                    password: controllers['password']!.text,
                                    confirmPassword:
                                        controllers['confirmPassword']!.text,
                                    agreeToTerms: signupFormState.agreeToTerms,
                                  );
                            }
                          },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
