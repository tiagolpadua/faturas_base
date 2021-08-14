import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/model/payment_options_model.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel({required PaymentOptionsModel paymentOptionsModel})
      : _paymentOptionsModel = paymentOptionsModel;

  List<PaymentOption> get paymentOptions {
    return _paymentOptionsModel.paymentOptions;
  }

  set selectedPaymentOption(PaymentOption? paymentOption) {
    _paymentOptionsModel.selectedPaymentOption = paymentOption;
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }
}