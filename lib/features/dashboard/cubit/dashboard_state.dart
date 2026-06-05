part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({this.tabIndex = 0});

  final int tabIndex;

  DashboardState copyWith({int? tabIndex}) {
    return DashboardState(tabIndex: tabIndex ?? this.tabIndex);
  }

  @override
  List<Object?> get props => [tabIndex];
}
