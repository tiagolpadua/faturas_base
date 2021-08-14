import 'package:faturas_base/main.dart';
import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/repository/rest/payment_options_rest_service.dart';
import 'package:flutter/cupertino.dart';

class PaymentOptionsModel extends ChangeNotifier {
  double _invoiceValue;
  List<PaymentOption>? _paymentOptions;

  PaymentOption? _selectedPaymentOption;

  PaymentOptionsModel() : _invoiceValue = 3025.49;

  Future<List<PaymentOption>> getPaymentOptions() async {
    if (_paymentOptions == null) {
      _paymentOptions =
          await getIt<PaymentOptionsRestService>().fetchPaymentOptions();
      selectedPaymentOption = _paymentOptions?[0];
    }
    return _paymentOptions!;
  }

  double get invoiceValue {
    return _invoiceValue;
  }

  set selectedPaymentOption(PaymentOption? paymentOption) {
    _selectedPaymentOption = paymentOption;
    notifyListeners();
  }

  PaymentOption? get selectedPaymentOption {
    return _selectedPaymentOption;
  }
}
