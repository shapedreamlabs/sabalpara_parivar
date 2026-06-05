part of 'villages_list_cubit.dart';

class VillagesListState extends Equatable {
  const VillagesListState({
    this.loader = false,
    this.villageName = "",
    this.villageList = const [],
  });

  final bool loader;
  final String villageName;
  final List<VillagesModel> villageList;

  VillagesListState copyWith({
    bool? loader,
    String? villageName,
    List<VillagesModel>? villageList,
  }) {
    return VillagesListState(
      loader: loader ?? this.loader,
      villageName: villageName ?? this.villageName,
      villageList: villageList ?? this.villageList,
    );
  }

  @override
  List<Object?> get props => [loader, villageName, villageList];
}
