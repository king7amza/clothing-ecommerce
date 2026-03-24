import 'package:clothing_ecommerce/features/profile/model/user_orders_model.dart';
import 'package:clothing_ecommerce/features/profile/view_models/user_orders_cudit/user_orders_cubit.dart';
import 'package:clothing_ecommerce/features/profile/views/widgets/count_down_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessingStateBodyPage extends StatefulWidget {
  const ProcessingStateBodyPage({super.key});

  @override
  State<ProcessingStateBodyPage> createState() =>
      _ProcessingStateBodyPageState();
}

class _ProcessingStateBodyPageState extends State<ProcessingStateBodyPage>
    with AutomaticKeepAliveClientMixin {
  final Map<String, bool> _finishedOrders = {};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.sizeOf(context);
    final userOrdersCubit = context.read<UserOrdersCubit>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: userOrdersLogs.isEmpty
          ? Center(
              child: Image.asset(
                "assets/images/empty_orders_delivering.png",
                width: size.width * 0.8,
                height: size.height * 0.5,
                fit: BoxFit.contain,
              ),
            )
          : ListView.builder(
              itemCount: userOrdersLogs.length,
              itemBuilder: (context, index) {
                final UserOrdersModel order = userOrdersLogs[index];
                final isFinished = _finishedOrders[order.orderId] ?? false;
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
                                  "Order: ${order.orderId}",
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
                              if (!isFinished && order.orderDeliveringTime > 0)
                                Row(
                                  children: [
                                    CountdownTimerWidget(
                                      key: ValueKey('timer_${order.orderId}'),
                                      seconds: order.orderDeliveringTime,
                                      onFinished: () {
                                        setState(() {
                                          _finishedOrders[order.orderId] = true;
                                          userOrdersCubit.moveToExactState(
                                            "Delivered",
                                            order,
                                          );
                                          userOrdersLogs.remove(order);
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${order.orderStatus}...",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: colorScheme.primaryContainer,
                                          ),
                                    ),
                                  ],
                                ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _finishedOrders[order.orderId] = true;
                                    userOrdersCubit.moveToExactState(
                                      "Cancelled",
                                      order,
                                    );
                                    userOrdersLogs.remove(order);
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: colorScheme.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "cancel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: colorScheme.onPrimary,
                                          ),
                                    ),
                                  ),
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
            ),
    );
  }
}
