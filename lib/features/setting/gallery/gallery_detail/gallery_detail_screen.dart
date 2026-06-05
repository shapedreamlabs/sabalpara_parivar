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
                                  return SizedBox(
                                    width: size,
                                    height: size,
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
