class DeliveryMethodsModel {
  final String name;
  final String imagePath;
  DeliveryMethodsModel({required this.name, required this.imagePath});
}

final deliveryMethods = [
  DeliveryMethodsModel(
    name: "FedEx",
    imagePath: "assets/images/payments_images/fedex.png",
  ),

  DeliveryMethodsModel(
    name: "USPS",
    imagePath: "assets/images/payments_images/usps.png",
  ),

  DeliveryMethodsModel(
    name: "DHL",
    imagePath: "assets/images/payments_images/dhl.png",
  ),
];
