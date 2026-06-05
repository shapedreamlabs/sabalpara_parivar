part of 'otp_verification_cubit.dart';

class OtpVerificationState extends Equatable {
  const OtpVerificationState({
    this.isLoading = false,
    this.phoneNumber = "",
    this.isOTPValidate = false,
    this.timer = 0,
  });

  final bool isLoading;
  final String phoneNumber;
  final bool isOTPValidate;
  final int timer;

  OtpVerificationState copyWith({
    bool? isLoading,
    String? phoneNumber,
    bool? isOTPValidate,
    int? timer,
  }) {
    return OtpVerificationState(
      isLoading: isLoading ?? this.isLoading,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isOTPValidate: isOTPValidate ?? this.isOTPValidate,
      timer: timer ?? this.timer,
    );
  }

  @override
  List<Object?> get props => [isLoading, phoneNumber, isOTPValidate, timer];
}
