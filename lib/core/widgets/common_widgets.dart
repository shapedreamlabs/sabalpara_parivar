import 'package:sabalpara_family/sabalpara_family.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    this.error,
    this.topPadding = 0,
    this.isCenterAlign = false,
  });

  final String? error;
  final double topPadding;
  final bool isCenterAlign;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Padding(
        padding: .only(top: topPadding),
        child: Row(
          spacing: 4.w,
          mainAxisAlignment: isCenterAlign ? .center : .start,
          children: [
            SvgAsset(imagePath: AppAssets.error, height: 16.h),
            Flexible(
              fit: isCenterAlign ? .loose : .tight,
              child: Align(
                alignment: .centerLeft,
                child: AnimatedSwitcher(
                  duration: 300.milliseconds,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          alignment: .centerLeft,
                          child: child,
                        );
                      },
                  child: Text(
                    error ?? '',
                    key: ValueKey<String>(error ?? ""),
                    style: styleW500S12.copyWith(color: AppColors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: SizedBox.shrink(),
      alignment: .center,
      sizeCurve: Curves.bounceOut,
      firstCurve: Curves.bounceOut,
      secondCurve: Curves.bounceOut,
      crossFadeState: (error ?? '').isNotEmpty ? .showFirst : .showSecond,
      duration: 300.milliseconds,
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: .srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class CommonDivider extends StatelessWidget {
  const CommonDivider({super.key, this.height, this.color, this.margin});

  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      width: .infinity,
      color: color ?? AppColors.black.withValues(alpha: 0.1),
      margin: margin ?? .zero,
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomShimmer({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: Shimmer.fromColors(
        baseColor: AppColors.primary.withValues(alpha: 0.2),
        highlightColor: AppColors.primary.withValues(alpha: 0),
        child: Container(
          height: height ?? .maxFinite,
          width: width ?? .maxFinite,
          color: AppColors.black,
        ),
      ),
    );
  }
}
