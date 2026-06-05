import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit(BuildContext context) : super(const GalleryState()) {
    _loadGalleries();
  }

  List<GalleryModel> _allGalleries = [];

  void refresh(GalleryState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadGalleries() async {
    refresh(state.copyWith(loader: true));
    try {
      final response = await GalleryRepo.galleries();
      _allGalleries = response.data ?? <GalleryModel>[];

      final eventsList = _allGalleries
          .map((e) => e.name ?? '')
          .where((e) => e.isNotEmpty)
          .toList();

      refresh(
        state.copyWith(
          loader: false,
          eventsList: eventsList,
          galleriesList: _allGalleries,
          filteredGalleriesList: _applyFilters(),
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }

  List<GalleryModel> _applyFilters({List<String>? selectedEvents}) {
    final activeEvents = selectedEvents ?? state.selectedEventsList;
    if (activeEvents.isEmpty) {
      return List<GalleryModel>.from(_allGalleries);
    }

    return _allGalleries
        .where((gallery) => activeEvents.contains(gallery.name ?? ''))
        .toList();
  }

  void toggleEventSelection(String event) {
    final updatedEvents = List<String>.from(state.selectedEventsList);
    if (updatedEvents.contains(event)) {
      updatedEvents.remove(event);
    } else {
      updatedEvents.add(event);
    }

    refresh(
      state.copyWith(
        selectedEventsList: updatedEvents,
        filteredGalleriesList: _applyFilters(selectedEvents: updatedEvents),
      ),
    );
  }

  void onTapGallery(BuildContext context, GalleryModel gallery) {
    final galleryId = gallery.id;
    if (galleryId == null) return;

    context.navigator.pushNamed(
      GalleryDetailScreen.routeName,
      arguments: {
        'gallery_id': galleryId,
        'title': gallery.name ?? '',
      },
    );
  }
}
