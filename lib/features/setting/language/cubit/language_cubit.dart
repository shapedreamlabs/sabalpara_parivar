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
    final languageCode = language.split('_').first.split('-').first;
    refresh(
      state.copyWith(
        selectedLanguage: state.languages.firstWhereOrNull(
          (element) => element.code == languageCode,
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

      await context.read<AppCubit>().changeLanguage(
        Locale(state.selectedLanguage?.code ?? 'en'),
      );

      if (!context.mounted) {
        return;
      }

      await WidgetsBinding.instance.endOfFrame;

      if (!context.mounted) {
        return;
      }

      context.navigator.pop(true);
    } catch (e, stack) {
      refresh(state.copyWith(loader: false));
      showCatchToast(e, stack, msg: e.toString());
      return;
    }

    refresh(state.copyWith(loader: false));
  }
}
