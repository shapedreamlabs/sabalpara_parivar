class VillageModel {
  final int? id;
  final String? name;
  final String? slug;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  VillageModel({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  VillageModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      VillageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory VillageModel.fromJson(Map<String, dynamic> json) => VillageModel(
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
