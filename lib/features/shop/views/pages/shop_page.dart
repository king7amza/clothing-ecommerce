import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/men_category_page.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/women_category_page.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 23,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightGrey1,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.black,
                size: 28,
              ),
            ),
          ],
          bottom:  TabBar(
            tabs: [
              Tab(text: 'Women',),
              Tab(text: 'Men'),
            ],
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 3.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
            labelColor: AppColors.black,
            labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelColor: AppColors.grey,
          ),
        ),
        backgroundColor: AppColors.lightGrey1,
        body: const TabBarView(
          children: [
            WomenCategoryPage(),
            MenCategoryPage(),
          ],
        ),
      ),
    );
  }
}
