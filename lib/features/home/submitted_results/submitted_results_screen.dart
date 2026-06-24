import 'package:sabalpara_family/sabalpara_family.dart';

class SubmittedResultsScreen extends StatelessWidget {
  const SubmittedResultsScreen({super.key});

  static const routeName = '/submitted_results';

  static Widget builder(BuildContext context) {
    final results = context.args is List<ResultsModel>
        ? context.args as List<ResultsModel>
        : null;
    return BlocProvider<SubmittedResultsCubit>(
      create: (c) => SubmittedResultsCubit(results),
      child: const SubmittedResultsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SubmittedResultsCubit, SubmittedResultsState>(
      builder: (context, state) {
        final cubit = context.read<SubmittedResultsCubit>();

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title: l10n?.submittedResults ?? "",
              onBackTap: () => context.navigator.pop(state.resultsList),
            ),
            floatingActionButton: Padding(
              padding: .only(bottom: 60.h),
              child: CustomIconButton(
                icon: AppAssets.addIcon,
                buttonColor: AppColors.primary,
                padding: 20.h,
                size: 24.h,
                onTap: () => cubit.onTapAddResult(context),
              ),
            ),
            body: Stack(
              children: [
                CustomListView(
                  itemCount: state.resultsList.length,
                  showEmptyWidget: !state.loader && state.resultsList.isEmpty,
                  emptyWidget: Center(
                    child: Text(
                      l10n?.noResultFound ?? "No Result Found!",
                      style: styleW500S16.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  padding: .symmetric(
                    vertical: 20.h,
                    horizontal: AppConstants.horizontalPadding,
                  ),
                  separatorBuilder: (_, _) => 15.h.spaceVertical,
                  itemBuilder: (context, index) {
                    final resultData = state.resultsList[index];

                    return CommonResultCardWidget(
                      index: index,
                      resultData: resultData,
                      showStatus: false,
                      onTapDelete: () =>
                          cubit.onTapDeleteResult(context, index: index),
                    );
                  },
                ),
                if (state.loader)
                  Container(
                    color: AppColors.white.withValues(alpha: 0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
