import 'package:sabalpara_family/sabalpara_family.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      width: 60.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(7),
        boxShadow: [
          BoxShadow(
            color: AppColors.text.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: .center,
      padding: .all(15.w),
      child: CircularProgressIndicator(),
    );
  }
}

class SmallLoader extends StatelessWidget {
  const SmallLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: AppLoader());
  }
}

class FullPageLoader extends StatelessWidget {
  const FullPageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(color: AppColors.black.withValues(alpha: 0.2)),
      child: Center(child: AppLoader()),
    );
  }
}

class StackedLoader extends StatelessWidget {
  final bool loading;
  final Widget child;

  const StackedLoader({super.key, this.loading = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimatedSwitcher(
          duration: 300.milliseconds,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Builder(
            key: ValueKey(loading),
            builder: (context) {
              if (!loading) return SizedBox();
              return SizedBox(
                height: 100.h,
                width: 100.w,
                child: Center(child: AppLoader()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class StackedLoaderBarrier extends StatelessWidget {
  final bool loading;
  final Widget child;

  const StackedLoaderBarrier({
    super.key,
    this.loading = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: 0.2),
              ),
            ),
          ),
      ],
    );
  }
}

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (onRefresh == null) return child;
    return RefreshIndicator(
      onRefresh: onRefresh!,
      backgroundColor: AppColors.white,
      color: AppColors.primary,
      strokeWidth: 4,
      child: child,
    );
  }
}

bool isLoaderDialogOpen = false;

void startLoaderDialog() {
  final context = navigatorKey.currentContext;
  if (isLoaderDialogOpen || context == null) {
    return;
  }
  isLoaderDialogOpen = true;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: const SmallLoader(),
        ),
      );
    },
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: AppColors.white.withValues(alpha: 0.1),
  ).whenComplete(() {
    isLoaderDialogOpen = false;
  });
}

void closeLoaderDialog() {
  final context = navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  if (isLoaderDialogOpen) {
    context.navigator.pop();
  }
}

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .maxFinite,
      width: .maxFinite,
      color: AppColors.black.withValues(alpha: 0.5),
      child: Center(child: AppLoader()),
    );
  }
}
