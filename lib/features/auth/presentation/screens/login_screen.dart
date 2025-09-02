import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/utils/validators.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/core/widgets/google_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController,
                  validator: CustomValidator.email,
                  suffixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController,
                  validator: CustomValidator.password,
                  obscureText: true,
                  suffixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Handle login
                    }
                  },
                ),
                const SizedBox(height: AppSizes.widgetSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
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
                GoogleButton(onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
