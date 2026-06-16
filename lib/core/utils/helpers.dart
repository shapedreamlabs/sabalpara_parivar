import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

void showErrorToast(String msg) {
  showCustomToast(msg, error: true);
}

void showSuccessToast(String msg) {
  showCustomToast(msg);
}

Future<void> showCatchToast(
  dynamic exception,
  StackTrace? stack, {
  String? msg,
}) async {
  bool isInternetOn = false;

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isInternetOn = true;
      debugPrint('connected');
    }
  } on SocketException catch (_) {
    debugPrint('not connected');
  }

  String content = "";

  if (!isInternetOn) {
    content = "Check you Internet connection !";
  } else if (kDebugMode) {
    content = msg ?? exception.toString();
  } else {
    content = "Something went wrong !";
  }

  showErrorToast(content);
}

bool isEnglishSelected() {
  final language = PrefService.getString(PrefKeys.localLanguage);
  return language.isEmpty || language.split('_').first.split('-').first == 'en';
}
