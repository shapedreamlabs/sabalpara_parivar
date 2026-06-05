import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'villages_state.dart';

class VillagesCubit extends Cubit<VillagesState> {
  VillagesCubit() : super(VillagesState()) {
    _loadVillages();
  }

  Timer? searchTimer;
  TextEditingController searchController = TextEditingController();

  void refresh(VillagesState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadVillages() async {
    refresh(state.copyWith(loader: true));
    try {
      final response = await VillagesRepo.villages();
      final villages = response.data ?? <VillageModel>[];
      refresh(
        state.copyWith(
          loader: false,
          villageList: villages,
          filteredVillageList: villages,
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }

  void onSearchChanged(String value) {
    initSearchTimer();
  }

  void initSearchTimer() {
    searchTimer?.cancel();

    searchTimer = Timer(800.milliseconds, () {
      final query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        refresh(state.copyWith(filteredVillageList: state.villageList));
        return;
      }

      final filtered = state.villageList.where((village) {
        final name = (village.name ?? '').toLowerCase();
        final slug = (village.slug ?? '').toLowerCase();
        return name.contains(query) || slug.contains(query);
      }).toList();

      refresh(state.copyWith(filteredVillageList: filtered));
    });
  }

  void onTapVillage(BuildContext context, VillageModel village) {
    final villageId = village.id?.toString() ?? "";
    if (villageId.isEmpty) {
      showErrorToast('Invalid village id');
      return;
    }

    context.navigator.pushNamed(
      CommunityUsersScreen.routeName,
      arguments: {
        "title": village.name ?? "",
        "villageId": villageId,
      },
    );
  }
}
