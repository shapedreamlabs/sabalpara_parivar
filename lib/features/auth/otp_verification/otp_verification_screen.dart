import 'package:sabalpara_family/sabalpara_family.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  static const routeName = '/otp_verification';

  static Widget builder(BuildContext context) {
    final phone = context.args is String ? context.args as String : null;
    return BlocProvider<OtpVerificationCubit>(
      create: (c) => OtpVerificationCubit(phone),
      child: const OtpVerificationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
      builder: (context, state) {
        final cubit = context.read<OtpVerificationCubit>();
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.otpVerification ?? ""),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child:
                    BlocSelector<
                      OtpVerificationCubit,
                      OtpVerificationState,
                      bool
                    >(
                      selector: (state) => state.isOTPValidate,
                      builder: (context, isOTPValidate) {
                        return CustomButton(
                          isDisabled: !isOTPValidate,
                          title: l10n?.verifyOtp ?? "",
                          onTap: () => cubit.onTapVerifyOTP(context),
                        );
                      },
                    ),
              ),
            ),
            body: Padding(
              padding: .symmetric(horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  30.h.spaceVertical,

                  Text(
                    l10n?.weSentACodeToYourMail ?? "",
                    textAlign: .center,
                    style: styleW400S16,
                  ),

                  30.h.spaceVertical,

                  Pinput(
                    length: 6,
                    controller: cubit.otpController,
                    onCompleted: (str) => cubit.onTapVerifyOTP(context),
                    onSubmitted: (str) => cubit.onTapVerifyOTP(context),
                    onChanged: cubit.onOtpChanged,
                    autofocus: true,
                    defaultPinTheme: pinTheme(),
                    disabledPinTheme: pinTheme(),
                    focusedPinTheme: pinTheme().copyWith(
                      decoration: pinTheme().decoration?.copyWith(
                        border: Border.all(color: AppColors.primary),
                      ),
                    ),
                    submittedPinTheme: pinTheme().copyWith(
                      decoration: pinTheme().decoration?.copyWith(
                        border: Border.all(color: AppColors.primary),
                      ),
                    ),
                    errorPinTheme: pinTheme().copyWith(
                      decoration: pinTheme().decoration?.copyWith(
                        border: Border.all(color: AppColors.red),
                      ),
                    ),
                  ),

                  40.h.spaceVertical,

                  BlocSelector<OtpVerificationCubit, OtpVerificationState, int>(
                    selector: (state) => state.timer,
                    builder: (context, timer) {
                      return AnimatedSwitcher(
                        duration: 300.milliseconds,
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Builder(
                          key: ValueKey(timer != 0),
                          builder: (context) {
                            if (timer == 0) {
                              return Row(
                                spacing: 5.w,
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    l10n?.didntYouReceiveAnyCode ?? "",
                                    style: styleW400S16.copyWith(
                                      color: AppColors.text.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),

                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: .circular(10.r),
                                      onTap: cubit.onTapResendCode,
                                      child: Padding(
                                        padding: .symmetric(
                                          vertical: 2.h,
                                          horizontal: 5.w,
                                        ),
                                        child: Text(
                                          l10n?.resendCode ?? "",
                                          style: styleW600S16.copyWith(
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Row(
                              spacing: 5.w,
                              mainAxisAlignment: .center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: l10n?.resendCodeIn ?? "",
                                    style: styleW400S16.copyWith(
                                      color: AppColors.text.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " ${(timer / 60).floor().toString().padLeft(2, "0")}:${(timer % 60).toString().padLeft(2, "0")}",
                                        style: styleW600S16.copyWith(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PinTheme pinTheme() {
    return PinTheme(
      width: 50.w,
      height: 50.w,
      textStyle: styleW500S16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        border: Border.all(color: AppColors.text.withValues(alpha: 0.1)),
      ),
    );
  }
}
