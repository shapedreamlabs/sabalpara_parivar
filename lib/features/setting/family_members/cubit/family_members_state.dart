part of 'family_members_cubit.dart';

class FamilyMembersState extends Equatable {
  const FamilyMembersState({
    this.loader = false,
    this.familyMembersList = const [],
  });

  final bool loader;
  final List<FamilyMembersModel> familyMembersList;

  FamilyMembersState copyWith({
    bool? loader,
    List<FamilyMembersModel>? familyMembersList,
  }) {
    return FamilyMembersState(
      loader: loader ?? this.loader,
      familyMembersList: familyMembersList ?? this.familyMembersList,
    );
  }

  @override
  List<Object?> get props => [loader, familyMembersList];
}
