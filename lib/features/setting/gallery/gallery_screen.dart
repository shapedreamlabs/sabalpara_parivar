import 'package:sabalpara_family/sabalpara_family.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const routeName = '/gallery';

  static Widget builder(BuildContext context) {
    return BlocProvider<GalleryCubit>(
      create: (c) => GalleryCubit(context),
      child: const GalleryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<GalleryCubit, GalleryState>(
      builder: (context, state) {
        final cubit = context.read<GalleryCubit>();

        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: l10n?.gallery ?? ""),
            body: state.loader
                ? const Center(child: AppLoader())
                : CustomSingleChildScroll(
                    padding: .only(top: 5.h),
                    child: Column(
                      spacing: 20.h,
                      children: [
                        if (state.eventsList.isNotEmpty)
                          SizedBox(
                            height: 38.h,
                            child: CustomListView(
                              itemCount: state.eventsList.length,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.horizontalPadding,
                              ),
                              separatorBuilder: (context, index) =>
                                  10.w.spaceHorizontal,
                              itemBuilder: (context, index) {
                                final event = state.eventsList[index];
                                return EventItemWidget(
                                  onTap: () {
                                    cubit.toggleEventSelection(event);
                                  },
                                  event: event,
                                  isSelected: state.selectedEventsList.contains(
                                    event,
                                  ),
                                );
                              },
                            ),
                          ),
                        Padding(
                          padding: .symmetric(horizontal: 15.w),
                          child: state.filteredGalleriesList.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 40.h),
                                  child: Text(
                                    context.l10n?.noDataFound ??
                                        "No data found",
                                    style: styleW400S16.copyWith(
                                      color: AppColors.text.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                )
                              : DynamicHeightGridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.w,
                                  builder: (context, index) {
                                    final gallery =
                                        state.filteredGalleriesList[index];
                                    return SizedBox(
                                      width: ((1.sw - 48.w) / 2),
                                      height: ((1.sw - 48.w) / 2),
                                      child: GalleryItemWidget(
                                        gallery: gallery,
                                        onTap: () => cubit.onTapGallery(
                                          context,
                                          gallery,
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.filteredGalleriesList.length,
                                  crossAxisCount: 2,
                                ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({
    super.key,
    required this.event,
    required this.isSelected,
    required this.onTap,
  });

  final String event;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 300.milliseconds,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(50.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: isSelected
                ? AppColors.primary
                : AppColors.white.withValues(alpha: 0.8),
          ),
          child: Center(
            child: Text(
              event,
              style: (isSelected ? styleW700S14 : styleW600S14).copyWith(
                color: isSelected
                    ? AppColors.white
                    : AppColors.text.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryItemWidget extends StatelessWidget {
  const GalleryItemWidget({
    super.key,
    required this.gallery,
    required this.onTap,
  });

  final GalleryModel gallery;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Stack(
        children: [
          CachedImage(
            gallery.thumbnail,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            skipBaseUrl: true,
            borderRadius: 8.r,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: .circular(8.r),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  AppColors.text.withValues(alpha: 0.14),
                  AppColors.text,
                ],
                begin: .topCenter,
                end: .bottomCenter,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10.h,
            child: Padding(
              padding: .symmetric(horizontal: 10.w),
              child: Text(
                gallery.name ?? "",
                textAlign: .center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: styleW700S16.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
