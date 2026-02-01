import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/shop/models/category_item_model.dart';
import 'package:flutter/material.dart';


class CategoryItemWidget extends StatelessWidget {
  final List<CategoryItemModel> categoryList;
  const CategoryItemWidget({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final categoryItem = categoryList[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/catalog");
            },
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.02,
              ),
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.grey,
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(-2, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.05),
                    child: Text(
                      categoryItem.title,
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Image.asset(
                    categoryItem.imagePath,
                    height: size.height,
                    width: size.width * 0.43,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
