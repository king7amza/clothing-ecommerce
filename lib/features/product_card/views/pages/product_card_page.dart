import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:clothing_ecommerce/features/product_card/models/product_colors_model.dart';
import 'package:clothing_ecommerce/features/product_card/models/products_sizes_model.dart';
import 'package:clothing_ecommerce/features/product_card/view_models/add_to_bag_cubit/add_to_bag_cubit.dart';
import 'package:clothing_ecommerce/features/product_card/view_models/modal_bottom_sheet_cubit/modal_bottom_sheet_cubit.dart';
import 'package:clothing_ecommerce/features/product_card/views/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:clothing_ecommerce/features/product_card/views/widgets/modal_color_content_widget.dart';
import 'package:clothing_ecommerce/features/product_card/views/widgets/modal_size_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardPage extends StatelessWidget {
  final Products? product;
  const ProductCardPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product!.title!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: AppColors.black, size: 28),
          ),
        ],
        backgroundColor: AppColors.lightGrey1,
      ),
      backgroundColor: AppColors.lightGrey1,
      body: BlocProvider(
        create: (context) => ModalBottomSheetCubit(),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product!.images!.first,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              product!.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<ModalBottomSheetCubit, ModalBottomSheetState>(
                      buildWhen: (previous, current) =>
                          current is ModalBottomSheetSuccess,
                      builder: (context, state) {
                        if (state is ModalBottomSheetSuccess) {
                          return CustomModalBottomSheetWidget<
                            ProductSizesModel
                          >(
                            title: state.selectedSize == null
                                ? "Size"
                                : state.selectedSize!.lableSize,
                            options: productSizesList,
                            selectedOption: state.selectedSize,
                            onSelected: (size) => context
                                .read<ModalBottomSheetCubit>()
                                .toggleSize(size),
                            itemBuilder: (size) => ModalSizeContentWidget(
                              sizeItem: size,
                              // isSelected: isSelected,
                            ),
                          );
                        } else {
                          return CustomModalBottomSheetWidget<
                            ProductSizesModel
                          >(
                            title: "Size",
                            options: productSizesList,
                            selectedOption: null,
                            onSelected: (size) => context
                                .read<ModalBottomSheetCubit>()
                                .toggleSize(size),
                            itemBuilder: (size) => ModalSizeContentWidget(
                              sizeItem: size,
                              // isSelected: isSelected,
                            ),
                          );
                        }
                      },
                    ),
                    BlocBuilder<ModalBottomSheetCubit, ModalBottomSheetState>(
                      buildWhen: (previous, current) =>
                          current is ModalBottomSheetSuccess,
                      builder: (context, state) {
                        if (state is ModalBottomSheetSuccess) {
                          return CustomModalBottomSheetWidget<
                            ProductColorsModel
                          >(
                            title: state.selectedColor == null
                                ? "Color"
                                : state.selectedColor!.colorName,
                            options: productColorsList,
                            selectedOption: state.selectedColor,
                            onSelected: (color) => context
                                .read<ModalBottomSheetCubit>()
                                .toggleColor(color),
                            itemBuilder: (color) => ModalColorContentWidget(
                              itemColor: color,
                              // isSelected: isSelected,
                            ),
                          );
                        } else {
                          return CustomModalBottomSheetWidget<
                            ProductColorsModel
                          >(
                            title: "Color",
                            options: productColorsList,
                            selectedOption: null,
                            onSelected: (color) => context
                                .read<ModalBottomSheetCubit>()
                                .toggleColor(color),
                            itemBuilder: (color) => ModalColorContentWidget(
                              itemColor: color,
                              // isSelected: isSelected,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: BlocProvider(
                    create: (context) => AddToBagCubit(),
                    child: BlocConsumer<AddToBagCubit, AddToBagState>(
                      listener: (context, state) {
                        if (state is AddToBagSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to Bag")),
                          );
                        } else if (state is AddToBagError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AddToBagSuccess ||
                          current is AddToBagError ||
                          current is AddToBagLoading,
                      builder: (context, state) {
                        if (state is AddToBagLoading) {
                          return CustomMainButtonWidget(
                            title: "Add To Bag",
                            isLoading: true,
                          );
                        }
                        return CustomMainButtonWidget(
                          title: "Add To Bag",
                          onTap: () {
                            final modalState = context
                                .read<ModalBottomSheetCubit>()
                                .state;
                            if (modalState is ModalBottomSheetSuccess) {
                              context.read<AddToBagCubit>().addToBag(
                                BagItemModel(
                                  product: product!,
                                  selectedSize: modalState.selectedSize!.size,
                                  selectedColor:
                                      modalState.selectedColor!.colorName,
                                  quantity: 1,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
