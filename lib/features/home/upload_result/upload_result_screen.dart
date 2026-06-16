import 'package:sabalpara_family/sabalpara_family.dart';

class UploadResultScreen extends StatelessWidget {
  const UploadResultScreen({super.key});

  static const routeName = '/upload_result';

  static Widget builder(BuildContext context) {
    return BlocProvider<UploadResultCubit>(
      create: (c) => UploadResultCubit(),
      child: const UploadResultScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<UploadResultCubit, UploadResultState>(
      builder: (context, state) {
        final cubit = context.read<UploadResultCubit>();

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.uploadResult ?? "", backArrow: true,),
            bottomNavigationBar: Padding(
              padding: .symmetric(
                vertical: 20.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: l10n?.upload ?? "",
                  isLoading: state.loader,
                  onTap: () => cubit.onTapUpload(context),
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
                      controller: cubit.childNameController,
                      header: l10n?.childName,
                      hintText: l10n?.enterChildFullName,
                      error: state.childNameError,
                    ),

                    Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        if (state.standardsLoading) ...[
                          if ((l10n?.standard ?? "").isNotEmpty)
                            Padding(
                              padding: .only(bottom: 10.h),
                              child: Text(
                                l10n?.standard ?? "",
                                style: styleW500S14,
                              ),
                            ),
                          CustomShimmer(
                            height: 48.h,
                            width: double.maxFinite,
                            borderRadius: 8.r,
                          ),
                        ] else
                          AppDropDown<StandardModel>(
                            onChanged: cubit.onChangeStandard,
                            itemAsString: (value) => value.name ?? "",
                            items: state.standardList,
                            value: state.selectedStandard,
                            error: state.standardError,
                            header: l10n?.standard,
                            hintText: l10n?.selectStandard,
                          ),
                      ],
                    ),

                    AppTextField(
                      controller: cubit.percentageController,
                      header: l10n?.percentage,
                      hintText: l10n?.enterPercentage,
                      error: state.percentageError,
                      textInputType: TextInputType.number,
                      onChanged: (value) =>
                          cubit.onChangePercentage(context, value),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),

                    AppDropDown<String>(
                      onChanged: cubit.onChangeYear,
                      itemAsString: (value) => value,
                      items: state.yearsList,
                      value: state.selectedYear,
                      error: state.yearError,
                      header: l10n?.year,
                      hintText: l10n?.selectYear,
                    ),

                    Column(
                      spacing: 8.h,
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        Text(l10n?.result ?? "", style: styleW500S14),

                        if (state.selectedResultFile == null) ...[
                          UploadAttachmentEmptyCell(
                            onTap: () => cubit.onTapUploadResult(context),
                          ),
                        ] else ...[
                          SelectedAttachmentView(
                            fileData: state.selectedResultFile!,
                            onTapRemoveAttachment: cubit.onTapRemoveResult,
                          ),
                        ],

                        ErrorText(error: state.resultError),
                      ],
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
