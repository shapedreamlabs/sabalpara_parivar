import 'package:sabalpara_family/sabalpara_family.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.buttonColor,
    this.padding,
    this.radius,
    this.size,
    this.border,
  });

  final String icon;
  final Color? buttonColor;
  final BoxBorder? border;
  final double? size, padding, radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor ?? Colors.transparent,
      borderRadius: .circular(radius ?? 500.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(radius ?? 500.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: .circular(radius ?? 500.r),
            border: border,
          ),
          child: Padding(
            padding: .all(padding ?? 5.w),
            child: SvgAsset(
              imagePath: icon,
              height: size ?? 24.h,
              width: size ?? 24.h,
            ),
          ),
        ),
      ),
    );
  }
}
