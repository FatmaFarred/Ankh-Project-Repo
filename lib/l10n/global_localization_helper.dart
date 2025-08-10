import 'package:flutter/material.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import '../../../main.dart'; // where navigatorKey is defined

class GlobalLocalization {
  static BuildContext? get context => navigatorKey.currentContext;
  
  /// Static method to get localization from context
  static GlobalLocalization of(BuildContext context) {
    return GlobalLocalization();
  }

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
      
  // Properties needed for ProductRatingWidget
  String get productRating => "Product Rating";
  String get error => "Error";
  String get ok => "OK";
  String get login => AppLocalizations.of(context!)!.login;
  String get pleaseLoginFirst => "Please login first";
  String get enterYourRate => "Please enter your rating";
  String get submitRating => "Submit Rating";
  String get rateThisProduct => "Rate This Product";
  String get ratingComment => "Rating Comment";

// Add more as needed
}
