import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/features/bag/models/delivery_methods_model.dart';
import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:clothing_ecommerce/features/bag/models/shipping_locations_model.dart';
import 'package:clothing_ecommerce/features/bag/view_models/delivery_methods_cubit/delivery_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/shipping_locations_cubit/shipping_locations_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/submit_order_cubit/submit_order_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/delivery_item_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/results_titeld_value_row_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/titeld_checkout_value_widget.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:clothing_ecommerce/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  final List<BagItemModel> bagItems;
  final int totalAmount;
  final int totalQuantity;
  const CheckoutPage({
    super.key,
    required this.bagItems,
    required this.totalAmount,
    required this.totalQuantity,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _loadData();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final shippingLocationsCubit = context.read<ShippingLocationsCubit>();
        final paymentMethodsCubit = context.read<PaymentMethodsCubit>();
        shippingLocationsCubit.fetchShippingLocations();
        paymentMethodsCubit.fetchCards();
      }
    });
  }

  ShippingLocationsModel? shippingLocationOrder;
  PaymentCardsModel? paymentMethodOrder;
  DeliveryMethodsModel? deliveryMethodOrder;
  bool isDeliveryMethodChosen = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final shippingLocationsCubit = context.read<ShippingLocationsCubit>();
    final paymentMethodsCubit = context.read<PaymentMethodsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.secondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Column(
            children: [
              TiteldCheckoutValueWidget(
                title: "Shipping Address",
                value: BlocBuilder<ShippingLocationsCubit, ShippingLocationsState>(
                  bloc: shippingLocationsCubit,
                  buildWhen: (previous, current) =>
                      current is FetchingShippingLocations ||
                      current is ShippingLocationsFetched ||
                      current is ShippingLocationsError,
                  builder: (context, state) {
                    if (state is FetchingShippingLocations) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      );
                    } else if (state is ShippingLocationsError) {
                      return Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onSurfaceVariant,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Center(child: Text(state.errorMessage)),
                      );
                    } else if (state is ShippingLocationsFetched) {
                      // select the first shipping location as default temporarily until adding select feature
                      final ShippingLocationsModel? shippingLocation =
                          state.shippingLocations.isEmpty
                          ? null
                          : state.shippingLocations.first;
                      shippingLocationOrder = shippingLocation;
                      if (shippingLocation == null) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(
                                size.height * 0.04,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.onSurface,
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, -1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(size.height * 0.01),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/address');
                                },
                                child: Text(
                                  'Add Shipping Address',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: size.width,
                        height: size.height * 0.16,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onSurfaceVariant,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.01,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/payments_images/location_icon2.png',
                                    width: size.width * 0.12,
                                    height: size.height * 0.12,
                                    fit: BoxFit.contain,
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: size.width * 0.4,
                                    child: Text(
                                      shippingLocation.address,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: colorScheme.secondary,
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    child: Text(
                                      "Change",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/address');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              size.height * 0.04,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.onSurface,
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, -1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(size.height * 0.01),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/address');
                              },
                              child: Text(
                                'Add Shipping Address',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * 0.04),
              TiteldCheckoutValueWidget(
                title: "Payment Method",
                value: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                  bloc: paymentMethodsCubit,
                  buildWhen: (previous, current) =>
                      current is FetchCardsLoading ||
                      current is FetchCardsSuccess ||
                      current is FetchCardsFailure,
                  builder: (context, state) {
                    if (state is FetchCardsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      );
                    }
                    if (state is FetchCardsFailure) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      );
                    }
                    if (state is FetchCardsSuccess) {
                      final PaymentCardsModel? paymentMethod =
                          state.paymentMethods.isEmpty
                          ? null
                          : state.paymentMethods.first;
                      paymentMethodOrder = paymentMethod;
                      if (paymentMethod == null) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(
                                size.height * 0.04,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.onSurface,
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, -1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(size.height * 0.01),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/payment');
                                },
                                child: Text(
                                  'Add Payment Method',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.15,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceTint,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.onSurface,
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: Offset(0, -1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    paymentMethod.imagePath,
                                    height: size.height * 0.04,
                                    width: size.width * 0.1,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                paymentMethod.cardNumber,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text(
                              "Change",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/payment');
                            },
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                            size.height * 0.04,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onSurface,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.01),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/payment');
                            },
                            child: Text(
                              'Add Payment Method',
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.04),
              TiteldCheckoutValueWidget(
                title: "Delivery Method",
                value: BlocProvider(
                  create: (context) => DeliveryMethodsCubit(),
                  child: SizedBox(
                    height: size.height * 0.11,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: deliveryMethods.length,
                      itemBuilder: (context, index) {
                        final deliveryMethod = deliveryMethods[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                          ),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<DeliveryMethodsCubit>()
                                  .toggleDeliveryMethod(deliveryMethod.name);
                              deliveryMethodOrder = deliveryMethod;
                            },
                            child:
                                BlocBuilder<
                                  DeliveryMethodsCubit,
                                  DeliveryMethodsState
                                >(
                                  buildWhen: (previous, current) =>
                                      current is ToggleDeliveryMethod,
                                  builder: (_, state) {
                                    if (state is ToggleDeliveryMethod) {
                                      state.deliveryMethodName != null
                                          ? isDeliveryMethodChosen = true
                                          : isDeliveryMethodChosen = false;
                                      if (mounted) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              setState(() {});
                                            });
                                      }
                                      return DeliveryItemWidget(
                                        imagePath: deliveryMethod.imagePath,
                                        name: deliveryMethod.name,
                                        borderColor:
                                            state.deliveryMethodName ==
                                                deliveryMethod.name
                                            ? colorScheme.primary
                                            : colorScheme.surface,
                                      );
                                    }
                                    return DeliveryItemWidget(
                                      imagePath: deliveryMethod.imagePath,
                                      name: deliveryMethod.name,
                                    );
                                  },
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ResultsTiteldValueRowWidget(
                title: "Order:",
                value: "${widget.totalAmount}\$",
              ),
              SizedBox(height: size.height * 0.01),
              ResultsTiteldValueRowWidget(title: "Delivery:", value: "20\$"),
              SizedBox(height: size.height * 0.01),
              ResultsTiteldValueRowWidget(
                title: "Summary:",
                value: "${widget.totalAmount + 20}\$",
              ),
              const Spacer(),
              BlocProvider(
                create: (context) => SubmitOrderCubit(),
                child: BlocConsumer<SubmitOrderCubit, SubmitOrderState>(
                  listenWhen: (previous, current) =>
                      current is AddOrderToLogsError ||
                      current is AddOrderToLogsSuccess,
                  listener: (context, state) {
                    if (state is AddOrderToLogsError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is AddOrderToLogsSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/success',
                        (route) => false,
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AddingOrderToLogs ||
                      current is AddOrderToLogsError ||
                      current is AddOrderToLogsSuccess,
                  builder: (context, state) {
                    if (state is AddingOrderToLogs) {
                      return CustomMainButtonWidget(isLoading: true);
                    }
                    if (
                    shippingLocationOrder == null ||
                      paymentMethodOrder == null ||
                    isDeliveryMethodChosen == false) {
                      return CustomMainButtonWidget(
                        title: "SUBMIT ORDER",
                        backgroundColor: colorScheme.onSurfaceVariant,
                      );
                    } else {
                      return CustomMainButtonWidget(
                        title: "SUBMIT ORDER",
                        onTap: () {
                          context.read<SubmitOrderCubit>().addOrderToLogs(
                            bagItemModel: widget.bagItems,
                            // shippingLocationsModel: shippingLocationOrder!,
                            // paymentMethodsModel: paymentMethodOrder!,
                            deliveryMethodsModel: deliveryMethodOrder!,
                            totalAmount: widget.totalAmount + 20,
                            totalQuantity: widget.totalQuantity,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
