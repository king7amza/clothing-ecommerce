import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_quantity_state.dart';

class ChangeQuantityCubit extends Cubit<ChangeQuantityState> {
  ChangeQuantityCubit() : super(ChangeQuantityInitial());
  final FirestoreServices firestoreServices = FirestoreServices.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> incrementQuantity(String bagItemId) async {
    final String userId = _firebaseAuth.currentUser!.uid;
    BagItemModel bagItem = await firestoreServices.getDocument(
      path: FirestoreApiPathes.bagItem(userId, bagItemId),
      builder: (bagItem, bagItemId) => BagItemModel.fromMap(bagItem),
    );
    debugPrint("before increment: ${bagItem.quantity}");
    final int quantity = bagItem.quantity + 1;
    debugPrint("after increment quantity: $quantity");
    debugPrint("after increment bagItem.quantity: ${bagItem.quantity}");
    emit(IncrementQuantityLoading());
    try {
      bagItem = bagItem.copyWith(quantity: quantity);
      await firestoreServices.setDocument(
        path: FirestoreApiPathes.bagItem(userId, bagItemId),
        data: bagItem.toMap(),
      );
      debugPrint("after update increment quantity: $quantity");
      debugPrint(
        "after update increment bagItem.quantity: ${bagItem.quantity}",
      );
      emit(IncrementQuantitySuccess(bagItem));
    } catch (e) {
      emit(IncrementQuantityError(e.toString()));
    }
  }

  Future<void> decrementQuantity(String bagItemId) async {
    final String userId = _firebaseAuth.currentUser!.uid;
    BagItemModel bagItem = await firestoreServices.getDocument(
      path: FirestoreApiPathes.bagItem(userId, bagItemId),
      builder: (bagItem, bagItemId) => BagItemModel.fromMap(bagItem),
    );
    int quantity = bagItem.quantity;
    if (quantity > 1) {
      quantity = bagItem.quantity - 1;
      emit(DecrementQuantityLoading());
      try {
        await firestoreServices.setDocument(
          path: FirestoreApiPathes.bagItem(userId, bagItemId),
          data: bagItem.copyWith(quantity: quantity).toMap(),
        );
        emit(DecrementQuantitySuccess(bagItem.copyWith(quantity: quantity)));
      } catch (e) {
        emit(DecrementQuantityError(e.toString()));
      }
    } else {
      try {
        await firestoreServices.deleteDocument(
          path: FirestoreApiPathes.bagItem(userId, bagItemId),
        );
      } catch (e) {
        emit(DecrementQuantityError(e.toString()));
      }
    }
  }
}
