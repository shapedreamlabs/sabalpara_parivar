import 'package:sabalpara_family/sabalpara_family.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const routeName = '/setting';

  static Widget builder(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (c) => SettingCubit(context),
      child: const SettingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return CommonBgWidget(
          backgroundColor: AppColors.primary,
          blurColor: AppColors.white,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              backArrow: false,
              centerTitle: false,
              systemUiStyle: .light,
              title: l10n?.setting ?? "",
              titleStyle: styleW700S24.copyWith(color: AppColors.white),
            ),
            body: Stack(
              alignment: .topCenter,
              children: [
                Padding(
                  padding: .symmetric(
                    vertical: 10.h,
                    horizontal: AppConstants.horizontalPadding,
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Container(
                        width: 115.h,
                        height: 115.h,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.6),
                          borderRadius: .circular(500.r),
                        ),
                        child: Center(
                          child: (state.avatar.isNotEmpty)
                              ? CachedImage(
                                  state.avatar,
                                  skipBaseUrl: true,
                                  height: 114.h,
                                  width: 114.h,
                                  fit: .cover,
                                  borderRadius: 500.r,
                                )
                              : AssetsImg(
                                  imagePath: AppAssets.profileImage,
                                  height: 114.h,
                                  width: 114.h,
                                  borderRadius: 500.r,
                                ),
                        ),
                      ),

                      15.h.spaceVertical,

                      Text(
                        state.name.isNotEmpty ? state.name : "User",
                        style: styleW700S20.copyWith(color: AppColors.white),
                      ),

                      6.h.spaceVertical,

                      Text(
                        state.email,
                        style: styleW400S16.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: .bottomCenter,
                  child: DraggableScrollableSheet(
                    minChildSize: 0.6,
                    initialChildSize: 0.65,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: .vertical(top: .circular(20.r)),
                        ),
                        child: SingleChildScrollView(
                          child: CustomListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.settings.length,
                            separatorBuilder: (context, index) => Padding(
                              padding: .symmetric(
                                horizontal: AppConstants.horizontalPadding,
                              ),
                              child: CommonDivider(
                                color: AppColors.text.withValues(alpha: 0.1),
                              ),
                            ),
                            itemBuilder: (context, index) {
                              final setting = state.settings[index];

                              return SettingItemWidget(
                                isFirst: index == 0,
                                isLast: index == state.settings.length - 1,
                                title: setting.title ?? "",
                                icon: setting.icon ?? "",
                                onTap: setting.onTap,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final bool isFirst;
  final bool isLast;
  final String title;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
        child: Container(
          padding: .symmetric(
            vertical: 20.h,
            horizontal: AppConstants.horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: isFirst ? .vertical(top: .circular(20.r)) : null,
          ),
          child: Row(
            spacing: 12.w,
            children: [
              SvgAsset(
                imagePath: icon,
                height: 24.h,
                color: isLast ? AppColors.red : AppColors.text,
              ),

              Expanded(
                child: Text(
                  title,
                  style: styleW600S16.copyWith(
                    color: isLast ? AppColors.red : AppColors.text,
                  ),
                ),
              ),

              if (!isLast)
                RotatedBox(
                  quarterTurns: 3,
                  child: SvgAsset(imagePath: AppAssets.downArrow, height: 16.h),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
