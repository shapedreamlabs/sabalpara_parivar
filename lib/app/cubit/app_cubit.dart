import 'package:sabalpara_family/sabalpara_family.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(locale: defaultLocale)) {
    init();
  }

  static const Locale defaultLocale = Locale('en');

  void refresh(AppState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init() {
    final savedLanguage = PrefService.getString(PrefKeys.localLanguage);
    emit(state.copyWith(locale: getLanStrToLocale(savedLanguage)));
  }

  /// Initializes Language and other settings
  Future<void> changeLanguage(Locale locale) async {
    final normalizedLocale = normalizeLocale(locale);
    emit(state.copyWith(locale: normalizedLocale));
    await PrefService.set(
      PrefKeys.localLanguage,
      getLanLocaleToStr(normalizedLocale),
    );
  }

  Locale normalizeLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'hi':
        return const Locale('hi');
      case 'gu':
        return const Locale('gu');
      default:
        return defaultLocale;
    }
  }

  Locale getLanStrToLocale(String lan) {
    if (lan.isEmpty) {
      return defaultLocale;
    }

    final languageCode = lan.split('_').first.split('-').first;
    return normalizeLocale(Locale(languageCode));
  }

  String getLanLocaleToStr(Locale locale) {
    return normalizeLocale(locale).languageCode;
  }
}
