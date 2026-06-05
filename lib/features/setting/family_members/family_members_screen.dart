import 'package:sabalpara_family/sabalpara_family.dart';

class FamilyMembersScreen extends StatelessWidget {
  const FamilyMembersScreen({super.key});

  static const routeName = '/family_members';

  static Widget builder(BuildContext context) {
    return BlocProvider<FamilyMembersCubit>(
      create: (c) => FamilyMembersCubit(context),
      child: const FamilyMembersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<FamilyMembersCubit, FamilyMembersState>(
      builder: (context, state) {
        final cubit = context.read<FamilyMembersCubit>();

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.familyMembers ?? ""),
            floatingActionButton: Padding(
              padding: .only(bottom: 60.h),
              child: CustomIconButton(
                icon: AppAssets.addIcon,
                buttonColor: AppColors.primary,
                padding: 20.h,
                size: 24.h,
                onTap: () => cubit.onTapAddMember(context),
              ),
            ),
            body: CustomListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding,
              ),
              emptyWidget: Center(
                child: Text(
                  context.l10n?.noDataFound ?? '',
                  style: styleW700S20,
                ),
              ),
              showEmptyWidget: !state.loader && state.familyMembersList.isEmpty,
              itemCount: state.familyMembersList.length,
              separatorBuilder: (context, index) => 12.h.spaceVertical,
              itemBuilder: (context, index) {
                final familyMember = state.familyMembersList[index];
                return FamilyMemberItemWidget(
                  familyMember: familyMember,
                  onTapEdit: () => cubit.onTapEditMember(context, index),
                  onTapDelete: () => cubit.onTapDeleteMember(context, index),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class FamilyMemberItemWidget extends StatelessWidget {
  const FamilyMemberItemWidget({
    super.key,
    required this.familyMember,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  final FamilyMembersModel familyMember;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    final relation = familyMember.relation ?? .father;

    return Container(
      padding: .all(15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(familyMember.name ?? "", style: styleW700S16),

          4.h.spaceVertical,

          Text(
            familyMember.phone ?? "",
            style: styleW500S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.8),
            ),
          ),

          6.h.spaceVertical,

          Row(
            spacing: 10.w,
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            children: [
              CommonTagWidget(
                textStyle: styleW600S14,
                color: FamilyMemberRelation.getColor(relation),
                text: FamilyMemberRelation.getString(context, relation),
              ),

              Row(
                spacing: 5.h,
                mainAxisSize: .min,
                children: [
                  CustomIconButton(
                    icon: AppAssets.editIcon,
                    size: 20.h,
                    radius: 10.r,
                    onTap: onTapEdit,
                  ),

                  Container(
                    width: 1.w,
                    height: 20.h,
                    color: AppColors.text.withValues(alpha: 0.1),
                  ),

                  CustomIconButton(
                    icon: AppAssets.deleteIcon,
                    size: 20.h,
                    radius: 10.r,
                    onTap: onTapDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
