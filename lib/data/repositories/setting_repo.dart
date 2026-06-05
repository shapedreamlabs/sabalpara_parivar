import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class SettingRepo {
  /// Members list
  static Future<ApiResponseModel<List<FamilyMembersModel>>> members({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.members,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<FamilyMembersModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(FamilyMembersModel.fromJson)
              .toList();
        }
        return <FamilyMembersModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Add member
  static Future<ApiResponseModel<FamilyMembersModel>> addMember({
    required String name,
    required String email,
    required String phone,
    required String age,
    required String relation,
    required String occupation,
    String? standardId,
    String? workTypeId,
    String? role,
    String? businessName,
    CancelToken? cancelToken,
  }) async {
    final fields = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'relation': relation,
      'occupation': occupation,
    };
    if ((standardId ?? '').isNotEmpty) fields['standard_id'] = standardId;
    if ((workTypeId ?? '').isNotEmpty) fields['work_type_id'] = workTypeId;
    if ((role ?? '').isNotEmpty) fields['role'] = role;
    if ((businessName ?? '').isNotEmpty) fields['business_name'] = businessName;

    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.addMember,
      fields: fields,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<FamilyMembersModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return FamilyMembersModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Edit member
  static Future<ApiResponseModel<FamilyMembersModel>> editMember({
    required String memberId,
    required String name,
    required String email,
    required String phone,
    required String age,
    required String relation,
    required String occupation,
    String? standardId,
    String? workTypeId,
    String? role,
    String? businessName,
    CancelToken? cancelToken,
  }) async {
    final fields = <String, dynamic>{
      'member_id': memberId,
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'relation': relation,
      'occupation': occupation,
    };
    if ((standardId ?? '').isNotEmpty) fields['standard_id'] = standardId;
    if ((workTypeId ?? '').isNotEmpty) fields['work_type_id'] = workTypeId;
    if ((role ?? '').isNotEmpty) fields['role'] = role;
    if ((businessName ?? '').isNotEmpty) fields['business_name'] = businessName;

    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.editMember,
      fields: fields,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<FamilyMembersModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return FamilyMembersModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Delete member
  static Future<void> deleteMember({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.deleteMember,
      fields: {'id': id},
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

  /// Sync profile and persist in local prefs
  static Future<ProfileModel?> syncProfileToPrefs({
    CancelToken? cancelToken,
  }) async {
    final response = await profile(cancelToken: cancelToken);
    final profileData = response.data;
    if (profileData == null) {
      return null;
    }

    await PrefService.set(
      PrefKeys.userData,
      userModelToJson(profileData.toUserModel()),
    );
    if ((profileData.accessToken ?? '').isNotEmpty) {
      await PrefService.set(PrefKeys.token, profileData.accessToken);
    }
    return profileData;
  }

  /// Profile
  static Future<ApiResponseModel<ProfileModel>> profile({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.profile,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<ProfileModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return ProfileModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Edit profile
  static Future<ApiResponseModel<ProfileModel>> editProfile({
    required Map<String, dynamic> fields,
    File? avatar,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.editProfile,
      fields: fields,
      files: avatar == null
          ? null
          : {
              'avatar': [avatar],
            },
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<ProfileModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return ProfileModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Cities
  static Future<ApiResponseModel<List<CityModel>>> cities({
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.cities,
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<List<CityModel>>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is List) {
          return rawData
              .whereType<Map<String, dynamic>>()
              .map(CityModel.fromJson)
              .toList();
        }
        return <CityModel>[];
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }

    return apiResponse;
  }

  /// Change password
  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .post,
      path: ApiConstants.changePassword,
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
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
  }

  /// Logout
  static Future<void> logout({CancelToken? cancelToken}) async {
    final response = await ApiService.request(
      type: .get,
      path: ApiConstants.logout,
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
