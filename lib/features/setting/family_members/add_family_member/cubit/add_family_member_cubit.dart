import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'add_family_member_state.dart';

class AddFamilyMemberCubit extends Cubit<AddFamilyMemberState> {
  AddFamilyMemberCubit(Map<String, dynamic>? data)
    : super(AddFamilyMemberState()) {
    if (data != null) {
      final member = data["member"] as FamilyMembersModel;
      _pendingStandardId = member.standard;
      _pendingWorkTypeId = member.workTypeId;

      refresh(
        state.copyWith(
          memberId: data["memberId"],
          selectedOccupation: member.occupation,
          selectedRole: member.role,
          selectedRelation: member.relation,
        ),
      );

      memberNameController.text = member.name ?? "";
      emailController.text = member.email ?? "";
      businessNameController.text = member.businessName ?? "";
      phoneNumberController.text = member.phone ?? "";
      ageController.text = member.age ?? "";
    }

    _loadStandards();
    _loadWorkTypes();
  }

  String? _pendingStandardId;
  String? _pendingWorkTypeId;

  TextEditingController memberNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final List<String> ageOptions = List.generate(100, (index) => "${index + 1}");

  void refresh(AddFamilyMemberState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onChangeStandard(StandardModel? value) {
    refresh(state.copyWith(selectedStandard: value, standardError: ""));
  }

  void onChangeOccupation(FamilyMemberOccupation? value) {
    final isJobOrBusiness =
        value == FamilyMemberOccupation.job ||
        value == FamilyMemberOccupation.business;

    refresh(
      state.copyWith(
        selectedOccupation: value,
        selectedStandard: value == FamilyMemberOccupation.study
            ? state.selectedStandard
            : null,
        selectedWorkType: isJobOrBusiness ? state.selectedWorkType : null,
        selectedRole: isJobOrBusiness ? state.selectedRole : null,
      ),
    );
  }

  void onChangeWorkType(WorkTypeModel? value) {
    refresh(state.copyWith(selectedWorkType: value, workTypeError: ""));
  }

  StandardModel? _findStandardById(String? standardId) {
    if (standardId == null || standardId.isEmpty) {
      return null;
    }
    return state.standardList.firstWhereOrNull(
      (e) => e.id?.toString() == standardId,
    );
  }

  WorkTypeModel? _findWorkTypeById(String? workTypeId) {
    if (workTypeId == null || workTypeId.isEmpty) {
      return null;
    }
    return state.workTypeList.firstWhereOrNull(
      (e) => e.id?.toString() == workTypeId,
    );
  }

  void _applyPendingStandardSelection() {
    final standardId = _pendingStandardId;
    if (standardId == null || state.standardList.isEmpty) {
      return;
    }

    final selected = _findStandardById(standardId);
    if (selected != null) {
      refresh(state.copyWith(selectedStandard: selected));
    }
    _pendingStandardId = null;
  }

  void _applyPendingWorkTypeSelection() {
    final workTypeId = _pendingWorkTypeId;
    if (workTypeId == null || state.workTypeList.isEmpty) {
      return;
    }

    final selected = _findWorkTypeById(workTypeId);
    if (selected != null) {
      refresh(state.copyWith(selectedWorkType: selected));
    }
    _pendingWorkTypeId = null;
  }

  Future<void> _loadStandards() async {
    try {
      final response = await DashboardRepo.standards();
      refresh(state.copyWith(standardList: response.data ?? <StandardModel>[]));
      _applyPendingStandardSelection();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> _loadWorkTypes() async {
    try {
      final response = await BusinessRepo.workTypes();
      refresh(state.copyWith(workTypeList: response.data ?? <WorkTypeModel>[]));
      _applyPendingWorkTypeSelection();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  void onChangeRole(FamilyMemberOccupationRole? value) {
    refresh(state.copyWith(selectedRole: value));
  }

  void onChangeRelation(FamilyMemberRelation? value) {
    refresh(state.copyWith(selectedRelation: value));
  }

  bool validation(BuildContext context) {
    String memberNameError = "";
    String occupationError = "";
    String emailError = "";
    String ageError = "";
    String workTypeError = "";
    String businessNameError = "";
    String roleError = "";
    String standardError = "";
    String phoneNumberError = "";
    String relationError = "";

    if (memberNameController.text.trim().isEmpty) {
      memberNameError = context.l10n?.memberNameIsRequired ?? "";
    }

    if (emailController.text.trim().isEmpty) {
      emailError = context.l10n?.emailIsRequired ?? "";
    } else if (!emailController.text.trim().isEmailValid()) {
      emailError = context.l10n?.emailIsInvalid ?? "";
    }

    if (state.selectedOccupation == null) {
      occupationError = context.l10n?.occupationIsRequired ?? "";
    }

    if (ageController.text.trim().isEmpty) {
      ageError = context.l10n?.ageIsRequired ?? "";
    }

    if (state.selectedOccupation == .study && state.selectedStandard == null) {
      standardError = context.l10n?.standardIsRequired ?? "";
    }

    if ((state.selectedOccupation == .job ||
            state.selectedOccupation == .business) &&
        state.selectedRole == null) {
      roleError = context.l10n?.roleIsRequired ?? "";
    }

    if ((state.selectedOccupation == .job ||
            state.selectedOccupation == .business) &&
        state.selectedWorkType == null) {
      workTypeError = context.l10n?.workTypeIsRequired ?? "";
    }

    if (state.selectedOccupation == .business &&
        businessNameController.text.trim().isEmpty) {
      businessNameError = context.l10n?.businessNameIsRequired ?? "";
    }

    if (phoneNumberController.text.trim().isEmpty) {
      phoneNumberError = context.l10n?.phoneNumberIsRequired ?? "";
    } else if (!phoneNumberController.text.trim().isPhoneValid()) {
      phoneNumberError = context.l10n?.phoneNumberIsInvalid ?? "";
    }

    if (state.selectedRelation == null) {
      relationError = context.l10n?.relationIsRequired ?? "";
    }

    refresh(
      state.copyWith(
        memberNameError: memberNameError,
        emailError: emailError,
        occupationError: occupationError,
        ageError: ageError,
        workTypeError: workTypeError,
        businessNameError: businessNameError,
        roleError: roleError,
        standardError: standardError,
        phoneNumberError: phoneNumberError,
        relationError: relationError,
      ),
    );

    return memberNameError.isEmpty &&
        emailError.isEmpty &&
        occupationError.isEmpty &&
        ageError.isEmpty &&
        workTypeError.isEmpty &&
        businessNameError.isEmpty &&
        roleError.isEmpty &&
        standardError.isEmpty &&
        phoneNumberError.isEmpty &&
        relationError.isEmpty;
  }

  String? get _standardId => state.selectedStandard?.id?.toString();

  String? get _workTypeId => state.selectedWorkType?.id?.toString();

  Future<void> onTapSubmit(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(loader: true));

    try {
      final isEditMode = state.memberId.isNotEmpty;
      final response = isEditMode
          ? await SettingRepo.editMember(
              memberId: state.memberId,
              name: memberNameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneNumberController.text.trim(),
              age: ageController.text.trim(),
              relation: state.selectedRelation?.name ?? "",
              occupation: state.selectedOccupation?.name ?? "",
              standardId:
                  state.selectedOccupation == FamilyMemberOccupation.study
                  ? _standardId
                  : null,
              workTypeId:
                  (state.selectedOccupation == FamilyMemberOccupation.job ||
                      state.selectedOccupation ==
                          FamilyMemberOccupation.business)
                  ? _workTypeId
                  : null,
              role:
                  (state.selectedOccupation == FamilyMemberOccupation.job ||
                      state.selectedOccupation ==
                          FamilyMemberOccupation.business)
                  ? state.selectedRole?.name
                  : null,
              businessName:
                  state.selectedOccupation == FamilyMemberOccupation.business
                  ? businessNameController.text.trim()
                  : null,
            )
          : await SettingRepo.addMember(
              name: memberNameController.text.trim(),
              email: emailController.text.trim(),
              phone: phoneNumberController.text.trim(),
              age: ageController.text.trim(),
              relation: state.selectedRelation?.name ?? "",
              occupation: state.selectedOccupation?.name ?? "",
              standardId:
                  state.selectedOccupation == FamilyMemberOccupation.study
                  ? _standardId
                  : null,
              workTypeId:
                  (state.selectedOccupation == FamilyMemberOccupation.job ||
                      state.selectedOccupation ==
                          FamilyMemberOccupation.business)
                  ? _workTypeId
                  : null,
              role:
                  (state.selectedOccupation == FamilyMemberOccupation.job ||
                      state.selectedOccupation ==
                          FamilyMemberOccupation.business)
                  ? state.selectedRole?.name
                  : null,
              businessName:
                  state.selectedOccupation == FamilyMemberOccupation.business
                  ? businessNameController.text.trim()
                  : null,
            );

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);
      context.navigator.pop(response.data);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(loader: false));
      }
    }
  }
}
