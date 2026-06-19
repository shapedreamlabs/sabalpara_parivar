import 'package:sabalpara_family/sabalpara_family.dart';

class RouteService {
  static String get initialRoute => SplashScreen.routeName;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: SplashScreen.builder,
          settings: settings,
        );

      /// OnBoarding
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: OnboardingScreen.builder,
          settings: settings,
        );

      /// Sign In
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: SignInScreen.builder,
          settings: settings,
        );

      /// Sign Up
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: SignUpScreen.builder,
          settings: settings,
        );

      /// OTP Verification
      case OtpVerificationScreen.routeName:
        return MaterialPageRoute(
          builder: OtpVerificationScreen.builder,
          settings: settings,
        );

      /// Forgot Password
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: ForgotPasswordScreen.builder,
          settings: settings,
        );

      /// Create New Password
      case CreateNewPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: CreateNewPasswordScreen.builder,
          settings: settings,
        );

      /// Dashboard
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: DashboardScreen.builder,
          settings: settings,
        );

      /// Notifications
      case NotificationsScreen.routeName:
        return MaterialPageRoute(
          builder: NotificationsScreen.builder,
          settings: settings,
        );

      /// Upload Result
      case UploadResultScreen.routeName:
        return MaterialPageRoute(
          builder: UploadResultScreen.builder,
          settings: settings,
        );

      /// Submitted Results
      case SubmittedResultsScreen.routeName:
        return MaterialPageRoute(
          builder: SubmittedResultsScreen.builder,
          settings: settings,
        );

      /// Business
      case BusinessScreen.routeName:
        return MaterialPageRoute(
          builder: BusinessScreen.builder,
          settings: settings,
        );

      /// Community users (village / business)
      case CommunityUsersScreen.routeName:
        return MaterialPageRoute(
          builder: CommunityUsersScreen.builder,
          settings: settings,
        );

      /// Villages
      case VillagesScreen.routeName:
        return MaterialPageRoute(
          builder: VillagesScreen.builder,
          settings: settings,
        );

      /// Committee
      case CommitteeScreen.routeName:
        return MaterialPageRoute(
          builder: CommitteeScreen.builder,
          settings: settings,
        );

      /// Setting
      case SettingScreen.routeName:
        return MaterialPageRoute(
          builder: SettingScreen.builder,
          settings: settings,
        );

      /// Language
      case LanguageScreen.routeName:
        return MaterialPageRoute(
          builder: LanguageScreen.builder,
          settings: settings,
        );

      /// Change Password
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(
          builder: ChangePasswordScreen.builder,
          settings: settings,
        );

      /// Gallery
      case GalleryScreen.routeName:
        return MaterialPageRoute(
          builder: GalleryScreen.builder,
          settings: settings,
        );

      /// Gallery Detail
      case GalleryDetailScreen.routeName:
        return MaterialPageRoute(
          builder: GalleryDetailScreen.builder,
          settings: settings,
        );

      /// Gallery Image Preview
      case GalleryImagePreviewScreen.routeName:
        return MaterialPageRoute(
          builder: GalleryImagePreviewScreen.builder,
          settings: settings,
        );

      /// Instructions
      case InstructionsScreen.routeName:
        return MaterialPageRoute(
          builder: InstructionsScreen.builder,
          settings: settings,
        );

      /// Family Members
      case FamilyMembersScreen.routeName:
        return MaterialPageRoute(
          builder: FamilyMembersScreen.builder,
          settings: settings,
        );

      /// Add Family Member
      case AddFamilyMemberScreen.routeName:
        return MaterialPageRoute(
          builder: AddFamilyMemberScreen.builder,
          settings: settings,
        );

      /// My Profile
      case MyProfileScreen.routeName:
        return MaterialPageRoute(
          builder: MyProfileScreen.builder,
          settings: settings,
        );

      /// Edit Profile
      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          builder: EditProfileScreen.builder,
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => UnknownScreen(),
          settings: settings,
        );
    }
  }
}
