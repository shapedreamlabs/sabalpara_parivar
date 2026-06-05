import 'package:sabalpara_family/sabalpara_family.dart';

class CommunityUsersScreen extends StatelessWidget {
  const CommunityUsersScreen({super.key});

  static const routeName = '/community_users';

  static Widget builder(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return BlocProvider<CommunityUsersCubit>(
      create: (c) => CommunityUsersCubit(arguments),
      child: const CommunityUsersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityUsersCubit, CommunityUsersState>(
      builder: (context, state) {
        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: state.title),
            body: state.loader
                ? const Center(child: AppLoader())
                : state.usersList.isEmpty
                    ? Center(
                        child: Text(
                          context.l10n?.noDataFound ?? "No data found",
                          style: styleW400S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : CustomListView(
                        padding: .symmetric(
                          horizontal: AppConstants.horizontalPadding,
                        ),
                        itemCount: state.usersList.length,
                        separatorBuilder: (context, index) =>
                            12.h.spaceVertical,
                        itemBuilder: (context, index) {
                          final userData = state.usersList[index];
                          return CommunityUserDetailsWidget(
                            userData: userData,
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}

class CommunityUserDetailsWidget extends StatelessWidget {
  const CommunityUserDetailsWidget({super.key, required this.userData});

  final CommunityUserModel userData;

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
          Text(userData.name ?? "", style: styleW700S16),

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
                  text: userData.phone ?? "",
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
                  text: "${l10n?.email ?? ""}: ",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
                TextSpan(
                  text: userData.email ?? "",
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
                  text: "${l10n?.occupation ?? ""}: ",
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.6),
                  ),
                ),
                TextSpan(
                  text: userData.occupation ?? "",
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
