part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final bool loader;
  final LanguageModel? selectedLanguage;
  final List<LanguageModel> languages;

  LanguageState({
    this.loader = false,
    LanguageModel? selectedLanguage,
    List<LanguageModel>? languages,
  }) : languages =
           languages ??
           [
             LanguageModel(
               code: 'hi',
               countryCode: 'IN',
               title: 'HIN',
               label: 'Hindi',
             ),
             LanguageModel(
               code: 'en',
               countryCode: 'US',
               title: 'EN_US',
               label: 'English',
             ),
             LanguageModel(
               code: 'gu',
               countryCode: 'IN',
               title: 'GUJ',
               label: 'Gujarati',
             ),
           ],
       selectedLanguage =
           selectedLanguage ??
           LanguageModel(
             code: 'en',
             countryCode: 'US',
             title: 'EN_US',
             label: 'English',
           );

  LanguageState copyWith({
    bool? loader,
    LanguageModel? selectedLanguage,
    List<LanguageModel>? languages,
  }) {
    return LanguageState(
      loader: loader ?? this.loader,
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [loader, languages, selectedLanguage];
}
