part of 'upload_result_cubit.dart';

class UploadResultState extends Equatable {
  const UploadResultState({
    this.loader = false,
    this.standardsLoading = false,
    this.childNameError = "",
    this.standardError = "",
    this.percentageError = "",
    this.yearError = "",
    this.resultError = "",
    this.standardList = const [],
    this.selectedStandard,
    this.yearsList = const [],
    this.selectedYear,
    this.selectedResultFile,
  });

  final bool loader;
  final bool standardsLoading;
  final String childNameError;
  final String standardError;
  final String percentageError;
  final String yearError;
  final String resultError;
  final List<StandardModel> standardList;
  final StandardModel? selectedStandard;
  final List<String> yearsList;
  final String? selectedYear;
  final File? selectedResultFile;

  UploadResultState copyWith({
    bool? loader,
    bool? standardsLoading,
    String? childNameError,
    String? standardError,
    String? percentageError,
    String? yearError,
    String? resultError,
    List<StandardModel>? standardList,
    StandardModel? selectedStandard,
    List<String>? yearsList,
    String? selectedYear,
    File? selectedResultFile,
    bool resetResultFile = false,
  }) {
    return UploadResultState(
      loader: loader ?? this.loader,
      standardsLoading: standardsLoading ?? this.standardsLoading,
      childNameError: childNameError ?? this.childNameError,
      standardError: standardError ?? this.standardError,
      percentageError: percentageError ?? this.percentageError,
      yearError: yearError ?? this.yearError,
      resultError: resultError ?? this.resultError,
      standardList: standardList ?? this.standardList,
      selectedStandard: selectedStandard ?? this.selectedStandard,
      yearsList: yearsList ?? this.yearsList,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedResultFile: resetResultFile == true
          ? null
          : selectedResultFile ?? this.selectedResultFile,
    );
  }

  @override
  List<Object?> get props => [
        loader,
        standardsLoading,
        childNameError,
        standardError,
        percentageError,
        yearError,
        resultError,
        standardList,
        selectedStandard,
        yearsList,
        selectedYear,
        selectedResultFile,
      ];
}
