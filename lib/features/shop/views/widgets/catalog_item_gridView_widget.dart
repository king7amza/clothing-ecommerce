import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';

import 'package:clothing_ecommerce/features/favorites/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogItemGridViewWidget extends StatelessWidget {
  final List<Products>? currentPageData;
  const CatalogItemGridViewWidget({super.key, this.currentPageData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: size.height,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: currentPageData!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.16 / 2.4,
        ),
        itemBuilder: (context, index) {
          final product = currentPageData![index];
          return Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.03,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BlocProvider(
                  create: (context) => FavoritesCubit()..fetchFavoritesItems(),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/productCard",
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
                                color: colorScheme.tertiary,
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: CachedNetworkImage(
                                      imageUrl: product.images!.first,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.surfaceContainer,
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
                                    margin: EdgeInsets.all(size.width * 0.03),
                                    child: Text(
                                      "New",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: colorScheme.onPrimary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...List.generate(5, (index) {
                                  index += 1;
                                  if ((index) < 4) {
                                    return Icon(
                                      Icons.star,
                                      color: colorScheme.tertiaryContainer,
                                      size: size.width * 0.043,
                                    );
                                  } else if ((index - 0.5) <= 4) {
                                    return Icon(
                                      Icons.star_half,
                                      color: colorScheme.tertiaryContainer,
                                      size: size.width * 0.043,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.star_border,
                                      color: colorScheme.tertiaryContainer,
                                      size: size.width * 0.043,
                                    );
                                  }
                                }),
                                Text(
                                  "${product.rating}",
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        color: colorScheme.onSurface,
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
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "${product.title}",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    fontSize: constraints.maxWidth * 0.08,
                                    color: colorScheme.secondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            // widget.isSaleProducts == true // show sale prices
                            Text(
                              // show regular price
                              "${product.price} \$",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          return Positioned(
                            top: size.height * 0.24,
                            right: 0,
                            child: BlocBuilder<FavoritesCubit, FavoritesState>(
                              bloc: BlocProvider.of<FavoritesCubit>(context),
                              buildWhen: (previous, current) =>
                                  current is FetchingFavoritesList ||
                                  current is FavoritesListFetched ||
                                  current is FetchingFavoritesItem ||
                                  current is FavoritesItemFetched ||
                                  current is FavoritesError ||
                                  current is AddingItemToFavorites ||
                                  current is FavoritesItemAdded ||
                                  current is RemovingFavoritesItem ||
                                  current is FavoritesItemRemoved,
                              builder: (context, state) {
                                if (state is FetchingFavoritesList) {
                                  return Container(
                                    height: size.width * 0.12,
                                    width: size.width * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: colorScheme.surface,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorScheme.tertiary,
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(-3, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  );
                                } else if (state is FavoritesListFetched) {
                                  final isFavoriteItem =
                                      state.favoriteItems.isEmpty
                                      ? false
                                      : state.favoriteItems.any(
                                          (favoriteItem) =>
                                              favoriteItem.id == product.id,
                                        );
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavoriteItem(product);
                                    },
                                    child: SizedBox(
                                      height: size.width * 0.12,
                                      width: size.width * 0.12,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                          color: colorScheme.surface,
                                          boxShadow: [
                                            BoxShadow(
                                              color: colorScheme.tertiary,
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
                                              isFavoriteItem
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavoriteItem
                                                  ? colorScheme.primary
                                                  : colorScheme.onSurface,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (state is RemovingFavoritesItem ||
                                    state is AddingItemToFavorites) {
                                  return Container(
                                    height: size.width * 0.12,
                                    width: size.width * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: colorScheme.surface,
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorScheme.tertiary,
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(-3, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  );
                                } else if (state is FavoritesItemAdded ||
                                    state is FavoritesItemRemoved) {
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavoriteItem(product);
                                    },
                                    child: SizedBox(
                                      height: size.width * 0.12,
                                      width: size.width * 0.12,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40,
                                          ),
                                          color: colorScheme.surface,
                                          boxShadow: [
                                            BoxShadow(
                                              color: colorScheme.tertiary,
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
                                              state is FavoritesItemAdded
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: state is FavoritesItemAdded
                                                  ? colorScheme.primary
                                                  : colorScheme.onSurface,
                                              size: size.width * 0.05,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (state is FavoritesError) {
                                  return SizedBox(
                                    height: size.width * 0.12,
                                    width: size.width * 0.12,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: colorScheme.surface,
                                        boxShadow: [
                                          BoxShadow(
                                            color: colorScheme.tertiary,
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
                                            Icons.error,
                                            color: colorScheme.error,
                                            size: size.width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<FavoritesCubit>()
                                        .toggleFavoriteItem(product);
                                  },
                                  child: SizedBox(
                                    height: size.width * 0.12,
                                    width: size.width * 0.12,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: colorScheme.surface,
                                        boxShadow: [
                                          BoxShadow(
                                            color: colorScheme.tertiary,
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
                                            color: colorScheme.onSurface,
                                            size: size.width * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
