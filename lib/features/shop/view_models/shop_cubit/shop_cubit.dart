import 'dart:math';

import 'package:clothing_ecommerce/core/common/common_models/clothes_request_model.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/features/shop/services/shop_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial()) {
    print("🆕 ShopCubit CREATED");
  }
  final shopServices = ShopServices();
  int startPage = 0;
  int currentPage = 0;
  int resultsPerPage = 4;
  int? totalProducts;
  Map<int, List<Products>> pageCache = {};
  void _distributeBatchToPages(List<Products> items, int skip) {
    for (int i = 0; i < items.length; i += resultsPerPage) {
      int pageIndex = i ~/ resultsPerPage;
      int end = min(i + resultsPerPage, items.length);
      pageCache[pageIndex] = items.sublist(i, end);
    }
  }

  Future<void> loadPage(int limit, int skip) async {
    print("📥 Loading page: limit=$limit, skip=$skip");
    if (isClosed) return;
    emit(FetchingProducts());
    try {
      final productsData = await shopServices.fetchProducts(
        ClothesRequestModel(limit: limit, skip: skip),
      );
      print(
        "✅ Data received for skip=$skip, items: ${productsData?.products.length ?? 0}",
      );
      if (productsData != null) {
        totalProducts ??= productsData.total;
        if (limit > resultsPerPage) {
          print("📦 Distributed batch to pages: ${pageCache.keys}");
          _distributeBatchToPages(productsData.products, skip);
        } else {
          int pageNumber = skip ~/ resultsPerPage;
          pageCache[pageNumber] = productsData.products;
          print("💾 Saved page $pageNumber to cache");
        }
      }
      emit(FetchedProducts(pageCache: pageCache, totalProducts: totalProducts));
    } catch (e) {
      print("❌ Error loading page: $e");
      emit(ErrorFetchingProducts(e.toString()));
    }
  }
}
