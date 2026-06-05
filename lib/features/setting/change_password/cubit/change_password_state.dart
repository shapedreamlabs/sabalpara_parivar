part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.isLoading = false,
    this.currentPasswordError = "",
    this.newPasswordError = "",
    this.confirmNewPasswordError = "",
  });

  final bool isLoading;
  final String currentPasswordError;
  final String newPasswordError;
  final String confirmNewPasswordError;

  ChangePasswordState copyWith({
    bool? isLoading,
    String? currentPasswordError,
    String? newPasswordError,
    String? confirmNewPasswordError,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      currentPasswordError: currentPasswordError ?? this.currentPasswordError,
      newPasswordError: newPasswordError ?? this.newPasswordError,
      confirmNewPasswordError:
          confirmNewPasswordError ?? this.confirmNewPasswordError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    currentPasswordError,
    newPasswordError,
    confirmNewPasswordError,
  ];
}
