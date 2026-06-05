import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'gallery_detail_state.dart';

class GalleryDetailCubit extends Cubit<GalleryDetailState> {
  GalleryDetailCubit(Map<String, dynamic>? arguments)
      : super(
          GalleryDetailState(
            title: arguments?['title']?.toString() ?? '',
          ),
        ) {
    final galleryId = arguments?['gallery_id'];
    if (galleryId != null) {
      _galleryId = galleryId.toString();
      _loadGalleryDetail(resetData: true);
    }
  }

  String? _galleryId;
  int _currentPage = 1;

  void refresh(GalleryDetailState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadGalleryDetail({
    required bool resetData,
    bool showLoader = true,
  }) async {
    final galleryId = _galleryId;
    if (galleryId == null || galleryId.isEmpty) return;

    if (showLoader) {
      refresh(state.copyWith(loader: true));
    } else {
      refresh(state.copyWith(loadingMore: true));
    }

    try {
      final page = resetData ? 1 : _currentPage + 1;
      final response = await GalleryRepo.galleryDetail(
        galleryId: galleryId,
        page: page,
      );
      final detail = response.data ?? GalleryDetailModel();
      _currentPage = detail.currentPage ?? page;

      final updatedImages = resetData
          ? detail.images
          : [...state.imagesList, ...detail.images];

      refresh(
        state.copyWith(
          loader: false,
          loadingMore: false,
          imagesList: updatedImages,
          hasMore: detail.hasMorePages,
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false, loadingMore: false));
      ErrorHandler.handle(e);
    }
  }

  void loadMore() {
    if (state.loader || state.loadingMore || !state.hasMore) return;
    _loadGalleryDetail(resetData: false, showLoader: false);
  }
}
