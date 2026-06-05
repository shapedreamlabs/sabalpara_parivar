import 'package:sabalpara_family/sabalpara_family.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign_in';

  static Widget builder(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (c) => SignInCubit(),
      child: const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            openSureToExitBottomSheet(context);
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                          l10n?.youDontHaveAnAccount ?? "",
                          style: styleW500S14.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: .circular(10.r),
                            onTap: () => cubit.onTapSignUp(context),
                            child: Padding(
                              padding: .symmetric(vertical: 2.h, horizontal: 5.w),
                              child: Text(
                                l10n?.signUp ?? "",
                                style: styleW700S14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                height: .maxFinite,
                color: AppColors.primary,
                child: Align(
                  alignment: .bottomCenter,
                  child: DraggableScrollableSheet(
                    minChildSize: 0.57,
                    initialChildSize: 0.57,
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
                                          l10n?.signInYourAccount ?? "",
                                          textAlign: .center,
                                          style: styleW700S26,
                                        ),

                                        Text(
                                          l10n?.welcomeBackPleaseSignInToContinue ??
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

                                        15.h.spaceVertical,

                                        AppTextField(
                                          controller: cubit.passwordController,
                                          header: l10n?.password,
                                          hintText: l10n?.enterPassword,
                                          textInputType: .visiblePassword,
                                          isPassword: true,
                                          error: state.passwordError,
                                          prefixIcon: AppAssets.lockIcon,
                                        ),

                                        12.h.spaceVertical,

                                        Row(
                                          spacing: 10.w,
                                          mainAxisAlignment: .spaceBetween,
                                          children: [
                                            CustomCheckbox(
                                              value: state.rememberMe,
                                              label: l10n?.rememberMe ?? "",
                                              onChanged: (value) =>
                                                  cubit.onChangeRememberMe(),
                                            ),

                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius: .circular(10.r),
                                                onTap: () => cubit
                                                    .onTapForgetPassword(context),
                                                child: Padding(
                                                  padding: .symmetric(
                                                    vertical: 2.h,
                                                    horizontal: 5.w,
                                                  ),
                                                  child: Text(
                                                    l10n?.forgotPasswordQ ?? "",
                                                    style: styleW700S14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    CustomButton(
                                      title: l10n?.signIn ?? "",
                                      isLoading: state.isLoading,
                                      onTap: () => cubit.onTapSignIn(context),
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
                                    //       l10n?.orSignInWith ?? "",
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
                                    //   title: l10n?.signInGoogle ?? "",
                                    //   isLoading: state.isLoading,
                                    //   buttonColor: Colors.transparent,
                                    //   borderColor: AppColors.text.withValues(
                                    //     alpha: 0.1,
                                    //   ),
                                    //   onTap: state.isLoading
                                    //       ? () {}
                                    //       : () => cubit.onTapGoogleSignIn(
                                    //             context,
                                    //           ),
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
          ),
        );
      },
    );
  }
}
