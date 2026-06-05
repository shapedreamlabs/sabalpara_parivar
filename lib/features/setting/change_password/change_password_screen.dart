import 'package:sabalpara_family/sabalpara_family.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static const routeName = '/change_password';

  static Widget builder(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (c) => ChangePasswordCubit(),
      child: const ChangePasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.changePassword ?? ""),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: l10n?.updatePassword ?? "",
                  isLoading: state.isLoading,
                  onTap: () => cubit.onTapUpdatePassword(context),
                ),
              ),
            ),
            body: Padding(
              padding: .symmetric(horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  10.h.spaceVertical,

                  AppTextField(
                    controller: cubit.currentPasswordController,
                    header: l10n?.currentPassword,
                    hintText: l10n?.enterCurrentPassword,
                    textInputType: .visiblePassword,
                    isPassword: true,
                    error: state.currentPasswordError,
                    prefixIcon: AppAssets.lockIcon,
                  ),

                  24.h.spaceVertical,

                  AppTextField(
                    controller: cubit.newPasswordController,
                    header: l10n?.newPassword,
                    hintText: l10n?.enterNewPassword,
                    textInputType: .visiblePassword,
                    isPassword: true,
                    error: state.newPasswordError,
                    prefixIcon: AppAssets.lockIcon,
                  ),

                  24.h.spaceVertical,

                  AppTextField(
                    controller: cubit.confirmNewPasswordController,
                    header: l10n?.confirmNewPassword,
                    hintText: l10n?.enterConfirmNewPassword,
                    textInputType: .visiblePassword,
                    isPassword: true,
                    error: state.confirmNewPasswordError,
                    prefixIcon: AppAssets.lockIcon,
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
