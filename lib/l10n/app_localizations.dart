import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @onBoarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Everything You Need to Buy, Sell, and Manage in One App'**
  String get onBoarding1Title;

  /// No description provided for @onBoarding1SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect seamlessly with owners, marketers, and inspectors, all in one powerful platform.'**
  String get onBoarding1SubTitle;

  /// No description provided for @onBoarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Easily List Your Property or Car and Stay in Control'**
  String get onBoarding2Title;

  /// No description provided for @onBoarding2SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit listings, manage updates, and handle inspections effortlessly from your dashboard.'**
  String get onBoarding2SubTitle;

  /// No description provided for @onBoarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Professional Inspections to Ensure Listing Quality'**
  String get onBoarding3Title;

  /// No description provided for @onBoarding3SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Verified by trusted experts, every listing is thoroughly reviewed for buyer confidence.'**
  String get onBoarding3SubTitle;

  /// No description provided for @onBoarding4Title.
  ///
  /// In en, this message translates to:
  /// **'Shop Verified Listings and Make Confident Purchases'**
  String get onBoarding4Title;

  /// No description provided for @onBoarding4SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore only inspected and approved properties and cars no guesswork, just trust.'**
  String get onBoarding4SubTitle;

  /// No description provided for @welcomeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Ankh'**
  String get welcomeScreenTitle;

  /// No description provided for @welcomeScreenSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the app and explore trusted services, verified properties, and inspected motors all in one place.'**
  String get welcomeScreenSubTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @continueAsVisitor.
  ///
  /// In en, this message translates to:
  /// **'Continue as visitor'**
  String get continueAsVisitor;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @chooseRole.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get chooseRole;

  /// No description provided for @chooseRoleDescribe.
  ///
  /// In en, this message translates to:
  /// **'Choose the role that best describes you.'**
  String get chooseRoleDescribe;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @inspector.
  ///
  /// In en, this message translates to:
  /// **'Inspector'**
  String get inspector;

  /// No description provided for @inspectorDescription.
  ///
  /// In en, this message translates to:
  /// **'Inspect and verify properties or cars'**
  String get inspectorDescription;

  /// No description provided for @ownerDescription.
  ///
  /// In en, this message translates to:
  /// **'Property or business owner'**
  String get ownerDescription;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @clientDescription.
  ///
  /// In en, this message translates to:
  /// **'Looking for services '**
  String get clientDescription;

  /// No description provided for @cst.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get cst;

  /// No description provided for @cstDescription.
  ///
  /// In en, this message translates to:
  /// **'Support users and handle inquiries'**
  String get cstDescription;

  /// No description provided for @selectYourServiceRole.
  ///
  /// In en, this message translates to:
  /// **'Select Your Service Role'**
  String get selectYourServiceRole;

  /// No description provided for @selectYourServiceRoleDescribe.
  ///
  /// In en, this message translates to:
  /// **'Choose the role that best describe your work.'**
  String get selectYourServiceRoleDescribe;

  /// No description provided for @marketer.
  ///
  /// In en, this message translates to:
  /// **'Marketer'**
  String get marketer;

  /// No description provided for @marketerDescription.
  ///
  /// In en, this message translates to:
  /// **'Promote listings and grow visibility'**
  String get marketerDescription;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
