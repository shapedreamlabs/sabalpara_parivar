part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.isLoading = false});

  final bool isLoading;

  OnboardingState copyWith({bool? isLoading}) {
    return OnboardingState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}
