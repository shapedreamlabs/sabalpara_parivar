import 'package:sabalpara_family/sabalpara_family.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign_up';

  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (c) => SignUpCubit(),
      child: const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: .light,
          child: Scaffold(
            backgroundColor: AppColors.white,
            bottomNavigationBar: Container(
              color: AppColors.white,
              child: Padding(
                padding: .symmetric(
                  vertical: 10.h,
                  horizontal: AppConstants.horizontalPadding,
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    spacing: 2.w,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        l10n?.alreadyHaveAnAccount ?? "",
                        style: styleW500S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.6),
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: .circular(10.r),
                          onTap: () => cubit.onTapSignIn(context),
                          child: Padding(
                            padding: .symmetric(vertical: 2.h, horizontal: 5.w),
                            child: Text(l10n?.signIn ?? "", style: styleW700S14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              color: AppColors.primary,
              child: Align(
                alignment: .bottomCenter,
                child: DraggableScrollableSheet(
                  minChildSize: 0.74,
                  initialChildSize: 0.74,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      clipBehavior: .none,
                      child: Container(
                        padding: .symmetric(
                          horizontal: AppConstants.horizontalPadding,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: .vertical(top: Radius.circular(40.r)),
                        ),
                        child: Stack(
                          clipBehavior: .none,
                          children: [
                            Padding(
                              padding: .only(top: 90.h, bottom: 10.h),
                              child: Column(
                                spacing: 24.h,
                                mainAxisSize: .min,
                                children: [
                                  Column(
                                    spacing: 10.h,
                                    mainAxisSize: .min,
                                    children: [
                                      Text(
                                        l10n?.createYourAccount ?? "",
                                        textAlign: .center,
                                        style: styleW700S26,
                                      ),

                                      Text(
                                        l10n?.joinTheCommunityAndStayConnect ??
                                            "",
                                        textAlign: .center,
                                        style: styleW400S16.copyWith(
                                          color: AppColors.text.withValues(
                                            alpha: 0.6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    spacing: 15.h,
                                    mainAxisSize: .min,
                                    children: [
                                      AppTextField(
                                        controller: cubit.emailController,
                                        header: l10n?.email,
                                        hintText: l10n?.enterEmail,
                                        textInputType: .emailAddress,
                                        error: state.emailError,
                                        prefixIcon: AppAssets.emailIcon,
                                      ),

                                      AppTextField(
                                        controller: cubit.phoneNumberController,
                                        header: l10n?.phone,
                                        hintText: l10n?.enterPhoneNumber,
                                        error: state.phoneError,
                                        prefixIcon: AppAssets.phoneIcon,
                                        textInputType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                      ),

                                      AppTextField(
                                        controller: cubit.passwordController,
                                        header: l10n?.password,
                                        hintText: l10n?.enterPassword,
                                        textInputType: .visiblePassword,
                                        isPassword: true,
                                        error: state.passwordError,
                                        prefixIcon: AppAssets.lockIcon,
                                      ),

                                      AppTextField(
                                        controller:
                                            cubit.confirmPasswordController,
                                        header: l10n?.confirmPassword,
                                        hintText: l10n?.enterConfirmPassword,
                                        textInputType: .visiblePassword,
                                        isPassword: true,
                                        error: state.confirmPasswordError,
                                        prefixIcon: AppAssets.lockIcon,
                                      ),
                                    ],
                                  ),

                                  CustomButton(
                                    title: l10n?.createAccount ?? "",
                                    isLoading: state.isLoading,
                                    onTap: () =>
                                        cubit.onTapCreateAccount(context),
                                  ),

                                  // Row(
                                  //   spacing: 8.w,
                                  //   children: [
                                  //     Expanded(
                                  //       child: CommonDivider(
                                  //         color: AppColors.text.withValues(
                                  //           alpha: 0.2,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //
                                  //     Text(
                                  //       l10n?.orSignUpWith ?? "",
                                  //       style: styleW400S14.copyWith(
                                  //         color: AppColors.text.withValues(
                                  //           alpha: 0.6,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //
                                  //     Expanded(
                                  //       child: CommonDivider(
                                  //         color: AppColors.text.withValues(
                                  //           alpha: 0.2,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // CustomButton(
                                  //   style: styleW400S14,
                                  //   title: l10n?.signUpGoogle ?? "",
                                  //   isLoading: state.isLoading,
                                  //   buttonColor: Colors.transparent,
                                  //   borderColor: AppColors.text.withValues(
                                  //     alpha: 0.1,
                                  //   ),
                                  //   onTap: state.isLoading
                                  //       ? () {}
                                  //       : () => cubit.onTapGoogleSignUp(context),
                                  //   startWidget: AssetsImg(
                                  //     imagePath: AppAssets.googleLogoImg,
                                  //     height: 25.h,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: -70.h,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4.h),
                                        blurRadius: 16,
                                        spreadRadius: 0,
                                        color: AppColors.black.withValues(
                                          alpha: 0.12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: .only(left: 2.w),
                                  child: AppBrandLogo(dimension: 140.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
