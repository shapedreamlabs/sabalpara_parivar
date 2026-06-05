import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class UploadAttachmentEmptyCell extends StatelessWidget {
  const UploadAttachmentEmptyCell({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: .circular(8.r),
      child: Container(
        height: 170.h,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(8.r),
            dashPattern: [5, 3],
            strokeWidth: 1,
            color: AppColors.primary,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgAsset(imagePath: AppAssets.uploadIcon, height: 34.h),

                8.h.spaceVertical,

                Text(
                  context.l10n?.clickToUploadYourResult ?? '',
                  style: styleW400S14.copyWith(
                    color: AppColors.text.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedAttachmentView extends StatelessWidget {
  const SelectedAttachmentView({
    super.key,
    required this.fileData,
    this.height,
    this.onTapRemoveAttachment,
  });

  final File fileData;
  final double? height;
  final VoidCallback? onTapRemoveAttachment;

  @override
  Widget build(BuildContext context) {
    final widgetHeight = height ?? 170.h;
    final mimeType = fileData.getName?.split(".").last.toLowerCase();
    final isImage = [
      "jpg",
      "jpeg",
      "png",
      "heic",
      "heif",
      "webp",
    ].contains(mimeType);

    return InkWell(
      onTap: () => OpenFile.open(fileData.path),
      borderRadius: .circular(8.r),
      child: Stack(
        children: [
          isImage
              ? Container(
                  height: widgetHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: FileImg(
                    fileData,
                    fit: BoxFit.cover,
                    borderRadius: 8.r,
                    height: widgetHeight,
                    width: .maxFinite,
                  ),
                )
              : Container(
                  height: widgetHeight,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: .all(10.w),
                  child: Column(
                    spacing: widgetHeight < 170.h ? 5.h : 10.h,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      SizedBox(),

                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgAsset(
                              imagePath: AppAssets.fileIcon,
                              color: AppColors.primary,
                              height: widgetHeight / 4,
                            ),

                            10.h.spaceVertical,

                            Text(
                              (mimeType ?? "").toUpperCase(),
                              style: styleW600S20.copyWith(
                                fontSize: widgetHeight < 170.h ? 12 : 20,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        fileData.getName ?? "",
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: styleW500S14.copyWith(
                          fontSize: widgetHeight < 170.h ? 10 : 20,
                          color: AppColors.primary,
                        ),
                      ),

                      SizedBox(),
                    ],
                  ),
                ),

          if (!isImage) ...[
            Container(
              height: widgetHeight,
              decoration: BoxDecoration(
                color: AppColors.text.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],

          onTapRemoveAttachment == null
              ? SizedBox()
              : Positioned(
                  top: 10.h,
                  right: 6.w,
                  child: CustomIconButton(
                    icon: AppAssets.trashIcon,
                    size: 16.h,
                    buttonColor: AppColors.white,
                    onTap: onTapRemoveAttachment,
                  ),
                ),
        ],
      ),
    );
  }
}
