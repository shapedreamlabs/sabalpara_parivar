class GalleryImageModel {
  final int? id;
  final int? galleryId;
  final String? image;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  GalleryImageModel({
    this.id,
    this.galleryId,
    this.image,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryImageModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = json["image"] ??
        json["file"] ??
        json["photo"] ??
        json["thumbnail"] ??
        json["url"];

    return GalleryImageModel(
      id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
      galleryId: json["gallery_id"] is int
          ? json["gallery_id"]
          : int.tryParse("${json["gallery_id"]}"),
      image: imageUrl?.toString(),
      title: json["title"]?.toString() ?? json["name"]?.toString(),
      createdAt: json["created_at"]?.toString(),
      updatedAt: json["updated_at"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gallery_id": galleryId,
        "image": image,
        "title": title,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
