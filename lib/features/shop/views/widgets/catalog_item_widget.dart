import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CatalogItemWidget extends StatelessWidget {
  final List<Products>? currentPageData;
  const CatalogItemWidget({super.key, this.currentPageData});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
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
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/productCard",
                  arguments: product,
                );
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Column(
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
                                Center(
                                  child: CachedNetworkImage(
                                    imageUrl: product.images!.first,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(size.width * 0.1),
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
                                        .copyWith(color: AppColors.white),
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
                                    color: AppColors.gold,
                                    size: size.width * 0.043,
                                  );
                                } else if ((index - 0.5) <= 4) {
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
                                "${product.rating}",
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
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "${product.title}",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: constraints.maxWidth * 0.08,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          // widget.isSaleProducts == true // show sale prices
                          Text(
                            // show regular price
                            "${product.price} \$",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: size.height * 0.24,
                        right: 0,
                        child: SizedBox(
                          height: size.width * 0.12,
                          width: size.width * 0.12,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
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
                              padding: EdgeInsets.all(size.width * 0.03),
                              child: Center(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: AppColors.grey,
                                  size: size.width * 0.05,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          );
        },
      ),
    );
  }
}
