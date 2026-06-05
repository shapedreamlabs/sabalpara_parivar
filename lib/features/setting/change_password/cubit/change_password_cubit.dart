import 'package:sabalpara_family/sabalpara_family.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void refresh(ChangePasswordState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  bool validation(BuildContext context) {
    String currentPasswordError = "";
    String newPasswordError = "";
    String confirmNewPasswordError = "";

    if (currentPasswordController.text.trim().isEmpty) {
      currentPasswordError = context.l10n?.currentPasswordIsRequired ?? "";
    }

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
        currentPasswordError: currentPasswordError,
        newPasswordError: newPasswordError,
        confirmNewPasswordError: confirmNewPasswordError,
      ),
    );

    return currentPasswordError.isEmpty &&
        newPasswordError.isEmpty &&
        confirmNewPasswordError.isEmpty;
  }

  Future<void> onTapUpdatePassword(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(isLoading: true));

    try {
      await SettingRepo.changePassword(
        oldPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast('Password changed');
      context.navigator.pop();
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(isLoading: false));
      }
    }
  }
}
