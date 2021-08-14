class PaymentOption {
  final int number;
  final double value;
  final double total;

  PaymentOption(this.number, this.value, this.total);

  @override
  String toString() {
    return 'PaymentOption{number: $number, value: $value, total: $total}';
  }
}
