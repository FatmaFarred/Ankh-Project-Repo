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

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterYourName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterYourPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Confirm Password'**
  String get enterYourConfirmPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number '**
  String get phoneNumber;

  /// No description provided for @enterYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone'**
  String get enterYourPhone;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get log;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get signIn;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @enterYourEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email or Phone Numbar '**
  String get enterYourEmailOrPhone;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @registerSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the following information to create a new account. Get started now!'**
  String get registerSubTitle;

  /// No description provided for @signInSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the following information to access your account!'**
  String get signInSubTitle;

  /// No description provided for @yourEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone Numbar  '**
  String get yourEmailOrPhone;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code that we have sent to your email'**
  String get verifyEmailSubTitle;

  /// No description provided for @codeWasSentTo.
  ///
  /// In en, this message translates to:
  /// **'A code has been sent to your email'**
  String get codeWasSentTo;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'resend'**
  String get resendCode;

  /// No description provided for @n.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get n;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm;

  /// No description provided for @forgetPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to recover your password!'**
  String get forgetPasswordSubTitle;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set a New Password'**
  String get setNewPassword;

  /// No description provided for @setPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new password. Ensure it differs from previous ones for security'**
  String get setPasswordSubTitle;

  /// No description provided for @reEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get reEnterNewPassword;

  /// No description provided for @otpEmailSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your OTP which has been sent to your email'**
  String get otpEmailSubTitle;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password!'**
  String get forgotPasswordTitle;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'enter a valid password :'**
  String get invalidPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @upperCaesLetter.
  ///
  /// In en, this message translates to:
  /// **'- Must contain at least one uppercase letter'**
  String get upperCaesLetter;

  /// No description provided for @lowerCaesLetter.
  ///
  /// In en, this message translates to:
  /// **'- Must contain at least one lowercase letter'**
  String get lowerCaesLetter;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'- Must contain at least one digit'**
  String get number;

  /// No description provided for @specialCharacter.
  ///
  /// In en, this message translates to:
  /// **'- Must contain at least one special character'**
  String get specialCharacter;

  /// No description provided for @minLength.
  ///
  /// In en, this message translates to:
  /// **'- Must be at least 8 characters long'**
  String get minLength;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name'**
  String get invalidName;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'confirm password is required'**
  String get confirmPasswordRequired;

  /// No description provided for @invalidPasswordDetails.
  ///
  /// In en, this message translates to:
  /// **'Invalid password:\n- Must contain at least one uppercase letter\n- Must contain at least one lowercase letter\n- Must include at least one digit\n- Must have 1 special character'**
  String get invalidPasswordDetails;

  /// No description provided for @topBrands.
  ///
  /// In en, this message translates to:
  /// **'Top Brands'**
  String get topBrands;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @popularNewCars.
  ///
  /// In en, this message translates to:
  /// **'Popular New Cars'**
  String get popularNewCars;

  /// No description provided for @recommendedCars.
  ///
  /// In en, this message translates to:
  /// **'Recommended Cars'**
  String get recommendedCars;

  /// No description provided for @searchRequest.
  ///
  /// In en, this message translates to:
  /// **'Search Request'**
  String get searchRequest;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get myRequests;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'Support Team'**
  String get supportTeam;

  /// No description provided for @chatNow.
  ///
  /// In en, this message translates to:
  /// **'Chat Now'**
  String get chatNow;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @lastEdited.
  ///
  /// In en, this message translates to:
  /// **'Last Edited'**
  String get lastEdited;

  /// No description provided for @batteryCapacity.
  ///
  /// In en, this message translates to:
  /// **'Battery Capacity'**
  String get batteryCapacity;

  /// No description provided for @transmission.
  ///
  /// In en, this message translates to:
  /// **'Transmission'**
  String get transmission;

  /// No description provided for @horsepower.
  ///
  /// In en, this message translates to:
  /// **'Horsepower'**
  String get horsepower;

  /// No description provided for @engineType.
  ///
  /// In en, this message translates to:
  /// **'Engine Type'**
  String get engineType;

  /// No description provided for @whatAreYouLookingFor.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for?'**
  String get whatAreYouLookingFor;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @enterClientName.
  ///
  /// In en, this message translates to:
  /// **'Enter Client Name'**
  String get enterClientName;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get enterAddress;

  /// No description provided for @preferredDate.
  ///
  /// In en, this message translates to:
  /// **'Preferred Date'**
  String get preferredDate;

  /// No description provided for @datePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'MM/DD/YYYY'**
  String get datePlaceholder;

  /// No description provided for @preferredTime.
  ///
  /// In en, this message translates to:
  /// **'Preferred Time'**
  String get preferredTime;

  /// No description provided for @selectTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Select a time slot'**
  String get selectTimeSlot;

  /// No description provided for @requestInspection.
  ///
  /// In en, this message translates to:
  /// **'Request Inspection'**
  String get requestInspection;

  /// No description provided for @requestSummary.
  ///
  /// In en, this message translates to:
  /// **'Request Summary'**
  String get requestSummary;

  /// No description provided for @requestSummaryNote.
  ///
  /// In en, this message translates to:
  /// **'Please review the details below before submitting your inspection request.'**
  String get requestSummaryNote;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @clientInformation.
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInformation;

  /// No description provided for @inspectionSchedule.
  ///
  /// In en, this message translates to:
  /// **'Inspection Schedule'**
  String get inspectionSchedule;

  /// No description provided for @statusTracker.
  ///
  /// In en, this message translates to:
  /// **'Status Tracker'**
  String get statusTracker;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @delayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get delayed;

  /// No description provided for @notResponding.
  ///
  /// In en, this message translates to:
  /// **'Not Responding'**
  String get notResponding;

  /// No description provided for @requestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Request Submitted'**
  String get requestSubmitted;

  /// No description provided for @requestSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Request Submitted Successfully!'**
  String get requestSubmittedSuccessfully;

  /// No description provided for @requestSubmittedNote.
  ///
  /// In en, this message translates to:
  /// **'Your inspection request has been sent to our system. We’ll notify you once it’s processed. You can track the status of your request anytime.'**
  String get requestSubmittedNote;

  /// No description provided for @goToMyRequests.
  ///
  /// In en, this message translates to:
  /// **'Go to My Requests'**
  String get goToMyRequests;

  /// No description provided for @saveInfoForLater.
  ///
  /// In en, this message translates to:
  /// **'Save info for later'**
  String get saveInfoForLater;

  /// No description provided for @confirmRequest.
  ///
  /// In en, this message translates to:
  /// **'Confirm Request'**
  String get confirmRequest;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @currrentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get currrentStatus;

  /// No description provided for @productInfo.
  ///
  /// In en, this message translates to:
  /// **'Product information'**
  String get productInfo;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;
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
