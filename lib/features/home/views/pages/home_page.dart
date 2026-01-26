import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/home/view_models/home_cubit/home_cubit.dart';
import 'package:clothing_ecommerce/features/home/views/widgets/carousel_item_widget.dart';
import 'package:clothing_ecommerce/features/home/views/widgets/check_button_widget.dart';
import 'package:clothing_ecommerce/features/home/views/widgets/top_headline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     context.read<HomeCubit>().fetchClothesData();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    // final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.lightGrey1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/Big Banner.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: size.height * 0.7,
                ),
                Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fashion",
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Text(
                        "Sale",
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: size.height * 0.57,
                  left: size.width * 0.05,
                  child: CheckButtonWidget(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: TopHeadlineWidget(
                headline: 'Sale',
                subHeadline: 'Super summer sale!',
                onTap: () {},
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              buildWhen: (previous, current) =>
                  current is FetchedWomensDresses ||
                  current is FetchingWomensDresses ||
                  current is WomensDressesError,
              builder: (context, state) {
                if (state is FetchingWomensDresses) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (state is FetchedWomensDresses) {
                  final clothesData = state.clothesData.products;
                  return CarouselItemWidget(clothesData: clothesData, isSaleProducts: true,);
                } else if (state is WomensDressesError) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: TopHeadlineWidget(
                headline: 'New',
                subHeadline: 'you\'ve never seen before!',
                onTap: () {},
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              buildWhen: (previous, current) =>
                  current is FetchedMensShirts ||
                  current is FetchingMensShirts ||
                  current is MensShirtsError,
              builder: (context, state) {
                if (state is FetchingMensShirts) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (state is FetchedMensShirts) {
                  final clothesData = state.clothesData.products;
                  return CarouselItemWidget(clothesData: clothesData, isSaleProducts: false,);
                } else if (state is MensShirtsError) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
