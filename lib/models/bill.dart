import 'dart:convert';

class Bill {
  String bill_uid;
  String name;
  DateTime date;
  double amount;
  bool isPaid;

  Bill({
    required this.bill_uid,
    required this.name,
    required this.date,
    required this.amount,
    required this.isPaid,
  });

  factory Bill.fromRawJson(String str) => Bill.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        bill_uid: json["bill_uid"],
        name: json["name"],
        date: json["date"]?.toDate(),
        amount: json["amount"].toDouble(),
        isPaid: json["isPaid"],
      );

  Map<String, dynamic> toJson() => {
        "bill_uid": bill_uid,
        "name": name,
        "date": date,
        "amount": amount,
        "isPaid": isPaid,
      };
}
