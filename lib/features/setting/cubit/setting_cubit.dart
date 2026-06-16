import 'package:sabalpara_family/features/setting/model/settings_model.dart';
import 'package:sabalpara_family/sabalpara_family.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(BuildContext context) : super(SettingState()) {
    init(context);
    _syncProfileAndRefresh();
  }

  void refresh(SettingState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init(BuildContext context) {
    final settings = [
      SettingsModel(
        title: context.l10n?.myProfile ?? "",
        icon: AppAssets.profileIcon,
        onTap: () => context.navigator.pushNamed(MyProfileScreen.routeName),
      ),
      SettingsModel(
        title: context.l10n?.familyMembers ?? "",
        icon: AppAssets.familyIcon,
        onTap: () => context.navigator.pushNamed(FamilyMembersScreen.routeName),
      ),
      SettingsModel(
        title: context.l10n?.instructions ?? "",
        icon: AppAssets.instructionsIcon,
        onTap: () => context.navigator.pushNamed(InstructionsScreen.routeName),
      ),
      SettingsModel(
        title: context.l10n?.gallery ?? "",
        icon: AppAssets.galleryIcon,
        onTap: () => context.navigator.pushNamed(GalleryScreen.routeName),
      ),
      SettingsModel(
        title: context.l10n?.changePassword ?? "",
        icon: AppAssets.lockIcon,
        onTap: () =>
            context.navigator.pushNamed(ChangePasswordScreen.routeName),
      ),
      SettingsModel(
        title: context.l10n?.language ?? "",
        icon: AppAssets.languageIcon,
        onTap: () => onTapLanguage(context),
      ),
      SettingsModel(
        title: context.l10n?.logout ?? "",
        icon: AppAssets.logoutIcon,
        onTap: () => onTapLogout(context),
      ),
    ];

    refresh(
      state.copyWith(
        settings: settings,
        name: userModel?.name ?? "User",
        email: userModel?.email ?? "",
        avatar: userModel?.image ?? "",
      ),
    );
  }

  Future<void> _syncProfileAndRefresh() async {
    try {
      await SettingRepo.syncProfileToPrefs();
      refresh(
        state.copyWith(
          name: userModel?.name ?? "User",
          email: userModel?.email ?? "",
          avatar: userModel?.image ?? "",
        ),
      );
    } catch (_) {}
  }

  Future<void> onTapLanguage(BuildContext context) async {
    final languageUpdated = await context.navigator.pushNamed(
      LanguageScreen.routeName,
    );

    if (!context.mounted || languageUpdated != true) {
      return;
    }

    await WidgetsBinding.instance.endOfFrame;

    if (!context.mounted) {
      return;
    }

    init(context);
    context.read<DashboardCubit>().refresh(context.read<DashboardCubit>().state);
  }
}
