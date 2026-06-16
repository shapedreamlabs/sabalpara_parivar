import 'package:sabalpara_family/sabalpara_family.dart';

class VillagesScreen extends StatelessWidget {
  const VillagesScreen({super.key});

  static const routeName = '/villages';

  static Widget builder(BuildContext context) {
    return BlocProvider<VillagesCubit>(
      create: (c) => VillagesCubit(),
      child: const VillagesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<VillagesCubit, VillagesState>(
      builder: (context, state) {
        final cubit = context.read<VillagesCubit>();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppColors.lightStatusBar,
          child: CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              backArrow: false,
              centerTitle: false,
              systemUiStyle: AppColors.lightStatusBar,
              title: l10n?.villages ?? "",
            ),
            body: state.loader
                ? const Center(child: AppLoader())
                : CustomSingleChildScroll(
                    padding: .symmetric(
                      horizontal: AppConstants.horizontalPadding,
                    ),
                    child: Column(
                      spacing: 20.h,
                      children: [
                        AppSearchBar(
                          controller: cubit.searchController,
                          hintText: context.l10n?.searchVillage ?? "",
                          onChanged: cubit.onSearchChanged,
                        ),

                        if (state.filteredVillageList.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Text(
                              context.l10n?.noDataFound ?? "No data found",
                              style: styleW400S16.copyWith(
                                color: AppColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                          )
                        else
                          DynamicHeightGridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.w,
                            builder: (context, index) {
                              final village = state.filteredVillageList[index];
                              return VillagesContainerWidget(
                                title: village.name ?? "",
                                onTap: () =>
                                    cubit.onTapVillage(context, village),
                              );
                            },
                            itemCount: state.filteredVillageList.length,
                            crossAxisCount: 2,
                          ),
                      ],
                    ),
                  ),
          ),
        ),
        );
      },
    );
  }
}

class VillagesContainerWidget extends StatelessWidget {
  const VillagesContainerWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: .circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(8.r),
        child: Container(
          height: 100.h,
          padding: .all(AppConstants.horizontalPadding),
          decoration: BoxDecoration(
            borderRadius: .circular(8.r),
            border: .all(color: AppColors.text.withValues(alpha: 0.05)),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: .center,
              maxLines: 2,
              overflow: .ellipsis,
              style: styleW600S20,
            ),
          ),
        ),
      ),
    );
  }
}
