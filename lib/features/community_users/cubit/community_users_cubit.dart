import 'package:sabalpara_family/sabalpara_family.dart';

part 'community_users_state.dart';

class CommunityUsersCubit extends Cubit<CommunityUsersState> {
  CommunityUsersCubit(Map<String, dynamic>? arguments)
      : super(CommunityUsersState()) {
    final title = arguments?["title"]?.toString() ?? "";
    final villageId = arguments?["villageId"]?.toString() ?? "";
    final workTypeId = arguments?["workTypeId"]?.toString() ?? "";

    refresh(state.copyWith(title: title));
    _loadUsers(villageId: villageId, workTypeId: workTypeId);
  }

  void refresh(CommunityUsersState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadUsers({
    required String villageId,
    required String workTypeId,
  }) async {
    refresh(state.copyWith(loader: true));
    try {
      final ApiResponseModel<List<CommunityUserModel>> response;

      if (villageId.isNotEmpty) {
        response = await VillagesRepo.villageUsers(villageId: villageId);
      } else if (workTypeId.isNotEmpty) {
        response = await BusinessRepo.businessUsers(workTypeId: workTypeId);
      } else {
        refresh(state.copyWith(loader: false, usersList: []));
        return;
      }

      refresh(
        state.copyWith(
          loader: false,
          usersList: response.data ?? <CommunityUserModel>[],
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }
}
