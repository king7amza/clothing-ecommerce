import 'package:clothing_ecommerce/features/profile/model/orders_states_model.dart';
import 'package:clothing_ecommerce/features/profile/model/user_orders_model.dart';
import 'package:clothing_ecommerce/features/profile/view_models/user_orders_cudit/user_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveredStateBodyPage extends StatefulWidget {
  const DeliveredStateBodyPage({super.key});

  @override
  State<DeliveredStateBodyPage> createState() => _DeliveredStateBodyPageState();
}

class _DeliveredStateBodyPageState extends State<DeliveredStateBodyPage> {
  @override
  void initState() {
    final userOrdersCubit = context.read<UserOrdersCubit>();
    deliveredOrders.isEmpty == true
        ? null
        : userOrdersCubit.fetchDeliveredOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: BlocBuilder<UserOrdersCubit, UserOrdersState>(
        buildWhen: (previous, current) =>
            current is FetchedDeliveredOrders ||
            current is FetchingDeliveredOrdersError ||
            current is FetchingDeliveredOrders,
        builder: (context, state) {
          if (state is FetchingDeliveredOrders) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          } else if (state is FetchingDeliveredOrdersError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FetchedDeliveredOrders) {
            final List<UserOrdersModel> deliveredOrders = state.orders;
            return ListView.builder(
              itemCount: deliveredOrders.length,
              itemBuilder: (context, index) {
                final order = deliveredOrders[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  "Order id: ${order.orderId}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                              Text(
                                order.orderDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: colorScheme.onSurface,
                                      fontSize: size.width * 0.04,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Quantity:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: colorScheme.onSurface,
                                          fontSize: size.width * 0.04,
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    order.totalQuantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: colorScheme.secondary,
                                          fontSize: size.width * 0.04,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: colorScheme.onSurface,
                                          fontSize: size.width * 0.04,
                                        ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    order.totalAmount.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: colorScheme.secondary,
                                          fontSize: size.width * 0.04,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: colorScheme.secondary,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.05,
                                          color: colorScheme.secondary,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                "Delivered",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05,
                                      color: colorScheme.secondaryContainer,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Image.asset(
              "assets/images/empty_orders_delivering.png",
              width: size.width * 0.8,
              height: size.height * 0.5,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
