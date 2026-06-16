import 'package:sabalpara_family/sabalpara_family.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 300.milliseconds,
      child: Builder(
        builder: (context) {
          final state = context.watch<HomeCubit>().state;
          final banners = state.bannersList;
          final bannerCount = banners.length;
          final hasMultipleBanners = bannerCount > 1;

          if (banners.isEmpty && !state.loader) {
            return SizedBox();
          }

          if (state.loader) {
            return SizedBox();
          }

          if (!hasMultipleBanners) {
            return InkWell(
              onTap: () => _onTapBanner(context),
              child: bannerCard(
                context: context,
                bannerImage: banners.first.image ?? "",
              ),
            );
          }

          return Column(
            spacing: 5.h,
            children: [
              CarouselSlider.builder(
                itemCount: bannerCount,
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) =>
                      context.read<HomeCubit>().onBannerChange(index),
                ),
                itemBuilder: (con, index, realIndex) {
                  final banner = banners[index];
                  return InkWell(
                    onTap: () => _onTapBanner(context),
                    child: bannerCard(
                      context: context,
                      bannerImage: banner.image ?? "",
                    ),
                  );
                },
              ),
              _buildBannerIndicators(
                context,
                itemCount: bannerCount >= 5 ? 5 : bannerCount,
                isLoading: false,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTapBanner(BuildContext context) {
    context.read<HomeCubit>().onTapUploadResult(context);
  }

  Widget bannerCard({
    required BuildContext context,
    required String bannerImage,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: bannerImage.isNotEmpty
            ? CachedImage(
                bannerImage,
                skipBaseUrl: true,
                height: 145.h,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              )
            : AssetsImg(imagePath: AppAssets.profileImage, borderRadius: 10.h),
      ),
    );
  }

  Widget _buildBannerIndicators(
    BuildContext context, {
    required int itemCount,
    required bool isLoading,
  }) {
    return SizedBox(
      height: 8.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) => 5.w.spaceHorizontal,
        itemBuilder: (context, index) {
          final currentBanner = context.watch<HomeCubit>().state.currentBanner;
          final isSelected = isLoading
              ? currentBanner == index
              : currentBanner == index || (currentBanner > 4 && index == 4);

          return AnimatedContainer(
            duration: 300.milliseconds,
            curve: Curves.easeInOut,
            width: isSelected ? 23.h : 8.h,
            height: 8.h,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.text.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50.h),
            ),
          );
        },
      ),
    );
  }

  // Widget bannerCardLoader() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 7.w, right: 7.w),
  //     child: CustomShimmer(
  //       height: 145.h,
  //       width: 100.w - 30.w,
  //       borderRadius: 10.h,
  //     ),
  //   );
  // }
}
