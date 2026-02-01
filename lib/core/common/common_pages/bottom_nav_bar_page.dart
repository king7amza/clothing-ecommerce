import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/bag_page.dart';
import 'package:clothing_ecommerce/features/favorites/views/pages/favorites_page.dart';
import 'package:clothing_ecommerce/features/home/view_models/home_cubit/home_cubit.dart';
import 'package:clothing_ecommerce/features/home/views/pages/home_page.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/profile_page.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        Future.microtask(() async {
          await cubit.fetchWomensDresses();
          await cubit.fetchMensShirt();
        });
        return cubit;
      },
      child: const HomePage(),
    ),
    const ShopPage(),
    const BagPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];
  // Widget _buildCurrentPage() {
  //   switch (currentIndex) {
  //     case 0:
  //       return BlocProvider(
  //         create: (context) {
  //           final cubit = HomeCubit();
  //           cubit.fetchClothesData();
  //           return cubit;
  //         },
  //         child: const HomePage(),
  //       );
  //     case 1:
  //       return const ShopPage();
  //     case 2:
  //       return const BagPage();
  //     case 3:
  //       return const FavoritesPage();
  //     case 4:
  //       return const ProfilePage();
  //     default:
  //       return const HomePage();
  //   }
  // }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: pages[currentIndex],
      // body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changePage,
        currentIndex: currentIndex,
        backgroundColor: AppColors.white,
        unselectedItemColor: AppColors.grey,
        selectedItemColor: AppColors.primaryColor,
        selectedIconTheme: IconThemeData(size: size.width * 0.1),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedLabelStyle: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        unselectedLabelStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Bag',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
