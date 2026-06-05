import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'submitted_results_state.dart';

class SubmittedResultsCubit extends Cubit<SubmittedResultsState> {
  SubmittedResultsCubit(List<ResultsModel>? results)
    : super(SubmittedResultsState()) {
    refresh(state.copyWith(resultsList: results ?? []));
  }

  void refresh(SubmittedResultsState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  Future<void> onTapAddResult(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      UploadResultScreen.routeName,
    );

    if (result != null) {
      refresh(
        state.copyWith(
          resultsList: List<ResultsModel>.from([
            ...state.resultsList,
            result as ResultsModel,
          ]),
        ),
      );
    }
  }

  Future<void> onTapDeleteResult(
    BuildContext context, {
    required int index,
  }) async {
    if (state.loader) return;
    if (index < 0 || index >= state.resultsList.length) {
      return;
    }

    final confirmed = await openDeleteResultConfirmationBottomSheet(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    final result = state.resultsList[index];

    refresh(state.copyWith(loader: true));
    try {
      await DashboardRepo.deleteResultModel(result);
      final updatedList = List<ResultsModel>.from(state.resultsList)
        ..removeAt(index);
      refresh(state.copyWith(loader: false, resultsList: updatedList));
      showSuccessToast('Result deleted successfully');
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }
}
