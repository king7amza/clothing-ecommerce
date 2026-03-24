import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/shimmer_item_widget.dart';
import 'package:clothing_ecommerce/features/favorites/view_models/favorites_cubit/favorites_cubit.dart';
import 'package:clothing_ecommerce/features/favorites/views/widgets/favorite_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.1,
              left: size.width * 0.05,
            ),
            child: Row(
              children: [
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            buildWhen: (previous, current) =>
                current is FavoritesListFetched ||
                current is FetchingFavoritesList ||
                current is FavoritesError,
            builder: (context, state) {
              if (state is FetchingFavoritesList) {
                return Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.01,
                        ),
                        child: const ShimmerItemWidget(),
                      );
                    },
                  ),
                );
              } else if (state is FavoritesError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: colorScheme.error),
                    SizedBox(height: size.height * 0.01),
                    Text(state.message),
                  ],
                );
              } else if (state is FavoritesListFetched) {
                final List<Products> favoriteItems = state.favoriteItems;
                if (favoriteItems.isEmpty) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/no_favorites_yet.png',
                          width: size.width * 0.8,
                          height: size.height * 0.4,
                        ),
                        Text(
                          'No favorite items yet',
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: favoriteItems.length,
                    itemBuilder: (context, index) {
                      final favoriteItem = favoriteItems[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.01,
                        ),
                        child: FavoriteItemWidget(
                          favoriteItem: favoriteItem,
                          fetchFavoritesAfterRemoved: () => context
                              .read<FavoritesCubit>()
                              .fetchFavoritesItems(),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Image.asset(
                    'assets/images/no_favorites_yet.png',
                    width: size.width * 0.8,
                    height: size.height * 0.3,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
