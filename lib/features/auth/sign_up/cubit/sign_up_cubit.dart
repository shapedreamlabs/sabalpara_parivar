import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void refresh(SignUpState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onTapSignIn(BuildContext context) {
    context.navigator.pushNamed(SignInScreen.routeName);
  }

  bool validation(BuildContext context) {
    String emailError = "";
    String phoneError = "";
    String passwordError = "";
    String confirmPasswordError = "";

    if (emailController.text.trim().isEmpty) {
      emailError = context.l10n?.emailIsRequired ?? "";
    } else if (!emailController.text.trim().isEmailValid()) {
      emailError = context.l10n?.emailIsInvalid ?? "";
    }

    if (phoneNumberController.text.trim().isEmpty) {
      phoneError = context.l10n?.phoneNumberIsRequired ?? "";
    } else if (!phoneNumberController.text.trim().isPhoneValid()) {
      phoneError = context.l10n?.phoneNumberIsInvalid ?? "";
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError = context.l10n?.passwordIsRequired ?? "";
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      confirmPasswordError = context.l10n?.confirmPasswordIsRequired ?? "";
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      confirmPasswordError =
          context.l10n?.passwordAndConfirmPasswordIsntMatching ?? "";
    }

    refresh(
      state.copyWith(
        emailError: emailError,
        phoneError: phoneError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ),
    );

    return emailError.isEmpty &&
        phoneError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
  }

  Future<void> onTapCreateAccount(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      final response = await AuthRepo.register(
        email: emailController.text.trim(),
        phone: phoneNumberController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);
      await PrefService.set(PrefKeys.isLoggedIn, true);

      if (!context.mounted) {
        return;
      }

      context.navigator.pushNamedAndRemoveUntil(
        DashboardScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }

  Future<void> onTapGoogleSignUp(BuildContext context) async {
    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      final googleUser = await GoogleAuthService.signIn();
      if (googleUser == null) {
        return;
      }

      final avatarFile = await GoogleAuthService.downloadAvatarFile(
        googleUser.photoUrl,
      );

      await AuthRepo.socialLogin(
        provider: 'google',
        providerId: googleUser.providerId,
        email: googleUser.email,
        name: googleUser.name,
        phone: phoneNumberController.text.trim(),
        avatar: avatarFile,
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast('Login Success!');
      await PrefService.set(PrefKeys.isLoggedIn, true);

      if (!context.mounted) {
        return;
      }

      context.navigator.pushNamedAndRemoveUntil(
        DashboardScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }
}
