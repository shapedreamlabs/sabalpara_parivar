import 'package:sabalpara_family/data/models/gallery_image_model.dart';

class GalleryDetailModel {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;
  final String? nextPageUrl;
  final List<GalleryImageModel> images;

  GalleryDetailModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.nextPageUrl,
    this.images = const [],
  });

  bool get hasMorePages {
    if (currentPage == null || lastPage == null) return false;
    return currentPage! < lastPage!;
  }

  factory GalleryDetailModel.fromJson(Map<String, dynamic> json) {
    final rawList = json["data"];
    final images = rawList is List
        ? rawList
            .whereType<Map<String, dynamic>>()
            .map(GalleryImageModel.fromJson)
            .toList()
        : <GalleryImageModel>[];

    return GalleryDetailModel(
      currentPage: json["current_page"] is int
          ? json["current_page"]
          : int.tryParse("${json["current_page"]}"),
      lastPage: json["last_page"] is int
          ? json["last_page"]
          : int.tryParse("${json["last_page"]}"),
      perPage: json["per_page"] is int
          ? json["per_page"]
          : int.tryParse("${json["per_page"]}"),
      total: json["total"] is int
          ? json["total"]
          : int.tryParse("${json["total"]}"),
      nextPageUrl: json["next_page_url"]?.toString(),
      images: images,
    );
  }
}
