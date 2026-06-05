import 'package:sabalpara_family/sabalpara_family.dart';

part 'business_list_state.dart';

class BusinessListCubit extends Cubit<BusinessListState> {
  BusinessListCubit(Map<String, dynamic> arguments)
    : super(BusinessListState()) {
    refresh(
      state.copyWith(
        businessName: arguments["businessName"],
        businessList: arguments["businessList"],
      ),
    );
  }

  void refresh(BusinessListState state) {
    if (!isClosed) {
      emit(state.copyWith());
    }
  }
}
