import 'package:sabalpara_family/sabalpara_family.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final TextStyle? labelStyle;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.labelStyle,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    if (widget.value) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        spacing: 8.w,
        mainAxisSize: .min,
        children: [
          Container(
            width: 20.h,
            height: 20.h,
            decoration: BoxDecoration(
              color: widget.value ? AppColors.primary : Colors.transparent,
              borderRadius: .circular(4.r),
              border: Border.all(
                color: widget.value
                    ? AppColors.primary
                    : AppColors.text.withValues(alpha: 0.2),
              ),
            ),
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scale,
                child: SvgAsset(
                  imagePath: AppAssets.tick,
                  height: 16.h,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          Text(
            widget.label,
            style:
                widget.labelStyle ??
                styleW500S14.copyWith(
                  color: AppColors.text.withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
    );
  }
}

class CustomCheckboxButton extends StatelessWidget {
  final String title;
  final bool isDisabled, isLoading, needBoxShadow, value;
  final Color? textColor, buttonColor, disabledButtonColor;
  final double? fontSize, iconSpacing, borderRadius;
  final Widget? startWidget, endWidget;
  final FontWeight? fontWeight;
  final ValueChanged<bool> onChanged;

  const CustomCheckboxButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.textColor,
    this.buttonColor,
    this.disabledButtonColor,
    this.fontSize,
    this.iconSpacing,
    this.startWidget,
    this.endWidget,
    this.fontWeight,
    this.needBoxShadow = false,
    this.isDisabled = false,
    this.isLoading = false,
    this.borderRadius,
  });

  void _handleTap() {
    onChanged(!value);
  }

  @override
  Widget build(BuildContext context) {
    final buildButtonColor = isDisabled
        ? (disabledButtonColor ?? AppColors.primary.withValues(alpha: 0.4))
        : (value == true
              ? (buttonColor ?? AppColors.primary)
              : AppColors.white);

    final buildBorderColor = isDisabled
        ? (disabledButtonColor ?? AppColors.primary.withValues(alpha: 0.4))
        : (value == true
              ? (buttonColor ?? AppColors.primary)
              : AppColors.text.withValues(alpha: 0.1));

    return Material(
      color: buildButtonColor,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: UnconstrainedBox(
          child: Container(
            padding: .symmetric(vertical: 8.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
              border: Border.all(color: buildBorderColor),
            ),
            child: Center(
              child: Row(
                spacing: iconSpacing ?? 10.w,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ?startWidget,
                  Text(
                    title,
                    style: styleW400S16.copyWith(
                      fontWeight: fontWeight,
                      color: value == true
                          ? (textColor ?? AppColors.white)
                          : AppColors.text.withValues(alpha: 0.8),
                    ),
                  ),
                  ?endWidget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
