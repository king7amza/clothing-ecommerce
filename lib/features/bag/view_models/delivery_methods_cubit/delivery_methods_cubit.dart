import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_methods_state.dart';

class DeliveryMethodsCubit extends Cubit<DeliveryMethodsState> {
  DeliveryMethodsCubit() : super(DeliveryMethodsInitial());

  void toggleDeliveryMethod(String deliveryMethodName) {
    if (state is ToggleDeliveryMethod &&
        (state as ToggleDeliveryMethod).deliveryMethodName != null) {
      deliveryMethodName == (state as ToggleDeliveryMethod).deliveryMethodName
          ? emit(ToggleDeliveryMethod(null))
          : emit(ToggleDeliveryMethod(deliveryMethodName));
    } else {
      emit(ToggleDeliveryMethod(deliveryMethodName));
    }
  }
}
