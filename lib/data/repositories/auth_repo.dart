import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class AuthRepo {
  static Future<UserModel> _persistLoginData(LoginModel loginData) async {
    final user = loginData.toUserModel();
    final token = loginData.accessToken;
    if (token != null && token.isNotEmpty) {
      await PrefService.set(PrefKeys.token, token);
    }
    await PrefService.set(PrefKeys.userData, userModelToJson(user));
    return user;
  }

  static LoginModel _parseLoginResponse(Map<String, dynamic> data) {
    final apiResponse = ApiResponseModel<LoginModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return LoginModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }

    final loginData = apiResponse.data;
    if (loginData == null) {
      throw AppException(message: 'Invalid server response');
    }

    return loginData;
  }

  /// Social login (Google, etc.)
  static Future<UserModel> socialLogin({
    required String provider,
    required String providerId,
    required String email,
    required String name,
    String? phone,
    File? avatar,
    CancelToken? cancelToken,
  }) async {
    final fields = <String, dynamic>{
      'provider': provider,
      'provider_id': providerId,
      'email': email,
      'name': name,
      'phone': phone ?? '',
    };

    final response = await ApiService.multipart(
      type: .post,
      path: ApiConstants.socialLogin,
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

    final loginData = _parseLoginResponse(data);
    return _persistLoginData(loginData);
  }

  /// Reset password
  static Future<ApiResponseModel<ResetPasswordModel>> resetPassword({
    required String email,
    required String password,
    required String code,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .post,
      path: ApiConstants.resetPassword,
      body: {'email': email, 'password': password, 'code': code},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<ResetPasswordModel>.fromJson(
      data,
      dataParser: (rawData) => ResetPasswordModel.fromJson(rawData),
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Forgot password
  static Future<ApiResponseModel<ForgotPasswordModel>> forgotPassword({
    required String email,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .post,
      path: ApiConstants.forgotPassword,
      body: {'email': email},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<ForgotPasswordModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return ForgotPasswordModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }
    return apiResponse;
  }

  /// Register
  static Future<ApiResponseModel<RegisterModel>> register({
    required String email,
    required String phone,
    required String password,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .post,
      path: ApiConstants.register,
      body: {'email': email, 'phone': phone, 'password': password},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final apiResponse = ApiResponseModel<RegisterModel>.fromJson(
      data,
      dataParser: (rawData) {
        if (rawData is Map<String, dynamic>) {
          return RegisterModel.fromJson(rawData);
        }
        return null;
      },
    );

    if (!apiResponse.isSuccess) {
      throw AppException(message: apiResponse.messageText);
    }

    final token = apiResponse.data?.accessToken;
    if (token != null && token.isNotEmpty) {
      await PrefService.set(PrefKeys.token, token);
    }
    return apiResponse;
  }

  /// Login
  static Future<UserModel> login({
    required String email,
    required String password,
    CancelToken? cancelToken,
  }) async {
    final response = await ApiService.request(
      type: .post,
      path: ApiConstants.login,
      body: {'email': email, 'password': password},
      cancelToken: cancelToken,
    );

    final data = response.data;
    if (data == null || data is! Map<String, dynamic>) {
      throw AppException(message: 'Invalid server response');
    }

    final loginData = _parseLoginResponse(data);
    return _persistLoginData(loginData);
  }
}
