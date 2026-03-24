import 'package:clothing_ecommerce/features/profile/view_models/user_orders_cudit/user_orders_cubit.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/cancelled_state_body_page.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/delivered_state_body_page.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/processing_state_body_page.dart';
import 'package:clothing_ecommerce/features/profile/views/widgets/tag_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  String selectedTag = "Delivered";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => UserOrdersCubit(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(backgroundColor: colorScheme.surfaceContainerHighest),
          backgroundColor: colorScheme.surfaceContainerHighest,
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Orders',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: colorScheme.secondary,
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedTag = [
                        "Delivered",
                        "Processing",
                        "Cancelled",
                      ][index];
                    });
                  },
                  indicator: BoxDecoration(),
                  dividerHeight: 0,
                  tabs: [
                    TagButtonWidget(
                      tagName: "Delivered",
                      isSelected: selectedTag == "Delivered",
                    ),
                    TagButtonWidget(
                      tagName: "Processing",
                      isSelected: selectedTag == "Processing",
                    ),
                    TagButtonWidget(
                      tagName: "Cancelled",
                      isSelected: selectedTag == "Cancelled",
                    ),
                  ],
                ),
                Expanded(
                  child: const TabBarView(
                    children: [
                      DeliveredStateBodyPage(),
                      ProcessingStateBodyPage(),
                      CancelledStateBodyPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
