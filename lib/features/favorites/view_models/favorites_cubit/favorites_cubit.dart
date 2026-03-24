import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/common/common_services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final firestore = FirestoreServices.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> fetchFavoritesItems() async {
    final userId = firebaseAuth.currentUser!.uid;
    emit(FetchingFavoritesList());
    try {
      final List<Products> storedFavoriteItems = await firestore.getCollection(
        path: FirestoreApiPathes.favoriteItems(userId),
        builder: (favoriteItem, favoriteItemId) =>
            Products.fromMap(favoriteItem),
      );
      emit(FavoritesListFetched(storedFavoriteItems));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
  Future<void> toggleFavoriteItem(Products favoriteItem) async {
    final Products? storedFavoriteItem = await fetchFavoritesItem(favoriteItem);
    final bool isFavoriteItem = storedFavoriteItem != null;
    if (isFavoriteItem) {
      await deleteFavoriteItem(favoriteItem);
    } else {
      await addFavoriteItem(favoriteItem);
    }
  }

  Future<Products?> fetchFavoritesItem(Products favoriteItem) async {
    final userId = firebaseAuth.currentUser!.uid;
    final favoriteItemId = favoriteItem.id.toString();
    emit(FetchingFavoritesItem());
    try {
      final Products? storedFavoriteItem = await firestore.getDocument(
        path: FirestoreApiPathes.favoriteItem(userId, favoriteItemId),
        builder: (favoriteItem, favoriteItemId) =>
            Products.fromMap(favoriteItem),
      );
      emit(FavoritesItemFetched());
      return storedFavoriteItem;
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
    return null;
  }


  Future<void> addFavoriteItem(Products favoriteItem) async {
    final userId = firebaseAuth.currentUser!.uid;
    final favoriteItemId = favoriteItem.id.toString();
    emit(AddingItemToFavorites());
    try {
      await firestore.setDocument(
        path: FirestoreApiPathes.favoriteItem(userId, favoriteItemId),
        data: favoriteItem.toMap(),
      );
      emit(FavoritesItemAdded());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> deleteFavoriteItem(Products favoriteItem) async {
    final userId = firebaseAuth.currentUser!.uid;
    final favoriteItemId = favoriteItem.id.toString();
    emit(RemovingFavoritesItem());
    try {
      await firestore.deleteDocument(
        path: FirestoreApiPathes.favoriteItem(userId, favoriteItemId),
      );
      emit(FavoritesItemRemoved());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
