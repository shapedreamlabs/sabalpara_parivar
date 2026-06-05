import 'package:sabalpara_family/sabalpara_family.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor,
    this.borderColor,
    this.buttonColor,
    this.disabledButtonColor,
    this.height,
    this.fontSize,
    this.iconSpacing,
    this.startWidget,
    this.endWidget,
    this.fontWeight,
    this.gradient,
    this.isDisabled = false,
    this.isLoading = false,
    this.borderRadius,
    this.style,
  });

  final String title;
  final VoidCallback onTap;
  final bool isDisabled, isLoading;
  final Color? textColor, borderColor, buttonColor, disabledButtonColor;
  final double? height, fontSize, iconSpacing, borderRadius;
  final Widget? startWidget, endWidget;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final buildButtonColor = isDisabled
        ? (disabledButtonColor ?? AppColors.primary.withValues(alpha: 0.4))
        : (buttonColor ?? AppColors.primary);

    return AnimatedContainer(
      duration: 300.milliseconds,
      height: height ?? 48.h,
      width: .maxFinite,
      decoration: BoxDecoration(
        color: buildButtonColor,
        borderRadius: .circular(borderRadius ?? 8.r),
        border: borderColor != null ? .all(color: borderColor!) : null,
        gradient: gradient,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading || isLoading ? null : onTap,
          borderRadius: .circular(borderRadius ?? 8.r),
          child: Center(
            child: AnimatedSwitcher(
              duration: 300.milliseconds,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Builder(
                key: ValueKey<bool>(isLoading),
                builder: (context) {
                  if (isLoading) {
                    return SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: CircularProgressIndicator(
                        color: textColor ?? AppColors.white,
                        strokeWidth: 2.5,
                      ),
                    );
                  } else {
                    return Row(
                      spacing: iconSpacing ?? 10.w,
                      mainAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        ?startWidget,
                        Text(
                          title,
                          style:
                              style ??
                              styleW700S14.copyWith(
                                color: textColor ?? AppColors.white,
                              ),
                        ),
                        ?endWidget,
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
