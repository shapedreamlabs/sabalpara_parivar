import 'package:sabalpara_family/sabalpara_family.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit({required this.email, required this.code})
    : super(CreateNewPasswordState());

  final String email;
  final String code;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void refresh(CreateNewPasswordState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  bool validation(BuildContext context) {
    String newPasswordError = "";
    String confirmNewPasswordError = "";

    if (newPasswordController.text.trim().isEmpty) {
      newPasswordError = context.l10n?.newPasswordIsRequired ?? "";
    }

    if (confirmNewPasswordController.text.trim().isEmpty) {
      confirmNewPasswordError =
          context.l10n?.confirmNewPasswordIsRequired ?? "";
    } else if (newPasswordController.text.trim() !=
        confirmNewPasswordController.text.trim()) {
      confirmNewPasswordError =
          context.l10n?.newPasswordAndConfirmNewPasswordIsntMatching ?? "";
    }

    refresh(
      state.copyWith(
        newPasswordError: newPasswordError,
        confirmNewPasswordError: confirmNewPasswordError,
      ),
    );

    return newPasswordError.isEmpty && confirmNewPasswordError.isEmpty;
  }

  Future<void> onTapUpdatePassword(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      final response = await AuthRepo.resetPassword(
        email: email,
        password: newPasswordController.text.trim(),
        code: code,
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);
      context.navigator.pushNamed(SignInScreen.routeName);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }
}
