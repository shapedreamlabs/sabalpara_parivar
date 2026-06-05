import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// No description provided for @connectWithOurSabalparaCommunity.
  ///
  /// In en, this message translates to:
  /// **'Connect With Our Sabalpara Community.'**
  String get connectWithOurSabalparaCommunity;

  /// No description provided for @onBoardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover members, explore businesses, and stay connected with the Sabalpara community in one place.'**
  String get onBoardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @signInYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign In Your Account'**
  String get signInYourAccount;

  /// No description provided for @welcomeBackPleaseSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Please sign in to continue.'**
  String get welcomeBackPleaseSignInToContinue;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get createYourAccount;

  /// No description provided for @joinTheCommunityAndStayConnect.
  ///
  /// In en, this message translates to:
  /// **'join the Sabalpara Community & stay connect.'**
  String get joinTheCommunityAndStayConnect;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enterEmail;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required!'**
  String get emailIsRequired;

  /// No description provided for @emailIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Email is invalid!'**
  String get emailIsInvalid;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @phoneNumberIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone Number is required!'**
  String get phoneNumberIsRequired;

  /// No description provided for @phoneNumberIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Phone Number is invalid!'**
  String get phoneNumberIsInvalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required!'**
  String get passwordIsRequired;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enterConfirmPassword;

  /// No description provided for @confirmPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password is required!'**
  String get confirmPasswordIsRequired;

  /// No description provided for @passwordAndConfirmPasswordIsntMatching.
  ///
  /// In en, this message translates to:
  /// **'Password & Confirm Password isn\'t matching!'**
  String get passwordAndConfirmPasswordIsntMatching;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPasswordQ.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordQ;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign In Google'**
  String get signInGoogle;

  /// No description provided for @signUpGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Google'**
  String get signUpGoogle;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Or Sign In With'**
  String get orSignInWith;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Or Sign Up With'**
  String get orSignUpWith;

  /// No description provided for @youDontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have an account?'**
  String get youDontHaveAnAccount;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @weSentACodeToYourMail.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to your email It may take a minute to arrive.'**
  String get weSentACodeToYourMail;

  /// No description provided for @didntYouReceiveAnyCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t you receive any code?'**
  String get didntYouReceiveAnyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCodeIn;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @otpIsRequired.
  ///
  /// In en, this message translates to:
  /// **'OTP is required!'**
  String get otpIsRequired;

  /// No description provided for @otpIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'OTP is invalid!'**
  String get otpIsInvalid;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Current Password'**
  String get enterCurrentPassword;

  /// No description provided for @currentPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Current Password is required!'**
  String get currentPasswordIsRequired;

  /// No description provided for @currentPasswordIsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Current Password is invalid!'**
  String get currentPasswordIsInvalid;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @newPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'New Password is required!'**
  String get newPasswordIsRequired;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @enterConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm New Password'**
  String get enterConfirmNewPassword;

  /// No description provided for @confirmNewPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password is required!'**
  String get confirmNewPasswordIsRequired;

  /// No description provided for @newPasswordAndConfirmNewPasswordIsntMatching.
  ///
  /// In en, this message translates to:
  /// **'New Password & Confirm New Password isn\'t matching!'**
  String get newPasswordAndConfirmNewPasswordIsntMatching;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @communityOverview.
  ///
  /// In en, this message translates to:
  /// **'Community Overview'**
  String get communityOverview;

  /// No description provided for @totalFamilies.
  ///
  /// In en, this message translates to:
  /// **'Total Families'**
  String get totalFamilies;

  /// No description provided for @totalMembers.
  ///
  /// In en, this message translates to:
  /// **'Total Members'**
  String get totalMembers;

  /// No description provided for @totalBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Total Businesses'**
  String get totalBusinesses;

  /// No description provided for @totalVillages.
  ///
  /// In en, this message translates to:
  /// **'Total Villages'**
  String get totalVillages;

  /// No description provided for @uploadResult.
  ///
  /// In en, this message translates to:
  /// **'Upload Result'**
  String get uploadResult;

  /// No description provided for @submittedResults.
  ///
  /// In en, this message translates to:
  /// **'Submitted Results'**
  String get submittedResults;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @villages.
  ///
  /// In en, this message translates to:
  /// **'Villages'**
  String get villages;

  /// No description provided for @committee.
  ///
  /// In en, this message translates to:
  /// **'Committee'**
  String get committee;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutDescription.
  ///
  /// In en, this message translates to:
  /// **'You will be logged out of your account and need to sign in again to continue.'**
  String get logoutDescription;

  /// No description provided for @yesLogout.
  ///
  /// In en, this message translates to:
  /// **'Yes, Logout'**
  String get yesLogout;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure?'**
  String get areYouSure;

  /// No description provided for @youWantToExitTheApp.
  ///
  /// In en, this message translates to:
  /// **'You want to exit the app?'**
  String get youWantToExitTheApp;

  /// No description provided for @yesExitNow.
  ///
  /// In en, this message translates to:
  /// **'Yes, Exit Now'**
  String get yesExitNow;

  /// No description provided for @childName.
  ///
  /// In en, this message translates to:
  /// **'Child Name'**
  String get childName;

  /// No description provided for @enterChildFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Child\'s Full Name'**
  String get enterChildFullName;

  /// No description provided for @childNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Child Name is required!'**
  String get childNameIsRequired;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @selectStandard.
  ///
  /// In en, this message translates to:
  /// **'Select Standard'**
  String get selectStandard;

  /// No description provided for @standardIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Standard is required!'**
  String get standardIsRequired;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentage;

  /// No description provided for @enterPercentage.
  ///
  /// In en, this message translates to:
  /// **'Enter Percentage'**
  String get enterPercentage;

  /// No description provided for @percentageIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Percentage is required!'**
  String get percentageIsRequired;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @selectYear.
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get selectYear;

  /// No description provided for @yearIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Year is required!'**
  String get yearIsRequired;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @resultIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Result is required!'**
  String get resultIsRequired;

  /// No description provided for @clickToUploadYourResult.
  ///
  /// In en, this message translates to:
  /// **'Click to upload your result'**
  String get clickToUploadYourResult;

  /// No description provided for @resultUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Result Uploaded Successfully!'**
  String get resultUploadedSuccessfully;

  /// No description provided for @resultUploadedSuccessfullyDesc.
  ///
  /// In en, this message translates to:
  /// **'Your child’s result has been submitted successfully and will be reviewed by the team.'**
  String get resultUploadedSuccessfullyDesc;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @selectMediaSource.
  ///
  /// In en, this message translates to:
  /// **'Select Media Source'**
  String get selectMediaSource;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @searchBusiness.
  ///
  /// In en, this message translates to:
  /// **'Search Business...'**
  String get searchBusiness;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @villageName.
  ///
  /// In en, this message translates to:
  /// **'Village Name'**
  String get villageName;

  /// No description provided for @searchVillage.
  ///
  /// In en, this message translates to:
  /// **'Search Village...'**
  String get searchVillage;

  /// No description provided for @committeeMember.
  ///
  /// In en, this message translates to:
  /// **'Committee Member'**
  String get committeeMember;

  /// No description provided for @searchMember.
  ///
  /// In en, this message translates to:
  /// **'Search Member...'**
  String get searchMember;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @president.
  ///
  /// In en, this message translates to:
  /// **'President'**
  String get president;

  /// No description provided for @vicePresident.
  ///
  /// In en, this message translates to:
  /// **'Vice President'**
  String get vicePresident;

  /// No description provided for @secretary.
  ///
  /// In en, this message translates to:
  /// **'Secretary'**
  String get secretary;

  /// No description provided for @treasurer.
  ///
  /// In en, this message translates to:
  /// **'Treasurer'**
  String get treasurer;

  /// No description provided for @volunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteer;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get member;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @familyMembers.
  ///
  /// In en, this message translates to:
  /// **'Family Members'**
  String get familyMembers;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here...'**
  String get searchHere;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @enterCorrectDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter Correct Details'**
  String get enterCorrectDetails;

  /// No description provided for @enterCorrectDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Make sure the child’s name, class, and school details are accurate.'**
  String get enterCorrectDetailsDesc;

  /// No description provided for @uploadClearMarksheet.
  ///
  /// In en, this message translates to:
  /// **'Upload Clear Marksheet'**
  String get uploadClearMarksheet;

  /// No description provided for @uploadClearMarksheetDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear image or PDF of the marksheet. Avoid blurry or cropped files.'**
  String get uploadClearMarksheetDesc;

  /// No description provided for @checkFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Check File Format'**
  String get checkFileFormat;

  /// No description provided for @checkFileFormatDesc.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: JPG, PNG, PDF (Max size: 5MB)'**
  String get checkFileFormatDesc;

  /// No description provided for @verifyBeforeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Verify Before Submit'**
  String get verifyBeforeSubmit;

  /// No description provided for @verifyBeforeSubmitDesc.
  ///
  /// In en, this message translates to:
  /// **'Double-check all details before submitting the result.'**
  String get verifyBeforeSubmitDesc;

  /// No description provided for @submissionDeadline.
  ///
  /// In en, this message translates to:
  /// **'Submission Deadline'**
  String get submissionDeadline;

  /// No description provided for @submissionDeadlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload the result before 30 Oct to participate in SnehMilan 2027.'**
  String get submissionDeadlineDesc;

  /// No description provided for @oneSubmissionPerChild.
  ///
  /// In en, this message translates to:
  /// **'One Submission Per Child'**
  String get oneSubmissionPerChild;

  /// No description provided for @oneSubmissionPerChildDesc.
  ///
  /// In en, this message translates to:
  /// **'Each child’s result should be uploaded only once.'**
  String get oneSubmissionPerChildDesc;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @son.
  ///
  /// In en, this message translates to:
  /// **'Son'**
  String get son;

  /// No description provided for @daughter.
  ///
  /// In en, this message translates to:
  /// **'Daughter'**
  String get daughter;

  /// No description provided for @brother.
  ///
  /// In en, this message translates to:
  /// **'Brother'**
  String get brother;

  /// No description provided for @sister.
  ///
  /// In en, this message translates to:
  /// **'Sister'**
  String get sister;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get study;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @manager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get manager;

  /// No description provided for @worker.
  ///
  /// In en, this message translates to:
  /// **'Worker'**
  String get worker;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @editMember.
  ///
  /// In en, this message translates to:
  /// **'Edit Member'**
  String get editMember;

  /// No description provided for @memberName.
  ///
  /// In en, this message translates to:
  /// **'Member Name'**
  String get memberName;

  /// No description provided for @enterMemberFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Member Full Name'**
  String get enterMemberFullName;

  /// No description provided for @memberNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Member Name is required!'**
  String get memberNameIsRequired;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @selectOccupation.
  ///
  /// In en, this message translates to:
  /// **'Select Occupation'**
  String get selectOccupation;

  /// No description provided for @occupationIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Occupation is required!'**
  String get occupationIsRequired;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @enterAge.
  ///
  /// In en, this message translates to:
  /// **'Enter Age'**
  String get enterAge;

  /// No description provided for @ageIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Age is required!'**
  String get ageIsRequired;

  /// No description provided for @workType.
  ///
  /// In en, this message translates to:
  /// **'Work Type'**
  String get workType;

  /// No description provided for @selectWorkType.
  ///
  /// In en, this message translates to:
  /// **'Select Work Type'**
  String get selectWorkType;

  /// No description provided for @workTypeIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Work Type is required!'**
  String get workTypeIsRequired;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @enterBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Enter Business Name'**
  String get enterBusinessName;

  /// No description provided for @businessNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Business Name is required!'**
  String get businessNameIsRequired;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @roleIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Role is required!'**
  String get roleIsRequired;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @selectRelation.
  ///
  /// In en, this message translates to:
  /// **'Select Relation'**
  String get selectRelation;

  /// No description provided for @relationIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Relation is required!'**
  String get relationIsRequired;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required!'**
  String get nameIsRequired;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @selectVillage.
  ///
  /// In en, this message translates to:
  /// **'Select Village'**
  String get selectVillage;

  /// No description provided for @villageIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Village is required!'**
  String get villageIsRequired;

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

  /// No description provided for @addressIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required!'**
  String get addressIsRequired;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @cityIsRequired.
  ///
  /// In en, this message translates to:
  /// **'City is required!'**
  String get cityIsRequired;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @readAll.
  ///
  /// In en, this message translates to:
  /// **'Read All'**
  String get readAll;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found!'**
  String get noDataFound;

  /// No description provided for @noResultFound.
  ///
  /// In en, this message translates to:
  /// **'No Result Found!'**
  String get noResultFound;

  /// No description provided for @deleteResult.
  ///
  /// In en, this message translates to:
  /// **'Delete Result'**
  String get deleteResult;

  /// No description provided for @deleteResultDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this result? This action cannot be undone.'**
  String get deleteResultDescription;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet'**
  String get noInternet;

  /// No description provided for @noInternetDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet and refresh the page to continue.'**
  String get noInternetDescription;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
