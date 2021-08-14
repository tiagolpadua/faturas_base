import 'package:faturas_base/shared/model/credit_card/credit_card.dart';
import 'package:faturas_base/shared/model/credit_card/user_credit_card_model.dart';
import 'package:faturas_base/shared/model/payment_option/payment_option.dart';
import 'package:faturas_base/shared/model/payment_option/payment_options_model.dart';

class ConfirmationViewModel {
  final PaymentOptionsModel _paymentOptionsModel;
  final UserCreditCardModel _userCreditCardModel;

  ConfirmationViewModel(
      {required PaymentOptionsModel paymentOptionsModel,
      required UserCreditCardModel userCreditCardModel})
      : _paymentOptionsModel = paymentOptionsModel,
        _userCreditCardModel = userCreditCardModel;

  PaymentOption? get selectedPaymentOption {
    return _paymentOptionsModel.selectedPaymentOption;
  }

  CreditCard? get userCreditCard {
    return _userCreditCardModel.userCreditCard;
  }

  get invoiceValue {
    return _paymentOptionsModel.invoiceValue;
  }
}
