import 'package:sabalpara_family/sabalpara_family.dart';

class GalleryDetailScreen extends StatelessWidget {
  const GalleryDetailScreen({super.key});

  static const routeName = '/gallery_detail';

  static Widget builder(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return BlocProvider<GalleryDetailCubit>(
      create: (c) => GalleryDetailCubit(arguments),
      child: const GalleryDetailScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryDetailCubit, GalleryDetailState>(
      builder: (context, state) {
        final cubit = context.read<GalleryDetailCubit>();

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: state.title),
            body: state.loader
                ? const Center(child: AppLoader())
                : state.imagesList.isEmpty
                ? Center(
                    child: Text(
                      context.l10n?.noDataFound ?? "No data found",
                      style: styleW400S16.copyWith(
                        color: AppColors.text.withValues(alpha: 0.6),
                      ),
                    ),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent - 200) {
                        cubit.loadMore();
                      }
                      return false;
                    },
                    child: CustomSingleChildScroll(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      child: Column(
                        children: [
                          DynamicHeightGridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.w,
                            crossAxisCount: 2,
                            itemCount: state.imagesList.length,
                            builder: (context, index) {
                              final image = state.imagesList[index];
                              final size = (1.sw - 42.w) / 2;
                              return GalleryImageItemWidget(
                                image: image,
                                size: size,
                                isDownloading:
                                    state.downloadingImageId == image.id,
                                onTap: () =>
                                    cubit.openImagePreview(context, index),
                                onDownload: () => cubit.downloadImage(
                                  image,
                                  savedMessage:
                                      context.l10n?.imageSavedToGallery ??
                                      'Image saved to gallery',
                                  permissionDeniedMessage:
                                      context.l10n?.photoPermissionDenied ??
                                      'Photo permission denied',
                                  failedMessage:
                                      context.l10n?.imageDownloadFailed ??
                                      'Could not download image',
                                ),
                              );
                            },
                          ),
                          if (state.loadingMore)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const AppLoader(),
                            ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class GalleryImageItemWidget extends StatelessWidget {
  const GalleryImageItemWidget({
    super.key,
    required this.image,
    required this.size,
    required this.isDownloading,
    required this.onTap,
    required this.onDownload,
  });

  final GalleryImageModel image;
  final double size;
  final bool isDownloading;
  final VoidCallback onTap;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedImage(
                image.image,
                width: size,
                height: size,
                fit: BoxFit.cover,
                skipBaseUrl: true,
                borderRadius: 8.r,
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              enabled: !isDownloading,
              offset: Offset(0, 36.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              icon: Container(
                height: 28.h,
                width: 28.h,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: isDownloading
                    ? Padding(
                        padding: EdgeInsets.all(6.h),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Icon(
                        Icons.more_vert,
                        color: AppColors.white,
                        size: 18.h,
                      ),
              ),
              onSelected: (value) {
                if (value == 'download') {
                  onDownload();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'download',
                  child: Text(context.l10n?.download ?? 'Download'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
