import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const routeName = "/dashboard";

  static Widget builder(BuildContext context) {
    final initialIndex = context.args is int ? context.args as int : null;

    return BlocProvider<DashboardCubit>(
      create: (c) => DashboardCubit(context, initialIndex),
      child: const DashboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;

                if (state.tabIndex == 0) {
                  openSureToExitBottomSheet(context);
                } else {
                  context.read<DashboardCubit>().onTabChanged(0);
                }
              },
              child: Scaffold(
                bottomNavigationBar: _BottomBar(),
                body: AnimatedSwitcher(
                  duration: 200.milliseconds,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Builder(
                    key: ValueKey<int>(state.tabIndex),
                    builder: (context) {
                      if (state.tabIndex == 0) {
                        return HomeScreen.builder(context);
                      } else if (state.tabIndex == 1) {
                        return BusinessScreen.builder(context);
                      } else if (state.tabIndex == 2) {
                        return VillagesScreen.builder(context);
                      } else if (state.tabIndex == 3) {
                        return CommitteeScreen.builder(context);
                      }
                      return SettingScreen.builder(context);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .only(
        top: 5.h,
        bottom: Platform.isIOS ? 0 : AppConstants.safeAreaPadding.bottom,
      ),
      color: AppColors.white,
      child: Container(
        margin: .only(bottom: 5.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            _SingleItem(
              index: 0,
              name: context.l10n?.home ?? "",
              activeIcon: AppAssets.homeActiveIcon,
              inactiveIcon: AppAssets.homeInactiveIcon,
            ),
            _SingleItem(
              index: 1,
              name: context.l10n?.business ?? "",
              activeIcon: AppAssets.businessActiveIcon,
              inactiveIcon: AppAssets.businessInactiveIcon,
            ),
            _SingleItem(
              index: 2,
              name: context.l10n?.villages ?? "",
              activeIcon: AppAssets.villagesActiveIcon,
              inactiveIcon: AppAssets.villagesInactiveIcon,
            ),
            _SingleItem(
              index: 3,
              name: context.l10n?.committee ?? "",
              activeIcon: AppAssets.committeeActiveIcon,
              inactiveIcon: AppAssets.committeeInactiveIcon,
            ),
            _SingleItem(
              index: 4,
              name: context.l10n?.setting ?? "",
              activeIcon: AppAssets.settingActiveIcon,
              inactiveIcon: AppAssets.settingInactiveIcon,
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleItem extends StatelessWidget {
  const _SingleItem({
    required this.index,
    required this.name,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final int index;
  final String name;
  final String activeIcon;
  final String inactiveIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final bool isSelected = state.tabIndex == index;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.read<DashboardCubit>().onTabChanged(index),
              borderRadius: .circular(8.r),
              child: AnimatedSwitcher(
                duration: 200.milliseconds,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1).animate(animation),
                    child: child,
                  );
                },
                child: Column(
                  key: ValueKey<bool>(isSelected),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Space
                    14.h.spaceVertical,

                    /// Icon
                    SvgAsset(
                      imagePath: isSelected ? activeIcon : inactiveIcon,
                      height: 24.h,
                    ),

                    /// Space
                    6.h.spaceVertical,

                    /// Title
                    Text(
                      name,
                      style: (isSelected ? styleW700S12 : styleW400S12)
                          .copyWith(
                            color: AppColors.text.withValues(
                              alpha: isSelected ? 1 : 0.6,
                            ),
                          ),
                    ),

                    /// Space
                    14.h.spaceVertical,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
