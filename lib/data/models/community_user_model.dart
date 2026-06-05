class CommunityUserModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? occupation;

  CommunityUserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.occupation,
  });

  CommunityUserModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? occupation,
  }) =>
      CommunityUserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        occupation: occupation ?? this.occupation,
      );

  factory CommunityUserModel.fromJson(Map<String, dynamic> json) =>
      CommunityUserModel(
        id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
        name: json["name"]?.toString(),
        phone: json["phone"]?.toString(),
        email: json["email"]?.toString(),
        occupation: json["occupation"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "occupation": occupation,
      };
}
