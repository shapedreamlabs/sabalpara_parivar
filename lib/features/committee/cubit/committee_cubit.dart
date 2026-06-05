import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'committee_state.dart';

class CommitteeCubit extends Cubit<CommitteeState> {
  CommitteeCubit(BuildContext context) : super(CommitteeState()) {
    _loadCommittees();
  }

  Timer? searchTimer;
  TextEditingController searchController = TextEditingController();
  List<CommitteeMembersModel> _allMembersList = [];

  void refresh(CommitteeState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadCommittees() async {
    refresh(state.copyWith(loader: true));
    try {
      final response = await CommitteeRepo.committees();
      _allMembersList = response.data ?? <CommitteeMembersModel>[];

      final typeList = _allMembersList
          .map((e) => e.type ?? '')
          .where((e) => e.isNotEmpty)
          .toSet()
          .toList();

      refresh(
        state.copyWith(
          loader: false,
          typeList: typeList,
          committeeMembersList: _applyFilters(),
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }

  List<CommitteeMembersModel> _applyFilters({List<String>? selectedTypes}) {
    final query = searchController.text.trim().toLowerCase();
    final activeTypes = selectedTypes ?? state.selectedTypeList;

    return _allMembersList.where((member) {
      final matchesType =
          activeTypes.isEmpty || activeTypes.contains(member.type ?? '');

      if (!matchesType) return false;

      if (query.isEmpty) return true;

      final name = (member.name ?? '').toLowerCase();
      final email = (member.email ?? '').toLowerCase();
      final phone = (member.phone ?? '').toLowerCase();

      return name.contains(query) ||
          email.contains(query) ||
          phone.contains(query);
    }).toList();
  }

  void onSearchChanged(String value) {
    initSearchTimer();
  }

  void initSearchTimer() {
    searchTimer?.cancel();

    searchTimer = Timer(800.milliseconds, () {
      refresh(state.copyWith(committeeMembersList: _applyFilters()));
    });
  }

  void toggleTypeSelection(String type) {
    final updatedTypes = List<String>.from(state.selectedTypeList);
    if (updatedTypes.contains(type)) {
      updatedTypes.remove(type);
    } else {
      updatedTypes.add(type);
    }

    refresh(
      state.copyWith(
        selectedTypeList: updatedTypes,
        committeeMembersList: _applyFilters(selectedTypes: updatedTypes),
      ),
    );
  }
}
