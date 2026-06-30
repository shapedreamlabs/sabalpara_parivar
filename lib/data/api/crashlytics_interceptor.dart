import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class CrashlyticsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    CrashlyticsService.recordError(
      CrashArea.api,
      err,
      err.stackTrace,
      info: {
        'path': err.requestOptions.path,
        'method': err.requestOptions.method,
        'status_code': '${err.response?.statusCode ?? 'none'}',
      },
    );

    handler.next(err);
  }
}
