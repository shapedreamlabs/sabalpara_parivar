import 'package:sabalpara_family/sabalpara_family.dart';

class BusinessListScreen extends StatelessWidget {
  const BusinessListScreen({super.key});

  static const routeName = '/business_list';

  static Widget builder(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<BusinessListCubit>(
      create: (c) => BusinessListCubit(arguments),
      child: const BusinessListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessListCubit, BusinessListState>(
      builder: (context, state) {
        return CommonBgWidget(
          spreadSize: 1200,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: state.businessName),
            body: CustomListView(
              padding: .symmetric(horizontal: AppConstants.horizontalPadding),
              itemCount: state.businessList.length,
              separatorBuilder: (context, index) => 12.h.spaceVertical,
              itemBuilder: (context, index) {
                final businessData = state.businessList[index];
                return BusinessDetailsWidget(businessData: businessData);
              },
            ),
          ),
        );
      },
    );
  }
}

class BusinessDetailsWidget extends StatelessWidget {
  const BusinessDetailsWidget({super.key, required this.businessData});

  final BusinessModel businessData;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.text.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              spacing: 4.h,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(businessData.name ?? "", style: styleW700S16),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${l10n?.phoneNumber ?? ""}: ",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.6),
                        ),
                      ),
                      TextSpan(
                        text: businessData.phone ?? "",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${l10n?.villageName ?? ""}: ",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.6),
                        ),
                      ),
                      TextSpan(
                        text: businessData.village ?? "",
                        style: styleW400S14.copyWith(
                          color: AppColors.text.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // if ((businessData.phone ?? '').trim().isNotEmpty) 
            CustomIconButton(
              icon: AppAssets.phoneIcon,
              size: 20.h,
              radius: 10.r,
              onTap: () => openPhoneDialer(businessData.phone),
            ),
        ],
      ),
    );
  }
}
