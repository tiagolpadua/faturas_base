import 'package:faturas_base/confirmation/view_model/confirmation.dart';
import 'package:faturas_base/shared/model/credit_card/user_credit_card_model.dart';
import 'package:faturas_base/shared/model/payment_option/payment_options_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

var nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

Future<String> processPayment(String cvv) async =>
    await Future.delayed(Duration(seconds: 2), () {
      if (cvv != '111') {
        return 'error';
      }
      return 'ok';
    });

showProcessingDialog(BuildContext context, String cvv) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget reviewButton = TextButton(
    child: Text("Revisar dados"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog processingDialog = AlertDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularProgressIndicator(),
        Text("Confirmando seu pagamento"),
      ],
    ),
    content: Text(
        "Estamos confirmando a stansação co seu banco e isso pode levar alguns segundos."),
  );

  AlertDialog dialogOk = AlertDialog(
    title: Text("Cobrança Efetuada"),
    content: Text("Tudo certo, seu pagamento foi efetuado!"),
    actions: [okButton],
  );

  AlertDialog dialogError = AlertDialog(
    title: Text("Falha na cobrança"),
    content: Text(
        "Algo deu errado no processamento do seu cartão. Verifique se os dados do cartão estão corretos."),
    actions: [reviewButton],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<String>(
          future: processPayment(cvv),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 'ok') {
                return dialogOk;
              } else {
                return dialogError;
              }
            }
            return processingDialog;
          });
    },
  );
}

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ProxyProvider2<PaymentOptionsModel, UserCreditCardModel,
          ConfirmationViewModel>(
        create: (context) => ConfirmationViewModel(
            paymentOptionsModel: context.read<PaymentOptionsModel>(),
            userCreditCardModel: context.read<UserCreditCardModel>()),
        update: (context, paymentOptionsModel, userCreditCardModel, notifier) =>
            ConfirmationViewModel(
          paymentOptionsModel: paymentOptionsModel,
          userCreditCardModel: userCreditCardModel,
        ),
      ),
    ], child: ConfirmationWidget());
  }
}

class ConfirmationWidget extends StatefulWidget {
  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  @override
  Widget build(BuildContext context) {
    final vm = context.select(
      (ConfirmationViewModel model) => model,
    );

    final txtFee = nf.format(vm.selectedPaymentOption!.total - vm.invoiceValue);

    final txtTotal = nf.format(vm.selectedPaymentOption!.total);

    final txtYouPay =
        '${vm.selectedPaymentOption!.number} x ${nf.format(vm.selectedPaymentOption!.value)}';

    final txtInvoiceValue = nf.format(vm.invoiceValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento da fatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Revise os valores",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Fatura de junho",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Spacer(),
                          Text(txtInvoiceValue,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Taxa de operação",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Spacer(),
                          Text(txtFee,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Total", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Text(txtTotal, style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Você vai pagar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Spacer(),
                          Text(txtYouPay,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    "Este pagamento é referente somente ao mês de junho. Não vamos salvar os dados do seu cartão para pagamentos recorrentes.",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ),
            Spacer(),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Voltar")),
                Spacer(),
                Text("3 de 3"),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      showProcessingDialog(context, vm.userCreditCard!.cvv);
                    },
                    child: Text("Pagar Fatura"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
