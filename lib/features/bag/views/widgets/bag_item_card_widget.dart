import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/view_models/change_quantity_cubit/change_quantity_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/icon_quantity_button_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/lable_value_row_widget.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagItemCardWidget extends StatelessWidget {
  final BagItemModel bagItem;
  const BagItemCardWidget({super.key, required this.bagItem});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final bagItemId = bagItem.product.id.toString();
    final productBagItem = bagItem.product;
    final selectedSize = bagItem.selectedSize;
    final selectedColor = bagItem.selectedColor;
    final quantity = bagItem.quantity;
    return BlocProvider(
      create: (context) => ChangeQuantityCubit(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        height: size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(size.height * 0.02),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.lightGrey3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.02),
                  bottomLeft: Radius.circular(size.height * 0.02),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: productBagItem.images!.first,
                height: size.height * 0.2,
                width: size.width * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productBagItem.title!,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        LableValueRowWidget(
                          title: "Color",
                          value: selectedColor,
                        ),
                        SizedBox(width: size.width * 0.05),
                        LableValueRowWidget(title: "Size", value: selectedSize),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Builder(
                                builder: (context) {
                                  return IconQuantityButtonWidget(
                                    icon: Icons.remove,
                                    onTap: () {
                                      context
                                          .read<ChangeQuantityCubit>()
                                          .decrementQuantity(bagItemId);
                                    },
                                  );
                                },
                              ),
                              BlocBuilder<
                                ChangeQuantityCubit,
                                ChangeQuantityState
                              >(
                                buildWhen: (previous, current) =>
                                    current is IncrementQuantityLoading ||
                                    current is IncrementQuantitySuccess ||
                                    current is IncrementQuantityError ||
                                    current is DecrementQuantityLoading ||
                                    current is DecrementQuantitySuccess ||
                                    current is DecrementQuantityError,
                                builder: (context, state) {
                                  if (state is IncrementQuantityLoading ||
                                      state is DecrementQuantityLoading) {
                                    return const CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    );
                                  } else if (state
                                      is IncrementQuantitySuccess) {
                                    return Text(
                                      "${state.bagItem.quantity}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    );
                                  } else if (state
                                      is DecrementQuantitySuccess) {
                                    return Text(
                                      "${state.bagItem.quantity}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    );
                                  } else if (state is IncrementQuantityError) {
                                    return Text(
                                      state.message,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    );
                                  } else if (state is DecrementQuantityError) {
                                    return Text(
                                      state.message,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    );
                                  } else {
                                    return Text(
                                      "$quantity",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                    );
                                  }
                                },
                              ),
                              Builder(
                                builder: (context) {
                                  return IconQuantityButtonWidget(
                                    icon: Icons.add,
                                    onTap: () {
                                      context
                                          .read<ChangeQuantityCubit>()
                                          .incrementQuantity(bagItemId);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(productBagItem.price! * quantity).ceil()}\$",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
