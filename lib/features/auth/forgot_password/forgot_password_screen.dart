import 'package:sabalpara_family/sabalpara_family.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const routeName = '/forgot_password';

  static Widget builder(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (c) => ForgotPasswordCubit(),
      child: const ForgotPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final cubit = context.read<ForgotPasswordCubit>();
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.forgotPassword ?? ""),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: l10n?.sendResetLink ?? "",
                  isLoading: state.isLoading,
                  onTap: () => cubit.onTapSendResetLink(context),
                ),
              ),
            ),
            body: Padding(
              padding: .symmetric(horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  24.h.spaceVertical,

                  AppTextField(
                    controller: cubit.emailController,
                    header: l10n?.email,
                    hintText: l10n?.enterEmail,
                    textInputType: .emailAddress,
                    error: state.emailError,
                    prefixIcon: AppAssets.emailIcon,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
