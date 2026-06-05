import 'package:sabalpara_family/sabalpara_family.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static const routeName = '/edit_profile';

  static Widget builder(BuildContext context) {
    final data = context.args as Map<String, dynamic>?;
    return BlocProvider<EditProfileCubit>(
      create: (c) => EditProfileCubit(data),
      child: const EditProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.editProfile ?? ""),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: l10n?.save ?? "",
                  isLoading: state.loader,
                  onTap: () => cubit.onTapSave(context),
                ),
              ),
            ),
            body: CustomSingleChildScroll(
              child: Padding(
                padding: .symmetric(
                  horizontal: AppConstants.horizontalPadding,
                  vertical: 10.h,
                ),
                child: Column(
                  spacing: 15.h,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () => cubit.onChangeProfile(context),
                        borderRadius: .circular(500.r),
                        child: Stack(
                          clipBehavior: .none,
                          children: [
                            ///Profile Image
                            state.profileImage == null
                                ? ((state.profileImageUrl ?? "").isNotEmpty
                                      ? CachedImage(
                                          state.profileImageUrl,
                                          skipBaseUrl: true,
                                          height: 116.h,
                                          width: 116.h,
                                          fit: .cover,
                                          borderRadius: 500.r,
                                        )
                                      : AssetsImg(
                                          imagePath: AppAssets.profileImage,
                                          height: 116.h,
                                          width: 116.h,
                                          borderRadius: 500.r,
                                        ))
                                : FileImg(
                                    state.profileImage,
                                    height: 116.h,
                                    width: 116.h,
                                    fit: .cover,
                                    borderRadius: 500.r,
                                    errorWidget: Padding(
                                      padding: EdgeInsets.all(20.w),
                                      child: AssetsImg(
                                        imagePath: AppAssets.logoImg,
                                        height: 50.w,
                                        width: 50.w,
                                        borderRadius: 500.r,
                                      ),
                                    ),
                                  ),

                            ///Stack Camera
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: .all(5),
                                decoration: BoxDecoration(
                                  borderRadius: .circular(500.r),
                                  color: AppColors.primary,
                                  border: .all(
                                    width: 2.w,
                                    color: AppColors.white,
                                  ),
                                ),
                                child: Center(
                                  child: SvgAsset(
                                    imagePath: AppAssets.editPencilIcon,
                                    height: 16.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    AppTextField(
                      controller: cubit.nameController,
                      header: l10n?.name,
                      hintText: l10n?.enterName,
                      error: state.nameError,
                    ),

                    AppTextField(
                      controller: cubit.emailController,
                      header: l10n?.email,
                      hintText: l10n?.enterEmail,
                      error: state.emailError,
                      textInputType: TextInputType.emailAddress,
                    ),

                    AppTextField(
                      controller: cubit.phoneNumberController,
                      header: l10n?.phoneNumber,
                      hintText: l10n?.enterPhoneNumber,
                      error: state.phoneNumberError,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),

                    AppDropDown<FamilyMemberOccupation>(
                      onChanged: cubit.onChangeOccupation,
                      itemAsString: (value) =>
                          FamilyMemberOccupation.getString(context, value),
                      items: FamilyMemberOccupation.getOccupationsList(context),
                      value: state.selectedOccupation,
                      error: state.occupationError,
                      header: l10n?.occupation,
                      hintText: l10n?.selectOccupation,
                    ),

                    if (state.selectedOccupation != null &&
                        state.selectedOccupation != .none) ...[
                      AnimatedSwitcher(
                        duration: 500.milliseconds,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: child,
                              );
                            },
                        child: Builder(
                          key: ValueKey(state.selectedOccupation),
                          builder: (context) {
                            if (state.selectedOccupation == .study) {
                              return AppDropDown<StandardModel>(
                                onChanged: cubit.onChangeStandard,
                                itemAsString: (value) => value.name ?? "",
                                items: state.standardList,
                                value: state.selectedStandard,
                                error: state.standardError,
                                header: l10n?.standard,
                                hintText: l10n?.selectStandard,
                              );
                            }

                            return Column(
                              spacing: 15.h,
                              mainAxisSize: .min,
                              children: [
                                if (state.selectedOccupation == .job ||
                                    state.selectedOccupation == .business) ...[
                                  AppDropDown<WorkTypeModel>(
                                    onChanged: cubit.onChangeWorkType,
                                    itemAsString: (value) => value.name ?? "",
                                    items: state.workTypeList,
                                    value: state.selectedWorkType,
                                    error: state.workTypeError,
                                    header: l10n?.workType,
                                    hintText: l10n?.selectWorkType,
                                  ),

                                  if (state.selectedOccupation ==
                                      .business) ...[
                                    AppTextField(
                                      controller: cubit.businessNameController,
                                      header: l10n?.businessName,
                                      hintText: l10n?.enterBusinessName,
                                      error: state.businessNameError,
                                    ),
                                  ],

                                  AppDropDown<FamilyMemberOccupationRole>(
                                    onChanged: cubit.onChangeRole,
                                    itemAsString: (value) =>
                                        FamilyMemberOccupationRole.getString(
                                          context,
                                          value,
                                        ),
                                    items:
                                        FamilyMemberOccupationRole.getOccupationRolesList(
                                          context,
                                        ),
                                    value: state.selectedRole,
                                    error: state.roleError,
                                    header: l10n?.role,
                                    hintText: l10n?.selectRole,
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    AppTextField(
                      controller: cubit.ageController,
                      header: l10n?.age,
                      hintText: l10n?.enterAge,
                      error: state.ageError,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),

                    AppDropDown<VillageModel>(
                      onChanged: cubit.onChangeVillage,
                      itemAsString: (value) => value.name ?? "",
                      items: state.villageList,
                      value: state.selectedVillage,
                      error: state.villageError,
                      header: l10n?.village,
                      hintText: l10n?.selectVillage,
                    ),

                    AppTextField(
                      controller: cubit.addressController,
                      header: l10n?.address,
                      hintText: l10n?.enterAddress,
                      error: state.addressError,
                      minLines: 3,
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
                    ),

                    _CitySearchDropdown(
                      header: l10n?.city ?? "",
                      hintText: l10n?.selectCity ?? "",
                      error: state.cityError,
                      value: state.selectedCity,
                      cities: state.cityList,
                      onChanged: cubit.onChangeCity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CitySearchDropdown extends StatelessWidget {
  const _CitySearchDropdown({
    required this.header,
    required this.hintText,
    required this.error,
    required this.value,
    required this.cities,
    required this.onChanged,
  });

  final String header;
  final String hintText;
  final String error;
  final String? value;
  final List<CityModel> cities;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .only(bottom: 10.h),
          child: Text(header, style: styleW500S14),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              final selected = await _openCitySearchSheet(context);
              if (selected != null) {
                onChanged(selected.name);
              }
            },
            borderRadius: .circular(8.r),
            child: Container(
              width: double.maxFinite,
              padding: .symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: .circular(8.r),
                border: .all(
                  color: error.isNotEmpty
                      ? AppColors.red
                      : AppColors.text.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value?.isNotEmpty == true ? value! : hintText,
                      style: styleW400S14.copyWith(
                        color: error.isNotEmpty
                            ? AppColors.red
                            : (value?.isNotEmpty == true
                                  ? AppColors.text
                                  : AppColors.grey),
                      ),
                    ),
                  ),

                  SvgAsset(
                    imagePath: AppAssets.downArrow,
                    height: 20.h,
                    color: AppColors.text,
                  ),
                ],
              ),
            ),
          ),
        ),
        ErrorText(error: error, topPadding: 6.h),
      ],
    );
  }

  Future<CityModel?> _openCitySearchSheet(BuildContext context) async {
    return showModalBottomSheet<CityModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetContext) {
        String query = "";
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredCities = cities.where((city) {
              final name = city.name ?? "";
              return name.toLowerCase().contains(query.toLowerCase());
            }).toList();

            return Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 12.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    hintText: 'Search city',
                    textInputAction: TextInputAction.search,
                    prefixIcon: AppAssets.searchIcon,
                    onChanged: (value) => setState(() => query = value),
                  ),
                  10.h.spaceVertical,
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredCities.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        color: AppColors.text.withValues(alpha: 0.08),
                      ),
                      itemBuilder: (context, index) {
                        final city = filteredCities[index];
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                          title: Text(city.name ?? "", style: styleW400S14),
                          onTap: () => Navigator.of(context).pop(city),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
