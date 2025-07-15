import 'package:flutter/material.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import '../../../main.dart'; // where navigatorKey is defined

class GlobalLocalization {
  static BuildContext? get context => navigatorKey.currentContext;

  static String get noInternet =>
      AppLocalizations.of(context!)!.noInternetConnection;
  static String get failedToSendPasswordResetEmail =>
      AppLocalizations.of(context!)!.failedToSendPasswordResetEmail;

  static String get passwordResetEmailSentSuccessfully =>
      AppLocalizations.of(context!)!.passwordResetEmailSentSuccessfully;

  static String get failedToLoadPopularProducts =>
      AppLocalizations.of(context!)!.failedToLoadPopularProducts;
  static String get failedToLoadRecommendedBrands =>
      AppLocalizations.of(context!)!.failedToLoadRecommendedBrands;



// Add more as needed
}
