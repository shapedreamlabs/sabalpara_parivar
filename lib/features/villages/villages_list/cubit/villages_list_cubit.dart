import 'package:sabalpara_family/sabalpara_family.dart';

part 'villages_list_state.dart';

class VillagesListCubit extends Cubit<VillagesListState> {
  VillagesListCubit(Map<String, dynamic> arguments)
    : super(VillagesListState()) {
    refresh(
      state.copyWith(
        villageName: arguments["villageName"],
        villageList: arguments["villageList"],
      ),
    );
  }

  void refresh(VillagesListState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }
}
