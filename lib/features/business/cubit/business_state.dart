part of 'business_cubit.dart';

class BusinessState extends Equatable {
  const BusinessState({
    this.loader = false,
    this.workTypesList = const [],
    this.filteredWorkTypesList = const [],
  });

  final bool loader;
  final List<WorkTypeModel> workTypesList;
  final List<WorkTypeModel> filteredWorkTypesList;

  BusinessState copyWith({
    bool? loader,
    List<WorkTypeModel>? workTypesList,
    List<WorkTypeModel>? filteredWorkTypesList,
  }) {
    return BusinessState(
      loader: loader ?? this.loader,
      workTypesList: workTypesList ?? this.workTypesList,
      filteredWorkTypesList:
          filteredWorkTypesList ?? this.filteredWorkTypesList,
    );
  }

  @override
  List<Object?> get props => [loader, workTypesList, filteredWorkTypesList];
}
