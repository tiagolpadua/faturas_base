import 'package:faturas_base/confirmation/view/screens/confirmation.dart';
import 'package:faturas_base/credit-card-details/view_model/credit_card_details.dart';
import 'package:faturas_base/shared/model/credit_card/credit_card.dart';
import 'package:faturas_base/shared/model/credit_card/user_credit_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreditCardDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ProxyProvider<UserCreditCardModel, CreditCartDetailsViewModel>(
        create: (context) => CreditCartDetailsViewModel(
            userCreditCardModel: context.read<UserCreditCardModel>()),
        update: (context, userCreditCardModel, notifier) =>
            CreditCartDetailsViewModel(
          userCreditCardModel: userCreditCardModel,
        ),
      ),
    ], child: CreditCardDetailsWidget());
  }
}

class CreditCardDetailsWidget extends StatefulWidget {
  @override
  _CreditCardDetailsWidgetState createState() =>
      _CreditCardDetailsWidgetState();
}

class _CreditCardDetailsWidgetState extends State<CreditCardDetailsWidget> {
  final _formKey = new GlobalKey<FormState>();

  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expirationController = TextEditingController();
  final _cvvController = TextEditingController();

  String? _notEmpty(String? text) {
    if (text == null || text.isEmpty) {
      return 'Deve ser preenchido';
    }
    return null;
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creditCartDetailsViewModel = context.select(
      (CreditCartDetailsViewModel model) => model,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento da fatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Número do Cartão",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextFormField(
                  controller: _numberController,
                  maxLength: 16,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: _notEmpty,
                ),
                Text("Nome do titular do cartão",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: _notEmpty,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Validade",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _expirationController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: _notEmpty,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "CVV",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _cvvController,
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: _notEmpty,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Essa transação é 100% segura e com certificados de segurança que garantem a integridade dos seus dados.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Voltar")),
                    Spacer(),
                    Text("2 de 3"),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            creditCartDetailsViewModel.userCreditCard =
                                CreditCard(
                                    _nameController.text,
                                    _nameController.text,
                                    _expirationController.text,
                                    _cvvController.text);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ConfirmationScreen();
                            }));
                          }
                        },
                        child: Text("Continuar"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
