import 'dart:math';

import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/shop/view_models/shop_cubit/shop_cubit.dart';
import 'package:clothing_ecommerce/features/shop/views/widgets/catalog_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int startPage = 0;
  int currentPage = 0;
  int resultsPerPage = 4;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shopCubit = context.read<ShopCubit>();
    int numberOfButtonsPerPage = ((size.width - 150) / 60).floor();
    Map<int, List<Products>> pageCache = {};
    List<Products>? currentPageData;
    int? _totalProducts;
    int? totalNumberOfPages;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey1,
        title: Text(
          "Women's Tops",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightGrey1,
      body: BlocBuilder<ShopCubit, ShopState>(
        bloc: shopCubit,
        buildWhen: (previous, current) =>
            current is FetchedProducts ||
            current is ErrorFetchingProducts ||
            current is FetchingProducts,
        builder: (context, state) {
          if (state is FetchingProducts) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is ErrorFetchingProducts) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is FetchedProducts) {
            _totalProducts = state.totalProducts;
            pageCache = state.pageCache;
            currentPageData = state.pageCache[currentPage];
            totalNumberOfPages = _totalProducts != null
                ? (_totalProducts! / resultsPerPage).ceil()
                : 1;
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (_totalProducts != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Page ${currentPage + 1} of $totalNumberOfPages",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // First Page button
                              if (startPage > 0)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      startPage = 0;
                                      currentPage = 0;
                                    });
                                  },
                                  icon: const Icon(Icons.first_page),
                                ),
                              // brevious page button
                              if (currentPage > 0)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage--;
                                      if (currentPage < startPage) {
                                        startPage = max(
                                          0,
                                          startPage - numberOfButtonsPerPage,
                                        );
                                      }
                                    });
                                    if (!pageCache.containsKey(currentPage)) {
                                      shopCubit.loadPage(
                                        resultsPerPage,
                                        currentPage * resultsPerPage,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_left),
                                ),
                              // Page buttons
                              for (
                                int i = startPage;
                                i < startPage + numberOfButtonsPerPage &&
                                    i < totalNumberOfPages!;
                                i++
                              )
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: InkWell(
                                      onTap: () {
                                        if (i == currentPage) return;
                                        setState(() {
                                          currentPage = i;
                                          if (i < startPage) {
                                            startPage = max(
                                              0,
                                              i - numberOfButtonsPerPage ~/ 2,
                                            );
                                          } else if (i >=
                                              startPage +
                                                  numberOfButtonsPerPage) {
                                            startPage =
                                                i - numberOfButtonsPerPage + 1;
                                          }
                                        });
                                        if (!pageCache.containsKey(i)) {
                                          shopCubit.loadPage(
                                            resultsPerPage,
                                            i * resultsPerPage,
                                          );
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: currentPage == i
                                            ? AppColors.primaryColor
                                            : AppColors.grey,
                                        child: Text(
                                          "${i + 1}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // Next Page button
                              if (currentPage < totalNumberOfPages! - 1)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage++;
                                      if (currentPage >=
                                          startPage + numberOfButtonsPerPage) {
                                        startPage += numberOfButtonsPerPage;
                                      }
                                    });
                                    if (!pageCache.containsKey(currentPage)) {
                                      shopCubit.loadPage(
                                        resultsPerPage,
                                        currentPage * resultsPerPage,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.navigate_next),
                                ),
                              // Last Page button
                              if (startPage + numberOfButtonsPerPage <
                                  totalNumberOfPages!)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage = totalNumberOfPages! - 1;
                                      startPage =
                                          totalNumberOfPages! -
                                          numberOfButtonsPerPage;
                                    });
                                    if (!pageCache.containsKey(currentPage)) {
                                      shopCubit.loadPage(
                                        resultsPerPage,
                                        currentPage * resultsPerPage,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.last_page),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (currentPageData != null && currentPageData!.isNotEmpty)
                    CatalogItemWidget(currentPageData: currentPageData),
                ],
              ),
            );
          }
          return Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.primaryColor),
              child: Center(
                child: Text(
                  "No products found",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
