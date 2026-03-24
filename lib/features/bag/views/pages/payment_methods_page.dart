import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/features/bag/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/add_new_card_text_field_widget.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/payment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final TextEditingController nameOnCardController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final paymentMethodsCubit = context.read<PaymentMethodsCubit>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Methods",
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
          padding: EdgeInsets.only(
            left: size.width * 0.04,
            right: size.width * 0.04,
            top: size.height * 0.03,
          ),
          child: Stack(
            children: [
              Text(
                "Your Payment Cards",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
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
                  } else if (state is FetchCardsSuccess) {
                    final paymentCards = state.paymentMethods;
                    if (paymentCards.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "assets/images/payments_images/empty_payments.png",
                          width: size.width * 0.6,
                          height: size.height * 0.7,
                          fit: BoxFit.contain,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: ListView.builder(
                        itemCount: paymentCards.length,
                        itemBuilder: (context, index) {
                          final paymentCard = paymentCards[index];
                          return PaymentCardWidget(paymentCard: paymentCard);
                        },
                      ),
                    );
                  } else if (state is FetchCardsFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    );
                  }
                  return Image.asset(
                    "assets/images/payments_images/empty_payments.png",
                    width: size.width * 0.5,
                    fit: BoxFit.contain,
                  );
                },
              ),
              SizedBox(height: size.height * 0.02),
              Positioned(
                bottom: 20,
                right: 0,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.75,
                      ),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.02),
                                  Container(
                                    width: size.width * 0.15,
                                    height: size.height * 0.008,
                                    decoration: BoxDecoration(
                                      color: colorScheme.onSurface,
                                      borderRadius: BorderRadius.circular(
                                        size.height * 0.004,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Text(
                                    "Add New Card",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  AddNewCardTextFieldWidget(
                                    lableText: "Name on card",
                                    hintText: "Enter name on card",
                                    controller: nameOnCardController,
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  AddNewCardTextFieldWidget(
                                    lableText: "Card number",
                                    hintText: "Enter card number",
                                    controller: cardNumberController,
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  AddNewCardTextFieldWidget(
                                    lableText: "Expiry date",
                                    hintText: "MM/YY",
                                    controller: expiryDateController,
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  AddNewCardTextFieldWidget(
                                    lableText: "CVV",
                                    hintText: "Enter CVV",
                                    controller: cvvController,
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(
                                            size.width * 0.01,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            size.width * 0.013,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: colorScheme.surface,
                                              size: size.height * 0.025,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        "Set as default payment method",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: size.width * 0.05,
                                              color: colorScheme.secondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  CustomMainButtonWidget(
                                    title: "ADD CARD",
                                    onTap: () {
                                      paymentMethodsCubit.addNewCard(
                                        name: nameOnCardController.text,
                                        cardNumber: cardNumberController.text,
                                        expiryDate: expiryDateController.text,
                                        cvv: cvvController.text,
                                      );
                                      paymentMethodsCubit.fetchCards();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.025),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(size.height * 0.07),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: colorScheme.surface,
                        size: size.height * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
