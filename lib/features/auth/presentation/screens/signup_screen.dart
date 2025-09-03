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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          SnackBar(
            content: Text(AppLocalizations.of(context)!.accountCreatedSuccessfully),
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
                  AppLocalizations.of(context)!.createYourAccount,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.joinOkazyonTagline,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.05),
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.username,
                  hintText: AppLocalizations.of(context)!.chooseUsername,
                  controller: controllers['username']!,
                  validator: CustomValidator.username,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  hintText: AppLocalizations.of(context)!.enterPhone,
                  controller: controllers['phone']!,
                  validator: CustomValidator.phone,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: AppLocalizations.of(context)!.password,
                  hintText: AppLocalizations.of(context)!.createStrongPassword,
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
                  labelText: AppLocalizations.of(context)!.confirmPassword,
                  hintText: AppLocalizations.of(context)!.enterPasswordAgain,
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
                            TextSpan(text: AppLocalizations.of(context)!.iAgreeToThe),
                            TextSpan(
                              text: AppLocalizations.of(context)!.termsOfService,
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(text: AppLocalizations.of(context)!.and),
                            TextSpan(
                              text: AppLocalizations.of(context)!.privacyPolicy,
                              style: const TextStyle(color: AppColors.primary),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(text: AppLocalizations.of(context)!.dot),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text: authState.isLoading
                      ? AppLocalizations.of(context)!.creatingAccount
                      : AppLocalizations.of(context)!.signUpCta,
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
                    Text(AppLocalizations.of(context)!.alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
