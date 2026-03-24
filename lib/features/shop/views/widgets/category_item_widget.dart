import 'package:clothing_ecommerce/features/shop/models/category_item_model.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final List<CategoryItemModel> categoryList;
  const CategoryItemWidget({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categoryList.length,
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      itemBuilder: (context, index) {
        final categoryItem = categoryList[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/catalog", arguments: categoryItem);
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
              color: colorScheme.surface,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Text(
                        categoryItem.title,
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(
                              fontSize: constraints.maxWidth * 0.07,
                              color: colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                      child: Image.asset(
                        categoryItem.imagePath,
                        height: size.height,
                        width: size.width * 0.43,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
