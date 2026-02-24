import 'dart:math';
import 'dart:ui';

import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(AddNewCardInitial());

  String getCardImagePath(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
    String bin = cleanNumber.substring(0, 4);
    String firstDigit = cleanNumber.substring(0, 1);
    String firstTwo = cleanNumber.substring(0, 2);
    // if (cleanNumber.isEmpty)return "assets/images/payments_images/unknown_card.png"; use Text Form Field validator to check if the card number is empty or not and show error message if it is empty
    if (firstDigit == '4') {
      // Visa
      return "assets/images/payments_images/visa.png";
    } else if (firstTwo == '50' ||
        (int.tryParse(firstTwo)! >= 51 && int.tryParse(firstTwo)! <= 55)) {
      // Mastercard
      return "assets/images/payments_images/mastercard.png";
    } else if (bin.startsWith('5019') || bin.startsWith('4571')) {
      // Dankort
      return "assets/images/payments_images/dankort.png";
    }
    //Meeza
    else if (bin.startsWith('6500') ||
        bin.startsWith('5061') ||
        bin.startsWith('5078')) {
      return "assets/images/payments_images/meeza.png";
    }

    // Unknown card type
    return "assets/images/payments_images/unknown_card.png";
  }

  void addNewCard({
    required String name,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) {
    emit(AddNewCardLoading());
    try {
      final random = Random();
      final randomColor = Color.fromRGBO(
        random.nextInt(60),
        random.nextInt(60),
        random.nextInt(60),
        1.0,
      );
      paymentCards.add(
        PaymentCardsModel(
          id: "${paymentCards.length + 1}",
          cardHolderName: name,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cvv: cvv,
          cardColor: randomColor,
          imagePath: getCardImagePath(cardNumber),
        ),
      );
      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(e.toString()));
    }
  }

  void fetchCards() {
    emit(FetchCardsLoading());
    try {
      Future.delayed(Duration(seconds: 1), () {
        emit(FetchCardsSuccess(paymentCards));
      });
    } catch (e) {
      emit(FetchCardsFailure(e.toString()));
    }
  }
}
