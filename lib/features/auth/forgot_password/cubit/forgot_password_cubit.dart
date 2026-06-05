import 'package:sabalpara_family/sabalpara_family.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState());

  TextEditingController emailController = TextEditingController();

  void refresh(ForgotPasswordState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  bool validation(BuildContext context) {
    String emailError = "";

    if (emailController.text.trim().isEmpty) {
      emailError = context.l10n?.emailIsRequired ?? "";
    } else if (!emailController.text.trim().isEmailValid()) {
      emailError = context.l10n?.emailIsInvalid ?? "";
    }

    refresh(state.copyWith(emailError: emailError));

    return emailError.isEmpty;
  }

  Future<void> onTapSendResetLink(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      final response = await AuthRepo.forgotPassword(
        email: emailController.text.trim(),
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);

      context.navigator.pushNamed(
        CreateNewPasswordScreen.routeName,
        arguments: {
          'email': emailController.text.trim(),
          'code': response.data?.rememberCode ?? '',
        },
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
