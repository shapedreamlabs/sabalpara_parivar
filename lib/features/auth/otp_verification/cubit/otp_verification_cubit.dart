import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit(String? phone) : super(OtpVerificationState()) {
    refresh(state.copyWith(phoneNumber: phone));

    startTimer();
  }

  Timer? timer;
  TextEditingController otpController = TextEditingController();

  void refresh(OtpVerificationState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void startTimer() {
    timer?.cancel();
    refresh(state.copyWith(timer: 60));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timer == 0) {
        timer.cancel();
      } else {
        refresh(state.copyWith(timer: state.timer - 1));
      }
    });
  }

  Future<void> onTapResendCode() async {
    startTimer();
  }

  void onOtpChanged(String value) {
    refresh(state.copyWith(isOTPValidate: value.length == 6));
  }

  Future<void> onTapVerifyOTP(BuildContext context) async {
    await PrefService.set(PrefKeys.isLoggedIn, true);

    if (context.mounted) {
      context.navigator.pushNamedAndRemoveUntil(
        DashboardScreen.routeName,
        (route) => false,
      );
    }
  }
}
