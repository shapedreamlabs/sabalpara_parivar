part of 'community_users_cubit.dart';

class CommunityUsersState extends Equatable {
  const CommunityUsersState({
    this.loader = false,
    this.title = "",
    this.usersList = const [],
  });

  final bool loader;
  final String title;
  final List<CommunityUserModel> usersList;

  CommunityUsersState copyWith({
    bool? loader,
    String? title,
    List<CommunityUserModel>? usersList,
  }) {
    return CommunityUsersState(
      loader: loader ?? this.loader,
      title: title ?? this.title,
      usersList: usersList ?? this.usersList,
    );
  }

  @override
  List<Object?> get props => [loader, title, usersList];
}
