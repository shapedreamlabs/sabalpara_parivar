part of 'business_list_cubit.dart';

class BusinessListState extends Equatable {
  const BusinessListState({
    this.loader = false,
    this.businessName = "",
    this.businessList = const [],
  });

  final bool loader;
  final String businessName;
  final List<BusinessModel> businessList;

  BusinessListState copyWith({
    bool? loader,
    String? businessName,
    List<BusinessModel>? businessList,
  }) {
    return BusinessListState(
      loader: loader ?? this.loader,
      businessName: businessName ?? this.businessName,
      businessList: businessList ?? this.businessList,
    );
  }

  @override
  List<Object?> get props => [loader, businessName, businessList];
}
