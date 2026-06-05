import 'package:sabalpara_family/sabalpara_family.dart';

class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.text.withValues(alpha: 0.5),
      builder: (con) {
        return Container(
          width: double.maxFinite,
          margin: .only(bottom: MediaQuery.of(con).viewInsets.bottom),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: .vertical(top: .circular(8.r)),
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              if (title != null)
                Container(
                  padding: .all(16.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.text.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(title, style: styleW600S18),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: context.navigator.pop,
                          borderRadius: .circular(10.r),
                          child: SvgAsset(
                            imagePath: AppAssets.close,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Flexible(child: SafeArea(top: false, child: child)),
            ],
          ),
        );
      },
    );
  }
}

Future<void> onTapLogout(BuildContext context) async {
  AppBottomSheet.show(context: context, child: LogOutWidget());
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: .all(20.w),
      child: Column(
        mainAxisSize: .min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: context.navigator.pop,
                borderRadius: .circular(10.r),
                child: SvgAsset(imagePath: AppAssets.close, height: 24.h),
              ),
            ),
          ),
          Container(
            padding: .all(10.w),
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                padding: .all(10.w),
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Container(
                    padding: .all(23.w),
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AppAssets.logoutIcon,
                        height: 40.h,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Text(l10n?.logout ?? "", style: styleW700S20),
          ),
          Text(
            l10n?.logoutDescription ?? "",
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey),
          ),
          20.h.spaceVertical,
          CustomButton(
            title: l10n?.yesLogout ?? "",
            onTap: () async {
              context.navigator.pop();

              try {
                await SettingRepo.logout();
              } catch (_) {}

              await logoutUser();
            },
          ),
        ],
      ),
    );
  }
}

Future<void> openSureToExitBottomSheet(BuildContext context) async {
  AppBottomSheet.show(context: context, child: SureToExitSheetWidget());
}

class SureToExitSheetWidget extends StatelessWidget {
  const SureToExitSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: .all(16.w),
      child: Column(
        mainAxisSize: .min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: context.navigator.pop,
                borderRadius: .circular(10.r),
                child: SvgAsset(imagePath: AppAssets.close, height: 24.h),
              ),
            ),
          ),
          Container(
            padding: .all(10.w),
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                padding: .all(10.w),
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Container(
                    padding: .all(10.w),
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AppAssets.logoutIcon,
                        height: 40.h,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Text(l10n?.areYouSure ?? "", style: styleW700S20),
          ),
          Text(
            l10n?.youWantToExitTheApp ?? "",
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey),
          ),
          20.h.spaceVertical,
          CustomButton(
            title: l10n?.yesExitNow ?? "",
            onTap: context.navigator.pop,
          ),
        ],
      ),
    );
  }
}

Future<bool> openDeleteResultConfirmationBottomSheet(
  BuildContext context,
) async {
  final confirmed = await AppBottomSheet.show<bool>(
    context: context,
    child: const DeleteResultConfirmationSheetWidget(),
  );
  return confirmed ?? false;
}

class DeleteResultConfirmationSheetWidget extends StatelessWidget {
  const DeleteResultConfirmationSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: .all(16.w),
      child: Column(
        mainAxisSize: .min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.navigator.pop(false),
                borderRadius: .circular(10.r),
                child: SvgAsset(imagePath: AppAssets.close, height: 24.h),
              ),
            ),
          ),
          Container(
            padding: .all(10.w),
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.red.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                padding: .all(10.w),
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.red.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Container(
                    padding: .all(23.w),
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: AppColors.red.withValues(alpha: 0.08),
                    ),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AppAssets.deleteIcon,
                        height: 40.h,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Text(l10n?.areYouSure ?? "", style: styleW700S20),
          ),
          Text(
            l10n?.deleteResultDescription ?? "",
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey),
          ),
          20.h.spaceVertical,
          CustomButton(
            title: l10n?.yesDelete ?? "",
            buttonColor: AppColors.red,
            onTap: () => context.navigator.pop(true),
          ),
        ],
      ),
    );
  }
}

Future<void> openUploadResultSuccessBottomSheet(
  BuildContext context,
  ResultsModel resultData,
) async {
  AppBottomSheet.show(
    context: context,
    child: UploadResultSuccessSheetWidget(resultData: resultData),
  );
}

class UploadResultSuccessSheetWidget extends StatelessWidget {
  const UploadResultSuccessSheetWidget({super.key, required this.resultData});

  final ResultsModel resultData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: .all(16.w),
      child: Column(
        mainAxisSize: .min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: context.navigator.pop,
                borderRadius: .circular(10.r),
                child: SvgAsset(imagePath: AppAssets.close, height: 24.h),
              ),
            ),
          ),

          Container(
            padding: .all(10.w),
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
            child: Center(
              child: Container(
                padding: .all(10.w),
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Container(
                    padding: .all(23.w),
                    decoration: BoxDecoration(
                      shape: .circle,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                    child: Center(
                      child: SvgAsset(
                        imagePath: AppAssets.successIcon,
                        height: 40.h,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
            child: Text(
              l10n?.resultUploadedSuccessfully ?? "",
              style: styleW700S20,
            ),
          ),

          Text(
            l10n?.resultUploadedSuccessfullyDesc ?? "",
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey),
          ),

          16.h.spaceVertical,

          Padding(
            padding: .symmetric(horizontal: 2.w, vertical: 4.w),
            child: CustomButton(
              title: l10n?.done ?? "",
              onTap: () {
                context.navigator.pop();
                context.navigator.pop(resultData);
              },
            ),
          ),
        ],
      ),
    );
  }
}
