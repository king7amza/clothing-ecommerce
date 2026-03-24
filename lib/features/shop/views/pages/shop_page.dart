import 'package:clothing_ecommerce/features/shop/views/pages/men_category_page.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/women_category_page.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 23,
              color: colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: colorScheme.surfaceContainerHighest,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: colorScheme.secondary, size: 28),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Women'),
              Tab(text: 'Men'),
            ],
            indicatorColor: colorScheme.primary,
            indicatorWeight: 3.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
            labelColor: colorScheme.secondary,
            labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelColor: colorScheme.onSurfaceVariant,
          ),
        ),
        backgroundColor: colorScheme.surfaceContainerHighest,
        body: const TabBarView(
          children: [WomenCategoryPage(), MenCategoryPage()],
        ),
      ),
    );
  }
}
