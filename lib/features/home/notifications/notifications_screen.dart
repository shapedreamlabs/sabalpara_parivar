import 'package:sabalpara_family/sabalpara_family.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const routeName = '/notifications';

  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
      create: (c) => NotificationsCubit(),
      child: const NotificationsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title: l10n?.notifications ?? "",
              actions: [
                Padding(
                  padding: .only(right: 10.w),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: .circular(10.r),
                      onTap: () {},
                      child: Padding(
                        padding: .symmetric(vertical: 2.h, horizontal: 5.w),
                        child: Text(
                          l10n?.readAll ?? "",
                          style: styleW500S16.copyWith(
                            color: AppColors.text.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: CustomListView(
              itemCount: state.notificationsList.length,
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              separatorBuilder: (_, _) => 15.h.spaceVertical,
              itemBuilder: (context, index) {
                final notificationData = state.notificationsList[index];

                return CommonNotificationCardWidget(
                  notificationData: notificationData,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CommonNotificationCardWidget extends StatelessWidget {
  const CommonNotificationCardWidget({
    super.key,
    required this.notificationData,
  });

  final NotificationModel notificationData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(8.r),
        border: .all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Row(
        spacing: 10.w,
        crossAxisAlignment: .start,
        children: [
          AssetsImg(
            imagePath: notificationData.image ?? "",
            height: 50.h,
            width: 50.h,
          ),

          Expanded(
            child: Column(
              spacing: 5.h,
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notificationData.title ?? "",
                        style: styleW700S16,
                      ),
                    ),

                    Text(
                      "5 days ago",
                      style: styleW500S12.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                Text(
                  notificationData.message ?? "",
                  style: styleW500S12.copyWith(
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
