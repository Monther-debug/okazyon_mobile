import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/image_strings.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';
import 'package:okazyon_mobile/features/auth/presentation/controllers/otp_controller.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends ConsumerWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpControllerProvider);
    final otpController = ref.read(otpControllerProvider.notifier);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSizes.screenHeight(context) * 0.25,
                child: SvgPicture.asset(AppImageStrings.otp),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                'Enter Verification Code',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.widgetSpacing),
              Text(
                'We\'ve sent a 6-digit code to $phone',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (s) {
                  // return s == '2222' ? null : 'Pin is incorrect';
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => otpController.verifyOtp(pin, context),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              CustomButton(
                text: otpState.isLoading 
                    ? AppLocalizations.of(context)!.verifying 
                    : AppLocalizations.of(context)!.verify,
                onPressed:
                    otpState.isLoading
                        ? null
                        : () {
                          // The onCompleted callback handles verification
                        },
              ),
              const SizedBox(height: AppSizes.widgetSpacing),
              otpState.isTimerActive
                  ? Text(
                    AppLocalizations.of(context)!.resendCodeIn(otpState.timerValue),
                    style: const TextStyle(color: AppColors.textSecondary),
                  )
                  : TextButton(
                    onPressed: () => otpController.resendOtp(phone),
                    child: Text(
                      AppLocalizations.of(context)!.resendCode,
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
