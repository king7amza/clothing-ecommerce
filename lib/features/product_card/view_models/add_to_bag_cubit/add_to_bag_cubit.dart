import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_to_bag_state.dart';

class AddToBagCubit extends Cubit<AddToBagState> {
  AddToBagCubit() : super(AddToBagInitial());
  final FirestoreServices firestoreServices = FirestoreServices.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> addToBag(BagItemModel bagItem) async {
    final String userId = firebaseAuth.currentUser!.uid;
    final String bagItemId = bagItem.product.id.toString();
    emit(AddToBagLoading());
    try {
      await firestoreServices.setData(
        path: FirestoreApiPathes.bagItem(userId, bagItemId),
        data: bagItem.toMap(),
      );
      emit(AddToBagSuccess());
    } catch (e) {
      emit(AddToBagError(e.toString()));
    }
  }
}
