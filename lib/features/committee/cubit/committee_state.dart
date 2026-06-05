part of 'committee_cubit.dart';

class CommitteeState extends Equatable {
  const CommitteeState({
    this.loader = false,
    this.typeList = const [],
    this.selectedTypeList = const [],
    this.committeeMembersList = const [],
  });

  final bool loader;
  final List<String> typeList;
  final List<String> selectedTypeList;
  final List<CommitteeMembersModel> committeeMembersList;

  CommitteeState copyWith({
    bool? loader,
    List<String>? typeList,
    List<String>? selectedTypeList,
    List<CommitteeMembersModel>? committeeMembersList,
  }) {
    return CommitteeState(
      loader: loader ?? this.loader,
      typeList: typeList ?? this.typeList,
      selectedTypeList: selectedTypeList ?? this.selectedTypeList,
      committeeMembersList: committeeMembersList ?? this.committeeMembersList,
    );
  }

  @override
  List<Object?> get props => [
        loader,
        typeList,
        selectedTypeList,
        committeeMembersList,
      ];
}
