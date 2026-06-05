import 'package:sabalpara_family/sabalpara_family.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  static const routeName = '/my_profile';

  static Widget builder(BuildContext context) {
    return BlocProvider<MyProfileCubit>(
      create: (c) => MyProfileCubit(),
      child: const MyProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<MyProfileCubit, MyProfileState>(
      builder: (context, state) {
        final cubit = context.read<MyProfileCubit>();

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.myProfile ?? ""),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: l10n?.edit ?? "",
                  onTap: () => cubit.onTapEdit(context),
                ),
              ),
            ),
            body: CustomSingleChildScroll(
              padding: .symmetric(
                horizontal: AppConstants.horizontalPadding,
                vertical: 10.h,
              ),
              child: Padding(
                padding: .only(top: 58.h),
                child: Stack(
                  clipBehavior: .none,
                  alignment: .topCenter,
                  children: [
                    Container(
                      padding: .symmetric(horizontal: 15.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.text.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: .min,
                        children: [
                          65.h.spaceVertical,

                          MyProfileItemWidget(
                            title: l10n?.name ?? "",
                            value: userModel?.name ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.email ?? "",
                            value: userModel?.email ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.phone ?? "",
                            value: userModel?.phone ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.occupation ?? "",
                            value: userModel?.occupation ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.age ?? "",
                            value: userModel?.age ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.village ?? "",
                            value: userModel?.village ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.address ?? "",
                            value: userModel?.address ?? "-",
                          ),

                          MyProfileItemWidget(
                            title: l10n?.city ?? "",
                            value: userModel?.city ?? "-",
                            needDivider: false,
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: -58.h,
                      child: (userModel?.image ?? "").isNotEmpty
                          ? CachedImage(
                              userModel?.image,
                              skipBaseUrl: true,
                              height: 116.h,
                              width: 116.h,
                              fit: .cover,
                              borderRadius: 500.r,
                            )
                          : AssetsImg(
                              imagePath: AppAssets.profileImage,
                              height: 116.h,
                              width: 116.h,
                              fit: .cover,
                              borderRadius: 500.r,
                            ),
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

class MyProfileItemWidget extends StatelessWidget {
  const MyProfileItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.needDivider = true,
  });

  final String title;
  final String value;
  final bool needDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        border: !needDivider
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.text.withValues(alpha: 0.1),
                ),
              ),
      ),
      child: Row(
        spacing: 10.w,
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Text(
              title,
              style: styleW500S16.copyWith(
                color: AppColors.text.withValues(alpha: 0.6),
              ),
            ),
          ),

          Expanded(
            child: Text(value, style: styleW600S16, textAlign: .end),
          ),
        ],
      ),
    );
  }
}
