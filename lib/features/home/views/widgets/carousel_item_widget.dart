import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/features/favorites/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:clothing_ecommerce/features/home/extensions/product_extinsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselItemWidget extends StatefulWidget {
  final bool isSaleProducts;
  final List<Products> clothesData;

  const CarouselItemWidget({
    super.key,
    required this.clothesData,
    required this.isSaleProducts,
  });

  @override
  State<CarouselItemWidget> createState() => _CarouselItemWidgetState();
}

class _CarouselItemWidgetState extends State<CarouselItemWidget> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      child: PageView.custom(
        controller: _pageController,
        padEnds: false,
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: widget.clothesData.length,
          (context, index) {
            final product = widget.clothesData[index];
            final double priceBeforeDiscount =
                product.price! +
                product.price! * (product.discountPercentage! / 100);
            return Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.height * 0.01,
                bottom: size.height * 0.03,
              ),
              child: BlocProvider(
                create: (context) {
                  return FavoritesCubit()..fetchFavoritesItems();
                },
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/productCard',
                          arguments: product,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.28,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: AppColors.lightGrey3,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: size.height * 0.02,
                                  left: size.width * 0.02,
                                  right: size.width * 0.02,
                                  bottom: size.height * 0.02,
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: product.images!.first,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                widget.isSaleProducts ==
                                        true // show sale products
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                              size.width * 0.1,
                                            ),
                                            bottomRight: Radius.circular(
                                              size.width * 0.1,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.03,
                                          vertical: size.height * 0.005,
                                        ),
                                        margin: EdgeInsets.all(
                                          size.width * 0.03,
                                        ),
                                        child: Text(
                                          "-${product.discountPercentage!.toStringAsFixed(0)}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                      )
                                    : product.isNew ==
                                          true // show new products
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                              size.width * 0.1,
                                            ),
                                            bottomRight: Radius.circular(
                                              size.width * 0.1,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.03,
                                          vertical: size.height * 0.005,
                                        ),
                                        margin: EdgeInsets.all(
                                          size.width * 0.03,
                                        ),
                                        child: Text(
                                          "New",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(5, (index) {
                                index += 1;
                                if ((index) < product.rating!) {
                                  return Icon(
                                    Icons.star,
                                    color: AppColors.gold,
                                    size: size.width * 0.043,
                                  );
                                } else if ((index - 0.5) <= product.rating!) {
                                  return Icon(
                                    Icons.star_half,
                                    color: AppColors.gold,
                                    size: size.width * 0.043,
                                  );
                                } else {
                                  return Icon(
                                    Icons.star_border,
                                    color: AppColors.gold,
                                    size: size.width * 0.043,
                                  );
                                }
                              }),
                              Text(
                                "(${product.rating!.toStringAsFixed(1)})",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "${product.brand}",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "${product.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          widget.isSaleProducts ==
                                  true // show sale prices
                              ? Row(
                                  children: [
                                    Text(
                                      "\$${priceBeforeDiscount.toStringAsFixed(2)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Text(
                                      "\$${product.price!.toStringAsFixed(2)}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                  ],
                                )
                              : Text(
                                  // show regular price
                                  "\$${product.price!.toStringAsFixed(2)}",
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.24,
                      right: 0,
                      child: SizedBox(
                        height: size.width * 0.12,
                        width: size.width * 0.12,
                        child: Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<FavoritesCubit>(
                                  context,
                                ).toggleFavoriteItem(product);
                              },
                              child:
                                  BlocBuilder<FavoritesCubit, FavoritesState>(
                                    buildWhen: (previous, current) =>
                                        current is AddingItemToFavorites ||
                                        current is FavoritesItemAdded ||
                                        current is FavoritesError ||
                                        current is RemovingFavoritesItem ||
                                        current is FavoritesItemRemoved ||
                                        current is FetchingFavoritesList ||
                                        current is FavoritesListFetched,
                                    builder: (context, state) {
                                      if (state is FetchingFavoritesList) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: SizedBox(
                                            height: size.width * 0.05,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryColor,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state
                                          is FavoritesListFetched) {
                                        final isFavoriteItem =
                                            state.favoriteItems.isEmpty
                                            ? false
                                            : state.favoriteItems.any(
                                                (favoriteItem) =>
                                                    favoriteItem.id ==
                                                    product.id,
                                              );
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            isFavoriteItem
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavoriteItem
                                                ? AppColors.primaryColor
                                                : AppColors.grey,
                                          ),
                                        );
                                      } else if (state
                                              is AddingItemToFavorites ||
                                          state is RemovingFavoritesItem) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: SizedBox(
                                            height: size.width * 0.05,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryColor,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state is FavoritesItemAdded) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              size.width * 0.03,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite,
                                                color: AppColors.primaryColor,
                                                size: size.width * 0.05,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state
                                          is FavoritesItemRemoved) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              size.width * 0.03,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite_border,
                                                color: AppColors.grey,
                                                size: size.width * 0.05,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (state is FavoritesError) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              40,
                                            ),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.lightGrey3,
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(-3, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              size.width * 0.03,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite_border,
                                                color: AppColors.grey,
                                                size: size.width * 0.05,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.lightGrey3,
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(-3, 3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            size.width * 0.03,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: AppColors.grey,
                                              size: size.width * 0.05,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
