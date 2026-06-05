import 'package:sabalpara_family/sabalpara_family.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    super.key,
    required this.onChanged,
    this.value,
    required this.items,
    required this.itemAsString,
    this.header,
    this.hintText,
    this.fillColor,
    this.radius,
    this.contentPadding,
    this.dropdownItems,
    this.error,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
  });

  final void Function(T? value) onChanged;
  final T? value;
  final List<T> items;
  final String Function(T value) itemAsString;
  final Color? fillColor;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final String? header, hintText, error, prefixIcon, suffixIcon;
  final Widget? prefixWidget, suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (header?.isNotEmpty ?? false)
          Padding(
            padding: .only(bottom: 10.h),
            child: Text(header ?? "", style: styleW500S14),
          ),
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            isDense: true,
            isExpanded: true,
            alignment: Alignment.centerLeft,
            style: styleW400S14.copyWith(
              color: (error ?? '').isNotEmpty ? AppColors.red : AppColors.grey,
            ),
            items:
                dropdownItems ??
                items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(itemAsString(item), style: styleW400S14),
                  );
                }).toList(),
            initialValue: value,
            onChanged: onChanged,
            dropdownColor: AppColors.white,
            icon: SvgAsset(
              imagePath: AppAssets.downArrow,
              height: 20.h,
              color: AppColors.text,
            ),
            iconSize: 20.h,
            decoration: InputDecoration(
              fillColor: fillColor ?? AppColors.white,
              filled: true,
              isDense: true,
              hintText: hintText,
              hintStyle: styleW400S14.copyWith(
                color: (error ?? '').isNotEmpty
                    ? AppColors.red
                    : AppColors.grey,
              ),
              visualDensity: .standard,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              border: inputBorder(),
              focusedBorder: inputBorder().copyWith(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              disabledBorder: inputBorder(),
              errorBorder: inputBorder(),
              focusedErrorBorder: inputBorder(),
              enabledBorder: inputBorder(),
              prefixIconConstraints: BoxConstraints(
                minWidth: 44.w,
                maxWidth: 44.w,
                minHeight: 44.h,
                maxHeight: 44.h,
              ),
              prefixIcon:
                  prefixWidget ??
                  (prefixIcon != null
                      ? IntrinsicWidth(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 14.w, right: 5.w),
                            child: SvgPicture.asset(prefixIcon!, height: 20.h),
                          ),
                        )
                      : null),
              suffixIcon:
                  suffixWidget ??
                  (suffixIcon != null
                      ? IntrinsicWidth(
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(left: 14.w),
                            child: SvgPicture.asset(suffixIcon!, height: 20.h),
                          ),
                        )
                      : null),
            ),
          ),
        ),
        ErrorText(error: error, topPadding: 6.h),
      ],
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 8.r),
      borderSide: BorderSide(
        color: error?.isNotEmpty ?? false
            ? AppColors.red
            : AppColors.text.withValues(alpha: 0.1),
      ),
    );
  }
}
