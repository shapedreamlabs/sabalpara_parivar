import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

/// Loads the Firebase Remote Config `app_update` payload once per session.
class RemoteAppConfigService {
  RemoteAppConfigService._();

  static final RemoteAppConfigService instance = RemoteAppConfigService._();

  VersionUpdateData? _cached;
  Future<VersionUpdateData?>? _inFlight;
  bool _loaded = false;

  VersionUpdateData? get data => _cached;

  Future<VersionUpdateData?> ensureLoaded() {
    if (_loaded) return Future.value(_cached);
    return _inFlight ??= _load();
  }

  Future<VersionUpdateData?> _load() async {
    try {
      await _ensureFirebase();

      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: 1.minutes,
          minimumFetchInterval: 1000.milliseconds,
        ),
      );
      await remoteConfig.fetchAndActivate();

      final response = remoteConfig.getValue("app_update");
      if (response.asString().isEmpty) {
        _loaded = true;
        _inFlight = null;
        return null;
      }

      final decoded = jsonDecode(response.asString());
      final model = VersionUpdateData.fromJson(_payloadMap(decoded));
      _cached = model;
      _loaded = true;
      return model;
    } catch (e) {
      debugPrint("RemoteAppConfigService: $e");
      _inFlight = null;
      return null;
    }
  }

  Map<String, dynamic> _payloadMap(dynamic decoded) {
    final root = decoded is Map
        ? Map<String, dynamic>.from(decoded)
        : <String, dynamic>{};
    final nested = root["data"];
    if (root["android_build_version"] == null &&
        root["ios_build_version"] == null &&
        nested is Map) {
      return Map<String, dynamic>.from(nested);
    }
    return root;
  }

  Future<void> _ensureFirebase() async {
    if (Firebase.apps.isNotEmpty) return;
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (_) {
      if (Firebase.apps.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }
  }
}
