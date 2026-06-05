import 'package:sabalpara_family/sabalpara_family.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  static const routeName = '/business';

  static Widget builder(BuildContext context) {
    return BlocProvider<BusinessCubit>(
      create: (c) => BusinessCubit(),
      child: const BusinessScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<BusinessCubit, BusinessState>(
      builder: (context, state) {
        final cubit = context.read<BusinessCubit>();

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              backArrow: false,
              centerTitle: false,
              title: l10n?.business ?? "",
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
                          hintText: context.l10n?.searchBusiness ?? "",
                          onChanged: cubit.onSearchChanged,
                        ),

                        if (state.filteredWorkTypesList.isEmpty)
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
                              final workType =
                                  state.filteredWorkTypesList[index];
                              return BusinessContainerWidget(
                                title: workType.name ?? "",
                                onTap: () =>
                                    cubit.onTapWorkType(context, workType),
                              );
                            },
                            itemCount: state.filteredWorkTypesList.length,
                            crossAxisCount: 2,
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

class BusinessContainerWidget extends StatelessWidget {
  const BusinessContainerWidget({
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
