class RegisterModel {
  final String? email;
  final String? phone;
  final int? roleId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? accessToken;
  final String? lastLogin;

  RegisterModel({
    this.email,
    this.phone,
    this.roleId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.accessToken,
    this.lastLogin,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    phone: json["phone"],
    roleId: json["role_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
    accessToken: json["access_token"],
    lastLogin: json["last_login"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
    "role_id": roleId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
    "access_token": accessToken,
    "last_login": lastLogin,
  };
}
