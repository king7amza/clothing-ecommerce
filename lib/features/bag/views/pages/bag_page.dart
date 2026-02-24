import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/view_models/fetch_bag_products_cubit/fetch_bag_products_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/bag_item_card_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/shimmer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: AppColors.black,
              size: size.width * 0.06,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.lightGrey1,
      body: BlocProvider(
        create: (context) {
          final cubit = FetchBagProductsCubit();
          cubit.watchBagItems();
          return cubit;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    'My Bag',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppColors.black,
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                BlocBuilder<FetchBagProductsCubit, FetchBagProductsState>(
                  buildWhen: (previous, current) =>
                      current is FetchedBagProducts ||
                      current is BagProductsError ||
                      current is FetchingBagProducts,
                  builder: (context, state) {
                    if (state is FetchingBagProducts) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ShimmerItemWidget();
                        },
                      );
                    } else if (state is FetchedBagProducts) {
                      final bagItems = state.bagItems; //old
                      if (bagItems.isNotEmpty) {
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bagItems.length,
                              itemBuilder: (context, index) {
                                final bagItem = bagItems[index];
                                return BagItemCardWidget(bagItem: bagItem);
                              },
                            ),
                            SizedBox(height: size.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total amount :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: AppColors.grey,
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${bagItems.fold<int>(0, (previous, element) => previous + (element.product.price!.ceil() * element.quantity))}\$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: AppColors.black,
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.04),
                            CustomMainButtonWidget(
                              title: "Checkout",
                              onTap: () {
                                Navigator.pushNamed(context, "/checkout");
                              },
                            ),
                          ],
                        );
                      } else {
                        return Image.asset(
                          'assets/images/empty_bag.png',
                          height: size.height * 0.6,
                          width: size.width * 0.8,
                          fit: BoxFit.contain,
                        );
                      }
                    } else if (state is BagProductsError) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                        ),
                        height: 100,
                        color: AppColors.grey,
                        child: Center(child: Text(state.message)),
                      );
                    }
                    return Center(
                      child: Image.asset(
                        'assets/images/empty_bag.png',
                        height: size.height * 1,
                        width: size.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
