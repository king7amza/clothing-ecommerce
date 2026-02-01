import 'package:clothing_ecommerce/features/shop/models/category_item_model.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/summer_sales_banner_widget.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/category_item_widget.dart';
import 'package:flutter/material.dart';

class MenCategoryPage extends StatelessWidget {
  const MenCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SummerSalesBannerWidget(),
          CategoryItemWidget(categoryList: mensCategoriesList),
        ],
      ),
    );
  }
}
