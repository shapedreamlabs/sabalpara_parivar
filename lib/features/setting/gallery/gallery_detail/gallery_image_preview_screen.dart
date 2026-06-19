import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class GalleryImagePreviewScreen extends StatefulWidget {
  const GalleryImagePreviewScreen({super.key, required this.initialIndex});

  final int initialIndex;

  static const routeName = '/gallery_image_preview';

  static Widget builder(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return GalleryImagePreviewScreen(
      initialIndex: arguments?['initial_index'] as int? ?? 0,
    );
  }

  @override
  State<GalleryImagePreviewScreen> createState() =>
      _GalleryImagePreviewScreenState();
}

class _GalleryImagePreviewScreenState extends State<GalleryImagePreviewScreen> {
  late final PageController _pageController;
  late int _currentIndex;
  late TransformationController _transformationController;

  bool _isDownloading = false;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _transformationController = TransformationController();
    _transformationController.addListener(_onTransformationChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTransformationChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    final isZoomed = scale > 1.01;
    if (isZoomed != _isZoomed) {
      setState(() => _isZoomed = isZoomed);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _isZoomed = false;
    });

    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    _transformationController = TransformationController();
    _transformationController.addListener(_onTransformationChanged);

    final cubit = context.read<GalleryDetailCubit>();
    final state = cubit.state;
    if (index >= state.imagesList.length - 2 && state.hasMore) {
      cubit.loadMore();
    }
  }

  Future<void> _downloadImage(GalleryImageModel? image) async {
    if (image == null || _isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      await ImageDownloadService.saveNetworkImage(image.image);
      if (mounted) {
        showSuccessToast(
          context.l10n?.imageSavedToGallery ?? 'Image saved to gallery',
        );
      }
    } on AppException catch (e) {
      if (!mounted) return;
      final message = e.message == 'Photo permission denied'
          ? (context.l10n?.photoPermissionDenied ?? 'Photo permission denied')
          : (context.l10n?.imageDownloadFailed ?? 'Could not download image');
      showErrorToast(message);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryDetailCubit, GalleryDetailState>(
      builder: (context, state) {
        final images = state.imagesList;
        final currentImage = _currentIndex < images.length
            ? images[_currentIndex]
            : null;

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              title: state.title,
              actions: images.isNotEmpty
                  ? [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Center(
                          child: Text(
                            '${_currentIndex + 1}/${images.length}',
                            style: styleW600S14.copyWith(
                              color: AppColors.text.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ),
                    ]
                  : null,
            ),
            body: Column(
              children: [
                Expanded(
                  child: images.isEmpty
                      ? Center(
                          child: Text(
                            context.l10n?.noDataFound ?? 'No data found',
                            style: styleW400S16.copyWith(
                              color: AppColors.text.withValues(alpha: 0.6),
                            ),
                          ),
                        )
                      : PageView.builder(
                          controller: _pageController,
                          physics: _isZoomed
                              ? const NeverScrollableScrollPhysics()
                              : const PageScrollPhysics(),
                          onPageChanged: _onPageChanged,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            final image = images[index];
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                return InteractiveViewer(
                                  transformationController:
                                      index == _currentIndex
                                      ? _transformationController
                                      : null,
                                  minScale: 0.5,
                                  maxScale: 4.0,
                                  child: Center(
                                    child: CachedImage(
                                      image.image,
                                      skipBaseUrl: true,
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
                if (currentImage != null)
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppConstants.horizontalPadding,
                        12.h,
                        AppConstants.horizontalPadding,
                        20.h,
                      ),
                      child: CustomButton(
                        title: context.l10n?.download ?? 'Download',
                        isLoading: _isDownloading,
                        onTap: () => _downloadImage(currentImage),
                        startWidget: Icon(
                          Icons.download_rounded,
                          color: AppColors.white,
                          size: 20.h,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
