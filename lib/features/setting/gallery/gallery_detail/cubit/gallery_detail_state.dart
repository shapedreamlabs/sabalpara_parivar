part of 'gallery_detail_cubit.dart';

class GalleryDetailState extends Equatable {
  const GalleryDetailState({
    this.loader = false,
    this.loadingMore = false,
    this.title = '',
    this.imagesList = const [],
    this.hasMore = false,
  });

  final bool loader;
  final bool loadingMore;
  final String title;
  final List<GalleryImageModel> imagesList;
  final bool hasMore;

  GalleryDetailState copyWith({
    bool? loader,
    bool? loadingMore,
    String? title,
    List<GalleryImageModel>? imagesList,
    bool? hasMore,
  }) {
    return GalleryDetailState(
      loader: loader ?? this.loader,
      loadingMore: loadingMore ?? this.loadingMore,
      title: title ?? this.title,
      imagesList: imagesList ?? this.imagesList,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [loader, loadingMore, title, imagesList, hasMore];
}
