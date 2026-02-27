import 'package:clothing_ecommerce/core/app_constants.dart';

class CategoryItemModel {
  final String title;
  final String imagePath;
  final String endPoint;
  // final int startPage;
  const CategoryItemModel({
    required this.title,
    required this.imagePath,
    required this.endPoint,
    // required this.startPage,
  });
}

List<CategoryItemModel> mensCategoriesList = [
  CategoryItemModel(
    title: "Shirts",
    imagePath: "assets/images/mens_images/mens_shirts.png",
    endPoint: AppConstants.mensShirtCategoryEndpoint,
    // startPage: 83,
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/mens_images/mens_shoes.jpg",
    endPoint: AppConstants.mensShoesCategoryEndpoint,
    // startPage: 88,
  ),
  CategoryItemModel(
    title: "Sunglasses",
    imagePath: "assets/images/mens_images/mens_sunglasses.jpg",
    endPoint: AppConstants.sunglassesCategoryEndpoint,
    // startPage: 154,
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/mens_images/mens_watches.jpg",
    endPoint: AppConstants.mensWatchesCategoryEndpoint,
    // startPage: 93,
  ),
];

List<CategoryItemModel> womensCategoriesList = [
  CategoryItemModel(
    title: "Tops",
    imagePath: "assets/images/womens_images/womens_tops.png",
    endPoint: AppConstants.topsCategoryEndpoint,
    // startPage: 162,
  ),
  CategoryItemModel(
    title: "Clothes",
    imagePath: "assets/images/womens_images/womens_clothes.png",
    endPoint: AppConstants.womensDressesCategoryEndpoint,
    // startPage: 177, //177 gowns , 178 skirt
  ),
  CategoryItemModel(
    title: "Bags",
    imagePath: "assets/images/womens_images/womens_bags.png",
    endPoint: AppConstants.womensBagsCategoryEndpoint,
    // startPage: 172,
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/womens_images/womens_shoes.png",
    endPoint: AppConstants.womensShoesCategoryEndpoint,
    // startPage: 185,
  ),
  CategoryItemModel(
    title: "Jewellery",
    imagePath: "assets/images/womens_images/womens_jewellery.png",
    endPoint: AppConstants.womensJewelleryCategoryEndpoint,
    // startPage: 182,
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/womens_images/womens_watches.png",
    endPoint: AppConstants.womensWatchesCategoryEndpoint,
    // startPage: 190,
  ),
];
