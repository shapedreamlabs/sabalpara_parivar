import 'package:sabalpara_family/sabalpara_family_extra.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor(this.dio);

  final Dio dio;
  static const _maxRetries = 2;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    final shouldRetry =
        retryCount < _maxRetries &&
        (err.type == .connectionError ||
            err.type == .connectionTimeout ||
            err.type == .sendTimeout ||
            err.type == .receiveTimeout);

    if (!shouldRetry) {
      handler.reject(err);
      return;
    }

    await Future.delayed(Duration(milliseconds: 600 * (retryCount + 1)));

    try {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.reject(retryError);
    } catch (_) {
      handler.reject(err);
    }
  }
}
