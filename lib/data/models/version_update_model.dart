import 'package:sabalpara_family/sabalpara_family_extra.dart';

VersionUpdateModel versionUpdateModelFromJson(String str) =>
    VersionUpdateModel.fromJson(json.decode(str));

String versionUpdateModelToJson(VersionUpdateModel data) =>
    json.encode(data.toJson());

class VersionUpdateModel {
  VersionUpdateData? data;

  VersionUpdateModel({this.data});

  factory VersionUpdateModel.fromJson(Map<String, dynamic> json) =>
      VersionUpdateModel(
        data: json["data"] == null
            ? null
            : VersionUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class VersionUpdateData {
  String? androidBuildVersion;
  String? androidBuildNumber;
  String? iosBuildNumber;
  String? iosBuildVersion;
  bool? isRequired;
  bool? isForcefully;
  String? appstoreLink;
  String? playstoreLink;
  String? updateMessage;
  bool? isMaintenance;
  String? maintenanceMessage;
  String? apiUrl;
  String? assetApiUrl;

  VersionUpdateData({
    this.androidBuildVersion,
    this.androidBuildNumber,
    this.iosBuildNumber,
    this.iosBuildVersion,
    this.isRequired,
    this.isForcefully,
    this.appstoreLink,
    this.playstoreLink,
    this.updateMessage,
    this.isMaintenance,
    this.maintenanceMessage,
    this.apiUrl,
    this.assetApiUrl,
  });

  factory VersionUpdateData.fromJson(Map<String, dynamic> json) =>
      VersionUpdateData(
        androidBuildVersion: json["android_build_version"],
        androidBuildNumber: json["android_build_number"],
        iosBuildNumber: json["ios_build_number"],
        iosBuildVersion: json["ios_build_version"],
        isRequired: json["is_required"],
        isForcefully: json["is_forcefully"],
        appstoreLink: json["appstore_link"],
        playstoreLink: json["playstore_link"],
        updateMessage: json["update_message"],
        isMaintenance: json["is_maintenance"],
        maintenanceMessage: json["maintenance_message"],
        apiUrl: json["api_url"]?.toString(),
        assetApiUrl: json["asset_api_url"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "android_build_version": androidBuildVersion,
    "android_build_number": androidBuildNumber,
    "ios_build_number": iosBuildNumber,
    "ios_build_version": iosBuildVersion,
    "is_required": isRequired,
    "is_forcefully": isForcefully,
    "appstore_link": appstoreLink,
    "playstore_link": playstoreLink,
    "update_message": updateMessage,
    "is_maintenance": isMaintenance,
    "maintenance_message": maintenanceMessage,
    "api_url": apiUrl,
    "asset_api_url": assetApiUrl,
  };
}
