import 'package:package_info_plus/package_info_plus.dart';
import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

bool _openAppDialog = false;
PackageInfo? packageInfo;
bool isDialogOpen = false;
String? updateMessage;
String? maintenanceMessage;
ValueNotifier<bool> isUpdateAvailable = ValueNotifier(false);
VoidCallback onAppUpdateBtnTap = () {};

class AppUpGrader extends StatefulWidget {
  final Widget child;

  const AppUpGrader({super.key, required this.child});

  @override
  State<AppUpGrader> createState() => _AppUpGraderState();
}

class _AppUpGraderState extends State<AppUpGrader> {
  String version = "";
  String buildNumber = "";
  VersionUpdateData versionUpdateData = VersionUpdateData();

  @override
  void initState() {
    getVersion();
    super.initState();
  }

  Future<void> getVersion() async {
    if (_openAppDialog) {
      return;
    }
    _openAppDialog = true;
    try {
      final model = await RemoteAppConfigService.instance.ensureLoaded();

      if (model != null) {
        versionUpdateData = model;
        getVersionMap(versionUpdateData);
        if ((model.updateMessage ?? "").trim().isNotEmpty) {
          updateMessage = model.updateMessage;
        }
        if ((model.maintenanceMessage ?? "").trim().isNotEmpty) {
          maintenanceMessage = model.maintenanceMessage;
        }
        if (model.isMaintenance == true) {
          openMaintenanceDialog();
        }
        await checkAppVersion();
      }
    } catch (e) {
      debugPrint("AppUpGrader: $e");
    }
  }

  void getVersionMap(VersionUpdateData? data) {
    if (data == null) {
      return;
    } else {
      if (Platform.isAndroid) {
        version = data.androidBuildVersion ?? '';
        buildNumber = data.androidBuildNumber ?? '';
      } else {
        version = data.iosBuildVersion ?? '';
        buildNumber = data.iosBuildNumber ?? '';
      }
    }
  }

  Future<void> checkAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();

    isUpdateAvailable.value = isShowDialog();
    onAppUpdateBtnTap = () {
      final storeUrl = Platform.isAndroid
          ? versionUpdateData.playstoreLink
          : versionUpdateData.appstoreLink;
      openStore(storeUrl);
    };
    if (versionUpdateData.isRequired == true &&
        isShowDialog() &&
        (isDialogOpen == false)) {
      isDialogOpen = true;

      openDialog();
    }
  }

  void openDialog() {
    final dialogContext = _dialogContext;
    if (dialogContext == null) {
      isDialogOpen = false;
      return;
    }

    showDialog(
      context: dialogContext,
      builder: (con) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            if (versionUpdateData.isForcefully != true || kDebugMode) {
              Navigator.pop(con);
            }
          },
          child: Dialog(
            insetPadding: .symmetric(horizontal: 24.w),
            backgroundColor: Colors.transparent,
            child: AppUpgradeDialog(versionUpdateData: versionUpdateData),
          ),
        );
      },
      barrierDismissible: versionUpdateData.isForcefully != true || kDebugMode,
    ).whenComplete(() {
      isDialogOpen = false;
    });
  }

  void openMaintenanceDialog() {
    final dialogContext = _dialogContext;
    if (dialogContext == null) {
      return;
    }

    showDialog(
      context: dialogContext,
      builder: (con) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            if (versionUpdateData.isForcefully != true || kDebugMode) {
              Navigator.pop(con);
            }
          },
          child: Dialog(
            insetPadding: .symmetric(horizontal: 24.w),
            backgroundColor: Colors.transparent,
            child: const MaintenanceDialog(),
          ),
        );
      },
      barrierDismissible: false,
    ).whenComplete(() {
      isDialogOpen = false;
    });
  }

  BuildContext? get _dialogContext {
    if (mounted) return context;
    final current = navigatorKey.currentContext;
    if (current != null && current.mounted) return current;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  bool isShowDialog() {
    final apiVersion = version.toString();
    final apiBuild = buildNumber.toString();
    final appVersion = packageInfo?.version.toString() ?? '';
    final appBuild = packageInfo?.buildNumber.toString() ?? '';

    if (appVersion.isEmpty ||
        apiBuild.isEmpty ||
        appVersion.isEmpty ||
        appBuild.isEmpty) {
      return false;
    }

    final apiVersionList = apiVersion
        .split(".")
        .map<int>((e) => int.parse(e))
        .toList();
    final appVersionList = appVersion
        .split(".")
        .map<int>((e) => int.parse(e))
        .toList();

    for (var i = 0; i < apiVersionList.length; i++) {
      if (appVersionList[i] > apiVersionList[i]) {
        return false;
      }
      if (appVersionList[i] < apiVersionList[i]) {
        return true;
      }
    }
    final apiBuildNumber = int.parse(apiBuild);
    final appBuildNumber = int.parse(appBuild);

    if (appBuildNumber < apiBuildNumber) {
      return true;
    } else {
      return false;
    }
  }
}

void openStore(String? url) {
  redirectUrl(url);
}

class AppUpgradeDialog extends StatelessWidget {
  final VersionUpdateData? versionUpdateData;

  const AppUpgradeDialog({super.key, this.versionUpdateData});

  bool get _canDismiss => versionUpdateData?.isForcefully != true || kDebugMode;

  void _close(BuildContext context) {
    if (_canDismiss) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: .infinity,
      padding: .fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(20.r),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          _AppUpgradeLogoHeader(
            showClose: _canDismiss,
            onClose: () => _close(context),
          ),

          SizedBox(height: 12.h),

          Text(
            l10n?.newVersionAvailable ?? '',
            textAlign: .center,
            style: styleW600S18.copyWith(color: AppColors.text),
          ),

          SizedBox(height: 4.h),

          Text(
            updateMessage ?? l10n?.updatePopupContent ?? '',
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey, height: 1.45),
          ),

          SizedBox(height: 24.h),

          CustomButton(
            title: l10n?.yes ?? '',
            onTap: () {
              final storeUrl = Platform.isAndroid
                  ? versionUpdateData?.playstoreLink ?? ""
                  : versionUpdateData?.appstoreLink ?? "";
              openStore(storeUrl);
            },
          ),

          if (_canDismiss) ...[
            SizedBox(height: 12.h),
            CustomButton(
              title: l10n?.no ?? '',
              buttonColor: AppColors.white,
              textColor: AppColors.grey,
              borderColor: AppColors.text.withValues(alpha: 0.1),
              onTap: () => _close(context),
            ),
          ],
        ],
      ),
    );
  }
}

class MaintenanceDialog extends StatelessWidget {
  const MaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: .infinity,
      padding: .fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(20.r),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          const _AppUpgradeLogoHeader(showClose: false),

          SizedBox(height: 12.h),

          Text(
            l10n?.maintenanceInProgress ?? '',
            textAlign: .center,
            style: styleW600S18.copyWith(color: AppColors.text),
          ),

          SizedBox(height: 4.h),

          Text(
            maintenanceMessage ?? l10n?.maintenancePopupContent ?? '',
            textAlign: .center,
            style: styleW400S14.copyWith(color: AppColors.grey, height: 1.45),
          ),

          SizedBox(height: 24.h),

          CustomButton(
            title: l10n?.ok ?? '',
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AppUpgradeLogoHeader extends StatelessWidget {
  const _AppUpgradeLogoHeader({required this.showClose, this.onClose});

  final bool showClose;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: .center,
        children: [
          Image.asset(
            AppAssets.logoImg,
            width: 48.w,
            height: 48.w,
            fit: .contain,
          ),
          if (showClose)
            Align(
              alignment: .topRight,
              child: InkWell(
                onTap: onClose,
                borderRadius: .circular(20.r),
                child: Padding(
                  padding: .all(8.w),
                  child: Icon(Icons.close, size: 22.h, color: AppColors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
