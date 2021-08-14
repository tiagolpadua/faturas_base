import 'package:faturas_base/shared/model/credit_card/credit_card.dart';
import 'package:faturas_base/shared/model/credit_card/user_credit_card_model.dart';

class CreditCartDetailsViewModel {
  final UserCreditCardModel _userCreditCardModel;

  CreditCartDetailsViewModel({required UserCreditCardModel userCreditCardModel})
      : _userCreditCardModel = userCreditCardModel;

  CreditCard? get userCreditCard {
    return _userCreditCardModel.userCreditCard;
  }

  set userCreditCard(CreditCard? creditCard) {
    _userCreditCardModel.userCreditCard = creditCard;
  }
}
