class LanguageModel {
  final String code;
  final String countryCode;
  final String title;
  final String label;

  LanguageModel({
    required this.code,
    required this.countryCode,
    required this.title,
    required this.label,
  });

  @override
  bool operator ==(Object other) {
    return other is LanguageModel &&
        other.code == code &&
        other.countryCode == countryCode &&
        other.title == title &&
        other.label == label;
  }

  @override
  int get hashCode =>
      code.hashCode + countryCode.hashCode + title.hashCode + label.hashCode;
}
