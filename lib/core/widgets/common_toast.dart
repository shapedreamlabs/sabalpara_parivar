import 'dart:io';

import 'package:sabalpara_family/sabalpara_family.dart';

void showCustomToast(String msg, {bool error = false}) {
  final Color accent = error ? AppColors.red : AppColors.primary;

  Widget widget() {
    return Container(
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: Platform.isAndroid ? 0 : 0,
      ),
      padding: .all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Left accent bar
          Container(
            height: 48.h,
            width: 5.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [accent, accent.withValues(alpha: 0.6)],
              ),
            ),
          ),

          /// Icon
          Container(
            padding: EdgeInsets.all(6.w),
            margin: EdgeInsets.only(left: 10.w, right: 12.w),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              shape: .circle,
            ),
            child: SvgAsset(
              imagePath: error ? AppAssets.close : AppAssets.tick,
              height: 18.h,
              color: accent,
            ),
          ),

          /// Text
          Expanded(
            child: Column(
              spacing: 2.h,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(error ? "Error" : "Success", style: styleW600S14),
                Text(msg, style: styleW400S12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showToastWidget(
    widget(),
    duration: const Duration(seconds: 3),
    handleTouch: true,
    dismissOtherToast: true,
    position: ToastPosition(
      align: Alignment.topCenter,
      offset: Platform.isAndroid ? 40 : 70,
    ),
  );
}
