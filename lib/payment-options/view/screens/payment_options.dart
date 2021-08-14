import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/model/payment_options_model.dart';
import 'package:faturas_base/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PaymentOptionsModel>(
          create: (_) => PaymentOptionsModel()),
      ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
        create: (context) => PaymentOptionsViewModel(
            paymentOptionsModel: context.read<PaymentOptionsModel>()),
        update: (context, paymentOptionsModel, notifier) =>
            PaymentOptionsViewModel(
          paymentOptionsModel: paymentOptionsModel,
        ),
      ),
    ], child: PaymentOptionsWidget());
  }
}

class PaymentOptionsWidget extends StatelessWidget {
  final nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  Widget build(BuildContext context) {
    final vm = context.select(
      (PaymentOptionsViewModel vm) => vm,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento da fatura'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Escolha o número de parcelas:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16))),
              Expanded(
                child: FutureBuilder<List<PaymentOption>>(
                    future: context.select(
                      (PaymentOptionsViewModel model) =>
                          model.getPaymentOptions(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final paymentOptions = snapshot.data!;
                        return ListView.builder(
                            itemCount: paymentOptions.length,
                            itemBuilder: (context, indice) {
                              final paymentOption = paymentOptions[indice];
                              return PaymentOptionTile(paymentOption);
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: const CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }),
              ),
              Divider(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Text(
                              "Fatura de junho",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Spacer(),
                            Text(
                              "${nf.format(vm.invoiceValue)}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Row(
                          children: [
                            Text(
                              "Taxa da operação",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Spacer(),
                            Text(
                              "${nf.format(vm.operationTax)}",
                              key: Key("tax"),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
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
                  Text("1 de 3"),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        debugPrint("Continuar...");
                      },
                      child: Text("Continuar"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionTile extends StatelessWidget {
  final PaymentOption _payment;

  PaymentOptionTile(this._payment);

  @override
  Widget build(BuildContext context) {
    final vm = context.select(
      (PaymentOptionsViewModel vm) => vm,
    );

    var key = Key('rlt_${_payment.number}');

    var nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Card(
      child: RadioListTile<PaymentOption>(
        title: Row(
          children: [
            Text('${_payment.number} x ${nf.format(_payment.value)}', key: key),
            Spacer(),
            Text('${nf.format(_payment.total)}'),
          ],
        ),
        value: _payment,
        groupValue: vm.selectedPaymentOption,
        onChanged: (PaymentOption? value) {
          if (value == null) {
            return;
          }
          vm.selectedPaymentOption = value;
        },
      ),
    );
  }
}
