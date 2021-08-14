import 'package:flutter/cupertino.dart';

class PaymentOption {
  final int number;
  final double value;
  final double total;

  PaymentOption(this.number, this.value, this.total);

  @override
  String toString() {
    return 'PaymentOption{number: $number, value: $value, total: $total}';
  }

  PaymentOption.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        value = json['value'].toDouble(),
        total = json['total'].toDouble();

  bool operator ==(o) =>
      o is PaymentOption &&
      number == o.number &&
      value == o.value &&
      total == o.total;

  int get hashCode => hashValues(number, value, total);
}
