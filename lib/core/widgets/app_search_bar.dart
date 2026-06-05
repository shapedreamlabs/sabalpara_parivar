import 'package:sabalpara_family/sabalpara_family.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: styleW400S16,
      controller: controller,
      onTapOutside: (e) => hideKeyboard(context: context),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText ?? context.l10n?.searchHere,
        hintStyle: styleW400S16.copyWith(
          color: AppColors.text.withValues(alpha: 0.6),
        ),
        isCollapsed: true,
        contentPadding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          top: 12.h,
          bottom: 12.h,
        ),
        filled: true,
        fillColor: AppColors.white.withValues(alpha: 0.5),
        border: inputBorder(),
        focusedBorder: inputBorder().copyWith(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        disabledBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),
        enabledBorder: inputBorder(),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 10.w),
          child: SvgAsset(imagePath: AppAssets.searchIcon, width: 20.w),
        ),
        prefixIconConstraints: BoxConstraints(maxWidth: 45.w, maxHeight: 45.w),
      ),
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(80.r),
      borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.5)),
    );
  }
}
