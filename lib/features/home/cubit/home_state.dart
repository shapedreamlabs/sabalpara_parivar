part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.loader = false,
    this.currentBanner = 0,
    this.bannersList = const [],
    this.resultsList = const [],
    this.totalFamily = 0,
    this.totalMembers = 0,
    this.totalBusinesses = 0,
    this.totalVillages = 0,
  });

  final bool loader;
  final int currentBanner;
  final List<BannerModel> bannersList;
  final List<ResultsModel> resultsList;
  final int totalFamily;
  final int totalMembers;
  final int totalBusinesses;
  final int totalVillages;

  HomeState copyWith({
    bool? loader,
    int? currentBanner,
    List<BannerModel>? bannersList,
    List<ResultsModel>? resultsList,
    int? totalFamily,
    int? totalMembers,
    int? totalBusinesses,
    int? totalVillages,
  }) {
    return HomeState(
      loader: loader ?? this.loader,
      currentBanner: currentBanner ?? this.currentBanner,
      bannersList: bannersList ?? this.bannersList,
      resultsList: resultsList ?? this.resultsList,
      totalFamily: totalFamily ?? this.totalFamily,
      totalMembers: totalMembers ?? this.totalMembers,
      totalBusinesses: totalBusinesses ?? this.totalBusinesses,
      totalVillages: totalVillages ?? this.totalVillages,
    );
  }

  @override
  List<Object?> get props => [
    loader,
    currentBanner,
    bannersList,
    resultsList,
    totalFamily,
    totalMembers,
    totalBusinesses,
    totalVillages,
  ];
}
