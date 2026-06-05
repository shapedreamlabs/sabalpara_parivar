import 'package:sabalpara_family/data/models/banner_model.dart';
import 'package:sabalpara_family/data/models/results_model.dart';

class DashboardModel {
  final List<BannerModel> banners;
  final CommunityOverviewModel communityOverview;
  final List<ResultsModel> results;

  DashboardModel({
    this.banners = const [],
    required this.communityOverview,
    this.results = const [],
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        banners: (json["banners"] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(BannerModel.fromJson)
            .toList(),
        communityOverview: CommunityOverviewModel.fromJson(
          json["community_overview"] is Map<String, dynamic>
              ? json["community_overview"]
              : const <String, dynamic>{},
        ),
        results: (json["results"] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ResultsModel.fromJson)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners.map((e) => e.toJson()).toList(),
        "community_overview": communityOverview.toJson(),
        "results": results.map((e) => e.toJson()).toList(),
      };
}

class CommunityOverviewModel {
  final int totalFamily;
  final int totalMembers;
  final int totalBusinesses;
  final int totalVillages;

  const CommunityOverviewModel({
    this.totalFamily = 0,
    this.totalMembers = 0,
    this.totalBusinesses = 0,
    this.totalVillages = 0,
  });

  factory CommunityOverviewModel.fromJson(Map<String, dynamic> json) =>
      CommunityOverviewModel(
        totalFamily: json["total_family"] is int
            ? json["total_family"]
            : int.tryParse("${json["total_family"]}") ?? 0,
        totalMembers: json["total_members"] is int
            ? json["total_members"]
            : int.tryParse("${json["total_members"]}") ?? 0,
        totalBusinesses: json["total_businesses"] is int
            ? json["total_businesses"]
            : int.tryParse("${json["total_businesses"]}") ?? 0,
        totalVillages: json["total_villages"] is int
            ? json["total_villages"]
            : int.tryParse("${json["total_villages"]}") ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "total_family": totalFamily,
        "total_members": totalMembers,
        "total_businesses": totalBusinesses,
        "total_villages": totalVillages,
      };
}
