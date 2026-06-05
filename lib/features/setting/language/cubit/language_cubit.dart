import 'package:sabalpara_family/sabalpara_family.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState()) {
    // refresh(
    //   state.copyWith(
    //     selectedLanguage: state.languages.firstWhereOrNull(
    //       (element) => element.title == userData?.language,
    //     ),
    //   ),
    // );
    final language = PrefService.getString(PrefKeys.localLanguage);
    refresh(
      state.copyWith(
        selectedLanguage: state.languages.firstWhereOrNull(
          (element) => element.code == language.split('_').first,
        ),
      ),
    );
  }

  void refresh(LanguageState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void selectLanguage(LanguageModel lang) {
    refresh(state.copyWith(selectedLanguage: lang));
  }

  Future<void> updateLanguage(BuildContext context) async {
    try {
      refresh(state.copyWith(loader: true));
      // final Map<String, dynamic> body = {
      //   "language": state.selectedLanguage?.title,
      // };

      // final result = await SettingsApi.updateUserProfile(body);
      final result = true;

      if (result && context.mounted) {
        await context.read<AppCubit>().changeLanguage(
          Locale(
            state.selectedLanguage?.code ?? "en",
            state.selectedLanguage?.countryCode ?? "US",
          ),
        );

        if (context.mounted) {
          context.navigator.pop();
        }
      }
    } catch (e, stack) {
      refresh(state.copyWith(loader: false));
      showCatchToast(e, stack, msg: e.toString());
    }

    refresh(state.copyWith(loader: false));
  }
}
