import 'package:sabalpara_family/sabalpara_family.dart';
import 'package:sabalpara_family/sabalpara_family_extra.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static const routeName = "/language";

  static Widget builder(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (_) => LanguageCubit(),
      child: const LanguageScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final cubit = context.read<LanguageCubit>();
        final languages = state.languages;

        return CommonBgWidget(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(title: context.l10n?.language ?? ""),
            body: Column(
              children: [
                10.h.spaceVertical,
                Expanded(
                  child: CustomListView(
                    itemCount: languages.length,
                    padding: .symmetric(
                      horizontal: AppConstants.horizontalPadding,
                    ),
                    separatorBuilder: (context, index) => 12.h.spaceVertical,
                    itemBuilder: (context, index) {
                      final lang = languages[index];
                      return LanguageItemWidget(
                        lang: lang,
                        isSelected: lang.code == state.selectedLanguage?.code,
                        onTap: () => cubit.selectLanguage(lang),
                      );
                    },
                  ),
                ),

                /// Save Button
                Padding(
                  padding: .symmetric(
                    vertical:
                        20.h +
                        (Platform.isIOS
                            ? 0
                            : AppConstants.safeAreaPadding.bottom),
                    horizontal: AppConstants.horizontalPadding,
                  ),
                  child: CustomButton(
                    title: context.l10n?.save ?? "",
                    onTap: () => cubit.updateLanguage(context),
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

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    super.key,
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });

  final LanguageModel lang;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: .circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(8.r),
        child: Container(
          padding: .symmetric(vertical: 16.h, horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: .circular(8.r),
            border: .all(color: AppColors.text.withValues(alpha: 0.05)),
          ),
          child: Row(
            spacing: 10.w,
            children: [
              Expanded(child: Text(lang.label, style: styleW600S16)),

              if (isSelected)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 1),
                    color: Colors.transparent,
                  ),
                  padding: .all(2.r),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: Container(
                      width: 16.h,
                      height: 16.h,
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
