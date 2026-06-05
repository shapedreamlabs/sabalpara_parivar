class ResetPasswordModel {
  final List<dynamic> items;

  const ResetPasswordModel({this.items = const []});

  factory ResetPasswordModel.fromJson(dynamic json) {
    if (json is List) {
      return ResetPasswordModel(items: json);
    }
    return const ResetPasswordModel();
  }

  dynamic toJson() => items;
}
