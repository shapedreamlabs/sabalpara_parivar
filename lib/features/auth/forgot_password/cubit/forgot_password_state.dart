part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({this.isLoading = false, this.emailError = ""});

  final bool isLoading;
  final String emailError;

  ForgotPasswordState copyWith({bool? isLoading, String? emailError}) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      emailError: emailError ?? this.emailError,
    );
  }

  @override
  List<Object?> get props => [isLoading, emailError];
}
