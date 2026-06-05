import 'package:sabalpara_family/sabalpara_family.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState()) {
    init();
  }

  void refresh(NotificationsState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init() {
    final notificationsList = [
      NotificationModel(
        title: "Notification 1",
        image: AppAssets.notificationImage,
        message: "Notification 1 message",
        createdAt: "2026-01-01",
      ),
      NotificationModel(
        title: "Notification 2",
        image: AppAssets.notificationImage,
        message: "Notification 2 message",
        createdAt: "2026-01-02",
      ),
      NotificationModel(
        title: "Notification 3",
        image: AppAssets.notificationImage,
        message: "Notification 3 message",
        createdAt: "2026-01-03",
      ),
      NotificationModel(
        title: "Notification 4",
        image: AppAssets.notificationImage,
        message: "Notification 4 message",
        createdAt: "2026-01-04",
      ),
      NotificationModel(
        title: "Notification 5",
        image: AppAssets.notificationImage,
        message: "Notification 5 message",
        createdAt: "2026-01-05",
      ),
    ];

    refresh(state.copyWith(notificationsList: notificationsList));
  }
}
