import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'upload_result_state.dart';

class UploadResultCubit extends Cubit<UploadResultState> {
  UploadResultCubit() : super(UploadResultState()) {
    refresh(
      state.copyWith(
        yearsList: ["2020", "2021", "2022", "2023", "2024", "2025", "2026"],
      ),
    );
    _loadStandards();
  }

  TextEditingController childNameController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  void refresh(UploadResultState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> _loadStandards() async {
    refresh(state.copyWith(standardsLoading: true));
    try {
      final response = await DashboardRepo.standards();
      refresh(
        state.copyWith(
          standardsLoading: false,
          standardList: response.data ?? <StandardModel>[],
        ),
      );
    } catch (e) {
      refresh(state.copyWith(standardsLoading: false));
      ErrorHandler.handle(e);
    }
  }

  void onChangeStandard(StandardModel? value) {
    refresh(state.copyWith(selectedStandard: value, standardError: ""));
  }

  void onChangeYear(String? value) {
    refresh(state.copyWith(selectedYear: value));
  }

  Future<void> onTapUploadResult(BuildContext context) async {
    final pickedImage = await MediaPicker.pickFile(context: context);

    if (pickedImage != null) {
      refresh(state.copyWith(selectedResultFile: pickedImage, resultError: ""));
    }
  }

  void onTapRemoveResult() {
    refresh(state.copyWith(resetResultFile: true));
  }

  bool validation(BuildContext context) {
    String childNameError = "";
    String standardError = "";
    String percentageError = "";
    String yearError = "";
    String resultError = "";

    if (childNameController.text.trim().isEmpty) {
      childNameError = context.l10n?.childNameIsRequired ?? "";
    }

    if (state.selectedStandard == null) {
      standardError = context.l10n?.standardIsRequired ?? "";
    }

    if (percentageController.text.trim().isEmpty) {
      percentageError = context.l10n?.percentageIsRequired ?? "";
    } else {
      final percentage = int.tryParse(percentageController.text.trim());
      if (percentage == null || percentage < 0 || percentage > 100) {
        percentageError = "Enter valid percentage (0-100)";
      }
    }

    if (state.selectedYear == null) {
      yearError = context.l10n?.yearIsRequired ?? "";
    }

    if (state.selectedResultFile == null) {
      resultError = context.l10n?.resultIsRequired ?? "";
    }

    refresh(
      state.copyWith(
        childNameError: childNameError,
        standardError: standardError,
        percentageError: percentageError,
        yearError: yearError,
        resultError: resultError,
      ),
    );

    return childNameError.isEmpty &&
        standardError.isEmpty &&
        percentageError.isEmpty &&
        yearError.isEmpty &&
        resultError.isEmpty;
  }

  Future<void> onTapUpload(BuildContext context) async {
    if (!validation(context)) {
      return;
    }

    final file = state.selectedResultFile;
    final standardId = state.selectedStandard?.id?.toString() ?? "";
    if (file == null || standardId.isEmpty) {
      return;
    }

    hideKeyboard(context: context);
    refresh(state.copyWith(loader: true));

    try {
      final response = await DashboardRepo.uploadResult(
        childName: childNameController.text.trim(),
        standardId: standardId,
        percentage: percentageController.text.trim(),
        year: state.selectedYear ?? "",
        file: file,
      );

      if (!context.mounted) {
        return;
      }

      showSuccessToast(response.messageText);

      final uploadedResult = ResultsModel.fromApiData(response.data);

      openUploadResultSuccessBottomSheet(
        context,
        ResultsModel(
          id: uploadedResult.id,
          resultIdRaw: uploadedResult.deleteResultId,
          name: uploadedResult.name ?? childNameController.text.trim(),
          standardId: uploadedResult.standardId ?? state.selectedStandard?.id,
          standardName:
              uploadedResult.standardName ?? state.selectedStandard?.name,
          percentage:
              uploadedResult.percentage ?? percentageController.text.trim(),
          year: uploadedResult.year ?? int.tryParse(state.selectedYear ?? ""),
          result: file,
          resultUrl: uploadedResult.resultUrl,
        ),
      );
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (!isClosed) {
        refresh(state.copyWith(loader: false));
      }
    }
  }
}
