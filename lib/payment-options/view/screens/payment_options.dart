import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/model/payment_options_model.dart';
import 'package:faturas_base/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var nf = NumberFormat.simpleCurrency(locale: 'pt_BR');

class PaymentOptionsScreen extends StatefulWidget {
  PaymentOptionsViewModel paymentOptionsViewModel =
      PaymentOptionsViewModel(paymentOptionsModel: PaymentOptionsModel());

  late PaymentOption selectedPaymentOption;

  @override
  _PaymentOptionsScreenState createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  @override
  void initState() {
    super.initState();
    widget.selectedPaymentOption =
        widget.paymentOptionsViewModel.paymentOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    final operationTax = nf.format((widget.selectedPaymentOption.number *
            widget.selectedPaymentOption.value) -
        widget.paymentOptionsViewModel.invoiceValue);

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
                child: ListView.builder(
                    itemCount:
                        widget.paymentOptionsViewModel.paymentOptions.length,
                    itemBuilder: (context, indice) {
                      final paymentOption =
                          widget.paymentOptionsViewModel.paymentOptions[indice];
                      return PaymentOptionTile(
                          paymentOption, widget.selectedPaymentOption, (value) {
                        setState(() {
                          widget.selectedPaymentOption = value;
                        });
                      });
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
                            Text("Fatura de junho",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            Spacer(),
                            Text(
                                "${nf.format(widget.paymentOptionsViewModel.invoiceValue)}",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Row(
                          children: [
                            Text("Taxa da operação",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            Spacer(),
                            Text("$operationTax",
                                key: Key("tax"),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
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
        )));
  }
}

class PaymentOptionTile extends StatelessWidget {
  final PaymentOption _payment;
  final Function(PaymentOption) _onChangedFunction;
  final PaymentOption _selectedPayment;

  PaymentOptionTile(
      this._payment, this._selectedPayment, this._onChangedFunction);

  @override
  Widget build(BuildContext context) {
    var key = Key('rlt_${_payment.number}');

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
      groupValue: _selectedPayment,
      onChanged: (PaymentOption? value) {
        _onChangedFunction(value!);
      },
    ));
  }
}
