import 'package:faturas_base/payment-options/repository/rest/payment_options_rest_service.dart';
import 'package:faturas_base/payment-options/view/screens/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<PaymentOptionsRestService>(
      PaymentOptionsRestService());
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Faturas(),
    );
  }
}

showNotImplementedDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Erro"),
    content: Text("Não implementado..."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Faturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Faturas'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: Text("Última fatura",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("R\$ 3.025,49",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 8),
                              child: Text("Vencimento 08/07/2019",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.6))),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text("Vencida",
                            style: TextStyle(fontSize: 18, color: Colors.red))
                      ],
                    ),
                    Divider(color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text("Formas de Pagamento",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text("Boleto Bancário",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.6))),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Copiar código de barras do boleto'),
                        ),
                        onPressed: () {
                          showNotImplementedDialog(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Enviar boleto por e-mail'),
                        ),
                        onPressed: () {
                          showNotImplementedDialog(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text("Cartão de Crédito",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.6))),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Pagar com cartão de crédito'),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PaymentOptionsScreen();
                          }));
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
