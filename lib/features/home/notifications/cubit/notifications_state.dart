part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.loader = false,
    this.notificationsList = const [],
  });

  final bool loader;
  final List<NotificationModel> notificationsList;

  NotificationsState copyWith({
    bool? loader,
    List<NotificationModel>? notificationsList,
  }) {
    return NotificationsState(
      loader: loader ?? this.loader,
      notificationsList: notificationsList ?? this.notificationsList,
    );
  }

  @override
  List<Object?> get props => [loader, notificationsList];
}
