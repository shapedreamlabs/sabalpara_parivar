import 'package:sabalpara_family/sabalpara_family.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<HomeCubit>();
    final results = context.watch<HomeCubit>().state.resultsList;

    return AnimatedSwitcher(
      duration: 300.milliseconds,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: Builder(
        key: ValueKey(results),
        builder: (context) {
          if (results.isEmpty) {
            return Padding(
              padding: .symmetric(
                vertical: 10.h,
                horizontal: AppConstants.horizontalPadding,
              ),
              child: CustomButton(
                title: l10n?.uploadResult ?? "",
                onTap: () => cubit.onTapUploadResult(context),
              ),
            );
          }

          return Column(
            spacing: 15.h,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .symmetric(horizontal: AppConstants.horizontalPadding),
                child: Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: Text(
                        l10n?.submittedResults ?? "",
                        style: styleW700S20,
                      ),
                    ),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: .circular(10.r),
                        onTap: () =>
                            cubit.onTapViewAllSubmittedResults(context),
                        child: Padding(
                          padding: .symmetric(vertical: 2.h, horizontal: 5.w),
                          child: Text(
                            l10n?.viewAll ?? "",
                            style: styleW400S16.copyWith(
                              color: AppColors.text.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: .horizontal,
                  itemCount: results.length,
                  itemBuilder: (con, index) {
                    final resultData = results[index];
                    return Container(
                      width: 0.96.sw,
                      padding: .only(left: index == 0 ? 20.w : 7.w, right: (index == (results.length - 1)) ? 20.w : 7.w),
                      child: CommonResultCardWidget(
                        index: index,
                        heightRestrict: true,
                        showStatus: false,
                        resultData: resultData,
                        onTapDelete: () => cubit.onTapDeleteResult(
                          context,
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CommonResultCardWidget extends StatelessWidget {
  const CommonResultCardWidget({
    super.key,
    required this.index,
    this.heightRestrict = false,
    this.showStatus = true,
    this.onTapDelete,
    required this.resultData,
  });

  final int index;
  final bool heightRestrict;
  final bool showStatus;
  final VoidCallback? onTapDelete;
  final ResultsModel resultData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: .min,
      children: [
        Container(
          padding: .symmetric(vertical: 10.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: index.toResultIndexedColor,
            border: Border(
              bottom: BorderSide(color: AppColors.text.withValues(alpha: 0.1)),
            ),
            borderRadius: .vertical(top: .circular(8.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  resultData.name ?? "",
                  style: styleW700S16,
                  maxLines: heightRestrict ? 1 : null,
                  overflow: .ellipsis,
                ),
              ),

              if (showStatus)
                Container(
                  padding: .symmetric(vertical: 5.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.5),
                    borderRadius: .circular(500.r),
                  ),
                  child: Text(
                    resultData.status.value.capitalize(),
                    style: styleW600S12,
                  ),
                ),

              if (!showStatus && onTapDelete != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: onTapDelete,
                    child: Padding(
                      padding: EdgeInsets.all(4.h),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.red,
                        size: 20.h,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: .symmetric(vertical: 10.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: index.toResultIndexedColor.withValues(alpha: 0.1),
            border: Border(
              left: BorderSide(color: AppColors.text.withValues(alpha: 0.1)),
              right: BorderSide(color: AppColors.text.withValues(alpha: 0.1)),
              bottom: BorderSide(color: AppColors.text.withValues(alpha: 0.1)),
            ),
            borderRadius: .vertical(bottom: .circular(8.r)),
          ),
          child: Column(
            spacing: 8.h,
            mainAxisSize: .min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: RichText(
                      maxLines: heightRestrict ? 2 : null,
                      overflow: .ellipsis,
                      text: TextSpan(
                        text: "${l10n?.standard}:\n",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                        children: [
                          TextSpan(
                            text: resultData.standard,
                            style: styleW600S14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      maxLines: heightRestrict ? 2 : null,
                      overflow: .ellipsis,
                      text: TextSpan(
                        text: "${l10n?.percentage}:\n",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                        children: [
                          TextSpan(
                            text: resultData.percentage,
                            style: styleW600S14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RichText(
                      maxLines: heightRestrict ? 2 : null,
                      overflow: .ellipsis,
                      text: TextSpan(
                        text: "${l10n?.year}:\n",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                        children: [
                          TextSpan(
                            text: "${resultData.year}",
                            style: styleW600S14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                spacing: 4.h,
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "${l10n?.result}:",
                    style: styleW400S14.copyWith(
                      color: AppColors.text.withValues(alpha: 0.8),
                    ),
                  ),
                  if (resultData.result != null)
                    SelectedAttachmentView(
                      height: 110.h,
                      fileData: resultData.result!,
                    )
                  else if ((resultData.resultUrl ?? "").isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedImage(
                        resultData.resultUrl,
                        skipBaseUrl: true,
                        height: 110.h,
                        width: double.maxFinite,
                        fit: .cover,
                      ),
                    )
                  else
                    Container(
                      height: 110.h,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.text.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        l10n?.noDataFound ?? "No result file",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
