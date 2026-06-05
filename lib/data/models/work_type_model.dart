class WorkTypeModel {
  final int? id;
  final String? name;
  final String? slug;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  WorkTypeModel({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  WorkTypeModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      WorkTypeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory WorkTypeModel.fromJson(Map<String, dynamic> json) => WorkTypeModel(
        id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
        name: json["name"]?.toString(),
        slug: json["slug"]?.toString(),
        status: json["status"] is int
            ? json["status"]
            : int.tryParse("${json["status"]}"),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
