import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomValidator {
  static String? email(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterEmail;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return AppLocalizations.of(context)!.pleaseEnterValidEmail;
    }
    return null;
  }

  static String? password(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterPassword;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinLength;
    }
    return null;
  }

  static String? username(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterUsername;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseConfirmPassword;
    }
    if (value != password) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  static String? phone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterPhone;
    }
    String phoneNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    if (phoneNumber.length < 10) {
      return AppLocalizations.of(context)!.pleaseEnterValidPhone;
    }
    return null;
  }
}
