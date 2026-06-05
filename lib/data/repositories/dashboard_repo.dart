import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class DashboardRepo {
  /// Standards list
  static Future<ApiResponseModel<List<StandardModel>>> standards({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.standards,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<StandardModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(StandardModel.fromJson)
              .toList();
        }
        return <StandardModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Dashboard
  static Future<ApiResponseModel<DashboardModel>> dashboard({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.dashboard,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<DashboardModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return DashboardModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }

    return apiResponse;
  }

  /// Upload result
  static Future<ApiResponseModel<dynamic>> uploadResult({
    required String childName,
    required String standardId,
    required String percentage,
    required String year,
    required File file,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.uploadResult,
      fields: {
        'child_name': childName,
        'standard_id': standardId,
        'percentage': percentage,
        'year': year,
      },
      files: {
        'file': [file],
      },
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<dynamic>.fromJson(
      data,
      dataParser: (rawData) => rawData,
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }

    return apiResponse;
  }

  /// Resolves delete id from model, or by matching on fresh dashboard data.
  static Future<String?> resolveResultDeleteId(
    ResultsModel result, {
    CancelToken? cancelToken,
  }) async {
    final direct = result.deleteResultId;
    if (direct != null && direct.isNotEmpty) {
      return direct;
    }

    try {
      final response = await dashboard(cancelToken: cancelToken);
      final results = response.data?.results ?? <ResultsModel>[];
      for (final item in results) {
        if (item.matchesForDelete(result)) {
          final id = item.deleteResultId;
          if (id != null && id.isNotEmpty) {
            return id;
          }
        }
      }
    } catch (_) {}

    return null;
  }

  /// Deletes using resolved id. Returns false if server id could not be found.
  static Future<bool> deleteResultModel(
    ResultsModel result, {
    CancelToken? cancelToken,
  }) async {
    final resultId = await resolveResultDeleteId(result, cancelToken: cancelToken);
    if (resultId == null || resultId.isEmpty) {
      return false;
    }
    await deleteResult(resultId: resultId, cancelToken: cancelToken);
    return true;
  }

  /// Delete result
  static Future<void> deleteResult({
    required String resultId,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.deleteResult,
      fields: {'result_id': resultId},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<dynamic>.fromJson(
      data,
      dataParser: (rawData) => rawData,
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
  }
}
