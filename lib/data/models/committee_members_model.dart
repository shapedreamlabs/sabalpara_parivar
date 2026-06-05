class CommitteeMembersModel {
  final int? id;
  final String? type;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? createdAt;
  final String? updatedAt;

  CommitteeMembersModel({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  CommitteeMembersModel copyWith({
    int? id,
    String? type,
    String? name,
    String? phone,
    String? email,
    String? avatar,
    String? createdAt,
    String? updatedAt,
  }) =>
      CommitteeMembersModel(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CommitteeMembersModel.fromJson(Map<String, dynamic> json) =>
      CommitteeMembersModel(
        id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
        type: json["type"]?.toString(),
        name: json["name"]?.toString(),
        phone: json["phone"]?.toString(),
        email: json["email"]?.toString(),
        avatar: json["avatar"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "phone": phone,
        "email": email,
        "avatar": avatar,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
