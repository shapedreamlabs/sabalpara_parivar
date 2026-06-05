import 'package:sabalpara_family/sabalpara_family.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.deviceHeight = MediaQuery.of(context).size.height;
    AppConstants.deviceWidth = MediaQuery.of(context).size.width;
    AppConstants.safeAreaPadding = MediaQuery.of(context).padding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: .light,
      child: ScreenUtilInit(
        designSize: AppConstants.figmaSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (context) => AppCubit(),
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return OKToast(
                  child: MaterialApp(
                    localizationsDelegates: [
                      ...AppLocalizations.localizationsDelegates,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: state.locale,
                    theme: AppColors.themeData,
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: kDebugMode,
                    title: AppConstants.appName,
                    initialRoute: RouteService.initialRoute,
                    onGenerateRoute: RouteService.onGenerateRoute,
                    builder: (context, child) => MediaQuery.withNoTextScaling(
                      child: Stack(
                        children: [
                          child ?? SizedBox(),

                          InternetConnectionLostWidget(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
