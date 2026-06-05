part of 'create_new_password_cubit.dart';

class CreateNewPasswordState extends Equatable {
  const CreateNewPasswordState({
    this.isLoading = false,
    this.newPasswordError = "",
    this.confirmNewPasswordError = "",
  });

  final bool isLoading;
  final String newPasswordError;
  final String confirmNewPasswordError;

  CreateNewPasswordState copyWith({
    bool? isLoading,
    String? newPasswordError,
    String? confirmNewPasswordError,
  }) {
    return CreateNewPasswordState(
      isLoading: isLoading ?? this.isLoading,
      newPasswordError: newPasswordError ?? this.newPasswordError,
      confirmNewPasswordError:
          confirmNewPasswordError ?? this.confirmNewPasswordError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    newPasswordError,
    confirmNewPasswordError,
  ];
}
