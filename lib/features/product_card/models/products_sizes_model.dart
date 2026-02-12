class ProductSizesModel {
  final String size;
  final String lableSize;
  const ProductSizesModel({
    required this.size,
    required this.lableSize,
  });
}

List<ProductSizesModel> productSizesList = [
  ProductSizesModel(size: "XS", lableSize: "Extra Small"),
  ProductSizesModel(size: "S", lableSize: "Small"),
  ProductSizesModel(size: "M", lableSize: "Medium"),
  ProductSizesModel(size: "L", lableSize: "Large"),
  ProductSizesModel(size: "XL", lableSize: "Extra Large"),
  ProductSizesModel(size: "XXL", lableSize: "Extra Extra Large"),
];
