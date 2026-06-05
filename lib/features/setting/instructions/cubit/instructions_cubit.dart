import 'package:sabalpara_family/sabalpara_family.dart';

part 'instructions_state.dart';

class InstructionsCubit extends Cubit<InstructionsState> {
  InstructionsCubit(BuildContext context) : super(InstructionsState()) {
    init(context);
  }

  void refresh(InstructionsState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void init(BuildContext context) {
    final instructionsList = [
      InstructionsModel(
        title: context.l10n?.enterCorrectDetails ?? "",
        description: context.l10n?.enterCorrectDetailsDesc ?? "",
      ),
      InstructionsModel(
        title: context.l10n?.uploadClearMarksheet ?? "",
        description: context.l10n?.uploadClearMarksheetDesc ?? "",
      ),
      InstructionsModel(
        title: context.l10n?.checkFileFormat ?? "",
        description: context.l10n?.checkFileFormatDesc ?? "",
      ),
      InstructionsModel(
        title: context.l10n?.verifyBeforeSubmit ?? "",
        description: context.l10n?.verifyBeforeSubmitDesc ?? "",
      ),
      InstructionsModel(
        title: context.l10n?.submissionDeadline ?? "",
        description: context.l10n?.submissionDeadlineDesc ?? "",
      ),
      InstructionsModel(
        title: context.l10n?.oneSubmissionPerChild ?? "",
        description: context.l10n?.oneSubmissionPerChildDesc ?? "",
      ),
    ];

    refresh(state.copyWith(instructionsList: instructionsList));
  }
}
