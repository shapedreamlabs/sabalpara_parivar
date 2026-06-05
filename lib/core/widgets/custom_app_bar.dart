import 'package:sabalpara_family/sabalpara_family.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.actions,
    this.centerTitle = true,
    this.backArrow = true,
    this.appBarSize,
    this.bottomSize = 0,
    this.bottom,
    this.leading,
    this.color,
    this.titleStyle,
    this.onBackTap,
    this.leadingWidth,
    this.titleSpacing,
    this.titleWidget,
    this.flexibleSpaceWidget,
    this.systemUiStyle,
  });

  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double bottomSize;
  final Widget? leading, titleWidget, flexibleSpaceWidget;
  final Color? color;
  final TextStyle? titleStyle;
  final void Function()? onBackTap;
  final bool centerTitle, backArrow;
  final double? appBarSize, leadingWidth, titleSpacing;
  final SystemUiOverlayStyle? systemUiStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: systemUiStyle ?? .dark,
      leading: backArrow && leading == null
          ? Center(
            child: CustomIconButton(
              border: Border.all(
                color: AppColors.text.withValues(alpha: 0.1),
              ),
              icon: AppAssets.backArrow,
              size: 24.h,
              padding: 10.w,
              onTap: onBackTap ?? context.navigator.pop,
            ),
          )
          : leading,
      leadingWidth: leadingWidth ?? 66.w,
      elevation: 0,
      backgroundColor: color ?? Colors.transparent,
      title:
          titleWidget ??
          (title.isEmpty
              ? SizedBox.shrink()
              : Text(title, style: titleStyle ?? styleW700S24)),
      centerTitle: centerTitle,
      actions: actions,
      titleSpacing: titleSpacing ?? 20.w,
      bottom: bottom,
      flexibleSpace: flexibleSpaceWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8.h + bottomSize);
}
