import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

final pushNotificationService = PushNotificationService();

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

      await PrefService.init();
      await ScreenUtil.ensureScreenSize();

      try {
        /// 🔥 Firebase Core
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        /// 🔐 App Preferences
        await PrefService.init();

        /// 🔔 Firebase Messaging
        await pushNotificationService.initialize();

        /// 📱 Orientation & Status bar
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        );
      } catch (e) {
        debugPrint('❌ App bootstrap error: $e');
      }

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
