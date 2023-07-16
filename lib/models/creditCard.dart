class CreditCard {
  String cardNumber;
  String expiryDate;
  String cvv;
  String holderName;
  //bool isCvv = false;
  String? id;

  CreditCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.holderName,
    //required this.isCvv,
    this.id,
  });
}
