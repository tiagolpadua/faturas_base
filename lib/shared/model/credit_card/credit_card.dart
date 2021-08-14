class CreditCard {
  final String number;
  final String name;
  final String expiration;
  final String cvv;

  CreditCard(this.number, this.name, this.expiration, this.cvv);

  @override
  String toString() {
    return 'CreditCard{number: $number, name: $name, expiration: $expiration, cvv: $cvv}';
  }
}
