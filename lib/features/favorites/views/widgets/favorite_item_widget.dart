import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/features/favorites/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteItemWidget extends StatelessWidget {
  final Products favoriteItem;
  final VoidCallback fetchFavoritesAfterRemoved;
  const FavoriteItemWidget({
    super.key,
    required this.favoriteItem,
    required this.fetchFavoritesAfterRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final favoriteItemDescription = favoriteItem.description;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        height: size.height * 0.17,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(size.height * 0.02),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurfaceVariant,
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
                color: colorScheme.tertiary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.02),
                  bottomLeft: Radius.circular(size.height * 0.02),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: favoriteItem.images![0],
                height: size.height * 0.2,
                width: size.width * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.023),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            favoriteItem.title!,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          buildWhen: (previous, current) =>
                              current is FavoritesError ||
                              current is RemovingFavoritesItem ||
                              current is FavoritesItemRemoved,
                          builder: (context, state) {
                            if (state is RemovingFavoritesItem) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: colorScheme.primary,
                                ),
                              );
                            } else if (state is FavoritesError) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceTint,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.error,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceTint,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<FavoritesCubit>()
                                      .deleteFavoriteItem(favoriteItem);
                                  fetchFavoritesAfterRemoved();
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      favoriteItemDescription!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(favoriteItem.price!).ceil()}\$",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontSize: size.height * 0.017,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.secondary,
                              ),
                        ),
                        Text(
                          "(${favoriteItem.category!})",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontSize: size.height * 0.017,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.secondary,
                              ),
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
