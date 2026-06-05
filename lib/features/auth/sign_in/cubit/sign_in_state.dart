part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.isLoading = false,
    this.rememberMe = false,
    this.emailError = "",
    this.passwordError = "",
  });

  final bool isLoading;
  final bool rememberMe;
  final String emailError;
  final String passwordError;

  SignInState copyWith({
    bool? isLoading,
    bool? rememberMe,
    String? emailError,
    String? passwordError,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      rememberMe: rememberMe ?? this.rememberMe,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  @override
  List<Object?> get props => [isLoading, rememberMe, emailError, passwordError];
}
