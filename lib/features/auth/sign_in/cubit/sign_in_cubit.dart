import 'package:sabalpara_family/sabalpara_family.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "test01@mailinator.com" : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "Test@123" : "",
  );

  void refresh(SignInState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onChangeRememberMe() {
    refresh(state.copyWith(rememberMe: !state.rememberMe));
  }

  void onTapSignUp(BuildContext context) {
    context.navigator.pushNamed(SignUpScreen.routeName);
  }

  void onTapForgetPassword(BuildContext context) {
    context.navigator.pushNamed(ForgotPasswordScreen.routeName);
  }

  bool validation(BuildContext context) {
    String emailError = "";
    String passwordError = "";

    if (emailController.text.trim().isEmpty) {
      emailError = context.l10n?.emailIsRequired ?? "";
    } else if (!emailController.text.trim().isEmailValid()) {
      emailError = context.l10n?.emailIsInvalid ?? "";
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError = context.l10n?.passwordIsRequired ?? "";
    }

    refresh(
      state.copyWith(emailError: emailError, passwordError: passwordError),
    );

    return emailError.isEmpty && passwordError.isEmpty;
  }

  Future<void> _completeAuthFlow(
    BuildContext context,
    String successMessage,
  ) async {
    showSuccessToast(successMessage);

    await SettingRepo.syncProfileToPrefs();
    await PrefService.set(PrefKeys.isLoggedIn, true);

    if (!context.mounted) return;

    context.navigator.pushNamedAndRemoveUntil(
      DashboardScreen.routeName,
      (route) => false,
    );
  }

  Future<void> onTapSignIn(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      await AuthRepo.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!context.mounted) return;
      await _completeAuthFlow(context, 'Login Success!');
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }

  Future<void> onTapGoogleSignIn(BuildContext context) async {
    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      final googleUser = await GoogleAuthService.signIn();
      if (googleUser == null) {
        return;
      }

      final avatarFile =
          await GoogleAuthService.downloadAvatarFile(googleUser.photoUrl);

      await AuthRepo.socialLogin(
        provider: 'google',
        providerId: googleUser.providerId,
        email: googleUser.email,
        name: googleUser.name,
        avatar: avatarFile,
      );

      if (!context.mounted) return;
      await _completeAuthFlow(context, 'Login Success!');
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }
}
