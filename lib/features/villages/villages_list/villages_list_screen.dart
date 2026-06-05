import 'package:sabalpara_family/sabalpara_family.dart';

class VillagesListScreen extends StatelessWidget {
  const VillagesListScreen({super.key});

  static const routeName = '/villages_list';

  static Widget builder(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<VillagesListCubit>(
      create: (c) => VillagesListCubit(arguments),
      child: const VillagesListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VillagesListCubit, VillagesListState>(
      builder: (context, state) {
        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: state?.villageName ?? ""),
            body: CustomListView(
              padding: .symmetric(horizontal: AppConstants.horizontalPadding),
              itemCount: state.villageList.length,
              separatorBuilder: (context, index) => 12.h.spaceVertical,
              itemBuilder: (context, index) {
                final villageData = state.villageList[index];
                return VillagesDetailsWidget(villageData: villageData);
              },
            ),
          ),
        );
      },
    );
  }
}

class VillagesDetailsWidget extends StatelessWidget {
  const VillagesDetailsWidget({super.key, required this.villageData});

  final VillagesModel villageData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: .all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(8.r),
        border: .all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        spacing: 4.h,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(villageData.name ?? "", style: styleW700S16),

          RichText(
            textAlign: .start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${l10n?.phoneNumber ?? ""}: ",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
                TextSpan(
                  text: villageData.phone ?? "",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          RichText(
            textAlign: .start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${l10n?.business ?? ""}: ",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
                TextSpan(
                  text: villageData.business ?? "",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
