part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.isLoading = false,
    this.emailError = "",
    this.phoneError = "",
    this.passwordError = "",
    this.confirmPasswordError = "",
  });

  final bool isLoading;
  final String emailError;
  final String phoneError;
  final String passwordError;
  final String confirmPasswordError;

  SignUpState copyWith({
    bool? isLoading,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      emailError: emailError ?? this.emailError,
      phoneError: phoneError ?? this.phoneError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    emailError,
    phoneError,
    passwordError,
    confirmPasswordError,
  ];
}
