import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == .connectionError || err.type == .connectionTimeout) {
      await Future.delayed(2.seconds);
      handler.resolve(await dio.fetch(err.requestOptions));
    } else {
      handler.reject(err);
    }
  }
}
