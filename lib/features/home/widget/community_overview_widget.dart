import 'package:sabalpara_family/sabalpara_family.dart';

class CommunityOverviewWidget extends StatelessWidget {
  const CommunityOverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<HomeCubit>().state;
    return Padding(
      padding: .symmetric(horizontal: AppConstants.horizontalPadding),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(l10n?.communityOverview ?? "", style: styleW700S20),

          16.h.spaceVertical,

          Row(
            spacing: 12.h,
            children: [
              Expanded(
                child: cardWidget(
                  iconImage: AppAssets.familiesIcon,
                  count: state.totalFamily,
                  title: l10n?.totalFamilies ?? "",
                  onTap: () {},
                ),
              ),

              Expanded(
                child: cardWidget(
                  iconImage: AppAssets.membersIcon,
                  count: state.totalMembers,
                  title: l10n?.totalMembers ?? "",
                  onTap: () {},
                ),
              ),
            ],
          ),

          12.h.spaceVertical,

          Row(
            spacing: 12.h,
            children: [
              Expanded(
                child: cardWidget(
                  iconImage: AppAssets.businessesIcon,
                  count: state.totalBusinesses,
                  title: l10n?.totalBusinesses ?? "",
                  onTap: () => context.read<DashboardCubit>().onTabChanged(1),
                ),
              ),

              Expanded(
                child: cardWidget(
                  iconImage: AppAssets.villagesIcon,
                  count: state.totalVillages,
                  title: l10n?.totalVillages ?? "",
                  onTap: () => context.read<DashboardCubit>().onTabChanged(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardWidget({
    required String iconImage,
    required int count,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgAsset(imagePath: iconImage, height: 40.h),

              SizedBox(height: 8.h),

              Text("$count", style: styleW700S18),

              Text(
                title,
                style: styleW400S14.copyWith(
                  color: AppColors.text.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
