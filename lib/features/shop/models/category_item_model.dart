class CategoryItemModel {
  final String title;
  final String imagePath;
  final int startPage;
  const CategoryItemModel({
    required this.title,
    required this.imagePath,
    required this.startPage,
  });
}

List<CategoryItemModel> mensCategoriesList = [
  CategoryItemModel(
    title: "Shirts",
    imagePath: "assets/images/mens_images/mens_shirts.png",
    startPage: 83,
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/mens_images/mens_shoes.jpg",
    startPage: 88,
  ),
  CategoryItemModel(
    title: "Sunglasses",
    imagePath: "assets/images/mens_images/mens_sunglasses.jpg",
    startPage: 154,
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/mens_images/mens_watches.jpg",
    startPage: 93,
  ),
];

List<CategoryItemModel> womensCategoriesList = [
  CategoryItemModel(
    title: "Tops",
    imagePath: "assets/images/womens_images/womens_tops.png",
    startPage: 162,
  ),
  CategoryItemModel(
    title: "Clothes",
    imagePath: "assets/images/womens_images/womens_clothes.png",
    startPage: 177, //177 gowns , 178 skirt
  ),
  CategoryItemModel(
    title: "Bags",
    imagePath: "assets/images/womens_images/womens_bags.png",
    startPage: 172,
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/womens_images/womens_shoes.png",
    startPage: 185,
  ),
  CategoryItemModel(
    title: "Jewellery",
    imagePath: "assets/images/womens_images/womens_jewellery.png",
    startPage: 182,
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/womens_images/womens_watches.png",
    startPage: 190,
  ),
];
