import 'package:gal/gal.dart';
import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class ImageDownloadService {
  static const _albumName = 'Sabalpara Family';

  static Future<void> saveNetworkImage(String? imageUrl) async {
    try {
      final url = _resolveImageUrl(imageUrl);
      if (url.isEmpty) {
        throw AppException(message: 'Image not available');
      }

      if (!await Gal.hasAccess(toAlbum: true)) {
        await Gal.requestAccess(toAlbum: true);
      }

      if (!await Gal.hasAccess(toAlbum: true)) {
        throw AppException(message: 'Photo permission denied');
      }

      final tempDir = await getTemporaryDirectory();
      final extension = _fileExtensionFromUrl(url);
      final filePath =
          '${tempDir.path}/sabalpara_${DateTime.now().millisecondsSinceEpoch}$extension';

      final dio = Dio();
      await dio.download(url, filePath);

      await Gal.putImage(filePath, album: _albumName);

      final tempFile = File(filePath);
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
    } catch (e, stack) {
      await CrashlyticsService.recordError(
        CrashArea.fileTransfer,
        e,
        stack,
        info: {'image_url': imageUrl ?? ''},
      );
      rethrow;
    }
  }

  static String _resolveImageUrl(String? imageUrl) {
    final trimmed = imageUrl?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '';
    }

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    return '${ApiConstants.assetBaseUrl}$trimmed';
  }

  static String _fileExtensionFromUrl(String url) {
    final uri = Uri.tryParse(url);
    final path = uri?.path ?? url;
    final dotIndex = path.lastIndexOf('.');

    if (dotIndex == -1 || dotIndex == path.length - 1) {
      return '.jpg';
    }

    final extension = path.substring(dotIndex).toLowerCase();
    if (extension == '.jpeg' ||
        extension == '.jpg' ||
        extension == '.png' ||
        extension == '.webp') {
      return extension == '.jpeg' ? '.jpg' : extension;
    }

    return '.jpg';
  }
}
