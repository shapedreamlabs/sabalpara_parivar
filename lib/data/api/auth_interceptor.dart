import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isLoggingOut = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = PrefService.getString(PrefKeys.token);

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (!_isLoggingOut) {
        _isLoggingOut = true;
        _forceLogout();
      }
    }

    final exception = _mapDioError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _mapDioError(DioException err) {
    if (err.type == .connectionTimeout || err.type == .receiveTimeout) {
      return AppException(message: 'Connection timeout');
    }

    if (err.type == .connectionError) {
      return AppException(message: 'No internet connection');
    }

    final status = err.response?.statusCode;

    switch (status) {
      case 400:
        return AppException(message: 'Bad request', statusCode: 400);
      case 401:
        return AppException(message: 'Session expired', statusCode: 401);
      case 403:
        return AppException(message: 'Access denied', statusCode: 403);
      case 404:
        return AppException(message: 'Resource not found', statusCode: 404);
      case 500:
        return AppException(message: 'Server error', statusCode: 500);
      default:
        return AppException(message: 'Something went wrong');
    }
  }

  void _forceLogout() {
    logoutUser();
    ApiService.invalidate();
  }
}
