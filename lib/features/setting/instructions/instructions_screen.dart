import 'package:sabalpara_family/sabalpara_family.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  static const routeName = '/instructions';

  static Widget builder(BuildContext context) {
    return BlocProvider<InstructionsCubit>(
      create: (c) => InstructionsCubit(context),
      child: const InstructionsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<InstructionsCubit, InstructionsState>(
      builder: (context, state) {
        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.instructions ?? ""),
            body: CustomListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding,
              ),
              itemCount: state.instructionsList.length,
              separatorBuilder: (context, index) => 12.h.spaceVertical,
              itemBuilder: (context, index) {
                final instruction = state.instructionsList[index];
                return InstructionsItemWidget(
                  index: index,
                  instruction: instruction,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class InstructionsItemWidget extends StatelessWidget {
  const InstructionsItemWidget({
    super.key,
    required this.index,
    required this.instruction,
  });

  final int index;
  final InstructionsModel instruction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Column(
        spacing: 4.h,
        crossAxisAlignment: .start,
        children: [
          Text("${index + 1}. ${instruction.title ?? ""}", style: styleW700S16),

          5.h.spaceVertical,

          Text(
            instruction.description ?? "",
            style: styleW400S14.copyWith(
              color: AppColors.text.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
