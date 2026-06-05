import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class BusinessRepo {
  /// Work types (business types) list
  static Future<ApiResponseModel<List<WorkTypeModel>>> workTypes({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.workTypes,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<WorkTypeModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(WorkTypeModel.fromJson)
              .toList();
        }
        return <WorkTypeModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Business users list
  static Future<ApiResponseModel<List<CommunityUserModel>>> businessUsers({
    required String workTypeId,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.businessUsers,
      fields: {'work_type_id': workTypeId},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<CommunityUserModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(CommunityUserModel.fromJson)
              .toList();
        }
        return <CommunityUserModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }
}
