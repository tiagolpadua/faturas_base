import 'package:faturas_base/main.dart';
import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:faturas_base/payment-options/model/payment_options_model.dart';
import 'package:faturas_base/payment-options/repository/rest/payment_options_rest_service.dart';
import 'package:faturas_base/payment-options/view/screens/payment_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

List<PaymentOption> defaultPaymentOptions = [
  PaymentOption(1, 3180, 3180),
  PaymentOption(2, 1630, 3260),
  PaymentOption(3, 1086.67, 3260),
  PaymentOption(4, 815, 3260),
  PaymentOption(5, 662, 3310),
  PaymentOption(6, 551.67, 3310),
  PaymentOption(7, 472.86, 3310),
];

class PaymentOptionsRestServiceMock extends Mock
    implements PaymentOptionsRestService {}

void main() {
  group('PaymentOptionsScreen', () {
    setUpAll(() {
      final paymentOptionsRestService = PaymentOptionsRestServiceMock();

      when(paymentOptionsRestService.fetchPaymentOptions())
          .thenAnswer((invocation) async => defaultPaymentOptions);

      GetIt.instance.registerSingleton<PaymentOptionsRestService>(
          paymentOptionsRestService);
    });

    testWidgets('Screen is rendered', (WidgetTester tester) async {
      Widget paymentOptionsScreenWidget =
          ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreenWidget);

      expect(find.text('Escolha o número de parcelas:'), findsOneWidget);
    });

    testWidgets('User can select other payment option', (tester) async {
      Widget paymentOptionsScreenWidget =
          ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreenWidget);

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('rlt_3')));

      await tester.pumpAndSettle();

      expect(find.byKey(Key("tax")).toString().contains("234,52"), true);
    });
  });
}
