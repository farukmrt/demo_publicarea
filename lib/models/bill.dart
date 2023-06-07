class Bill {
  final String? bill_uid;
  final String name;
  final DateTime date;
  final double amount;
  final bool isPaid;

  Bill({
    this.bill_uid,
    required this.name,
    required this.date,
    required this.amount,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      'bill_uid': bill_uid,
      'name': name,
      'date': date,
      'amount': amount,
      'isPaid': isPaid,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      bill_uid: map['bill_uid'] ?? '',
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      amount: map['amount'] ?? '',
      isPaid: map['isPaid'] ?? '',
    );
  }
}
