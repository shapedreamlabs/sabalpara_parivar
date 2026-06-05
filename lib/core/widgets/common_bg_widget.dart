import 'dart:ui';

import 'package:sabalpara_family/sabalpara_family.dart';

class CommonBgWidget extends StatelessWidget {
  const CommonBgWidget({
    super.key,
    this.spreadSize,
    required this.child,
    this.backgroundColor = AppColors.white,
    this.blurColor = AppColors.primary,
  });

  final double? spreadSize;
  final Widget child;
  final Color backgroundColor;
  final Color blurColor;

  Widget _buildBackground() {
    final size = spreadSize ?? 800.00;
    return Positioned(
      top: -(size / 2),
      right: -(size / 2),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: size, sigmaY: size),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [blurColor.withValues(alpha: 0.13), Color(0x008349E5)],
                stops: const [0.2, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: backgroundColor)),
        _buildBackground(),

        child,
      ],
    );
  }
}
