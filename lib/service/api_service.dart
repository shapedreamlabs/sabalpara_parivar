import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

/// REQUEST TYPE ==============================================
enum RequestType { get, post, put, patch, delete }

/// API SERVICE ==============================================
class ApiService {
  ApiService._();

  static Dio? _dio;

  static Dio get dio {
    if (_dio != null) return _dio!;

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: 15.seconds,
        receiveTimeout: 15.seconds,
        sendTimeout: 15.seconds,
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    _dio!.interceptors.add(AuthInterceptor(_dio!));
    _dio!.interceptors.add(RetryInterceptor(_dio!));
    _dio!.interceptors.add(LoggerInterceptor());

    return _dio!;
  }

  /// NORMAL REQUEST ==============================================
  static Future<Response<T>> request<T>({
    required String path,
    required RequestType type,
    Map<String, dynamic>? query,
    dynamic body,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      Options? effectiveOptions = options;
      if (body is FormData) {
        final headers = Map<String, dynamic>.from(options?.headers ?? {});
        headers.remove(Headers.contentTypeHeader);
        effectiveOptions = (options ?? Options()).copyWith(
          headers: headers,
          contentType: null,
        );
      }

      switch (type) {
        case .get:
          return await dio.get<T>(
            path,
            queryParameters: query,
            cancelToken: cancelToken,
            options: effectiveOptions,
          );

        case .post:
          return await dio.post<T>(
            path,
            data: body,
            queryParameters: query,
            cancelToken: cancelToken,
            options: effectiveOptions,
          );

        case .put:
          return await dio.put<T>(
            path,
            data: body,
            queryParameters: query,
            cancelToken: cancelToken,
            options: effectiveOptions,
          );

        case .patch:
          return await dio.patch<T>(
            path,
            data: body,
            queryParameters: query,
            cancelToken: cancelToken,
            options: effectiveOptions,
          );

        case .delete:
          return await dio.delete<T>(
            path,
            data: body,
            queryParameters: query,
            cancelToken: cancelToken,
            options: effectiveOptions,
          );
      }
    } on DioException {
      rethrow;
    }
  }

  /// MULTIPART REQUEST ==============================================
  static Future<Response<T>> multipart<T>({
    required String path,
    required RequestType type,
    required Map<String, dynamic> fields,
    Map<String, List<File>>? files,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    final payload = <String, dynamic>{};
    fields.forEach((key, value) {
      payload[key] = value.toString();
    });

    if (files != null) {
      for (final entry in files.entries) {
        final multipartFiles = <MultipartFile>[];
        for (final file in entry.value) {
          multipartFiles.add(
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          );
        }
        payload[entry.key] = multipartFiles.length == 1
            ? multipartFiles.first
            : multipartFiles;
      }
    }

    final formData = FormData.fromMap(payload);

    return request<T>(
      path: path,
      type: type,
      body: formData,
      query: query,
      cancelToken: cancelToken,
    );
  }
}
