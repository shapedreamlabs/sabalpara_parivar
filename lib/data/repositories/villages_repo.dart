import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class VillagesRepo {
  /// Villages list
  static Future<ApiResponseModel<List<VillageModel>>> villages({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.villages,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<VillageModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(VillageModel.fromJson)
              .toList();
        }
        return <VillageModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Village users list
  static Future<ApiResponseModel<List<CommunityUserModel>>> villageUsers({
    required String villageId,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.villageUsers,
      fields: {'village_id': villageId},
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
