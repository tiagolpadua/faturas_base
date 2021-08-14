import 'package:faturas_base/payment-options/model/payment_option.dart';

List<PaymentOption> defaultPaymentOptions = [
  PaymentOption(1, 3180, 3180),
  PaymentOption(2, 1630, 3260),
  PaymentOption(3, 1086.67, 3260),
  PaymentOption(4, 815, 3260),
  PaymentOption(5, 662, 3310),
  PaymentOption(6, 551.67, 3310),
  PaymentOption(7, 472.86, 3310),
];

class PaymentOptionsModel {
  double _invoiceValue;

  List<PaymentOption> _paymentOptions;

  PaymentOptionsModel()
      : _invoiceValue = 3025.49,
        _paymentOptions = defaultPaymentOptions {}

  List<PaymentOption> get paymentOptions {
    return _paymentOptions;
  }

  double get invoiceValue {
    return _invoiceValue;
  }

  set selectedPaymentOption(PaymentOption? paymentOption) {
    selectedPaymentOption = paymentOption;
  }
}
