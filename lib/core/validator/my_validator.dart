import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ValidatorUtils {
  static String? validateName(String? name, BuildContext context) {
    if (name == null || name.trim().isEmpty) {
      return AppLocalizations.of(context)!.nameRequired;
    }
    if (!RegExp(r'^[\u0621-\u064A\u0660-\u0669A-Za-z ]{3,}$').hasMatch(name)) {
      return AppLocalizations.of(context)!.nameRequired;
    }
    return null;
  }
  static String? validateEmail(String? email, BuildContext context) {
    if (email == null || email
        .trim()
        .isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(
        email)) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? password, BuildContext context) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }
    if (!RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*)(_+؟/\\|]).{8,}$')
        .hasMatch(password)) {
      return AppLocalizations.of(context)!.invalidPasswordDetails;
          return null;
    }
    return null;
  }

  static String? validateConfirmPassword(String? password,
      BuildContext context,
      String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppLocalizations.of(context)!.confirmPasswordRequired;
    }
    if (password != confirmPassword) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validatePhone(String? phone, BuildContext context) {
    if (phone == null || phone
        .trim()
        .isEmpty) {
      return AppLocalizations.of(context)!.phoneNumber;
    }
    if (!RegExp(r'^(?:\+20|0)(10|11|12|15)\d{8}$').hasMatch(phone)) {
      return AppLocalizations.of(context)!.invalidPhone;
    }
    return null;
  }
}