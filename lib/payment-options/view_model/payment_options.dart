import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/model/payment_options_model.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel({required PaymentOptionsModel paymentOptionsModel})
      : _paymentOptionsModel = paymentOptionsModel;

  List<PaymentOption> get paymentOptions {
    return _paymentOptionsModel.paymentOptions;
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }

  PaymentOption get selectedPaymentOption {
    return _paymentOptionsModel.selectedPaymentOption;
  }

  set selectedPaymentOption(PaymentOption paymentOption) {
    _paymentOptionsModel.selectedPaymentOption = paymentOption;
  }

  double get operationTax {
    return (_paymentOptionsModel.selectedPaymentOption.number *
            _paymentOptionsModel.selectedPaymentOption.value) -
        _paymentOptionsModel.invoiceValue;
  }
}
