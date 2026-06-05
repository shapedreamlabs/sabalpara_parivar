import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'business_state.dart';

class BusinessCubit extends Cubit<BusinessState> {
  BusinessCubit() : super(BusinessState()) {
    _loadWorkTypes();
  }

  Timer? searchTimer;
  TextEditingController searchController = TextEditingController();

  void refresh(BusinessState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadWorkTypes() async {
    refresh(state.copyWith(loader: true));
    try {
      final response = await BusinessRepo.workTypes();
      final workTypes = response.data ?? <WorkTypeModel>[];
      refresh(
        state.copyWith(
          loader: false,
          workTypesList: workTypes,
          filteredWorkTypesList: workTypes,
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
        refresh(state.copyWith(filteredWorkTypesList: state.workTypesList));
        return;
      }

      final filtered = state.workTypesList.where((workType) {
        final name = (workType.name ?? '').toLowerCase();
        final slug = (workType.slug ?? '').toLowerCase();
        return name.contains(query) || slug.contains(query);
      }).toList();

      refresh(state.copyWith(filteredWorkTypesList: filtered));
    });
  }

  void onTapWorkType(BuildContext context, WorkTypeModel workType) {
    final workTypeId = workType.id?.toString() ?? "";
    if (workTypeId.isEmpty) {
      showErrorToast('Invalid business type id');
      return;
    }

    context.navigator.pushNamed(
      CommunityUsersScreen.routeName,
      arguments: {"title": workType.name ?? "", "workTypeId": workTypeId},
    );
  }
}
