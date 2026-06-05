import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(Map<String, dynamic>? data) : super(EditProfileState()) {
    _prefillFromLocal();

    _loadVillages();
    _loadWorkTypes();
    _loadCities();
    _loadStandards();
    _loadProfile();
  }

  String? _pendingStandardId;
  String? _pendingVillageId;
  String? _pendingWorkTypeId;

  void _prefillFromLocal() {
    _pendingVillageId = userModel?.village;

    refresh(
      state.copyWith(
        selectedOccupation: FamilyMemberOccupation.values.firstWhereOrNull(
          (e) => e.name == userModel?.occupation,
        ),
        selectedCity: userModel?.city,
      ),
    );

    nameController.text = userModel?.name ?? "";
    emailController.text = userModel?.email ?? "";
    phoneNumberController.text = userModel?.phone ?? "";
    addressController.text = userModel?.address ?? "";
    ageController.text = userModel?.age ?? "";
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void refresh(EditProfileState state) {
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
        selectedStandard:
            value == FamilyMemberOccupation.study ? state.selectedStandard : null,
        selectedWorkType: isJobOrBusiness ? state.selectedWorkType : null,
        selectedRole: isJobOrBusiness ? state.selectedRole : null,
      ),
    );
  }

  StandardModel? _findStandardById(String? standardId) {
    if (standardId == null || standardId.isEmpty) {
      return null;
    }
    return state.standardList.firstWhereOrNull(
      (e) => e.id?.toString() == standardId,
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

  void onChangeWorkType(WorkTypeModel? value) {
    refresh(state.copyWith(selectedWorkType: value, workTypeError: ""));
  }

  WorkTypeModel? _findWorkTypeById(String? workTypeId) {
    if (workTypeId == null || workTypeId.isEmpty) {
      return null;
    }
    return state.workTypeList.firstWhereOrNull(
      (e) => e.id?.toString() == workTypeId,
    );
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

  void onChangeRole(FamilyMemberOccupationRole? value) {
    refresh(state.copyWith(selectedRole: value));
  }

  void onChangeVillage(VillageModel? value) {
    refresh(
      state.copyWith(
        selectedVillage: value,
        selectedVillageId: value?.id?.toString(),
        villageError: "",
      ),
    );
  }

  VillageModel? _findVillageById(String? villageId) {
    if (villageId == null || villageId.isEmpty) {
      return null;
    }
    return state.villageList.firstWhereOrNull(
      (e) => e.id?.toString() == villageId,
    );
  }

  VillageModel? _findVillageByName(String? name) {
    if (name == null || name.isEmpty) {
      return null;
    }
    return state.villageList.firstWhereOrNull((e) => e.name == name);
  }

  void _applyPendingVillageSelection() {
    final villageId = _pendingVillageId;
    if (villageId == null || state.villageList.isEmpty) {
      return;
    }

    final selected = _findVillageById(villageId);
    if (selected != null) {
      refresh(
        state.copyWith(
          selectedVillage: selected,
          selectedVillageId: villageId,
        ),
      );
    }
    _pendingVillageId = null;
  }

  void onChangeCity(String? value) {
    final city = state.cityList.firstWhereOrNull((e) => e.name == value);
    refresh(
      state.copyWith(
        selectedCity: value,
        selectedCityId: city?.id?.toString(),
      ),
    );
  }

  Future<void> _loadWorkTypes() async {
    try {
      final response = await BusinessRepo.workTypes();
      refresh(
        state.copyWith(workTypeList: response.data ?? <WorkTypeModel>[]),
      );
      _applyPendingWorkTypeSelection();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> _loadVillages() async {
    try {
      final response = await VillagesRepo.villages();
      refresh(
        state.copyWith(villageList: response.data ?? <VillageModel>[]),
      );
      _applyPendingVillageSelection();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> _loadStandards() async {
    try {
      final response = await DashboardRepo.standards();
      refresh(
        state.copyWith(standardList: response.data ?? <StandardModel>[]),
      );
      _applyPendingStandardSelection();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> _loadCities() async {
    try {
      final response = await SettingRepo.cities();
      final cities = response.data ?? <CityModel>[];

      final selectedCityName = state.selectedCity;
      final cityExists = selectedCityName == null
          ? false
          : cities.any((e) => e.name == selectedCityName);
      final selectedCity = cityExists
          ? cities.firstWhereOrNull((e) => e.name == selectedCityName)
          : null;

      refresh(
        state.copyWith(
          cityList: cities,
          selectedCity: cityExists ? selectedCityName : null,
          selectedCityId: selectedCity?.id?.toString(),
        ),
      );
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> _loadProfile() async {
    try {
      final response = await SettingRepo.profile();
      final profile = response.data;

      if (profile == null) {
        return;
      }

      nameController.text = profile.name ?? "";
      emailController.text = profile.email ?? "";
      phoneNumberController.text = profile.phone ?? "";
      addressController.text = profile.address ?? "";
      ageController.text = profile.age ?? "";
      businessNameController.text = profile.businessName ?? "";

      final selectedOccupation = FamilyMemberOccupation.values.firstWhereOrNull(
        (e) => e.name == profile.occupation,
      );
      final selectedRole = FamilyMemberOccupationRole.values.firstWhereOrNull(
        (e) => e.name == profile.roles?.toLowerCase(),
      );
      _pendingStandardId = profile.standardId;
      _pendingVillageId = profile.villageId;
      _pendingWorkTypeId = profile.workTypeId;

      final selectedVillage =
          _findVillageById(profile.villageId) ??
          _findVillageByName(profile.villageName);

      refresh(
        state.copyWith(
          selectedOccupation: selectedOccupation,
          selectedRole: selectedRole,
          selectedWorkType: _findWorkTypeById(profile.workTypeId),
          selectedStandard: _findStandardById(profile.standardId),
          selectedVillage: selectedVillage,
          selectedVillageId: profile.villageId,
          selectedCity: profile.cityName ?? state.selectedCity,
          selectedCityId: profile.cityId,
          profileImageUrl: profile.avatar,
        ),
      );

      _applyPendingStandardSelection();
      _applyPendingVillageSelection();
      _applyPendingWorkTypeSelection();

      await PrefService.set(PrefKeys.userData, userModelToJson(profile.toUserModel()));
      if ((profile.accessToken ?? '').isNotEmpty) {
        await PrefService.set(PrefKeys.token, profile.accessToken);
      }
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<void> onChangeProfile(BuildContext context) async {
    try {
      final result = await MediaPicker.pickMedia(context: context);
      if (result != null) {
        refresh(state.copyWith(profileImage: File(result.path)));
      }
    } catch (exception, stack) {
      showCatchToast(exception, stack);
    }
  }

  bool validation(BuildContext context) {
    String nameError = "";
    String emailError = "";
    String phoneNumberError = "";
    String occupationError = "";
    String workTypeError = "";
    String businessNameError = "";
    String roleError = "";
    String standardError = "";
    String ageError = "";
    String villageError = "";
    String addressError = "";
    String cityError = "";

    if (nameController.text.trim().isEmpty) {
      nameError = context.l10n?.nameIsRequired ?? "";
    }

    if (emailController.text.trim().isEmpty) {
      emailError = context.l10n?.emailIsRequired ?? "";
    } else if (!emailController.text.trim().isEmailValid()) {
      emailError = context.l10n?.emailIsInvalid ?? "";
    }

    if (phoneNumberController.text.trim().isEmpty) {
      phoneNumberError = context.l10n?.phoneNumberIsRequired ?? "";
    } else if (!phoneNumberController.text.trim().isPhoneValid()) {
      phoneNumberError = context.l10n?.phoneNumberIsInvalid ?? "";
    }

    if (state.selectedOccupation == null) {
      occupationError = context.l10n?.occupationIsRequired ?? "";
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

    if (ageController.text.trim().isEmpty) {
      ageError = context.l10n?.ageIsRequired ?? "";
    }

    if (state.selectedVillage == null) {
      villageError = context.l10n?.villageIsRequired ?? "";
    }

    if (addressController.text.trim().isEmpty) {
      addressError = context.l10n?.addressIsRequired ?? "";
    }

    if (state.selectedCity == null) {
      cityError = context.l10n?.cityIsRequired ?? "";
    }

    refresh(
      state.copyWith(
        nameError: nameError,
        emailError: emailError,
        phoneNumberError: phoneNumberError,
        occupationError: occupationError,
        workTypeError: workTypeError,
        businessNameError: businessNameError,
        roleError: roleError,
        standardError: standardError,
        ageError: ageError,
        villageError: villageError,
        addressError: addressError,
        cityError: cityError,
      ),
    );

    return nameError.isEmpty &&
        emailError.isEmpty &&
        phoneNumberError.isEmpty &&
        occupationError.isEmpty &&
        workTypeError.isEmpty &&
        businessNameError.isEmpty &&
        roleError.isEmpty &&
        standardError.isEmpty &&
        ageError.isEmpty &&
        villageError.isEmpty &&
        addressError.isEmpty &&
        cityError.isEmpty;
  }

  Future<void> onTapSave(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(loader: true));

    try {
      final fields = <String, dynamic>{
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneNumberController.text.trim(),
        'age': ageController.text.trim(),
        'address': addressController.text.trim(),
        'occupation': state.selectedOccupation?.name ?? '',
      };

      if ((state.selectedCityId ?? '').isNotEmpty) {
        fields['city_id'] = state.selectedCityId;
      }
      if ((state.selectedVillageId ?? '').isNotEmpty) {
        fields['village_id'] = state.selectedVillageId;
      }
      if (state.selectedOccupation == FamilyMemberOccupation.study &&
          state.selectedStandard?.id != null) {
        fields['standard_id'] = state.selectedStandard!.id.toString();
      }
      if ((state.selectedOccupation == FamilyMemberOccupation.job ||
              state.selectedOccupation == FamilyMemberOccupation.business) &&
          state.selectedWorkType?.id != null) {
        fields['work_type_id'] = state.selectedWorkType!.id.toString();
      }
      if ((state.selectedOccupation == FamilyMemberOccupation.job ||
              state.selectedOccupation == FamilyMemberOccupation.business) &&
          state.selectedRole != null) {
        fields['role'] = state.selectedRole!.name;
      }
      if (state.selectedOccupation == FamilyMemberOccupation.business &&
          businessNameController.text.trim().isNotEmpty) {
        fields['business_name'] = businessNameController.text.trim();
      }

      final response = await SettingRepo.editProfile(
        fields: fields,
        avatar: state.profileImage,
      );
      final profile = response.data;
      if (profile == null) {
        throw AppException(message: 'Invalid server response');
      }

      final user = profile.toUserModel();
      await PrefService.set(PrefKeys.userData, userModelToJson(user));
      if ((profile.accessToken ?? '').isNotEmpty) {
        await PrefService.set(PrefKeys.token, profile.accessToken);
      }

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);
      context.navigator.pop(user);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(loader: false));
      }
    }
  }
}
