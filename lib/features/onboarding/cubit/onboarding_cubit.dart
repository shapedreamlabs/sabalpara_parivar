import 'package:sabalpara_family/sabalpara_family.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void refresh(OnboardingState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }

  void onTapGetStarted(BuildContext context) {
    context.navigator.pushNamedAndRemoveUntil(
      SignInScreen.routeName,
      (route) => false,
    );
  }
}
