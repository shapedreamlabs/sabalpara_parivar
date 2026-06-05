import 'package:sabalpara_family/sabalpara_family.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  static Widget builder(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (c) => OnboardingCubit(),
      child: const OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: .light,
          child: Scaffold(
            body: SafeArea(
              top: false,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.2.sh,
                    child: AssetsImg(
                      imagePath: AppAssets.onboardingBgImg,
                      height: 0.8.sh,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 0.3.sh),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: .topCenter,
                          end: .bottomCenter,
                          colors: [
                            AppColors.white.withValues(alpha: 0),
                            AppColors.white,
                            AppColors.white,
                            AppColors.white,
                            AppColors.white,
                          ],
                        ),
                      ),
                      padding: .all(AppConstants.horizontalPadding),
                      child: Column(
                        spacing: 20.h,
                        mainAxisSize: .min,
                        crossAxisAlignment: .center,
                        children: [
                          50.h.spaceVertical,

                          Text(
                            l10n?.connectWithOurSabalparaCommunity ?? "",
                            textAlign: .center,
                            style: styleW700S30,
                          ),

                          Text(
                            l10n?.onBoardingDescription ?? "",
                            textAlign: .center,
                            style: styleW400S18,
                          ),

                          CustomButton(
                            title: l10n?.getStarted ?? "",
                            onTap: () => cubit.onTapGetStarted(context),
                          ),
                        ],
                      ),
                    ),
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
