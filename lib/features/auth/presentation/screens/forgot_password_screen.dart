import 'package:flutter/material.dart';
import 'package:okazyon_mobile/core/constants/app_colors.dart';
import 'package:okazyon_mobile/core/constants/ui_constants.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/core/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Reset Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: UiConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 60),
              const Icon(
                Icons.lock_outline,
                color: AppColors.primary,
                size: 70,
              ),
              const SizedBox(height: 30),
              const Text(
                'Forgot Your Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "No worries! Enter your phone number below and we'll send you a code to reset it.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 40),
              const CustomTextField(
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                hintText: 'Enter your registered phone number',
                prefixIcon: Icons.phone_outlined,
              ),
              const SizedBox(height: UiConstants.formSpacing),
              PrimaryButton(
                onPressed: () {
                },
                text: 'Send Reset Code',
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remember your password?',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
