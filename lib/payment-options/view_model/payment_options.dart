import 'package:faturas_base/shared/model/payment_option/payment_option.dart';
import 'package:faturas_base/shared/model/payment_option/payment_options_model.dart';

class PaymentOptionsViewModel {
  final PaymentOptionsModel _paymentOptionsModel;

  PaymentOptionsViewModel({required PaymentOptionsModel paymentOptionsModel})
      : _paymentOptionsModel = paymentOptionsModel;

  Future<List<PaymentOption>> getPaymentOptions() {
    return _paymentOptionsModel.getPaymentOptions();
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }

  PaymentOption? get selectedPaymentOption {
    return _paymentOptionsModel.selectedPaymentOption;
  }

  set selectedPaymentOption(PaymentOption? paymentOption) {
    _paymentOptionsModel.selectedPaymentOption = paymentOption;
  }

  double get operationTax {
    if (_paymentOptionsModel.selectedPaymentOption == null) {
      return 0;
    }

    return (_paymentOptionsModel.selectedPaymentOption!.number *
            _paymentOptionsModel.selectedPaymentOption!.value) -
        _paymentOptionsModel.invoiceValue;
  }
}
