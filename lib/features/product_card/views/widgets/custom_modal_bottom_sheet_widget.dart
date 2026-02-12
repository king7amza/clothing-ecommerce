import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/product_card/view_models/modal_bottom_sheet_cubit/modal_bottom_sheet_cubit.dart';
import 'package:clothing_ecommerce/features/product_card/views/widgets/modal_bottom_sheet_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomModalBottomSheetWidget<T> extends StatelessWidget {
  final String title;
  final List<T> options;
  final T? selectedOption;
  final ValueChanged<T> onSelected;
  final Widget Function(T) itemBuilder;
  const CustomModalBottomSheetWidget({
    super.key,
    required this.title,
    required this.options,
    this.selectedOption,
    required this.onSelected,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final cubit = context.read<ModalBottomSheetCubit>();
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.white,
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: cubit,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.008,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "Select $title",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: size.height * 0.3,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: options.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width * 0.4,
                          mainAxisSpacing: size.height * 0.03,
                          crossAxisSpacing: size.width * 0.03,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          final item = options[index];
                          return InkWell(
                            onTap: () {
                              onSelected(item);
                            },
                            child: itemBuilder(item),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: CustomMainButtonWidget(
                      title: "Save",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: ModalBottomSheetButton(title: title),
    );
  }
}
