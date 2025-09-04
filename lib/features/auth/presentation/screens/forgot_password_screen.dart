import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/widgets/custom_text_field.dart';
import 'package:okazyon_mobile/core/widgets/primary_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/otp_screen.dart';

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
        title: Text(AppLocalizations.of(context)!.resetPassword),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
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
              Text(
                AppLocalizations.of(context)!.forgotPassword,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.forgotHelp,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                keyboardType: TextInputType.phone,
                hintText: AppLocalizations.of(context)!.enterPhone,
                suffixIcon: Iconsax.mobile,
              ),
              const SizedBox(height: AppSizes.formSpacing),
              PrimaryButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtpScreen(phone: ''),
                    ),
                  );
                },
                text: AppLocalizations.of(context)!.sendResetCode,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.rememberPassword,
                    style: const TextStyle(color: AppColors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.backToLogin,
                      style: const TextStyle(
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
