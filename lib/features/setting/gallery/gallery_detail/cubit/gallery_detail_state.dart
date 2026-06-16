part of 'gallery_detail_cubit.dart';

class GalleryDetailState extends Equatable {
  const GalleryDetailState({
    this.loader = false,
    this.loadingMore = false,
    this.title = '',
    this.imagesList = const [],
    this.hasMore = false,
    this.downloadingImageId,
  });

  final bool loader;
  final bool loadingMore;
  final String title;
  final List<GalleryImageModel> imagesList;
  final bool hasMore;
  final int? downloadingImageId;

  GalleryDetailState copyWith({
    bool? loader,
    bool? loadingMore,
    String? title,
    List<GalleryImageModel>? imagesList,
    bool? hasMore,
    int? downloadingImageId,
    bool resetDownloadingImageId = false,
  }) {
    return GalleryDetailState(
      loader: loader ?? this.loader,
      loadingMore: loadingMore ?? this.loadingMore,
      title: title ?? this.title,
      imagesList: imagesList ?? this.imagesList,
      hasMore: hasMore ?? this.hasMore,
      downloadingImageId: resetDownloadingImageId
          ? null
          : downloadingImageId ?? this.downloadingImageId,
    );
  }

  @override
  List<Object?> get props =>
      [loader, loadingMore, title, imagesList, hasMore, downloadingImageId];
}
