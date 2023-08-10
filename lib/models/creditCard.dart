class CreditCard {
  String cardNumber;
  String expiryDate;
  String cvv;
  String holderName;
  String? id;

  CreditCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.holderName,
    this.id,
  });
}
