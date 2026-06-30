import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class MediaPicker {
  static Future<File?> pickFile({required BuildContext context}) async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          "jpg",
          "jpeg",
          "png",
          "heic",
          "heif",
          "webp",
          "pdf",
          "doc",
          "docx",
          "xls",
          "xlsx",
          "csv",
          "ppt",
          "pptx",
        ],
        withData: false,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      File? pickedFile;

      final file = result.files.first;

      if (file.path != null) {
        if ([
          "jpg",
          "png",
          "jpeg",
          "heic",
        ].contains(file.name.split(".").last.toLowerCase())) {
          final File? compressedImage = await compressImage(
            File(file.path ?? ""),
          );
          if (compressedImage != null) {
            pickedFile = compressedImage;
          }
        } else {
          pickedFile = File(file.path ?? "");
        }
      }

      return pickedFile;
    } catch (e, stack) {
      CrashlyticsService.recordError(
        CrashArea.mediaPicker,
        e,
        stack,
        info: {'source': 'file_picker'},
      );
      showCatchToast(e, stack);
      return null;
    }
  }

  static Future<File?> pickMedia({required BuildContext context}) async {
    try {
      final source = await _pickSource(context);

      if (source == null) return null;

      final xFile = await ImagePicker().pickImage(source: source);
      if (xFile == null) return null;

      final File? pickedFile = await compressImage(File(xFile.path));

      return pickedFile;
    } catch (e, stack) {
      CrashlyticsService.recordError(
        CrashArea.mediaPicker,
        e,
        stack,
        info: {'source': 'camera_gallery'},
      );
      showCatchToast(e, stack);
      return null;
    }
  }

  static Future<ImageSource?> _pickSource(BuildContext context) {
    final l10n = context.l10n;

    Widget buildBox(String image, String title, ImageSource source) {
      return Material(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: .circular(10.r),
        child: InkWell(
          onTap: () => context.navigator.pop(source),
          borderRadius: .circular(10.r),
          child: Container(
            padding: .all(20.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: .circular(10.r),
            ),
            child: Column(
              spacing: 8.h,
              mainAxisSize: .min,
              children: [
                SvgAsset(
                  imagePath: image,
                  height: 40.h,
                  color: AppColors.primary,
                ),

                Text(
                  title,
                  style: styleW500S18.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AppBottomSheet.show<ImageSource>(
      context: context,
      title: l10n?.selectMediaSource,
      child: Padding(
        padding: .all(20.w),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: .spaceAround,
          children: [
            Expanded(
              child: buildBox(
                AppAssets.camera,
                l10n?.camera ?? "",
                ImageSource.camera,
              ),
            ),

            Expanded(
              child: buildBox(
                AppAssets.gallery,
                l10n?.gallery ?? "",
                ImageSource.gallery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
