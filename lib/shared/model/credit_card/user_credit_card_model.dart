import 'package:faturas_base/shared/model/credit_card/credit_card.dart';
import 'package:flutter/cupertino.dart';

class UserCreditCardModel extends ChangeNotifier {
  CreditCard? _userCreditCard;

  CreditCard? get userCreditCard {
    return _userCreditCard;
  }

  set userCreditCard(CreditCard? creditCard) {
    _userCreditCard = creditCard;
    notifyListeners();
  }
}
