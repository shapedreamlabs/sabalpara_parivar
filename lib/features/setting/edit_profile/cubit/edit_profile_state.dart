part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.loader = false,
    this.nameError = "",
    this.emailError = "",
    this.phoneNumberError = "",
    this.occupationError = "",
    this.ageError = "",
    this.villageError = "",
    this.addressError = "",
    this.cityError = "",
    this.workTypeError = "",
    this.businessNameError = "",
    this.roleError = "",
    this.standardError = "",
    this.standardList = const [],
    this.villageList = const [],
    this.workTypeList = const [],
    this.cityList = const [],
    this.selectedOccupation,
    this.selectedWorkType,
    this.selectedRole,
    this.selectedStandard,
    this.selectedVillage,
    this.selectedVillageId,
    this.selectedCity,
    this.selectedCityId,
    this.profileImage,
    this.profileImageUrl,
  });

  final bool loader;
  final String nameError;
  final String emailError;
  final String phoneNumberError;
  final String occupationError;
  final String ageError;
  final String villageError;
  final String addressError;
  final String cityError;
  final String workTypeError;
  final String businessNameError;
  final String roleError;
  final String standardError;
  final List<StandardModel> standardList;
  final List<VillageModel> villageList;
  final List<WorkTypeModel> workTypeList;
  final List<CityModel> cityList;
  final FamilyMemberOccupation? selectedOccupation;
  final WorkTypeModel? selectedWorkType;
  final FamilyMemberOccupationRole? selectedRole;
  final StandardModel? selectedStandard;
  final VillageModel? selectedVillage;
  final String? selectedVillageId;
  final String? selectedCity;
  final String? selectedCityId;
  final File? profileImage;
  final String? profileImageUrl;

  EditProfileState copyWith({
    bool? loader,
    String? nameError,
    String? emailError,
    String? phoneNumberError,
    String? occupationError,
    String? ageError,
    String? villageError,
    String? addressError,
    String? cityError,
    String? workTypeError,
    String? businessNameError,
    String? roleError,
    String? standardError,
    List<StandardModel>? standardList,
    List<VillageModel>? villageList,
    List<WorkTypeModel>? workTypeList,
    List<CityModel>? cityList,
    FamilyMemberOccupation? selectedOccupation,
    WorkTypeModel? selectedWorkType,
    FamilyMemberOccupationRole? selectedRole,
    StandardModel? selectedStandard,
    VillageModel? selectedVillage,
    String? selectedVillageId,
    String? selectedCity,
    String? selectedCityId,
    File? profileImage,
    String? profileImageUrl,
  }) {
    return EditProfileState(
      loader: loader ?? this.loader,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      occupationError: occupationError ?? this.occupationError,
      ageError: ageError ?? this.ageError,
      villageError: villageError ?? this.villageError,
      addressError: addressError ?? this.addressError,
      cityError: cityError ?? this.cityError,
      workTypeError: workTypeError ?? this.workTypeError,
      businessNameError: businessNameError ?? this.businessNameError,
      roleError: roleError ?? this.roleError,
      standardError: standardError ?? this.standardError,
      standardList: standardList ?? this.standardList,
      villageList: villageList ?? this.villageList,
      workTypeList: workTypeList ?? this.workTypeList,
      cityList: cityList ?? this.cityList,
      selectedOccupation: selectedOccupation ?? this.selectedOccupation,
      selectedWorkType: selectedWorkType ?? this.selectedWorkType,
      selectedRole: selectedRole ?? this.selectedRole,
      selectedStandard: selectedStandard ?? this.selectedStandard,
      selectedVillage: selectedVillage ?? this.selectedVillage,
      selectedVillageId: selectedVillageId ?? this.selectedVillageId,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      profileImage: profileImage ?? this.profileImage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    nameError,
    emailError,
    phoneNumberError,
    occupationError,
    ageError,
    villageError,
    addressError,
    cityError,
    workTypeError,
    businessNameError,
    roleError,
    standardError,
    standardList,
    villageList,
    workTypeList,
    cityList,
    selectedOccupation,
    selectedWorkType,
    selectedRole,
    selectedStandard,
    selectedVillage,
    selectedVillageId,
    selectedCity,
    selectedCityId,
    profileImage,
    profileImageUrl,
  ];
}
