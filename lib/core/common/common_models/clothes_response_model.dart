

// class ClothesResponseModel {
//   final int total;
//   final int skip;
//   final int limit;
//   List<Products> products;

//   ClothesResponseModel({
//     required this.products,
//     required this.total,
//     required this.skip,
//     required this.limit,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'total': total,
//       'skip': skip,
//       'limit': limit,
//       'products': products.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory ClothesResponseModel.fromMap(Map<String, dynamic> map) {
//     return ClothesResponseModel(
//       total: map['total'] as int,
//       skip: map['skip'] as int,
//       limit: map['limit'] as int,
//       products: List<Products>.from((map['products'] as List<dynamic>).map<Products>((x) => Products.fromMap(x as Map<String,dynamic>),),),
//     );
//   }
// }

// class Products {
//   final int? id;
//   final String? title;
//   final String? description;
//   final String? category;
//   final double? price;
//   final double? discountPercentage;
//   final double? rating;
//   final int? stock;
//   final List<String>? tags;
//   final String? brand;
//   final String? sku;
//   final int? weight;
//   final Dimensions? dimensions;
//   final String? warrantyInformation;
//   final String? shippingInformation;
//   final String? availabilityStatus;
//   final List<Reviews>? reviews;
//   final String? returnPolicy;
//   final int? minimumOrderQuantity;
//   final Meta? meta;
//   final List<String>? images;
//   final String? thumbnail;

//   Products({
//     this.id,
//     this.title,
//     this.description,
//     this.category,
//     this.price,
//     this.discountPercentage,
//     this.rating,
//     this.stock,
//     this.tags,
//     this.brand,
//     this.sku,
//     this.weight,
//     this.dimensions,
//     this.warrantyInformation,
//     this.shippingInformation,
//     this.availabilityStatus,
//     this.reviews,
//     this.returnPolicy,
//     this.minimumOrderQuantity,
//     this.meta,
//     this.images,
//     this.thumbnail,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//       'description': description,
//       'category': category,
//       'price': price,
//       'discountPercentage': discountPercentage,
//       'rating': rating,
//       'stock': stock,
//       'tags': tags,
//       'brand': brand,
//       'sku': sku,
//       'weight': weight,
//       'dimensions': dimensions?.toMap(),
//       'warrantyInformation': warrantyInformation,
//       'shippingInformation': shippingInformation,
//       'availabilityStatus': availabilityStatus,
//       'reviews': reviews?.map((x) => x.toMap()).toList() ?? [],
//       'returnPolicy': returnPolicy,
//       'minimumOrderQuantity': minimumOrderQuantity,
//       'meta': meta?.toMap(),
//       'images': images,
//       'thumbnail': thumbnail,
//     };
//   }

//   factory Products.fromMap(Map<String, dynamic> map) {
//     return Products(
//       id: map['id'] != null ? map['id'] as int : null,
//       title: map['title'] != null ? map['title'] as String : null,
//       description: map['description'] != null
//           ? map['description'] as String
//           : null,
//       category: map['category'] != null ? map['category'] as String : null,
//       price: map['price'] != null ? map['price'] as double : null,
//       discountPercentage: map['discountPercentage'] != null
//           ? map['discountPercentage'] as double
//           : null,
//       rating: map['rating'] != null ? map['rating'] as double : null,
//       stock: map['stock'] != null ? map['stock'] as int : null,
//       tags: map['tags'] != null
//           ? List<String>.from((map['tags'] as List<dynamic>))
//           : null,
//       brand: map['brand'] != null ? map['brand'] as String : null,
//       sku: map['sku'] != null ? map['sku'] as String : null,
//       weight: map['weight'] != null ? map['weight'] as int : null,
//       dimensions: map['dimensions'] != null
//           ? Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>)
//           : null,
//       warrantyInformation: map['warrantyInformation'] != null
//           ? map['warrantyInformation'] as String
//           : null,
//       shippingInformation: map['shippingInformation'] != null
//           ? map['shippingInformation'] as String
//           : null,
//       availabilityStatus: map['availabilityStatus'] != null
//           ? map['availabilityStatus'] as String
//           : null,
//       reviews: map['reviews'] != null
//           ? List<Reviews>.from(
//               (map['reviews'] as List<dynamic>).map<Reviews?>(
//                 (x) => Reviews.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       returnPolicy: map['returnPolicy'] != null
//           ? map['returnPolicy'] as String
//           : null,
//       minimumOrderQuantity: map['minimumOrderQuantity'] != null
//           ? map['minimumOrderQuantity'] as int
//           : null,
//       meta: map['meta'] != null
//           ? Meta.fromMap(map['meta'] as Map<String, dynamic>)
//           : null,
//       images: map['images'] != null
//           ? List<String>.from((map['images'] as List<dynamic>))
//           : null,
//       thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
//     );
//   }
// }

// class Dimensions {
//   final double? height;
//   final double? width;
//   final double? depth;
//   const Dimensions({this.height, this.width, this.depth});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{'height': height, 'width': width, 'depth': depth};
//   }

//   factory Dimensions.fromMap(Map<String, dynamic> map) {
//     return Dimensions(
//       height: map['height'] != null ? map['height'] as double : null,
//       width: map['width'] != null ? map['width'] as double : null,
//       depth: map['depth'] != null ? map['depth'] as double : null,
//     );
//   }
// }

// class Reviews {
//   final int? rating;
//   final String? comment;
//   final String? date;
//   final String? reviewerName;
//   final String? reviewerEmail;

//   const Reviews({
//     this.rating,
//     this.comment,
//     this.date,
//     this.reviewerName,
//     this.reviewerEmail,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'rating': rating,
//       'comment': comment,
//       'date': date,
//       'reviewerName': reviewerName,
//       'reviewerEmail': reviewerEmail,
//     };
//   }

//   factory Reviews.fromMap(Map<String, dynamic> map) {
//     return Reviews(
//       rating: map['rating'] != null ? map['rating'] as int : null,
//       comment: map['comment'] != null ? map['comment'] as String : null,
//       date: map['date'] != null ? map['date'] as String : null,
//       reviewerName: map['reviewerName'] != null
//           ? map['reviewerName'] as String
//           : null,
//       reviewerEmail: map['reviewerEmail'] != null
//           ? map['reviewerEmail'] as String
//           : null,
//     );
//   }
// }

// class Meta {
//   final String? createdAt;
//   final String? updatedAt;
//   final String? barcode;
//   final String? qrCode;
//   const Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'barcode': barcode,
//       'qrCode': qrCode,
//     };
//   }

//   factory Meta.fromMap(Map<String, dynamic> map) {
//     return Meta(
//       createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
//       updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
//       barcode: map['barcode'] != null ? map['barcode'] as String : null,
//       qrCode: map['qrCode'] != null ? map['qrCode'] as String : null,
//     );
//   }
// }
class ClothesResponseModel {
  final int total;
  final int skip;
  final int limit;
  List<Products> products;

  ClothesResponseModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'skip': skip,
      'limit': limit,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ClothesResponseModel.fromMap(Map<String, dynamic> map) {
    return ClothesResponseModel(
      total: map['total'] as int,
      skip: map['skip'] as int,
      limit: map['limit'] as int,
      products: List<Products>.from(
        (map['products'] as List<dynamic>).map<Products>(
          (x) => Products.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class Products {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Reviews>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toMap(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews?.map((x) => x.toMap()).toList() ?? [],
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta?.toMap(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      discountPercentage: map['discountPercentage'] != null
          ? (map['discountPercentage'] as num).toDouble()
          : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      tags: map['tags'] != null
          ? List<String>.from((map['tags'] as List<dynamic>))
          : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      sku: map['sku'] != null ? map['sku'] as String : null,
      weight: map['weight'] != null ? map['weight'] as int : null,
      dimensions: map['dimensions'] != null
          ? Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>)
          : null,
      warrantyInformation: map['warrantyInformation'] != null
          ? map['warrantyInformation'] as String
          : null,
      shippingInformation: map['shippingInformation'] != null
          ? map['shippingInformation'] as String
          : null,
      availabilityStatus: map['availabilityStatus'] != null
          ? map['availabilityStatus'] as String
          : null,
      reviews: map['reviews'] != null
          ? List<Reviews>.from(
              (map['reviews'] as List<dynamic>).map<Reviews?>(
                (x) => Reviews.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      returnPolicy: map['returnPolicy'] != null
          ? map['returnPolicy'] as String
          : null,
      minimumOrderQuantity: map['minimumOrderQuantity'] != null
          ? map['minimumOrderQuantity'] as int
          : null,
      meta: map['meta'] != null
          ? Meta.fromMap(map['meta'] as Map<String, dynamic>)
          : null,
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<dynamic>))
          : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
    );
  }
}

class Dimensions {
  final double? height;
  final double? width;
  final double? depth;
  const Dimensions({this.height, this.width, this.depth});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'height': height, 'width': width, 'depth': depth};
  }

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      height: map['height'] != null ? (map['height'] as num).toDouble() : null,
      width: map['width'] != null ? (map['width'] as num).toDouble() : null,
      depth: map['depth'] != null ? (map['depth'] as num).toDouble() : null,
    );
  }
}

class Reviews {
  final int? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  const Reviews({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      rating: map['rating'] != null ? map['rating'] as int : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      reviewerName: map['reviewerName'] != null
          ? map['reviewerName'] as String
          : null,
      reviewerEmail: map['reviewerEmail'] != null
          ? map['reviewerEmail'] as String
          : null,
    );
  }
}

class Meta {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;
  const Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      qrCode: map['qrCode'] != null ? map['qrCode'] as String : null,
    );
  }
}
