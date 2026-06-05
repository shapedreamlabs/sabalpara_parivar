part of 'submitted_results_cubit.dart';

class SubmittedResultsState extends Equatable {
  const SubmittedResultsState({
    this.loader = false,
    this.resultsList = const [],
  });

  final bool loader;
  final List<ResultsModel> resultsList;

  SubmittedResultsState copyWith({
    bool? loader,
    List<ResultsModel>? resultsList,
  }) {
    return SubmittedResultsState(
      loader: loader ?? this.loader,
      resultsList: resultsList ?? this.resultsList,
    );
  }

  @override
  List<Object?> get props => [loader, resultsList];
}
