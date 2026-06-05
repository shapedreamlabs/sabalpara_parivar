part of 'my_profile_cubit.dart';

class MyProfileState extends Equatable {
  const MyProfileState({this.loader = false, this.refreshKey = 0});

  final bool loader;
  final int refreshKey;

  MyProfileState copyWith({bool? loader, int? refreshKey}) {
    return MyProfileState(
      loader: loader ?? this.loader,
      refreshKey: refreshKey ?? this.refreshKey,
    );
  }

  @override
  List<Object?> get props => [loader, refreshKey];
}
