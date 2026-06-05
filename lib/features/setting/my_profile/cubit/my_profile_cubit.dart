import 'package:sabalpara_family/sabalpara_family.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(MyProfileState()) {
    _syncProfile();
  }

  void refresh(MyProfileState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _syncProfile() async {
    try {
      await SettingRepo.syncProfileToPrefs();
      refresh(state.copyWith(refreshKey: state.refreshKey + 1));
    } catch (_) {}
  }

  Future<void> onTapEdit(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      EditProfileScreen.routeName,
    );
    if (result != null) {
      refresh(state.copyWith(refreshKey: state.refreshKey + 1));
    }
  }
}
