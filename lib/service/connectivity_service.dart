import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sabalpara_family/core/constants/end_points.dart';

/// Centralized internet connectivity checks using the app's own domain first.
class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService instance = ConnectivityService._();

  late final InternetConnection _connection = InternetConnection.createInstance(
    checkInterval: const Duration(seconds: 15),
    useDefaultOptions: false,
    customCheckOptions: [
      InternetCheckOption(
        uri: Uri.parse(ApiConstants.assetBaseUrl),
        timeout: const Duration(seconds: 5),
        responseStatusFn: (response) =>
            response.statusCode >= 200 && response.statusCode < 500,
      ),
      InternetCheckOption(
        uri: Uri.parse('https://one.one.one.one'),
        timeout: const Duration(seconds: 5),
      ),
    ],
  );

  InternetConnection get connection => _connection;

  Future<bool> get hasInternetAccess => _connection.hasInternetAccess;

  Stream<InternetStatus> get onStatusChange => _connection.onStatusChange;
}
