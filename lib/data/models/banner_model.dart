class BannerModel {
  final int? id;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  BannerModel({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"] is int ? json["id"] : int.tryParse("${json["id"]}"),
        image: json["image"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
