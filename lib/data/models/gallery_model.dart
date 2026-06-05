class GalleryModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? thumbnail;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  GalleryModel({
    this.id,
    this.name,
    this.slug,
    this.thumbnail,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
    name: json["name"]?.toString(),
    slug: json["slug"]?.toString(),
    thumbnail: json["thumbnail"]?.toString(),
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
    "thumbnail": thumbnail,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
