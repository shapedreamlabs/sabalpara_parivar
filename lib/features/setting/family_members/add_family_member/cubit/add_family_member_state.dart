part of 'add_family_member_cubit.dart';

class AddFamilyMemberState extends Equatable {
  const AddFamilyMemberState({
    this.loader = false,
    this.memberId = "",
    this.memberNameError = "",
    this.emailError = "",
    this.occupationError = "",
    this.ageError = "",
    this.workTypeError = "",
    this.businessNameError = "",
    this.roleError = "",
    this.standardError = "",
    this.phoneNumberError = "",
    this.relationError = "",
    this.standardList = const [],
    this.workTypeList = const [],
    this.selectedOccupation,
    this.selectedWorkType,
    this.selectedRole,
    this.selectedStandard,
    this.selectedRelation,
  });

  final bool loader;
  final String memberId;
  final String memberNameError;
  final String emailError;
  final String occupationError;
  final String ageError;
  final String workTypeError;
  final String businessNameError;
  final String roleError;
  final String standardError;
  final String phoneNumberError;
  final String relationError;
  final List<StandardModel> standardList;
  final List<WorkTypeModel> workTypeList;
  final FamilyMemberOccupation? selectedOccupation;
  final WorkTypeModel? selectedWorkType;
  final FamilyMemberOccupationRole? selectedRole;
  final StandardModel? selectedStandard;
  final FamilyMemberRelation? selectedRelation;

  AddFamilyMemberState copyWith({
    bool? loader,
    String? memberId,
    String? memberNameError,
    String? emailError,
    String? occupationError,
    String? ageError,
    String? workTypeError,
    String? businessNameError,
    String? roleError,
    String? standardError,
    String? phoneNumberError,
    String? relationError,
    List<StandardModel>? standardList,
    List<WorkTypeModel>? workTypeList,
    FamilyMemberOccupation? selectedOccupation,
    WorkTypeModel? selectedWorkType,
    FamilyMemberOccupationRole? selectedRole,
    StandardModel? selectedStandard,
    FamilyMemberRelation? selectedRelation,
  }) {
    return AddFamilyMemberState(
      loader: loader ?? this.loader,
      memberId: memberId ?? this.memberId,
      memberNameError: memberNameError ?? this.memberNameError,
      emailError: emailError ?? this.emailError,
      occupationError: occupationError ?? this.occupationError,
      ageError: ageError ?? this.ageError,
      workTypeError: workTypeError ?? this.workTypeError,
      businessNameError: businessNameError ?? this.businessNameError,
      roleError: roleError ?? this.roleError,
      standardError: standardError ?? this.standardError,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      relationError: relationError ?? this.relationError,
      standardList: standardList ?? this.standardList,
      workTypeList: workTypeList ?? this.workTypeList,
      selectedOccupation: selectedOccupation ?? this.selectedOccupation,
      selectedWorkType: selectedWorkType ?? this.selectedWorkType,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedStandard: selectedStandard ?? this.selectedStandard,
      selectedRelation: selectedRelation ?? this.selectedRelation,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    memberId,
    memberNameError,
    emailError,
    occupationError,
    ageError,
    workTypeError,
    businessNameError,
    roleError,
    standardError,
    phoneNumberError,
    relationError,
    standardList,
    workTypeList,
    selectedOccupation,
    selectedWorkType,
    selectedRole,
    selectedStandard,
    selectedRelation,
  ];
}
