
import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

      await PrefService.init();
      await ScreenUtil.ensureScreenSize();

      runApp(const AppView());
    },
    (error, stack) {
      if (kDebugMode) {
        log("error==========>>>>>>>>>\n$error");
        log("stack==========>>>>>>>>>\n$stack");
      }
    },
  );
}
