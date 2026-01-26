import 'package:clothing_ecommerce/features/shop/views/widgets/summer_sales_banner_widget.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/women_category_item_widget.dart';
import 'package:flutter/material.dart';

class MenCategoryPage extends StatelessWidget {
  const MenCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SummerSalesBannerWidget(),
          WomenCategoryItemWidget(
            title: "Tops",
            imagePath: "assets/images/womens_images/womens_tops.png",
          ),
          WomenCategoryItemWidget(
            title: "Bags",
            imagePath: "assets/images/womens_images/womens_bags.png",
          ),
          WomenCategoryItemWidget(
            title: "Shoes",
            imagePath: "assets/images/womens_images/womens_shoes.png",
          ),
          WomenCategoryItemWidget(
            title: "Jewellery",
            imagePath: "assets/images/womens_images/womens_jewellery.png",
          ),
          WomenCategoryItemWidget(
            title: "Watches",
            imagePath: "assets/images/womens_images/womens_watches.png",
          ),
        ],
      ),
    );
  }
}
