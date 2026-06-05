import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _loadDashboardData();
  }

  void refresh(HomeState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onBannerChange(int index) {
    refresh(state.copyWith(currentBanner: index));
  }

  Future<void> _loadDashboardData() async {
    refresh(state.copyWith(loader: true));

    try {
      await SettingRepo.syncProfileToPrefs();
      final response = await DashboardRepo.dashboard();
      final dashboardData = response.data;

      if (dashboardData == null) {
        refresh(state.copyWith(loader: false));
        return;
      }

      refresh(
        state.copyWith(
          loader: false,
          currentBanner: 0,
          bannersList: dashboardData.banners,
          resultsList: dashboardData.results,
          totalFamily: dashboardData.communityOverview.totalFamily,
          totalMembers: dashboardData.communityOverview.totalMembers,
          totalBusinesses: dashboardData.communityOverview.totalBusinesses,
          totalVillages: dashboardData.communityOverview.totalVillages,
        ),
      );
    } catch (e) {
      refresh(state.copyWith(loader: false));
      ErrorHandler.handle(e);
    }
  }

  Future<void> onTapViewAllSubmittedResults(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      SubmittedResultsScreen.routeName,
      arguments: state.resultsList,
    );

    if (result != null) {
      refresh(
        state.copyWith(
          resultsList: List<ResultsModel>.from(result as List<ResultsModel>),
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

  Future<void> onTapUploadResult(BuildContext context) async {
    final result = await context.navigator.pushNamed(
      UploadResultScreen.routeName,
    );

    if (result != null) {
      await _loadDashboardData();
    }
  }
}
