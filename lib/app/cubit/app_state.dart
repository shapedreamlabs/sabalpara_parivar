part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({required this.locale});

  final Locale locale;
  final List<Locale> languageList = const [
    Locale('en'),
    Locale('hi'),
    Locale('gu'),
  ];

  AppState copyWith({Locale? locale}) {
    return AppState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
