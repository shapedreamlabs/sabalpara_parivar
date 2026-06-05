import 'package:sabalpara_family/sabalpara_family.dart';

part 'family_members_state.dart';

class FamilyMembersCubit extends Cubit<FamilyMembersState> {
  FamilyMembersCubit(BuildContext context) : super(FamilyMembersState()) {
    init(context);
  }

  void refresh(FamilyMembersState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> init(BuildContext context) async {
    refresh(state.copyWith(loader: true));
    try {
      final response = await SettingRepo.members();
      refresh(
        state.copyWith(
          loader: false,
          familyMembersList: response.data ?? <FamilyMembersModel>[],
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }

  Future<void> onTapAddMember(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      AddFamilyMemberScreen.routeName,
    );

    if (result != null) {
      refresh(
        state.copyWith(
          familyMembersList: List<FamilyMembersModel>.from([
            ...state.familyMembersList,
            result as FamilyMembersModel,
          ]),
        ),
      );
    }
  }

  Future<void> onTapEditMember(BuildContext context, int index) async {
    final member = state.familyMembersList[index];
    final result = await context.navigator.pushNamed(
      AddFamilyMemberScreen.routeName,
      arguments: {
        "member": member,
        "memberId": member.id?.toString() ?? "",
        "index": index,
      },
    );

    if (result != null) {
      final updatedMember = result as FamilyMembersModel;
      final updatedList = List<FamilyMembersModel>.from(
        state.familyMembersList,
      );
      updatedList[index] = updatedMember;
      refresh(state.copyWith(familyMembersList: updatedList));
    }
  }

  Future<void> onTapDeleteMember(BuildContext context, int index) async {
    final memberId = state.familyMembersList[index].id?.toString() ?? "";
    if (memberId.isEmpty) {
      showErrorToast('Invalid member id');
      return;
    }

    try {
      await SettingRepo.deleteMember(id: memberId);
      final updatedList = List<FamilyMembersModel>.from(state.familyMembersList)
        ..removeAt(index);
      refresh(state.copyWith(familyMembersList: updatedList));
      showSuccessToast('Member deleted successfully');
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
