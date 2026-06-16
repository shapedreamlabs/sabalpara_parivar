import 'dart:async';

import 'package:sabalpara_family/sabalpara_family.dart';

class InternetConnectionLostWidget extends StatefulWidget {
  const InternetConnectionLostWidget({super.key});

  @override
  State<InternetConnectionLostWidget> createState() =>
      _InternetConnectionLostWidgetState();
}

class _InternetConnectionLostWidgetState
    extends State<InternetConnectionLostWidget> with WidgetsBindingObserver {
  final _connectivity = ConnectivityService.instance;

  bool _showOverlay = false;
  bool _checking = false;

  StreamSubscription<InternetStatus>? _subscription;
  Timer? _statusDebounce;
  Timer? _resumeDebounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = _connectivity.onStatusChange.listen(_handleStatusChange);
    _bootstrap();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _statusDebounce?.cancel();
    _resumeDebounce?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resumeDebounce?.cancel();
      _resumeDebounce = Timer(const Duration(milliseconds: 800), _recheckOnResume);
    }
  }

  Future<void> _bootstrap() async {
    final connected = await _connectivity.hasInternetAccess;
    if (!mounted) return;
    setState(() => _showOverlay = !connected);
  }

  Future<void> _recheckOnResume() async {
    final connected = await _connectivity.hasInternetAccess;
    if (!mounted) return;
    setState(() => _showOverlay = !connected);
  }

  void _handleStatusChange(InternetStatus status) {
    if (status == InternetStatus.connected) {
      _statusDebounce?.cancel();
      if (mounted) {
        setState(() => _showOverlay = false);
      }
      return;
    }

    _statusDebounce?.cancel();
    _statusDebounce = Timer(const Duration(milliseconds: 1200), () async {
      final connected = await _connectivity.hasInternetAccess;
      if (!mounted) return;
      setState(() => _showOverlay = !connected);
    });
  }

  Future<void> _onRetry() async {
    setState(() => _checking = true);
    final connected = await _connectivity.hasInternetAccess;
    if (!mounted) return;
    setState(() {
      _checking = false;
      _showOverlay = !connected;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showOverlay) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Container(
          color: AppColors.black.withValues(alpha: 0.6),
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
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
              CustomButton(
                isLoading: _checking,
                title: context.l10n?.retry ?? "",
                onTap: _onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
