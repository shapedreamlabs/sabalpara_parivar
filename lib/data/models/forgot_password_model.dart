class ForgotPasswordModel {
  final String? rememberCode;

  ForgotPasswordModel({this.rememberCode});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        rememberCode: json["remember_code"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "remember_code": rememberCode,
  };
}
