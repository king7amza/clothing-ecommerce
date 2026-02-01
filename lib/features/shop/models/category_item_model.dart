class CategoryItemModel {
  final String title;
  final String imagePath;
  const CategoryItemModel({required this.title, required this.imagePath});
}

List<CategoryItemModel> mensCategoriesList = [
  CategoryItemModel(
    title: "Shirts",
    imagePath: "assets/images/mens_images/mens_shirts.png",
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/mens_images/mens_shoes.jpg",
  ),
  CategoryItemModel(
    title: "Sunglasses",
    imagePath: "assets/images/mens_images/mens_sunglasses.jpg",
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/mens_images/mens_watches.jpg",
  ),
];

List<CategoryItemModel> womensCategoriesList = [
  CategoryItemModel(
    title: "Tops",
    imagePath: "assets/images/womens_images/womens_tops.png",
  ),
  CategoryItemModel(
    title: "Bags",
    imagePath: "assets/images/womens_images/womens_bags.png",
  ),
  CategoryItemModel(
    title: "Shoes",
    imagePath: "assets/images/womens_images/womens_shoes.png",
  ),
  CategoryItemModel(
    title: "Jewellery",
    imagePath: "assets/images/womens_images/womens_jewellery.png",
  ),
  CategoryItemModel(
    title: "Watches",
    imagePath: "assets/images/womens_images/womens_watches.png",
  ),
];
