import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

void hideKeyboard({BuildContext? context}) {
  context ??= navigatorKey.currentContext;
  if (context == null) {
    return;
  }
  if (FocusScope.of(context).hasFocus) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

bool isKeyboardOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}

Future<bool> redirectUrl(String? url) async {
  try {
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      return true;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return false;
}

Future<void> openPhoneDialer(String? phone) async {
  final trimmed = phone?.trim() ?? '';
  if (trimmed.isEmpty) {
    showErrorToast('Phone number not available');
    return;
  }

  final sanitized = trimmed.replaceAll(RegExp(r'[^\d+]'), '');
  if (sanitized.isEmpty) {
    showErrorToast('Invalid phone number');
    return;
  }

  final uri = Uri.parse('tel:$sanitized');

  try {
    if (!await canLaunchUrl(uri)) {
      showErrorToast('Could not open dialer');
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      showErrorToast('Could not open dialer');
    }
  } catch (e) {
    debugPrint(e.toString());
    showErrorToast('Could not open dialer');
  }
}

Future<void> openWhatsApp(String? phone) async {
  final trimmed = phone?.trim() ?? '';
  if (trimmed.isEmpty) {
    showErrorToast('Phone number not available');
    return;
  }

  final sanitized = trimmed.replaceAll(RegExp(r'[^\d]'), '');
  if (sanitized.isEmpty) {
    showErrorToast('Invalid phone number');
    return;
  }

  final uri = Uri.parse('https://wa.me/$sanitized');

  try {
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      showErrorToast('Could not open WhatsApp');
    }
  } catch (e) {
    debugPrint(e.toString());
    showErrorToast('Could not open WhatsApp');
  }
}

Future<void> logoutUser() async {
  await PrefService.clear();
  navigatorKey.currentState?.pushNamedAndRemoveUntil(
    SignInScreen.routeName,
    (predicate) => false,
  );
}

UserModel? get userModel {
  try {
    final str = PrefService.getString(PrefKeys.userData);
    if (str.isNotEmpty) {
      return userModelFromJson(str);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<void> loadAssetImage(String image) async {
  await loadImage(AssetImage(image));
}

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo image, bool sync) {
      completer.complete();
      stream.removeListener(listener);
    },
    onError: (dynamic exception, StackTrace? stackTrace) {
      completer.complete();
      stream.removeListener(listener);
      FlutterError.reportError(
        FlutterErrorDetails(
          context: ErrorDescription('image failed to load'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ),
      );
    },
  );

  stream.addListener(listener);
  return completer.future;
}

Future<File?> compressImage(File? file, {double? requestedSize}) async {
  if (file == null) {
    return null;
  }
  Directory directory = await getTemporaryDirectory();
  double requiredSize = requestedSize ?? (1024 * 1024 * 2);
  int fileSize = file.lengthSync();
  int quality = ((100 * requiredSize) / fileSize).round();
  var byte = await FlutterImageCompress.compressWithList(
    file.absolute.readAsBytesSync(),
    quality: quality > 100 ? 95 : quality,
    rotate: 0,
  );

  debugPrint(file.lengthSync().toString());

  File result = File(
    "${directory.path}/${DateTime.now().microsecondsSinceEpoch}.jpg",
  );

  if (result.existsSync()) {
    await result.delete();
  }
  result.writeAsBytesSync(byte);
  debugPrint(result.lengthSync().toString());

  final size = result.lengthSync();
  debugPrint(size.toString());

  return result;
}

String get greetingText {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning ☀️';
  }
  if (hour >= 12 && hour < 17) {
    return 'Good Afternoon 🌞';
  }
  if (hour >= 17 && hour < 21) {
    return 'Good Evening 🌙';
  }
  return 'Good Night 🌘';
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

Map<String, dynamic> getMapFromStr(String? str) {
  try {
    if (str == null) {
      return {};
    }
    return jsonDecode(str);
  } catch (e) {
    return {};
  }
}
