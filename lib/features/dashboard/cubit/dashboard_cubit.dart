import 'package:sabalpara_family/sabalpara_family.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(BuildContext context, int? initialIndex)
    : super(DashboardState()) {
    if (initialIndex != null) {
      onTabChanged(initialIndex);
    }
  }

  void refresh(DashboardState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onTabChanged(int index) {
    refresh(state.copyWith(tabIndex: index));
  }
}
