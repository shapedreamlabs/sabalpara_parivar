import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class GalleryRepo {
  /// Galleries list
  static Future<ApiResponseModel<List<GalleryModel>>> galleries({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.galleries,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<GalleryModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(GalleryModel.fromJson)
              .toList();
        }
        return <GalleryModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Gallery detail (paginated images)
  static Future<ApiResponseModel<GalleryDetailModel>> galleryDetail({
    required String galleryId,
    int page = 1,
    CancelToken? cancelToken,
  }) async {
    final fields = <String, dynamic>{
      'id': galleryId,
      if (page > 1) 'page': '$page',
    };

    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.galleryDetail,
      fields: fields,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<GalleryDetailModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return GalleryDetailModel.fromJson(rawData);
        }
        return GalleryDetailModel();
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }
}
