part of 'app_cubit.dart';

class AppState extends Equatable {
  AppState({this.locale});

  final Locale? locale;
  final List<Locale> languageList = [Locale("en", "US"), Locale("es", "ES")];

  AppState copyWith({Locale? locale}) {
    return AppState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
