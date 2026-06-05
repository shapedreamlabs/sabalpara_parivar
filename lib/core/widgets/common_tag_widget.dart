import 'package:sabalpara_family/sabalpara_family.dart';

class CommonTagWidget extends StatelessWidget {
  const CommonTagWidget({
    super.key,
    required this.text,
    required this.color,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: .circular(50.r),
      ),
      child: Text(
        text,
        style: (textStyle ?? styleW600S12).copyWith(color: color),
      ),
    );
  }
}
