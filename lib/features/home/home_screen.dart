import 'package:sabalpara_family/features/home/widget/banners_widget.dart';
import 'package:sabalpara_family/features/home/widget/community_overview_widget.dart';
import 'package:sabalpara_family/features/home/widget/results_widget.dart';
import 'package:sabalpara_family/sabalpara_family.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (c) => HomeCubit(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              backArrow: false,
              titleWidget: _UserWidget(),
              // actions: [
              //   Padding(
              //     padding: .only(right: AppConstants.horizontalPadding),
              //     child: Material(
              //       color: AppColors.white.withValues(alpha: 0.8),
              //       borderRadius: .circular(500.r),
              //       child: InkWell(
              //         onTap: () => context.navigator.pushNamed(
              //           NotificationsScreen.routeName,
              //         ),
              //         borderRadius: .circular(500.r),
              //         child: Padding(
              //           padding: .all(10.w),
              //           child: SvgAsset(
              //             imagePath: AppAssets.notificationIcon,
              //             height: 24.h,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
            ),
            body: CustomSingleChildScroll(
              child: Column(
                spacing: 20.h,
                children: [
                  BannersWidget(),
                  CommunityOverviewWidget(),
                  ResultsWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UserWidget extends StatelessWidget {
  const _UserWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(left: 10.w),
      child: Row(
        spacing: 10.w,
        children: [
          ClipOval(
            child: (userModel?.image ?? "").isNotEmpty
                ? CachedImage(
                    userModel?.image,
                    skipBaseUrl: true,
                    fit: .cover,
                    height: 48.w,
                    width: 48.w,
                  )
                : AssetsImg(
                    imagePath: AppAssets.profileImage,
                    fit: .cover,
                    height: 48.w,
                    width: 48.w,
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .start,
              spacing: 2.h,
              children: [
                Text(
                  greetingText,
                  style: styleW400S16.copyWith(
                    color: AppColors.text.withValues(alpha: 0.8),
                  ),
                ),
                Text(userModel?.name ?? "-", style: styleW600S18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
