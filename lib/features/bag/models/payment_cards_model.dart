import 'dart:ui';

class PaymentCardsModel {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final Color cardColor;
  final String imagePath;

  const PaymentCardsModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardColor,
    required this.imagePath,
  });
}

List<PaymentCardsModel> paymentCards = [];
