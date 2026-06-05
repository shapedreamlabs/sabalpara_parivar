import 'package:sabalpara_family/sabalpara_family.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  static const routeName = '/create_new_password';

  static Widget builder(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return BlocProvider<CreateNewPasswordCubit>(
      create: (c) => CreateNewPasswordCubit(
        email: args?['email']?.toString() ?? "",
        code: args?['code']?.toString() ?? "",
      ),
      child: const CreateNewPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CreateNewPasswordCubit, CreateNewPasswordState>(
      builder: (context, state) {
        final cubit = context.read<CreateNewPasswordCubit>();
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.createNewPassword ?? ""),
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
