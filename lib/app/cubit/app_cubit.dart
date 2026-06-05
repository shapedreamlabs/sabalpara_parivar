import 'package:sabalpara_family/sabalpara_family.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState()) {
    init();
  }

  void refresh(AppState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init() {
    final local = getLanStrToLocale(
      PrefService.getString(PrefKeys.localLanguage),
    );
    refresh(state.copyWith(locale: local));
  }

  /// Initializes Language and other settings
  Future<void> changeLanguage(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await PrefService.set(PrefKeys.localLanguage, getLanLocaleToStr(locale));
  }

  Locale getLanStrToLocale(String lan) {
    if (lan.isEmpty) {
      return const Locale("en", "US");
    }
    String lanCode = lan.split('_').first;
    String countryCode = lan.split('_').last;
    return Locale(lanCode, countryCode);
  }

  String getLanLocaleToStr(Locale locale) {
    return "${locale.languageCode}_${locale.countryCode}";
  }
}
