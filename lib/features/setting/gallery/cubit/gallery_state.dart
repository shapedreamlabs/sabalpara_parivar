part of 'gallery_cubit.dart';

class GalleryState extends Equatable {
  const GalleryState({
    this.loader = false,
    this.eventsList = const [],
    this.selectedEventsList = const [],
    this.galleriesList = const [],
    this.filteredGalleriesList = const [],
  });

  final bool loader;
  final List<String> eventsList;
  final List<String> selectedEventsList;
  final List<GalleryModel> galleriesList;
  final List<GalleryModel> filteredGalleriesList;

  GalleryState copyWith({
    bool? loader,
    List<String>? eventsList,
    List<String>? selectedEventsList,
    List<GalleryModel>? galleriesList,
    List<GalleryModel>? filteredGalleriesList,
  }) {
    return GalleryState(
      loader: loader ?? this.loader,
      eventsList: eventsList ?? this.eventsList,
      selectedEventsList: selectedEventsList ?? this.selectedEventsList,
      galleriesList: galleriesList ?? this.galleriesList,
      filteredGalleriesList:
          filteredGalleriesList ?? this.filteredGalleriesList,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    eventsList,
    selectedEventsList,
    galleriesList,
    filteredGalleriesList,
  ];
}
