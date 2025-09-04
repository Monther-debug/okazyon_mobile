import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
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

    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
        ref.read(authControllerProvider.notifier).clearError();
      }
      if (next.isAuthenticated && !((prev?.isAuthenticated) ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.accountCreatedSuccessfully ??
                  'Account created successfully',
            ),
            backgroundColor: Colors.green,
          ),
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
                Text(
                  AppLocalizations.of(context)?.createYourAccount ??
                      'Create Your Account',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)?.joinOkazyonTagline ??
                      'Join Okazyon and discover amazing deals',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.05),
                CustomTextField(
                  suffixIcon: Iconsax.user,
                  labelText:
                      AppLocalizations.of(context)?.username ?? 'Username',
                  hintText:
                      AppLocalizations.of(context)?.chooseUsername ??
                      'Choose a username',
                  controller: controllers['username']!,
                  validator: (value) => CustomValidator.username(value, context),
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  suffixIcon: Iconsax.mobile,
                  labelText:
                      AppLocalizations.of(context)?.phoneNumber ?? 'Phone',
                  hintText:
                      AppLocalizations.of(context)?.enterPhone ??
                      'Enter phone number',
                  controller: controllers['phone']!,
                  validator: (value) => CustomValidator.phone(value, context),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  suffixIcon: Iconsax.lock,
                  labelText:
                      AppLocalizations.of(context)?.password ?? 'Password',
                  hintText:
                      AppLocalizations.of(context)?.createStrongPassword ??
                      'Create a strong password',
                  controller: controllers['password']!,
                  validator: (value) => CustomValidator.password(value, context),
                  obscureText: signupFormState.obscurePassword,
                  prefixIcon:
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
                  suffixIcon: Iconsax.lock,
                  labelText:
                      AppLocalizations.of(context)?.confirmPassword ??
                      'Confirm Password',
                  hintText:
                      AppLocalizations.of(context)?.enterPasswordAgain ??
                      'Enter your password again',
                  controller: controllers['confirmPassword']!,
                  validator:
                      (value) => CustomValidator.confirmPassword(
                        value,
                        controllers['password']!.text,
                        context,
                      ),
                  obscureText: signupFormState.obscureConfirmPassword,
                  prefixIcon:
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
                      onChanged:
                          authState.isLoading
                              ? null
                              : (value) {
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
                            TextSpan(
                              text:
                                  AppLocalizations.of(context)?.iAgreeToThe ??
                                  'I agree to the ',
                            ),
                            TextSpan(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )?.termsOfService ??
                                  'Terms of Service',
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)?.and ?? 'and ',
                            ),
                            TextSpan(
                              text:
                                  AppLocalizations.of(context)?.privacyPolicy ??
                                  'Privacy Policy',
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)?.dot ?? '.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text:
                      authState.isLoading
                          ? (AppLocalizations.of(context)?.creatingAccount ??
                              'Creating account...')
                          : (AppLocalizations.of(context)?.signUpCta ??
                              'Sign up'),
                  onPressed:
                      authState.isLoading
                          ? null
                          : () {
                            if (!signupFormState.agreeToTerms) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'You must agree to the Terms & Privacy Policy',
                                  ),
                                ),
                              );
                              return;
                            }
                            if (formKey.currentState?.validate() ?? false) {
                              ref
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
                    Text(
                      AppLocalizations.of(context)?.alreadyHaveAccount ??
                          'Already have an account?',
                    ),
                    TextButton(
                      onPressed:
                          authState.isLoading
                              ? null
                              : () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                      child: Text(
                        AppLocalizations.of(context)?.login ?? 'Login',
                        style: const TextStyle(color: AppColors.primary),
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
