import 'package:sabalpara_family/sabalpara_family.dart';

class InternetConnectionLostWidget extends StatefulWidget {
  const InternetConnectionLostWidget({super.key});

  @override
  State<InternetConnectionLostWidget> createState() =>
      _InternetConnectionLostWidgetState();
}

class _InternetConnectionLostWidgetState
    extends State<InternetConnectionLostWidget> {
  ValueNotifier<bool> hasInternet = ValueNotifier(true);
  ValueNotifier<bool> checkingInternet = ValueNotifier(false);

  Future<void> checkInternet() async {
    checkingInternet.value = true;
    await Future.delayed(1000.milliseconds);
    checkingInternet.value = false;

    hasInternet.value = await InternetConnection().hasInternetAccess;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetConnection().onStatusChange,
      builder: (context, snapshot) {
        hasInternet.value = snapshot.data == InternetStatus.connected;

        if (hasInternet.value) {
          return SizedBox();
        } else {
          return Material(
            color: Colors.transparent,
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Container(
                color: AppColors.black.withValues(alpha: 0.6),
                padding: .symmetric(vertical: 50.h, horizontal: 30.w),
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SizedBox(),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgAsset(
                          imagePath: AppAssets.noInternetIcon,
                          height: 58.h,
                        ),

                        25.h.spaceVertical,

                        Text(
                          "${context.l10n?.noInternet}!",
                          style: styleW700S30,
                        ),

                        10.h.spaceVertical,

                        Text(
                          "${context.l10n?.noInternetDescription}.",
                          textAlign: TextAlign.center,
                          style: styleW400S16.copyWith(
                            color: AppColors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),

                    ValueListenableBuilder(
                      valueListenable: checkingInternet,
                      builder: (context, checkingInternet, child) =>
                          CustomButton(
                            isLoading: checkingInternet,
                            title: context.l10n?.retry ?? "",
                            onTap: checkInternet,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
