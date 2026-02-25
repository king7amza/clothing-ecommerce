part of 'favorites_cubit.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

// item
final class FetchingFavoritesItem extends FavoritesState {}

final class FavoritesItemFetched extends FavoritesState {}

final class AddingItemToFavorites extends FavoritesState {}

final class FavoritesItemAdded extends FavoritesState {
  // final String favoriteItemId;
  // FavoritesItemAdded(this.favoriteItemId);
}

final class RemovingFavoritesItem extends FavoritesState {}

final class FavoritesItemRemoved extends FavoritesState {
  // final String favoriteItemId;
  // FavoritesItemRemoved(this.favoriteItemId);
}

// list
final class FetchingFavoritesList extends FavoritesState {}

final class FavoritesListFetched extends FavoritesState {
  final List<Products> favoriteItems;
  FavoritesListFetched(this.favoriteItems);
}

// error
final class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
