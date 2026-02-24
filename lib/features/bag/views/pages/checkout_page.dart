import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/models/delivery_methods_model.dart';
import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:clothing_ecommerce/features/bag/models/shipping_locations_model.dart';
import 'package:clothing_ecommerce/features/bag/view_models/delivery_methods_cubit/delivery_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/shipping_locations_cubit/shipping_locations_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/delivery_item_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/results_titeld_value_row_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/titeld_checkout_value_widget.dart';
import 'package:clothing_ecommerce/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final shippingLocationsCubit = context.read<ShippingLocationsCubit>();
    final paymentMethodsCubit = context.read<PaymentMethodsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.lightGrey1,
      body: Padding(
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
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is ShippingLocationsError) {
                    return Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.grey,
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
                    if (shippingLocation == null) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                              size.height * 0.04,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.grey,
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
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.grey,
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
                                    // textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: AppColors.black,
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
                                          color: AppColors.primaryColor,
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
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            size.height * 0.04,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.grey,
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
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(
                                    color: AppColors.primaryColor,
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
                      child: const CircularProgressIndicator(
                        color: AppColors.primaryColor,
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
                    if (paymentMethod == null) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                              size.height * 0.04,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.grey,
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
                                      color: AppColors.primaryColor,
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
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.grey,
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
                                  color: AppColors.primaryColor,
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
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(size.height * 0.04),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.grey,
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
                                  color: AppColors.primaryColor,
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
                                    return DeliveryItemWidget(
                                      imagePath: deliveryMethod.imagePath,
                                      name: deliveryMethod.name,
                                      borderColor:
                                          state.deliveryMethodName ==
                                              deliveryMethod.name
                                          ? AppColors.primaryColor
                                          : AppColors.white,
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
            SizedBox(height: size.height * 0.04),
            ResultsTiteldValueRowWidget(title: "Order:", value: "120\$"),
            SizedBox(height: size.height * 0.02),
            ResultsTiteldValueRowWidget(title: "Delivery:", value: "15\$"),
            SizedBox(height: size.height * 0.02),
            ResultsTiteldValueRowWidget(title: "Summary:", value: "135\$"),
            const Spacer(),
            CustomMainButtonWidget(
              title: "SUBMIT ORDER",
              onTap: () {
                Navigator.pushNamed(context, '/success');
              },
            ),
          ],
        ),
      ),
    );
  }
}
