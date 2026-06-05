import 'package:sabalpara_family/sabalpara_family.dart';

class CommitteeScreen extends StatelessWidget {
  const CommitteeScreen({super.key});

  static const routeName = '/committee';

  static Widget builder(BuildContext context) {
    return BlocProvider<CommitteeCubit>(
      create: (c) => CommitteeCubit(context),
      child: const CommitteeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CommitteeCubit, CommitteeState>(
      builder: (context, state) {
        final cubit = context.read<CommitteeCubit>();

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              backArrow: false,
              centerTitle: false,
              title: l10n?.committeeMember ?? "",
            ),
            body: state.loader
                ? const Center(child: AppLoader())
                : CustomSingleChildScroll(
                    child: Column(
                      spacing: 20.h,
                      children: [
                        Padding(
                          padding: .symmetric(
                            horizontal: AppConstants.horizontalPadding,
                          ),
                          child: AppSearchBar(
                            controller: cubit.searchController,
                            hintText: context.l10n?.searchMember ?? "",
                            onChanged: cubit.onSearchChanged,
                          ),
                        ),

                        if (state.typeList.isNotEmpty)
                          SizedBox(
                            height: 38.h,
                            child: CustomListView(
                              itemCount: state.typeList.length,
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.horizontalPadding,
                              ),
                              separatorBuilder: (context, index) =>
                                  10.w.spaceHorizontal,
                              itemBuilder: (context, index) {
                                final type = state.typeList[index];
                                final isSelected = state.selectedTypeList
                                    .contains(type);
                                return CommitteePositionWidget(
                                  onTap: () {
                                    cubit.toggleTypeSelection(type);
                                  },
                                  type: type,
                                  isSelected: isSelected,
                                );
                              },
                            ),
                          ),

                        CustomListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.horizontalPadding,
                          ),
                          itemCount: state.committeeMembersList.length,
                          separatorBuilder: (context, index) =>
                              12.h.spaceVertical,
                          itemBuilder: (context, index) {
                            final member = state.committeeMembersList[index];
                            return CommitteeMemberItemWidget(member: member);
                          },
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

class CommitteePositionWidget extends StatelessWidget {
  const CommitteePositionWidget({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final String type;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 300.milliseconds,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(50.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: isSelected
                ? AppColors.primary
                : AppColors.white.withValues(alpha: 0.8),
          ),
          child: Center(
            child: Text(
              type,
              style: (isSelected ? styleW700S14 : styleW600S14).copyWith(
                color: isSelected
                    ? AppColors.white
                    : AppColors.text.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommitteeMemberItemWidget extends StatelessWidget {
  const CommitteeMemberItemWidget({super.key, required this.member});

  final CommitteeMembersModel member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Row(
        spacing: 10.w,
        crossAxisAlignment: .start,
        children: [
          (member.avatar ?? '').isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedImage(
                    member.avatar,
                    skipBaseUrl: true,
                    height: 100.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
                )
              : AssetsImg(
                  imagePath: AppAssets.profileImage,
                  height: 100.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                  borderRadius: 8.r,
                ),

          Column(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Text(
                member.name ?? "",
                maxLines: 2,
                overflow: .ellipsis,
                style: styleW700S16,
              ),

              5.h.spaceVertical,

              Text(
                member.phone ?? "",
                style: styleW500S14.copyWith(
                  color: AppColors.text.withValues(alpha: 0.8),
                ),
              ),

              5.h.spaceVertical,

              Text(
                member.email ?? "",
                style: styleW500S14.copyWith(
                  color: AppColors.text.withValues(alpha: 0.8),
                ),
              ),

              8.h.spaceVertical,

              if ((member.type ?? '').isNotEmpty)
                CommonTagWidget(
                  text: member.type ?? "",
                  color: AppColors.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
