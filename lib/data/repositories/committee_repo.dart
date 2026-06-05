import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class CommitteeRepo {
  /// Committees list
  static Future<ApiResponseModel<List<CommitteeMembersModel>>> committees({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.committees,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<CommitteeMembersModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(CommitteeMembersModel.fromJson)
              .toList();
        }
        return <CommitteeMembersModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }
}
