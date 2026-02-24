import 'dart:async';

import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_bag_products_state.dart';

class FetchBagProductsCubit extends Cubit<FetchBagProductsState> {
  FetchBagProductsCubit() : super(FetchBagProductsInitial());
  final FirestoreServices firestoreServices = FirestoreServices.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<List<BagItemModel>>? _bagItemsSubscription;

  // Future<void> fetchBagProducts() async {
  //   emit(FetchingBagProducts());
  //   try {
  //     final userId = firebaseAuth.currentUser!.uid;
  //     final bagItems = await firestoreServices.getCollection<BagItemModel>(
  //       path: FirestoreApiPathes.bagItems(userId),
  //       builder: (bagItem, bagItemId) {
  //         return BagItemModel.fromMap(bagItem);
  //       },
  //     );
  //     emit(FetchedBagProducts(bagItems));
  //   } catch (e) {
  //     emit(BagProductsError(e.toString()));
  //   }
  // }

  void watchBagItems() {
    final String userId = firebaseAuth.currentUser!.uid;

    emit(FetchingBagProducts());

    _bagItemsSubscription = firestoreServices
        .collectionStream<BagItemModel>(
          path: FirestoreApiPathes.bagItems(userId),
          builder: (data, documentId) => BagItemModel.fromMap(data),
        )
        .listen(
          (bagItems) {
            emit(FetchedBagProducts(bagItems));
          },
          onError: (error) {
            emit(BagProductsError(error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _bagItemsSubscription?.cancel();
    return super.close();
  }
}
