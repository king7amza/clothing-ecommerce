class AppConstants {
  static const String appName = "Clothing Ecommerce";
  static const String apiBaseUrl = "https://dummyjson.com";
  static const String productsEndpoint = "/products";
  static const String mensShirtCategoryEndpoint = "/category/mens-shirts";
  static const String mensShoesCategoryEndpoint = "/category/mens-shoes";
  static const String mensWatchesCategoryEndpoint = "/category/mens-watches";
  static const String sunglassesCategoryEndpoint = "/category/sunglasses";
  static const String topsCategoryEndpoint = "/category/tops";
  static const String womensBagsCategoryEndpoint = "/category/womens-bags";
  static const String womensDressesCategoryEndpoint =
      "/category/womens-dresses";
  static const String womensJewelleryCategoryEndpoint =
      "/category/womens-jewellery";
  static const String womensShoesCategoryEndpoint = "/category/womens-shoes";
  static const String womensWatchesCategoryEndpoint =
      "/category/womens-watches";
  static const String currentTheme = "currentTheme";
}

class FirestoreApiPathes {
  static String user(String userId) => 'users/$userId';
  static String userImage(String userId, String imageId) =>
      'users/$userId/image/$imageId';
  static String bagItem(String userId, String bagItemId) =>
      'users/$userId/bag/$bagItemId';
  static String bagItems(String userId) => 'users/$userId/bag';
  static String favoriteItem(String userId, String favoriteItemId) =>
      'users/$userId/favorites/$favoriteItemId';
  static String favoriteItems(String userId) => 'users/$userId/favorites';
}
