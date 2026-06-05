import 'package:sabalpara_family/sabalpara_family_extra.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━ REQUEST ━━━━━━━━━━');
      debugPrint('➡️ ${options.method} ${options.uri}');
      debugPrint('Headers: ${options.headers}');
      debugPrint('ContentType: ${options.contentType}');
      debugPrint('Query: ${options.queryParameters}');

      if (options.data != null) {
        if (options.data is FormData) {
          final formData = options.data as FormData;
          debugPrint(
            'Form fields: ${formData.fields.map((e) => "${e.key}=${e.value}").toList()}',
          );
          debugPrint(
            'Form files: ${formData.files.map((e) => "${e.key}=${e.value.filename}").toList()}',
          );
        } else {
          debugPrint('Body: ${options.data}');
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━ RESPONSE ━━━━━━━━━━');
      debugPrint('⬅️ ${response.statusCode} ${response.requestOptions.uri}');
      debugPrint('Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('━━━━━━━━━━ ERROR ━━━━━━━━━━');
      debugPrint('❌ ${err.requestOptions.uri}');
      debugPrint('Type: ${err.type}');
      debugPrint('Message: ${err.message}');
      debugPrint('Status: ${err.response?.statusCode}');
      debugPrint('Response: ${err.response?.data}');
    }
    handler.next(err);
  }
}
