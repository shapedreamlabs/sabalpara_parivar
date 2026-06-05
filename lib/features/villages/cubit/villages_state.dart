part of 'villages_cubit.dart';

class VillagesState extends Equatable {
  const VillagesState({
    this.loader = false,
    this.villageList = const [],
    this.filteredVillageList = const [],
  });

  final bool loader;
  final List<VillageModel> villageList;
  final List<VillageModel> filteredVillageList;

  VillagesState copyWith({
    bool? loader,
    List<VillageModel>? villageList,
    List<VillageModel>? filteredVillageList,
  }) {
    return VillagesState(
      loader: loader ?? this.loader,
      villageList: villageList ?? this.villageList,
      filteredVillageList: filteredVillageList ?? this.filteredVillageList,
    );
  }

  @override
  List<Object?> get props => [loader, villageList, filteredVillageList];
}
