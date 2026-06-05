import 'package:sabalpara_family/sabalpara_family.dart';

class AddFamilyMemberScreen extends StatelessWidget {
  const AddFamilyMemberScreen({super.key});

  static const routeName = '/add_family_member';

  static Widget builder(BuildContext context) {
    final data = context.args as Map<String, dynamic>?;
    return BlocProvider<AddFamilyMemberCubit>(
      create: (c) => AddFamilyMemberCubit(data),
      child: const AddFamilyMemberScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<AddFamilyMemberCubit, AddFamilyMemberState>(
      builder: (context, state) {
        final cubit = context.read<AddFamilyMemberCubit>();

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title:
                  "${state.memberId.isEmpty ? l10n?.addMember : l10n?.editMember}",
            ),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title:
                      "${state.memberId.isEmpty ? l10n?.addMember : l10n?.editMember}",
                  isLoading: state.loader,
                  onTap: () => cubit.onTapSubmit(context),
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
                    AppTextField(
                      controller: cubit.memberNameController,
                      header: l10n?.memberName,
                      hintText: l10n?.enterMemberFullName,
                      error: state.memberNameError,
                    ),

                    AppTextField(
                      controller: cubit.emailController,
                      header: l10n?.email,
                      hintText: l10n?.enterEmail,
                      error: state.emailError,
                      textInputType: TextInputType.emailAddress,
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

                    AppDropDown<FamilyMemberRelation>(
                      onChanged: cubit.onChangeRelation,
                      itemAsString: (value) =>
                          FamilyMemberRelation.getString(context, value),
                      items: FamilyMemberRelation.getRelationsList(context),
                      value: state.selectedRelation,
                      error: state.relationError,
                      header: l10n?.relation,
                      hintText: l10n?.selectRelation,
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
