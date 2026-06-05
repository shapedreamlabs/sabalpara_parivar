part of 'instructions_cubit.dart';

class InstructionsState extends Equatable {
  const InstructionsState({
    this.loader = false,
    this.instructionsList = const [],
  });

  final bool loader;
  final List<InstructionsModel> instructionsList;

  InstructionsState copyWith({
    bool? loader,
    List<InstructionsModel>? instructionsList,
  }) {
    return InstructionsState(
      loader: loader ?? this.loader,
      instructionsList: instructionsList ?? this.instructionsList,
    );
  }

  @override
  List<Object?> get props => [loader, instructionsList];
}
