import 'package:sabalpara_family/sabalpara_family.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    this.header,
    this.hintText,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.error,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = .none,
    this.isDoubleFiled = false,
    this.isPassword = false,
    this.inputFormatters,
    this.fieldColor,
    this.prefixWidget,
    this.suffixWidget,
    this.borderRadius,
    this.contentPadding,
  });

  final String? header, hintText, error, prefixIcon, suffixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength, maxLines, minLines;
  final Widget? prefixWidget, suffixWidget;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool isDoubleFiled, isPassword;
  final Color? fieldColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscure,
      builder: (context, bool isObscure, _) {
        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            if (header?.isNotEmpty ?? false)
              Padding(
                padding: .only(bottom: 10.h),
                child: Text(header ?? "", style: styleW500S14),
              ),
            TextField(
              style: styleW400S14,
              controller: controller,
              onTapOutside: (e) => hideKeyboard(context: context),
              keyboardType: textInputType,
              textInputAction: textInputAction ?? .next,
              onChanged: onChanged,
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              minLines: minLines,
              textCapitalization: textCapitalization,
              obscureText: isPassword ? _isObscure.value : false,
              obscuringCharacter: "●",
              inputFormatters: isDoubleFiled
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'),
                      ),
                    ]
                  : inputFormatters,
              decoration: InputDecoration(
                fillColor: fieldColor ?? AppColors.white,
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
                    .symmetric(horizontal: 14.w, vertical: 12.h),
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
                              alignment: .centerLeft,
                              padding: .only(left: 14.w, right: 5.w),
                              child: SvgPicture.asset(prefixIcon!, width: 20.w),
                            ),
                          )
                        : null),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 44.w,
                  maxWidth: 44.w,
                  minHeight: 44.h,
                  maxHeight: 44.h,
                ),
                suffixIcon: isPassword
                    ? Material(
                        color: Colors.transparent,
                        borderRadius: .circular(borderRadius ?? 8.r),
                        child: InkWell(
                          onTap: () => _isObscure.value = !isObscure,
                          borderRadius: .circular(10.r),
                          child: SizedBox(
                            width: 48.w,
                            child: Center(
                              child: SvgPicture.asset(
                                isObscure ? AppAssets.eye : AppAssets.eyeClose,
                                height: 20.h,
                              ),
                            ),
                          ),
                        ),
                      )
                    : suffixWidget ??
                          (suffixIcon != null
                              ? IntrinsicWidth(
                                  child: Container(
                                    alignment: .centerRight,
                                    padding: .only(left: 14.w),
                                    child: SvgPicture.asset(
                                      suffixIcon!,
                                      height: 20.h,
                                    ),
                                  ),
                                )
                              : SizedBox()),
              ),
            ),
            ErrorText(error: error, topPadding: 6.h),
          ],
        );
      },
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: .circular(borderRadius ?? 8.r),
      borderSide: BorderSide(
        color: error?.isNotEmpty ?? false
            ? AppColors.red
            : AppColors.text.withValues(alpha: 0.1),
      ),
    );
  }
}
