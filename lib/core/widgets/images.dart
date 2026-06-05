import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

double _errorPlaceholderLogoSide(double? height, double? width) {
  if (height != null && width != null) {
    return height <= width ? height : width;
  }
  return height ?? width ?? 56.0;
}

class SvgAsset extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final double? borderRadius;
  final Alignment? alignment;

  const SvgAsset({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.borderRadius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? .contain,
        alignment: alignment ?? .center,
        colorFilter: color == null ? null : ColorFilter.mode(color!, .srcIn),
      ),
    );
  }
}

class SvgNetwork extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? loadingHeight;
  final double? loadingWidth;
  final Color? color;
  final BoxFit? fit;
  final double? borderRadius;
  final Alignment? alignment;
  final Widget? errorWidget;

  const SvgNetwork({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.loadingHeight,
    this.loadingWidth,
    this.color,
    this.fit,
    this.borderRadius,
    this.alignment,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: url == null
          ? _errorWidgetBox()
          : SvgPicture.network(
              url.toString(),
              height: height,
              width: width,
              fit: fit ?? .contain,
              alignment: alignment ?? .center,
              placeholderBuilder: (con) {
                return CustomShimmer(
                  height: loadingHeight ?? height,
                  width: loadingWidth ?? width,
                );
              },
              colorFilter: color == null
                  ? null
                  : ColorFilter.mode(color!, .srcIn),
            ),
    );
  }

  Widget _errorWidgetBox() {
    if (errorWidget != null) {
      return errorWidget!;
    }
    return Container(
      height: height,
      width: width,
      color: AppColors.white,
      padding: .all(5.w),
      child: Center(
        child: AppBrandLogo(
          dimension: _errorPlaceholderLogoSide(
            height,
            width,
          ).clamp(40.0, 200.0),
        ),
      ),
    );
  }
}

class AssetsImg extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final double? borderRadius;

  const AssetsImg({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? .contain,
        color: color,
      ),
    );
  }
}

/// App mark in a square viewport with [BoxFit.contain], so the same asset
/// reads consistently on splash, login, and error placeholders.
class AppBrandLogo extends StatelessWidget {
  const AppBrandLogo({
    super.key,
    required this.dimension,
    this.paddingRatio = 0,
  });

  /// Edge length of the square reserved for the logo (including inner padding).
  final double dimension;

  /// Symmetric inset as a fraction of [dimension].
  final double paddingRatio;

  @override
  Widget build(BuildContext context) {
    final pad = dimension * paddingRatio;
    return SizedBox(
      width: dimension,
      height: dimension,
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: AssetsImg(imagePath: AppAssets.logoImg, fit: BoxFit.contain),
      ),
    );
  }
}

class FileImg extends StatelessWidget {
  final File? file;
  final double? height;
  final double? width;
  final double? loadingHeight;
  final double? loadingWidth;
  final BoxFit? fit;
  final double? borderRadius;
  final Widget? errorWidget;
  final bool skipBaseUrl;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final VoidCallback? onTap;

  const FileImg(
    this.file, {
    super.key,
    this.height,
    this.width,
    this.loadingHeight,
    this.loadingWidth,
    this.fit,
    this.borderRadius,
    this.errorWidget,
    this.skipBaseUrl = false,
    this.progressIndicatorBuilder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: Stack(
        children: [
          if (file == null)
            _errorWidgetBox()
          else
            Image.file(
              file!,
              height: height,
              width: width,
              fit: fit ?? .cover,
              errorBuilder: (con, str, obj) {
                return _errorWidgetBox();
              },
            ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: .circular(borderRadius ?? 0),
              child: SizedBox(height: height, width: width),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidgetBox() {
    if (errorWidget != null) {
      return errorWidget!;
    }
    return Container(
      height: height,
      width: width,
      color: AppColors.white,
      padding: EdgeInsets.all(5.w),
      child: Center(
        child: AppBrandLogo(
          dimension: _errorPlaceholderLogoSide(
            height,
            width,
          ).clamp(40.0, 200.0),
        ),
      ),
    );
  }
}

class CachedImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? loadingHeight;
  final double? loadingWidth;
  final BoxFit? fit;
  final double? borderRadius;
  final Widget? errorWidget;
  final bool skipBaseUrl;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final VoidCallback? onTap;
  final Alignment? alignment;

  const CachedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.loadingHeight,
    this.loadingWidth,
    this.fit,
    this.borderRadius,
    this.errorWidget,
    this.skipBaseUrl = false,
    this.progressIndicatorBuilder,
    this.onTap,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    String updatedUrl = "";

    if (skipBaseUrl) {
      updatedUrl = url.toString();
    } else {
      updatedUrl = "${ApiConstants.assetBaseUrl}${url ?? ""}";
    }

    return ClipRRect(
      borderRadius: .circular(borderRadius ?? 0),
      child: Stack(
        children: [
          if (url == null)
            _errorWidgetBox()
          else
            CachedNetworkImage(
              imageUrl: updatedUrl,
              height: height,
              width: width,
              fit: fit ?? .cover,
              alignment: alignment ?? .center,
              errorWidget: (con, str, obj) {
                return _errorWidgetBox();
              },
              progressIndicatorBuilder:
                  progressIndicatorBuilder ??
                  (con, str, progress) {
                    return CustomShimmer(
                      height: loadingHeight ?? height,
                      width: loadingWidth ?? width,
                    );
                  },
            ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: .circular(borderRadius ?? 0),
              child: SizedBox(height: height, width: width),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidgetBox() {
    if (errorWidget != null) {
      return errorWidget!;
    }
    return Container(
      height: height,
      width: width,
      color: AppColors.white,
      padding: .all(5.w),
      child: Center(
        child: AppBrandLogo(
          dimension: _errorPlaceholderLogoSide(
            height,
            width,
          ).clamp(40.0, 200.0),
        ),
      ),
    );
  }
}
