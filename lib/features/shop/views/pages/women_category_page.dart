import 'package:clothing_ecommerce/features/shop/models/category_item_model.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/summer_sales_banner_widget.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';

class WomenCategoryPage extends StatelessWidget {
  const WomenCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SummerSalesBannerWidget(),
          CategoryItemWidget(categoryList: womensCategoriesList),
        ],
      ),
    );
  }
}
