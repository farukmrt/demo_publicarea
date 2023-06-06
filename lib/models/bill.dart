class Bill {
  final String name;
  final DateTime date;
  final double amount;
  final bool isPaid;

  Bill(
      {required this.name,
      required this.date,
      required this.amount,
      required this.isPaid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'amount': amount,
      'isPaid': isPaid,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      amount: map['amount'] ?? '',
      isPaid: map['isPaid'] ?? '',
    );
  }
}
