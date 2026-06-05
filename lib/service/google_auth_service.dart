import 'package:google_sign_in/google_sign_in.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class GoogleSignInData {
  const GoogleSignInData({
    required this.providerId,
    required this.email,
    required this.name,
    this.photoUrl,
  });

  final String providerId;
  final String email;
  final String name;
  final String? photoUrl;
}

class GoogleAuthService {
  GoogleAuthService._();

  static bool _initialized = false;

  static Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  static Future<GoogleSignInData?> signIn() async {
    await _ensureInitialized();

    if (!GoogleSignIn.instance.supportsAuthenticate()) {
      throw AppException(message: 'Google sign in is not supported on this device');
    }

    try {
      final account = await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email', 'profile'],
      );

      if (account.email.trim().isEmpty) {
        throw AppException(message: 'Google account email is required');
      }

      return GoogleSignInData(
        providerId: account.id,
        email: account.email.trim(),
        name: (account.displayName ?? '').trim(),
        photoUrl: account.photoUrl,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw AppException(message: e.description ?? 'Google sign in failed');
    }
  }

  static Future<File?> downloadAvatarFile(String? photoUrl) async {
    if (photoUrl == null || photoUrl.trim().isEmpty) {
      return null;
    }

    try {
      final response = await Dio().get<List<int>>(
        photoUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        return null;
      }

      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/google_avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await file.writeAsBytes(bytes);
      return file;
    } catch (_) {
      return null;
    }
  }
}
