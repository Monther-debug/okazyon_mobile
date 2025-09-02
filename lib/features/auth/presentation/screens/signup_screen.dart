import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/utils/validators.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/login_screen.dart';

final obscurePasswordProvider = StateProvider<bool>((ref) => true);
final obscureConfirmPasswordProvider = StateProvider<bool>((ref) => true);
final agreeToTermsProvider = StateProvider<bool>((ref) => false);

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final obscurePassword = ref.watch(obscurePasswordProvider);
    final obscureConfirmPassword = ref.watch(obscureConfirmPasswordProvider);
    final agreeToTerms = ref.watch(agreeToTermsProvider);

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
                  controller: usernameController,
                  validator: CustomValidator.username,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Email Address',
                  hintText: 'you@example.com',
                  controller: emailController,
                  validator: CustomValidator.email,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Create a strong password',
                  controller: passwordController,
                  validator: CustomValidator.password,
                  obscureText: obscurePassword,
                  suffixIcon:
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  onSuffixIconPressed: () {
                    ref.read(obscurePasswordProvider.notifier).state =
                        !obscurePassword;
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your password again',
                  controller: confirmPasswordController,
                  validator:
                      (value) => CustomValidator.confirmPassword(
                        value,
                        passwordController.text,
                      ),
                  obscureText: obscureConfirmPassword,
                  suffixIcon:
                      obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  onSuffixIconPressed: () {
                    ref.read(obscureConfirmPasswordProvider.notifier).state =
                        !obscureConfirmPassword;
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        ref.read(agreeToTermsProvider.notifier).state =
                            value ?? false;
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
                  text: 'Sign up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (!agreeToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please agree to the terms and conditions',
                            ),
                          ),
                        );
                        return;
                      }
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
